import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reference/reference.dart';
import 'package:reference/src/templates/implementation.dart';
import 'package:uuid/uuid.dart';

void main() {
  final List<MethodCall> log = <MethodCall>[];

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    referenceManager = GeneratedReferenceManager('test_channel')..initialize();
    referenceManager.channel.setMockMethodCallHandler(
      (MethodCall methodCall) async {
        log.add(methodCall);
        if (methodCall.method == MethodChannelReferenceManager.methodMethod) {
          switch(methodCall.arguments[1]) {
            case 'methodTemplate':
              return 'Hello!';
            case 'callbackTemplate':
              return 'Potato';
          }
        }
        return null;
      },
    );
  });

  tearDown(() {
    referenceManager = null;
    log.clear();
  });

  test('retain', () async {
    final ClassTemplate testClass = ClassTemplate(1, null);

    referenceManager.retain(testClass);
    referenceManager.retain(testClass);

    expect(log, <Matcher>[
      isMethodCall('REFERENCE_CREATE', arguments: <dynamic>[
        referenceManager.getReferenceId(testClass),
        ClassTemplate(1, null),
      ]),
    ]);
  });

  test('release', () async {
    final ClassTemplate testClass = ClassTemplate(2, null);

    referenceManager.retain(testClass);
    final String referenceId = referenceManager.getReferenceId(testClass);
    log.clear();

    referenceManager.release(testClass);
    expect(log, <Matcher>[
      isMethodCall(
        'REFERENCE_DISPOSE',
        arguments: Reference(referenceId),
      ),
    ]);
  });

  test('sendMethodCall', () async {
    final ClassTemplate testClass = ClassTemplate(3, null);
    referenceManager.retain(testClass);
    log.clear();

    final String result = await testClass.methodTemplate('Goodbye!');

    expect(result, equals('Hello!'));
    expect(log, <Matcher>[
      isMethodCall('REFERENCE_METHOD', arguments: <dynamic>[
        Reference(referenceManager.getReferenceId(testClass)),
        'methodTemplate',
        <dynamic>['Goodbye!'],
      ]),
    ]);
  });

  test('receiveLocalMethodCall', () async {
    final Completer<double> callbackCompleter = Completer<double>();
    final ClassTemplate testClass = ClassTemplate(3, (double testParameter) {
      callbackCompleter.complete(testParameter);
      return 'Apple';
    });

    referenceManager.retain(testClass);

    final Completer<String> responseCompleter = Completer<String>();
    referenceManager.channel.binaryMessenger.handlePlatformMessage(
      'test_channel',
      referenceManager.channel.codec.encodeMethodCall(
        MethodCall(
          'REFERENCE_METHOD',
          <dynamic>[
            Reference(referenceManager.getReferenceId(testClass)),
            'callbackTemplate',
            <dynamic>[46.0],
          ],
        ),
      ),
      (ByteData data) {
        responseCompleter.complete(
          referenceManager.channel.codec.decodeEnvelope(data),
        );
      },
    );

    expect(callbackCompleter.future, completion(46.0));
    expect(responseCompleter.future, completion('Apple'));
  });

  test('createLocalReference', () async {
    final String referenceId = Uuid().v4();
    referenceManager.channel.binaryMessenger.handlePlatformMessage(
      'test_channel',
      referenceManager.channel.codec.encodeMethodCall(
        MethodCall(
          'REFERENCE_CREATE',
          <dynamic>[
            referenceId,
            ClassTemplate(45, null),
          ],
        ),
      ),
      (ByteData data) {},
    );

    final ClassTemplate testClass = referenceManager.getHolder(referenceId);
    expect(testClass.fieldTemplate, equals(45));
    expect(testClass.callbackTemplate, isNotNull);
  });

  test('sendMethodCall for callback', () async {
    final String referenceId = Uuid().v4();
    referenceManager.channel.binaryMessenger.handlePlatformMessage(
      'test_channel',
      referenceManager.channel.codec.encodeMethodCall(
        MethodCall(
          'REFERENCE_CREATE',
          <dynamic>[
            referenceId,
            ClassTemplate(45, null),
          ],
        ),
      ),
      (ByteData data) {},
    );

    final ClassTemplate testClass = referenceManager.getHolder(referenceId);
    final String result = await testClass.callbackTemplate(34.4);

    expect(result, equals('Potato'));
    expect(log, <Matcher>[
      isMethodCall('REFERENCE_METHOD', arguments: <dynamic>[
        Reference(referenceId),
        'callbackTemplate',
        <dynamic>[34.4],
      ]),
    ]);
  });
}
