import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reference/reference.dart';
import 'package:reference/src/template/src/template.dart' as template;
import 'package:reference/src/template/src/platform_interface_template.dart';

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
      final ClassTemplate testClass = ClassTemplate(
        1,
        ClassTemplate(2, ClassTemplate(43, null, null), null),
        <ClassTemplate>[ClassTemplate(3, null, null)],
      );

      referencePairManager
          .createRemoteReferenceFor(testClass as LocalReference);

      final RemoteReference remoteReference =
          referencePairManager.remoteReferenceFor(testClass as LocalReference);

      expect(remoteReference.referenceId, isNotNull);
      expect(
        referencePairManager.localReferenceFor(remoteReference),
        testClass,
      );
      expect(methodCallLog, <Matcher>[
        isMethodCallWithMatchers('REFERENCE_CREATE', arguments: <dynamic>[
          remoteReference,
          TypeReference(0),
          <dynamic>[
            1,
            isUnpairedRemoteReferenceWithSame(
              TypeReference(0),
              <dynamic>[
                2,
                isUnpairedRemoteReferenceWithSame(
                  TypeReference(0),
                  <dynamic>[43, null, null],
                ),
                null
              ],
            ),
            <Matcher>[
              isUnpairedRemoteReferenceWithSame(
                TypeReference(0),
                <dynamic>[3, null, null],
              ),
            ],
          ],
        ]),
      ]);
    });

    test('disposeRemoteReferenceFor', () async {
      final ReferencePairManager referencePairManager =
          template.referencePairManager;
      final ClassTemplate testClass = ClassTemplate(3, null, null);

      referencePairManager
          .createRemoteReferenceFor(testClass as LocalReference);
      final RemoteReference remoteReference =
          referencePairManager.remoteReferenceFor(testClass as LocalReference);
      methodCallLog.clear();

      referencePairManager
          .disposeRemoteReferenceFor(testClass as LocalReference);

      expect(referencePairManager.localReferenceFor(remoteReference), isNull);
      expect(
          referencePairManager.remoteReferenceFor(testClass as LocalReference),
          isNull);
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
      final ClassTemplate testClass = ClassTemplate(4, null, null);
      referencePairManager
          .createRemoteReferenceFor(testClass as LocalReference);
      methodCallLog.clear();

      final String result = await testClass.methodTemplate(
        'bye!',
        ClassTemplate(16, null, null),
        <ClassTemplate>[ClassTemplate(45, null, null)],
      );

      expect(result, equals('Goodbye!'));
      expect(methodCallLog, <Matcher>[
        isMethodCallWithMatchers('REFERENCE_METHOD', arguments: <dynamic>[
          referencePairManager.remoteReferenceFor(testClass as LocalReference),
          'methodTemplate',
          <dynamic>[
            'bye!',
            isUnpairedRemoteReferenceWithSame(
              TypeReference(0),
              <dynamic>[16, null, null],
            ),
            <Matcher>[
              isUnpairedRemoteReferenceWithSame(
                TypeReference(0),
                <dynamic>[45, null, null],
              ),
            ],
          ],
        ]),
      ]);
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
                UnpairedRemoteReference(
                  TypeReference(0),
                  <dynamic>[
                    9,
                    UnpairedRemoteReference(
                      TypeReference(0),
                      <dynamic>[14, null, null],
                    ),
                    null
                  ],
                ),
                <dynamic>[
                  UnpairedRemoteReference(
                    TypeReference(0),
                    <dynamic>[10, null, null],
                  ),
                ],
              ],
            ],
          ),
        ),
        (ByteData data) {},
      );

      final ClassTemplate testClass = referencePairManager
          .localReferenceFor(RemoteReference('aowejea;io')) as ClassTemplate;

      expect(
        testClass,
        isClassTemplateWithSame(
          8,
          isClassTemplateWithSame(
            9,
            isClassTemplateWithSame(14, null, null),
            null,
          ),
          <Matcher>[isClassTemplateWithSame(10, null, null)],
        ),
      );
    });

    test('executeLocalMethodFor', () async {
      final MethodChannelReferencePairManager referencePairManager =
          template.referencePairManager;

      final Completer<List<dynamic>> callbackCompleter =
          Completer<List<dynamic>>();

      final ClassTemplate testClass = TestClassTemplate(
        5,
        null,
        null,
        (
          String parameterTemplate,
          ClassTemplate referenceParameterTemplate,
          List<ClassTemplate> referenceListTemplate,
        ) async {
          callbackCompleter.complete(<dynamic>[
            parameterTemplate,
            referenceParameterTemplate,
            referenceListTemplate,
          ]);
          return parameterTemplate + ' pie';
        },
      );

      referencePairManager
          .createRemoteReferenceFor(testClass as LocalReference);

      final Completer<String> responseCompleter = Completer<String>();
      await referencePairManager.channel.binaryMessenger.handlePlatformMessage(
        'test_plugin',
        referencePairManager.channel.codec.encodeMethodCall(
          MethodCall(
            'REFERENCE_METHOD',
            <dynamic>[
              referencePairManager
                  .remoteReferenceFor(testClass as LocalReference),
              'methodTemplate',
              <dynamic>[
                'Apple',
                UnpairedRemoteReference(
                    TypeReference(0), <dynamic>[19, null, null]),
                <dynamic>[
                  UnpairedRemoteReference(
                    TypeReference(0),
                    <dynamic>[62, null, null],
                  ),
                ],
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
            isClassTemplateWithSame(19, null, null),
            <Matcher>[isClassTemplateWithSame(62, null, null)],
          ],
        ),
      );
      expect(responseCompleter.future, completion('Apple pie'));
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
              <dynamic>[45, null, null],
            ],
          ),
        ),
        (ByteData data) {},
      );

      final ClassTemplate testClass = referencePairManager
          .localReferenceFor(RemoteReference('aowejea;io')) as ClassTemplate;
      expect(testClass, isClassTemplateWithSame(45, null, null));

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
    ClassTemplate referenceFieldTemplate,
    List<ClassTemplate> referenceListTemplate,
    this.onMethodTemplate,
  ) : super(fieldTemplate, referenceFieldTemplate, referenceListTemplate);

  final Future<String> Function(
    String parameterTemplate,
    ClassTemplate referenceParameterTemplate,
    List<ClassTemplate> referenceListTemplate,
  ) onMethodTemplate;

  @override
  FutureOr<String> methodTemplate(
    String parameterTemplate,
    ClassTemplate referenceParameterTemplate,
    List<ClassTemplate> referenceListTemplate,
  ) {
    return onMethodTemplate(
      parameterTemplate,
      referenceParameterTemplate,
      referenceListTemplate,
    );
  }
}
