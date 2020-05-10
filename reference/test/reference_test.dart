import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reference/reference.dart';
import 'package:reference/src/templates/template.dart' as template;
import 'package:reference/src/templates/template_interface.dart';

import 'reference_matchers.dart';

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
      final template.PlatformClassTemplate testClass =
          template.PlatformClassTemplate(
        1,
        template.PlatformClassTemplate(2, null),
      );

      referencePairManager.createRemoteReferenceFor(testClass);

      final RemoteReference remoteReference =
          referencePairManager.remoteReferenceFor(testClass);

      expect(remoteReference.referenceId, isNotNull);
      expect(
        referencePairManager.localReferenceFor(remoteReference),
        equals(testClass),
      );
      expect(methodCallLog, <Matcher>[
        isMethodCallWithMatchers('REFERENCE_CREATE', arguments: <dynamic>[
          remoteReference,
          TypeReference(0),
          <dynamic>[
            1,
            isUnpairedRemoteReferenceWithSame(
              TypeReference(0),
              <dynamic>[2, null],
            ),
          ],
        ]),
      ]);
    });

    test('disposeRemoteReferenceFor', () async {
      final ReferencePairManager referencePairManager =
          template.referencePairManager;
      final template.PlatformClassTemplate testClass =
          template.PlatformClassTemplate(3, null);

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
      final ReferencePairManager referencePairManager =
          template.referencePairManager;
      final template.PlatformClassTemplate testClass =
          template.PlatformClassTemplate(4, null);
      referencePairManager.createRemoteReferenceFor(testClass);
      methodCallLog.clear();

      final String result = await testClass.methodTemplate(
        'bye!',
        template.PlatformClassTemplate(16, null),
      );

      expect(result, equals('Goodbye!'));
      expect(methodCallLog, <Matcher>[
        isMethodCallWithMatchers('REFERENCE_METHOD', arguments: <dynamic>[
          referencePairManager.remoteReferenceFor(testClass),
          'methodTemplate',
          <dynamic>[
            'bye!',
            isUnpairedRemoteReferenceWithSame(
              TypeReference(0),
              <dynamic>[16, null],
            ),
          ],
        ]),
      ]);
    });

    test('executeLocalMethodFor', () async {
      final MethodChannelReferencePairManager referencePairManager =
          template.referencePairManager;

      final Completer<List<dynamic>> callbackCompleter =
          Completer<List<dynamic>>();

      final template.PlatformClassTemplate testClass = TestClassTemplate(
        5,
        null,
        (
          String parameterTemplate,
          ClassTemplate referenceParameterTemplate,
        ) async {
          callbackCompleter.complete(<dynamic>[
            parameterTemplate,
            referenceParameterTemplate,
          ]);
          return parameterTemplate + ' pie';
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
              'methodTemplate',
              <dynamic>[
                'Apple',
                UnpairedRemoteReference(TypeReference(0), <dynamic>[19, null]),
              ],
            ],
          ),
        ),
        (ByteData data) {
          responseCompleter.complete(
            referencePairManager.channel.codec.decodeEnvelope(data),
          );
        },
      );

      expect(
        callbackCompleter.future,
        completion(
          <dynamic>[
            'Apple',
            template.PlatformClassTemplate(19, null),
          ],
        ),
      );
      expect(responseCompleter.future, completion('Apple pie'));
    });

    test('createLocalReferenceFor', () async {
      final MethodChannelReferencePairManager referencePairManager =
          template.referencePairManager;

      await referencePairManager.channel.binaryMessenger.handlePlatformMessage(
        'test_plugin',
        referencePairManager.channel.codec.encodeMethodCall(
          MethodCall(
            'REFERENCE_CREATE',
            <dynamic>[
              RemoteReference('aowejea;io'),
              TypeReference(0),
              <dynamic>[
                8,
                UnpairedRemoteReference(TypeReference(0), <dynamic>[9, null]),
              ],
            ],
          ),
        ),
        (ByteData data) {},
      );

      final template.PlatformClassTemplate testClass =
          referencePairManager.localReferenceFor(RemoteReference('aowejea;io'));

      expect(testClass.fieldTemplate, equals(8));
      expect(testClass.referenceFieldTemplate.fieldTemplate, equals(9));
      expect(testClass.referenceFieldTemplate.referenceFieldTemplate, isNull);
    });

    test('disposeLocalReference', () async {
      final MethodChannelReferencePairManager referencePairManager =
          template.referencePairManager;

      await referencePairManager.channel.binaryMessenger.handlePlatformMessage(
        'test_plugin',
        referencePairManager.channel.codec.encodeMethodCall(
          MethodCall(
            'REFERENCE_CREATE',
            <dynamic>[
              RemoteReference('aowejea;io'),
              TypeReference(0),
              <dynamic>[45, null],
            ],
          ),
        ),
        (ByteData data) {},
      );

      final template.PlatformClassTemplate testClass =
          referencePairManager.localReferenceFor(RemoteReference('aowejea;io'));
      expect(testClass, isNotNull);
      expect(testClass.fieldTemplate, 45);
      expect(testClass.referenceFieldTemplate, isNull);

      await referencePairManager.channel.binaryMessenger.handlePlatformMessage(
        'test_plugin',
        referencePairManager.channel.codec.encodeMethodCall(
          MethodCall(
            'REFERENCE_DISPOSE',
            RemoteReference('aowejea;io'),
          ),
        ),
        (ByteData data) {},
      );

      expect(
        referencePairManager.localReferenceFor(RemoteReference('aowejea;io')),
        isNull,
      );
    });
  });
}

class TestClassTemplate extends template.PlatformClassTemplate {
  TestClassTemplate(
    int fieldTemplate,
    template.PlatformClassTemplate referenceFieldTemplate,
    this.onMethodTemplate,
  ) : super(fieldTemplate, referenceFieldTemplate);

  final Future<String> Function(
    String parameterTemplate,
    ClassTemplate referenceParameterTemplate,
  ) onMethodTemplate;

  @override
  FutureOr<String> methodTemplate(
    String parameterTemplate,
    ClassTemplate referenceParameterTemplate,
  ) {
    return onMethodTemplate(parameterTemplate, referenceParameterTemplate);
  }
}
