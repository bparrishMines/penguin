import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reference/reference.dart';
import 'package:reference/src/templates/implementation.dart' as template;

void main() {
  final List<MethodCall> methodCallLog = <MethodCall>[];

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    template.referencePairManager = template.GeneratedReferencePairManager(
      'test_plugin',
      template.LocalReferenceCommunicationHandlerTemplate(),
    )..initialize();

    template.referencePairManager.channel.setMockMethodCallHandler(
      (MethodCall methodCall) async {
        methodCallLog.add(methodCall);
        if (methodCall.method ==
            MethodChannelReferencePairManager.methodMethod) {
          switch (methodCall.arguments[1]) {
            case 'methodTemplate':
              return 'Good' + methodCall.arguments[2][0];
            case 'callbackTemplate':
              return 'Potato';
          }
        }
        return null;
      },
    );
  });

  tearDown(() {
    template.referencePairManager = null;
    methodCallLog.clear();
  });

  test('createRemoteReference', () async {
    final ReferencePairManager referencePairManager =
        template.referencePairManager;
    final template.ClassTemplate testClass = template.ClassTemplate(1);

    referencePairManager.createRemoteReferenceFor(testClass);

    final RemoteReference remoteReference =
        referencePairManager.remoteReferenceFor(testClass);

    expect(remoteReference.referenceId, isNotNull);
    expect(
      referencePairManager.localReferenceFor(remoteReference),
      equals(testClass),
    );
    expect(methodCallLog, <Matcher>[
      isMethodCall('REFERENCE_CREATE', arguments: <dynamic>[
        remoteReference,
        <dynamic>[
          'ClassTemplate',
          <dynamic>[1]
        ],
      ]),
    ]);
  });

  test('disposeRemoteReference', () async {
    final ReferencePairManager referencePairManager =
        template.referencePairManager;
    final template.ClassTemplate testClass = template.ClassTemplate(2);

    referencePairManager.createRemoteReferenceFor(testClass);
    final RemoteReference remoteReference =
        referencePairManager.remoteReferenceFor(testClass);
    methodCallLog.clear();

    referencePairManager.disposeRemoteReferenceFor(testClass);

    expect(referencePairManager.localReferenceFor(remoteReference), isNull);
    expect(referencePairManager.remoteReferenceFor(testClass), isNull);
    expect(methodCallLog, <Matcher>[
      isMethodCall(
        'REFERENCE_DISPOSE',
        arguments: remoteReference,
      ),
    ]);
  });

  test('executeRemoteMethod', () async {
    final ReferencePairManager referencePairManager =
        template.referencePairManager;
    final template.ClassTemplate testClass = template.ClassTemplate(3);
    referencePairManager.createRemoteReferenceFor(testClass);
    methodCallLog.clear();

    final String result = await testClass.methodTemplate('bye!');

    expect(result, equals('Goodbye!'));
    expect(methodCallLog, <Matcher>[
      isMethodCall('REFERENCE_METHOD', arguments: <dynamic>[
        referencePairManager.remoteReferenceFor(testClass),
        'methodTemplate',
        <dynamic>['bye!'],
      ]),
    ]);
  });

  test('executeLocalMethod', () async {
    final MethodChannelReferencePairManager referencePairManager =
        template.referencePairManager;

    final Completer<double> callbackCompleter = Completer<double>();

    final template.ClassTemplate testClass = TestClassTemplate(
      3,
      (double testParameter) async {
        callbackCompleter.complete(testParameter);
        return testParameter.toString();
      },
    );

    referencePairManager.createRemoteReferenceFor(testClass);

    final Completer<String> responseCompleter = Completer<String>();
    await referencePairManager.channel.binaryMessenger.handlePlatformMessage(
      'test_plugin',
      referencePairManager.channel.codec.encodeMethodCall(
        MethodCall(
          'REFERENCE_METHOD',
          <dynamic>[
            referencePairManager.remoteReferenceFor(testClass),
            'callbackTemplate',
            <dynamic>[46.0],
          ],
        ),
      ),
      (ByteData data) {
        responseCompleter.complete(
          referencePairManager.channel.codec.decodeEnvelope(data),
        );
      },
    );

    expect(callbackCompleter.future, completion(46.0));
    expect(responseCompleter.future, completion('46.0'));
  });

  test('createLocalReference', () async {
    final MethodChannelReferencePairManager referencePairManager =
        template.referencePairManager;

    final RemoteReference remoteReference = RemoteReference('aowejea;io');
    await referencePairManager.channel.binaryMessenger.handlePlatformMessage(
      'test_plugin',
      referencePairManager.channel.codec.encodeMethodCall(
        MethodCall(
          'REFERENCE_CREATE',
          <dynamic>[
            remoteReference,
            <dynamic>[
              'ClassTemplate',
              <dynamic>[45],
            ],
          ],
        ),
      ),
      (ByteData data) {},
    );

    final template.ClassTemplate testClass =
        referencePairManager.localReferenceFor(remoteReference);

    expect(testClass.fieldTemplate, equals(45));
  });
}

class TestClassTemplate extends template.ClassTemplate {
  TestClassTemplate(int fieldTemplate, this.onCallbackTemplate)
      : super(fieldTemplate);

  final Future<String> Function(double parameterTemplate) onCallbackTemplate;

  @override
  FutureOr<String> callbackTemplate(double parameterTemplate) {
    return onCallbackTemplate(parameterTemplate);
  }
}
