import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reference/reference.dart';
import 'package:reference/src/template/template.dart';

import 'reference_matchers.dart';

void main() {
  final List<MethodCall> methodCallLog = <MethodCall>[];

  TestWidgetsFlutterBinding.ensureInitialized();

  group('$ReferenceMessageCodec', () {
    final methodCodec = StandardMethodCodec(ReferenceMessageCodec());

    test('encode/decode $RemoteReference', () {
      final ByteData byteData = methodCodec.encodeMethodCall(
        MethodCall('oeifj', RemoteReference('a')),
      );

      expect(
        methodCodec.decodeMethodCall(byteData),
        isMethodCall('oeifj', arguments: RemoteReference('a')),
      );
    });

    test('encode/decode $UnpairedRemoteReference', () {
      final ByteData byteData = methodCodec.encodeMethodCall(
        MethodCall(
          'a',
          UnpairedRemoteReference(56, <Object>[], "apple"),
        ),
      );

      expect(
        methodCodec.decodeMethodCall(byteData),
        isMethodCallWithMatchers(
          'a',
          arguments: isUnpairedRemoteReference(56, <Object>[], "apple"),
        ),
      );
    });
  });

  group('$MethodChannelReferencePairManager', () {
    setUp(() {
      referencePairManager = ReferencePairManagerTemplate()..initialize();
      referencePairManager.channel.setMockMethodCallHandler(
        (MethodCall methodCall) async {
          methodCallLog.add(methodCall);
          if (methodCall.method == 'REFERENCE_METHOD') {
            switch (methodCall.arguments[1]) {
              case 'methodTemplate':
                return 'Good' + methodCall.arguments[2][0];
            }
          }
          return null;
        },
      );
    });

    tearDown(() {
      referencePairManager = null;
      methodCallLog.clear();
    });

    test('createRemoteReferenceFor', () async {
      final ClassTemplate testClass = ClassTemplate(1);

      referencePairManager.createRemoteReferenceFor(testClass);

      final RemoteReference remoteReference =
          referencePairManager.remoteReferenceFor(testClass);

      expect(remoteReference?.referenceId, isNotNull);
      expect(
        referencePairManager.localReferenceFor(remoteReference),
        testClass,
      );
      expect(methodCallLog, <Matcher>[
        isMethodCallWithMatchers('REFERENCE_CREATE', arguments: <Object>[
          remoteReference,
          0,
          <Object>[1],
        ]),
      ]);
    });

    test('disposeRemoteReferenceFor', () async {
      final ClassTemplate testClass = ClassTemplate(3);

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

    test('executeRemoteMethodFor', () async {
      final ClassTemplate testClass = ClassTemplate(4);
      referencePairManager.createRemoteReferenceFor(testClass);
      methodCallLog.clear();

      final String result = await testClass.methodTemplate('bye!');

      expect(result, equals('Goodbye!'));
      expect(methodCallLog, <Matcher>[
        isMethodCallWithMatchers('REFERENCE_METHOD', arguments: <Object>[
          referencePairManager.remoteReferenceFor(testClass),
          'methodTemplate',
          <Object>['bye!'],
        ]),
      ]);
    });

    test('createLocalReferenceFor', () async {
      await referencePairManager.channel.binaryMessenger.handlePlatformMessage(
        'github.penguin/reference/template',
        referencePairManager.channel.codec.encodeMethodCall(
          MethodCall(
            'REFERENCE_CREATE',
            <Object>[
              RemoteReference('aowejea;io'),
              0,
              <Object>[8],
            ],
          ),
        ),
        (ByteData data) {},
      );

      final ClassTemplate testClass =
          referencePairManager.localReferenceFor(RemoteReference('aowejea;io'));

      expect(testClass, isClassTemplate(8));
    });

    test('executeLocalMethodFor', () async {
      final Completer<List<Object>> callbackCompleter =
          Completer<List<Object>>();

      final ClassTemplate testClass = TestClassTemplate(
        5,
        (String parameterTemplate) {
          callbackCompleter.complete(<Object>[
            parameterTemplate,
          ]);
          return parameterTemplate + ' pie';
        },
      );

      referencePairManager.createRemoteReferenceFor(testClass);

      final Completer<String> responseCompleter = Completer<String>();
      await referencePairManager.channel.binaryMessenger.handlePlatformMessage(
        'github.penguin/reference/template',
        referencePairManager.channel.codec.encodeMethodCall(
          MethodCall(
            'REFERENCE_METHOD',
            <Object>[
              referencePairManager.remoteReferenceFor(testClass),
              'methodTemplate',
              <Object>['Apple'],
            ],
          ),
        ),
        (ByteData data) {
          responseCompleter.complete(
            referencePairManager.channel.codec.decodeEnvelope(data),
          );
        },
      );

      expect(callbackCompleter.future, completion(<Object>['Apple']));
      expect(responseCompleter.future, completion('Apple pie'));
    });

    test('disposeLocalReference', () async {
      await referencePairManager.channel.binaryMessenger.handlePlatformMessage(
        'github.penguin/reference/template',
        referencePairManager.channel.codec.encodeMethodCall(
          MethodCall(
            'REFERENCE_CREATE',
            <Object>[
              RemoteReference('ajackwhack'),
              0,
              <Object>[45],
            ],
          ),
        ),
        (ByteData data) {},
      );

      final ClassTemplate testClass = referencePairManager
          .localReferenceFor(RemoteReference('ajackwhack')) as ClassTemplate;
      expect(testClass, isClassTemplate(45));

      await referencePairManager.channel.binaryMessenger.handlePlatformMessage(
        'github.penguin/reference/template',
        referencePairManager.channel.codec.encodeMethodCall(
          MethodCall(
            'REFERENCE_DISPOSE',
            RemoteReference('ajackwhack'),
          ),
        ),
        (ByteData data) {},
      );

      expect(
        referencePairManager.localReferenceFor(RemoteReference('ajackwhack')),
        isNull,
      );
    });
  });
}

class TestClassTemplate extends ClassTemplate {
  TestClassTemplate(int fieldTemplate, this.onMethodTemplate)
      : super(fieldTemplate);

  final String Function(String parameterTemplate) onMethodTemplate;

  @override
  FutureOr<String> methodTemplate(String parameterTemplate) {
    return onMethodTemplate(parameterTemplate);
  }
}
