import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reference/reference.dart';
import 'package:reference/src/template/template.dart';

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
      referencePairManager = ReferencePairManagerTemplate()..initialize();
      referencePairManager.channel.setMockMethodCallHandler(
        (MethodCall methodCall) async {
          methodCallLog.add(methodCall);
          if (methodCall.method == 'REFERENCE_METHOD') {
            switch (methodCall.arguments[1]) {
              case 'methodTemplate':
                return 'Good' + methodCall.arguments[2][0];
              case 'returnsReference':
                return UnpairedRemoteReference(
                  TypeReference(0),
                  <dynamic>[44, null, null, null],
                );
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
      final ClassTemplate testClass = ClassTemplate(
        1,
        ClassTemplate(2, ClassTemplate(43, null, null, null), null, null),
        <ClassTemplate>[ClassTemplate(3, null, null, null)],
        <String, ClassTemplate>{
          'fire': ClassTemplate(14, null, null, null),
        },
      );

      referencePairManager.createRemoteReferenceFor(testClass);

      final RemoteReference remoteReference =
          referencePairManager.remoteReferenceFor(testClass);

      expect(remoteReference?.referenceId, isNotNull);
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
                  <dynamic>[
                    43,
                    null,
                    null,
                    null,
                  ],
                ),
                null,
                null,
              ],
            ),
            <Matcher>[
              isUnpairedRemoteReferenceWithSame(
                TypeReference(0),
                <dynamic>[3, null, null, null],
              ),
            ],
            <String, Matcher>{
              'fire': isUnpairedRemoteReferenceWithSame(
                TypeReference(0),
                <dynamic>[14, null, null, null],
              )
            },
          ],
        ]),
      ]);
    });

    test('disposeRemoteReferenceFor', () async {
      final ClassTemplate testClass = ClassTemplate(3, null, null, null);

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
      final ClassTemplate testClass = ClassTemplate(4, null, null, null);
      referencePairManager.createRemoteReferenceFor(testClass);
      methodCallLog.clear();

      final String result = await testClass.methodTemplate(
        'bye!',
        ClassTemplate(16, null, null, null),
        <ClassTemplate>[ClassTemplate(45, null, null, null)],
        <String, ClassTemplate>{
          'pickle': ClassTemplate(4555, null, null, null),
        },
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
              <dynamic>[16, null, null, null],
            ),
            <Matcher>[
              isUnpairedRemoteReferenceWithSame(
                TypeReference(0),
                <dynamic>[45, null, null, null],
              ),
            ],
            <String, Matcher>{
              'pickle': isUnpairedRemoteReferenceWithSame(
                TypeReference(0),
                <dynamic>[4555, null, null, null],
              ),
            }
          ],
        ]),
      ]);
    });

    test('executeRemoteMethodFor returnsReference', () async {
      final ClassTemplate testClass = ClassTemplate(10101, null, null, null);
      referencePairManager.createRemoteReferenceFor(testClass);
      methodCallLog.clear();

      final ClassTemplate result = await testClass.returnsReference();

      expect(result, isClassTemplateWithSame(44, null, null, null));
    });

    test('createLocalReferenceFor', () async {
      await referencePairManager.channel.binaryMessenger.handlePlatformMessage(
        'github.penguin/reference',
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
                      <dynamic>[14, null, null, null],
                    ),
                    null,
                    null,
                  ],
                ),
                <dynamic>[
                  UnpairedRemoteReference(
                    TypeReference(0),
                    <dynamic>[10, null, null, null],
                  ),
                ],
                <dynamic, dynamic>{
                  'ohno': UnpairedRemoteReference(
                    TypeReference(0),
                    <dynamic>[13, null, null, null],
                  ),
                }
              ],
            ],
          ),
        ),
        (ByteData data) {},
      );

      final ClassTemplate testClass =
          referencePairManager.localReferenceFor(RemoteReference('aowejea;io'));

      expect(
        testClass,
        isClassTemplateWithSame(
          8,
          isClassTemplateWithSame(
            9,
            isClassTemplateWithSame(14, null, null, null),
            null,
            null,
          ),
          <Matcher>[isClassTemplateWithSame(10, null, null, null)],
          <String, Matcher>{
            'ohno': isClassTemplateWithSame(13, null, null, null)
          },
        ),
      );
    });

    test('executeLocalMethodFor', () async {
      final Completer<List<dynamic>> callbackCompleter =
          Completer<List<dynamic>>();

      final ClassTemplate testClass = TestClassTemplate(5, null, null, null, (
        String parameterTemplate,
        ClassTemplate referenceParameterTemplate,
        List<ClassTemplate> referenceListTemplate,
        Map<String, ClassTemplate> referenceMapTemplate,
      ) {
        callbackCompleter.complete(<dynamic>[
          parameterTemplate,
          referenceParameterTemplate,
          referenceListTemplate,
          referenceMapTemplate,
        ]);
        return parameterTemplate + ' pie';
      }, null);

      referencePairManager.createRemoteReferenceFor(testClass);

      final Completer<String> responseCompleter = Completer<String>();
      await referencePairManager.channel.binaryMessenger.handlePlatformMessage(
        'github.penguin/reference',
        referencePairManager.channel.codec.encodeMethodCall(
          MethodCall(
            'REFERENCE_METHOD',
            <dynamic>[
              referencePairManager.remoteReferenceFor(testClass),
              'methodTemplate',
              <dynamic>[
                'Apple',
                UnpairedRemoteReference(
                    TypeReference(0), <dynamic>[19, null, null, null]),
                <dynamic>[
                  UnpairedRemoteReference(
                    TypeReference(0),
                    <dynamic>[62, null, null, null],
                  ),
                ],
                <dynamic, dynamic>{
                  'poyo': UnpairedRemoteReference(
                    TypeReference(0),
                    <dynamic>[11, null, null, null],
                  ),
                },
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
            isClassTemplateWithSame(19, null, null, null),
            <Matcher>[isClassTemplateWithSame(62, null, null, null)],
            <String, Matcher>{
              'poyo': isClassTemplateWithSame(11, null, null, null),
            }
          ],
        ),
      );
      expect(responseCompleter.future, completion('Apple pie'));
    });

    test('executeLocalMethodFor returnsReference', () async {
      final ClassTemplate testClass = TestClassTemplate(
        6,
        null,
        null,
        null,
        null,
        () => ClassTemplate(919, null, null, null),
      );

      referencePairManager.createRemoteReferenceFor(testClass);

      final Completer<UnpairedRemoteReference> responseCompleter =
          Completer<UnpairedRemoteReference>();
      await referencePairManager.channel.binaryMessenger.handlePlatformMessage(
        'github.penguin/reference',
        referencePairManager.channel.codec.encodeMethodCall(
          MethodCall(
            'REFERENCE_METHOD',
            <dynamic>[
              referencePairManager.remoteReferenceFor(testClass),
              'returnsReference',
              <dynamic>[],
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
        responseCompleter.future,
        completion(
          isUnpairedRemoteReferenceWithSame(
            TypeReference(0),
            <dynamic>[919, null, null, null],
          ),
        ),
      );
    });

    test('disposeLocalReference', () async {
      await referencePairManager.channel.binaryMessenger.handlePlatformMessage(
        'github.penguin/reference',
        referencePairManager.channel.codec.encodeMethodCall(
          MethodCall(
            'REFERENCE_CREATE',
            <dynamic>[
              RemoteReference('aowejea;io'),
              TypeReference(0),
              <dynamic>[45, null, null, null],
            ],
          ),
        ),
        (ByteData data) {},
      );

      final ClassTemplate testClass = referencePairManager
          .localReferenceFor(RemoteReference('aowejea;io')) as ClassTemplate;
      expect(testClass, isClassTemplateWithSame(45, null, null, null));

      await referencePairManager.channel.binaryMessenger.handlePlatformMessage(
        'github.penguin/reference',
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

class TestClassTemplate extends ClassTemplate {
  TestClassTemplate(
    int fieldTemplate,
    ClassTemplate referenceFieldTemplate,
    List<ClassTemplate> referenceListTemplate,
    Map<String, ClassTemplate> referenceMapTemplate,
    this.onMethodTemplate,
    this.onReturnsReference,
  ) : super(fieldTemplate, referenceFieldTemplate, referenceListTemplate,
            referenceMapTemplate);

  final String Function(
    String parameterTemplate,
    ClassTemplate referenceParameterTemplate,
    List<ClassTemplate> referenceListTemplate,
    Map<String, ClassTemplate> referenceMapTemplate,
  ) onMethodTemplate;

  final ClassTemplate Function() onReturnsReference;

  @override
  FutureOr<String> methodTemplate(
    String parameterTemplate,
    ClassTemplate referenceParameterTemplate,
    List<ClassTemplate> referenceListTemplate,
    Map<String, ClassTemplate> referenceMapTemplate,
  ) {
    return onMethodTemplate(
      parameterTemplate,
      referenceParameterTemplate,
      referenceListTemplate,
      referenceMapTemplate,
    );
  }

  @override
  FutureOr<ClassTemplate> returnsReference() {
    return onReturnsReference();
  }
}
