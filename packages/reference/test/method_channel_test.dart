import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reference/reference.dart';

import 'reference_matchers.dart';
import 'test_classes.dart' hide TestMessenger;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('$ReferenceMessageCodec', () {
    const ReferenceMessageCodec messageCodec = ReferenceMessageCodec();

    test('encode/decode $PairedInstance', () {
      final ByteData? byteData = messageCodec.encodeMessage(
        const PairedInstance('a'),
      );

      expect(
        messageCodec.decodeMessage(byteData),
        const PairedInstance('a'),
      );
    });

    test('encode/decode $NewUnpairedInstance', () {
      final ByteData? byteData = messageCodec.encodeMessage(
        const NewUnpairedInstance('apple', <Object>[]),
      );

      expect(
        messageCodec.decodeMessage(byteData),
        isUnpairedInstance('apple', <Object>[]),
      );
    });
  });

  group('$MethodChannelConverter', () {
    final MethodChannelMessenger messenger = MethodChannelMessenger('a_name');

    test('convertForRemoteMessenger', () {
      final InstanceConverter converter = messenger.converter;
      expect(
        converter.convertForRemoteMessenger(messenger, Uint8List(2)),
        isA<Uint8List>(),
      );
      expect(
        converter.convertForRemoteMessenger(messenger, Int32List(2)),
        isA<Int32List>(),
      );
      expect(
        converter.convertForRemoteMessenger(messenger, Int64List(2)),
        isA<Int64List>(),
      );
      expect(
        converter.convertForRemoteMessenger(messenger, Float64List(2)),
        isA<Float64List>(),
      );
    });

    test('convertForLocalMessenger', () {
      final InstanceConverter converter = messenger.converter;
      expect(
        converter.convertForLocalMessenger(messenger, Uint8List(2)),
        isA<Uint8List>(),
      );
      expect(
        converter.convertForLocalMessenger(messenger, Int32List(2)),
        isA<Int32List>(),
      );
      expect(
        converter.convertForLocalMessenger(messenger, Int64List(2)),
        isA<Int64List>(),
      );
      expect(
        converter.convertForLocalMessenger(messenger, Float64List(2)),
        isA<Float64List>(),
      );
    });
  });

  group('$MethodChannelMessenger', () {
    late TestMessenger testMessenger;

    setUp(() {
      testMessenger = TestMessenger();
    });

    test('onReceiveCreateNewInstancePair', () async {
      await testMessenger.channel.binaryMessenger.handlePlatformMessage(
        'test_method_channel',
        testMessenger.channel.codec.encodeMethodCall(
          const MethodCall(
            'REFERENCE_CREATE',
            <Object>[
              'test_channel',
              PairedInstance('test_reference_id'),
              <Object>[],
            ],
          ),
        ),
        (ByteData? data) {},
      );

      expect(
        testMessenger.isPaired(testMessenger.testHandler.testClassInstance),
        isTrue,
      );
    });

    test('onReceiveInvokeStaticMethod', () async {
      final Completer<String> responseCompleter = Completer<String>();
      await testMessenger.channel.binaryMessenger.handlePlatformMessage(
        'test_method_channel',
        testMessenger.channel.codec.encodeMethodCall(
          const MethodCall(
            'REFERENCE_STATIC_METHOD',
            <Object>['test_channel', 'aStaticMethod', <Object>[]],
          ),
        ),
        (ByteData? data) {
          responseCompleter.complete(
            testMessenger.channel.codec.decodeEnvelope(data!)
                as FutureOr<String>?,
          );
        },
      );

      expect(responseCompleter.future, completion('return_value'));
    });

    test('onReceiveInvokeMethod', () async {
      testMessenger.onReceiveCreateNewInstancePair(
        'test_channel',
        const PairedInstance('test_id'),
        <Object>[],
      );

      final Completer<String> responseCompleter = Completer<String>();
      await testMessenger.channel.binaryMessenger.handlePlatformMessage(
        'test_method_channel',
        testMessenger.channel.codec.encodeMethodCall(
          const MethodCall(
            'REFERENCE_METHOD',
            <Object>[
              'test_channel',
              PairedInstance('test_id'),
              'aMethod',
              <Object>[],
            ],
          ),
        ),
        (ByteData? data) {
          responseCompleter.complete(
            testMessenger.channel.codec.decodeEnvelope(data!)
                as FutureOr<String>?,
          );
        },
      );

      expect(responseCompleter.future, completion('return_value'));
    });

    test('onReceiveInvokeMethodOnUnpairedInstance', () async {
      final Completer<String> responseCompleter = Completer<String>();
      await testMessenger.channel.binaryMessenger.handlePlatformMessage(
        'test_method_channel',
        testMessenger.channel.codec.encodeMethodCall(
          const MethodCall(
            'REFERENCE_UNPAIRED_METHOD',
            <Object>[
              NewUnpairedInstance('test_channel', <dynamic>[]),
              'aMethod',
              <Object>[],
            ],
          ),
        ),
        (ByteData? data) {
          responseCompleter.complete(
            testMessenger.channel.codec.decodeEnvelope(data!)
                as FutureOr<String>?,
          );
        },
      );

      expect(responseCompleter.future, completion('return_value'));
    });

    test('onReceiveDisposeInstancePair', () async {
      testMessenger.onReceiveCreateNewInstancePair(
        'test_channel',
        const PairedInstance('test_id'),
        <Object>[],
      );

      await testMessenger.channel.binaryMessenger.handlePlatformMessage(
        'test_method_channel',
        testMessenger.channel.codec.encodeMethodCall(
          const MethodCall(
            'REFERENCE_DISPOSE',
            <Object>['test_channel', PairedInstance('test_id')],
          ),
        ),
        (ByteData? data) {},
      );

      expect(
        testMessenger.isPaired(testMessenger.testHandler.testClassInstance),
        isFalse,
      );
    });
  });

  group('$MethodChannelDispatcher', () {
    final List<MethodCall> methodCallLog = <MethodCall>[];
    late TestMessenger testMessenger;
    late TypeChannel<TestClass> testChannel;

    setUp(() {
      methodCallLog.clear();
      testMessenger = TestMessenger();
      testChannel = TypeChannel<TestClass>(testMessenger, 'test_channel');

      testMessenger.channel.setMockMethodCallHandler(
        (MethodCall methodCall) async {
          methodCallLog.add(methodCall);
          if (methodCall.method == 'REFERENCE_METHOD' &&
              methodCall.arguments[2] == 'aMethod') {
            return 'return_value';
          } else if (methodCall.method == 'REFERENCE_STATIC_METHOD' &&
              methodCall.arguments[1] == 'aStaticMethod') {
            return 'return_value';
          } else if (methodCall.method == 'REFERENCE_UNPAIRED_METHOD' &&
              methodCall.arguments[1] == 'aMethod') {
            return 'return_value';
          }
          return null;
        },
      );
    });

    test('createNewPair', () {
      testChannel.createNewInstancePair(TestClass(testMessenger));

      expect(methodCallLog, <Matcher>[
        isMethodCallWithMatchers('REFERENCE_CREATE', arguments: <Object>[
          'test_channel',
          const PairedInstance('test_reference_id'),
          <Object>[],
        ]),
      ]);
    });

    test('sendInvokeStaticMethod', () {
      expect(
        testChannel.sendInvokeStaticMethod('aStaticMethod', <Object>[]),
        completion('return_value'),
      );
      expect(methodCallLog, <Matcher>[
        isMethodCallWithMatchers('REFERENCE_STATIC_METHOD', arguments: <Object>[
          'test_channel',
          'aStaticMethod',
          <Object>[],
        ]),
      ]);
    });

    test('sendInvokeMethod', () {
      final TestClass testClass = TestClass(testMessenger);
      testChannel.createNewInstancePair(testClass);

      methodCallLog.clear();

      expect(
        testChannel.sendInvokeMethod(testClass, 'aMethod', <Object>[]),
        completion('return_value'),
      );
      expect(methodCallLog, <Matcher>[
        isMethodCallWithMatchers('REFERENCE_METHOD', arguments: <Object>[
          'test_channel',
          const PairedInstance('test_reference_id'),
          'aMethod',
          <Object>[],
        ]),
      ]);
    });

    test('sendInvokeMethodOnUnpairedReference', () {
      expect(
        testChannel
            .sendInvokeMethod(TestClass(testMessenger), 'aMethod', <Object>[]),
        completion('return_value'),
      );
      expect(methodCallLog, <Matcher>[
        isMethodCallWithMatchers(
          'REFERENCE_UNPAIRED_METHOD',
          arguments: <Object>[
            isUnpairedInstance('test_channel', <Object>[]),
            'aMethod',
            <Object>[],
          ],
        ),
      ]);
    });

    test('disposePair', () {
      final TestClass testClass = TestClass(testMessenger);
      testChannel.createNewInstancePair(testClass);

      methodCallLog.clear();

      testChannel.disposeInstancePair(testClass);
      expect(testMessenger.isPaired(testClass), isFalse);
      expect(methodCallLog, <Matcher>[
        isMethodCall(
          'REFERENCE_DISPOSE',
          arguments: <Object>[
            'test_channel',
            const PairedInstance('test_reference_id'),
          ],
        ),
      ]);
    });
  });
}

class TestMessenger extends MethodChannelMessenger {
  TestMessenger() : super('test_method_channel') {
    testHandler = TestHandler(this);
    registerHandler('test_channel', testHandler);
  }

  late final TestHandler testHandler;

  @override
  String generateUniqueInstanceId(Object instance) {
    return 'test_reference_id';
  }
}
