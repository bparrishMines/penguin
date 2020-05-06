import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reference/reference.dart';
import 'package:reference/src/templates/template.dart' as template;

void main() {
  final List<MethodCall> methodCallLog = <MethodCall>[];

  TestWidgetsFlutterBinding.ensureInitialized();

  group('$OwnerCounter', () {
    test('increment', () {
      int callCount = 0;

      final OwnerCounter counter = OwnerCounter(
        OwnerCounterLifecycleListener(
          onCreate: () {
            callCount++;
            return Future<void>.value();
          },
          onDispose: () => null,
        ),
      );

      counter.increment();
      counter.increment();

      expect(callCount, 1);
    });

    test('decrement', () {
      int callCount = 0;

      final OwnerCounter counter = OwnerCounter(
          OwnerCounterLifecycleListener(
            onCreate: () => null,
            onDispose: () {
              callCount++;
              return Future<void>.value();
            },
          ),
          2);

      counter.decrement();
      counter.decrement();

      expect(callCount, 1);
      expect(() => counter.decrement(), throwsAssertionError);
    });
  });

  group('$ReferencePairManager', () {
    setUp(() {
      template.referencePairManager = template.GeneratedReferencePairManager(
        'test_plugin',
        template.LocalReferenceCommunicationHandlerTemplate(),
      )..initialize();

      template.referencePairManager.channel.setMockMethodCallHandler(
        (MethodCall methodCall) async {
          methodCallLog.add(methodCall);
          if (methodCall.method == 'REFERENCE_METHOD') {
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

    test('createRemoteReferenceFor', () async {
      final ReferencePairManager referencePairManager =
          template.referencePairManager;
      final template.ClassTemplate testClass = template.ClassTemplate(1);

      referencePairManager.createRemoteReferenceFor(
        testClass,
        TypeReference(0),
      );

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
          TypeReference(0),
          <dynamic>[1],
        ]),
      ]);
    });

    test('disposeRemoteReferenceFor', () async {
      final ReferencePairManager referencePairManager =
          template.referencePairManager;
      final template.ClassTemplate testClass = template.ClassTemplate(2);

      referencePairManager.createRemoteReferenceFor(
        testClass,
        TypeReference(0),
      );
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

    test('executeRemoteMethodFor', () async {
      final ReferencePairManager referencePairManager =
          template.referencePairManager;
      final template.ClassTemplate testClass = template.ClassTemplate(3);
      referencePairManager.createRemoteReferenceFor(
          testClass, TypeReference(0),);
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

    test('executeLocalMethodFor', () async {
      final MethodChannelReferencePairManager referencePairManager =
          template.referencePairManager;

      final Completer<String> callbackCompleter = Completer<String>();

      final template.ClassTemplate testClass = TestClassTemplate(
        3,
        (String parameterTemplate) async {
          callbackCompleter.complete(parameterTemplate);
          return parameterTemplate + ' pie';
        },
      );

      referencePairManager.createRemoteReferenceFor(
        testClass,
        TypeReference(0),
      );

      final Completer<String> responseCompleter = Completer<String>();
      await referencePairManager.channel.binaryMessenger.handlePlatformMessage(
        'test_plugin',
        referencePairManager.channel.codec.encodeMethodCall(
          MethodCall(
            'REFERENCE_METHOD',
            <dynamic>[
              referencePairManager.remoteReferenceFor(testClass),
              'methodTemplate',
              <dynamic>['Apple'],
            ],
          ),
        ),
        (ByteData data) {
          responseCompleter.complete(
            referencePairManager.channel.codec.decodeEnvelope(data),
          );
        },
      );

      expect(callbackCompleter.future, completion('Apple'));
      expect(responseCompleter.future, completion('Apple pie'));
    });

    test('createLocalReferenceFor', () async {
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
              TypeReference(0),
              <dynamic>[45],
            ],
          ),
        ),
        (ByteData data) {},
      );

      final template.ClassTemplate testClass =
          referencePairManager.localReferenceFor(remoteReference);

      expect(testClass.fieldTemplate, equals(45));
    });

    test('disposeLocalReference', () async {
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

      await referencePairManager.channel.binaryMessenger.handlePlatformMessage(
        'test_plugin',
        referencePairManager.channel.codec.encodeMethodCall(
          MethodCall(
            'REFERENCE_DISPOSE',
            remoteReference,
          ),
        ),
        (ByteData data) {},
      );

      final template.ClassTemplate testClass =
          referencePairManager.localReferenceFor(remoteReference);

      expect(testClass, isNull);
    });
  });
}

class TestClassTemplate extends template.ClassTemplate {
  TestClassTemplate(int fieldTemplate, this.onMethodTemplate)
      : super(fieldTemplate);

  final Future<String> Function(String parameterTemplate) onMethodTemplate;

  @override
  FutureOr<String> methodTemplate(String parameterTemplate) {
    return onMethodTemplate(parameterTemplate);
  }
}
