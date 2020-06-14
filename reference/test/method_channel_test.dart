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

    test('encode/decode $UnpairedReference', () {
      final ByteData byteData = methodCodec.encodeMethodCall(
        MethodCall(
          'a',
          UnpairedReference(56, <Object>[], "apple"),
        ),
      );

      expect(
        methodCodec.decodeMethodCall(byteData),
        isMethodCallWithMatchers(
          'a',
          arguments: isUnpairedReference(56, <Object>[], "apple"),
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

    test('pairWithNewRemoteReference', () async {
      final ClassTemplate testClass = ClassTemplate(1);

      referencePairManager.pairWithNewRemoteReference(testClass);
      final RemoteReference remoteReference =
          referencePairManager.getPairedRemoteReference(testClass);

      expect(methodCallLog, <Matcher>[
        isMethodCallWithMatchers('REFERENCE_CREATE', arguments: <Object>[
          remoteReference,
          0,
          <Object>[1],
        ]),
      ]);
    });

    test('disposePairWithLocalReference', () async {
      final ClassTemplate testClass = ClassTemplate(3);

      referencePairManager.pairWithNewRemoteReference(testClass);
      final RemoteReference remoteReference =
          referencePairManager.getPairedRemoteReference(testClass);
      methodCallLog.clear();

      referencePairManager.disposePairWithLocalReference(testClass);

      expect(methodCallLog, <Matcher>[
        isMethodCall(
          'REFERENCE_DISPOSE',
          arguments: remoteReference,
        ),
      ]);
    });

    test('invokeRemoteMethod', () async {
      final ClassTemplate testClass = ClassTemplate(4);
      referencePairManager.pairWithNewRemoteReference(testClass);
      methodCallLog.clear();

      final String result = await testClass.methodTemplate('bye!');

      expect(result, equals('Goodbye!'));
      expect(methodCallLog, <Matcher>[
        isMethodCallWithMatchers('REFERENCE_METHOD', arguments: <Object>[
          referencePairManager.getPairedRemoteReference(testClass),
          'methodTemplate',
          <Object>['bye!'],
        ]),
      ]);
    });

    test('invokeRemoteMethodOnUnpairedReference', () async {
      final ClassTemplate testClass = ClassTemplate(4);

      final String result = await testClass.methodTemplate('bye!');

      expect(result, equals('Goodbye!'));
      expect(methodCallLog, <Matcher>[
        isMethodCallWithMatchers('REFERENCE_METHOD', arguments: <Object>[
          isUnpairedReference(0, <dynamic>[4], null),
          'methodTemplate',
          <Object>['bye!'],
        ]),
      ]);
    });

    test('pairWithNewLocalReference', () async {
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

      final ClassTemplate testClass = referencePairManager
          .getPairedLocalReference(RemoteReference('aowejea;io'));

      expect(testClass, isClassTemplate(8));
    });

    test('invokeLocalMethod', () async {
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

      referencePairManager.pairWithNewRemoteReference(testClass);

      final Completer<String> responseCompleter = Completer<String>();
      await referencePairManager.channel.binaryMessenger.handlePlatformMessage(
        'github.penguin/reference/template',
        referencePairManager.channel.codec.encodeMethodCall(
          MethodCall(
            'REFERENCE_METHOD',
            <Object>[
              referencePairManager.getPairedRemoteReference(testClass),
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

    test('invokeLocalMethodOnUnpairedReference', () async {
      final Completer<String> responseCompleter = Completer<String>();
      await referencePairManager.channel.binaryMessenger.handlePlatformMessage(
        'github.penguin/reference/template',
        referencePairManager.channel.codec.encodeMethodCall(
          MethodCall(
            'REFERENCE_METHOD',
            <Object>[
              UnpairedReference(0, <dynamic>[18]),
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

      expect(methodCallLog, <Matcher>[
        isMethodCallWithMatchers('REFERENCE_METHOD', arguments: <Object>[
          isUnpairedReference(0, <dynamic>[18], null),
          'methodTemplate',
          <Object>['Apple'],
        ]),
      ]);
    });

    test('disposePairWithRemoteReference', () async {
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
              .getPairedLocalReference(RemoteReference('ajackwhack'))
          as ClassTemplate;
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
        referencePairManager
            .getPairedLocalReference(RemoteReference('ajackwhack')),
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
