import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:reference/reference.dart';

import 'reference_matchers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('$ReferenceMessageCodec', () {
    final ReferenceMessageCodec messageCodec = ReferenceMessageCodec();

    test('encode/decode $RemoteReference', () {
      final ByteData byteData = messageCodec.encodeMessage(
        RemoteReference('a'),
      );

      expect(
        messageCodec.decodeMessage(byteData),
        RemoteReference('a'),
      );
    });

    test('encode/decode $UnpairedReference', () {
      final ByteData byteData = messageCodec.encodeMessage(
        UnpairedReference('apple', <Object>[]),
      );

      expect(
        messageCodec.decodeMessage(byteData),
        isUnpairedReference('apple', <Object>[]),
      );
    });
  });

  group('$MethodChannelManager', () {
    TestManager testManager;

    setUp(() {
      testManager = TestManager();
    });

    test('onReceiveCreateNewPair', () async {
      final TestClass testClass = TestClass(testManager);

      when(testManager.mockHandler.createInstance(testManager, <Object>[]))
          .thenReturn(testClass);

      await testManager.channel.binaryMessenger.handlePlatformMessage(
        'test_method_channel',
        testManager.channel.codec.encodeMethodCall(
          MethodCall(
            'REFERENCE_CREATE',
            <Object>[
              'test_channel',
              RemoteReference('test_reference_id'),
              <Object>[],
            ],
          ),
        ),
        (ByteData data) {},
      );

      expect(testManager.isPaired(testClass), isTrue);
    });

    test('onReceiveInvokeStaticMethod', () async {
      when(
        testManager.mockHandler.invokeStaticMethod(
          testManager,
          'aStaticMethod',
          <Object>[],
        ),
      ).thenReturn('return_value');

      final Completer<String> responseCompleter = Completer<String>();
      await testManager.channel.binaryMessenger.handlePlatformMessage(
        'test_method_channel',
        testManager.channel.codec.encodeMethodCall(
          MethodCall(
            'REFERENCE_STATIC_METHOD',
            <Object>['test_channel', 'aStaticMethod', <Object>[]],
          ),
        ),
        (ByteData data) {
          responseCompleter.complete(
            testManager.channel.codec.decodeEnvelope(data),
          );
        },
      );

      expect(responseCompleter.future, completion('return_value'));
    });

    test('onReceiveInvokeMethod', () async {
      final TestClass testClass = TestClass(testManager);

      when(testManager.mockHandler.createInstance(testManager, <Object>[]))
          .thenReturn(testClass);

      testManager.onReceiveCreateNewPair(
        'test_channel',
        RemoteReference('test_id'),
        <Object>[],
      );

      when(
        testManager.mockHandler.invokeMethod(
          testManager,
          testClass,
          'aMethod',
          <Object>[],
        ),
      ).thenReturn('return_value');

      final Completer<String> responseCompleter = Completer<String>();
      await testManager.channel.binaryMessenger.handlePlatformMessage(
        'test_method_channel',
        testManager.channel.codec.encodeMethodCall(
          MethodCall(
            'REFERENCE_METHOD',
            <Object>[
              'test_channel',
              RemoteReference('test_id'),
              'aMethod',
              <Object>[],
            ],
          ),
        ),
        (ByteData data) {
          responseCompleter.complete(
            testManager.channel.codec.decodeEnvelope(data),
          );
        },
      );

      expect(responseCompleter.future, completion('return_value'));
    });

    test('onReceiveInvokeMethodOnUnpairedReference', () async {
      final TestClass testClass = TestClass(testManager);

      when(testManager.mockHandler.createInstance(testManager, <Object>[]))
          .thenReturn(testClass);

      when(
        testManager.mockHandler.invokeMethod(
          testManager,
          testClass,
          'aMethod',
          <Object>[],
        ),
      ).thenReturn('return_value');

      final Completer<String> responseCompleter = Completer<String>();
      await testManager.channel.binaryMessenger.handlePlatformMessage(
        'test_method_channel',
        testManager.channel.codec.encodeMethodCall(
          MethodCall(
            'REFERENCE_UNPAIRED_METHOD',
            <Object>[
              UnpairedReference('test_channel', <dynamic>[]),
              'aMethod',
              <Object>[],
            ],
          ),
        ),
        (ByteData data) {
          responseCompleter.complete(
            testManager.channel.codec.decodeEnvelope(data),
          );
        },
      );

      expect(responseCompleter.future, completion('return_value'));
    });

    test('onReceiveDisposePair', () async {
      final TestClass testClass = TestClass(testManager);

      when(testManager.mockHandler.createInstance(testManager, <Object>[]))
          .thenReturn(testClass);

      testManager.onReceiveCreateNewPair(
        'test_channel',
        RemoteReference('test_id'),
        <Object>[],
      );

      await testManager.channel.binaryMessenger.handlePlatformMessage(
        'test_method_channel',
        testManager.channel.codec.encodeMethodCall(
          MethodCall(
            'REFERENCE_DISPOSE',
            <Object>['test_channel', RemoteReference('test_id')],
          ),
        ),
        (ByteData data) {},
      );

      expect(testManager.isPaired(testClass), isFalse);
    });
  });

  group('$MethodChannelMessenger', () {
    final List<MethodCall> methodCallLog = <MethodCall>[];
    TestManager testManager;
    ReferenceChannel<TestClass> testChannel;

    setUp(() {
      methodCallLog.clear();
      testManager = TestManager();
      testChannel = ReferenceChannel<TestClass>(testManager, 'test_channel');

      testManager.channel.setMockMethodCallHandler(
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
      final TestClass testClass = TestClass(testManager);

      when(testManager.mockHandler.getCreationArguments(testManager, testClass))
          .thenReturn(<Object>[]);

      testChannel.createNewPair(testClass);

      expect(methodCallLog, <Matcher>[
        isMethodCallWithMatchers('REFERENCE_CREATE', arguments: <Object>[
          'test_channel',
          RemoteReference('test_reference_id'),
          <Object>[],
        ]),
      ]);
    });

    test('sendInvokeStaticMethod', () {
      expect(
        testChannel.invokeStaticMethod('aStaticMethod', <Object>[]),
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
      final TestClass testClass = TestClass(testManager);
      testChannel.createNewPair(testClass);

      methodCallLog.clear();

      expect(
        testChannel.invokeMethod(testClass, 'aMethod', <Object>[]),
        completion('return_value'),
      );
      expect(methodCallLog, <Matcher>[
        isMethodCallWithMatchers('REFERENCE_METHOD', arguments: <Object>[
          'test_channel',
          RemoteReference('test_reference_id'),
          'aMethod',
          <Object>[],
        ]),
      ]);
    });

    test('sendInvokeMethodOnUnpairedReference', () {
      final TestClass testClass = TestClass(testManager);

      when(testManager.mockHandler.getCreationArguments(testManager, testClass))
          .thenReturn(<Object>[]);

      expect(
        testChannel.invokeMethodOnUnpairedReference(
          testClass,
          'aMethod',
          <Object>[],
        ),
        completion('return_value'),
      );
      expect(methodCallLog, <Matcher>[
        isMethodCallWithMatchers(
          'REFERENCE_UNPAIRED_METHOD',
          arguments: <Object>[
            isUnpairedReference('test_channel', <Object>[]),
            'aMethod',
            <Object>[],
          ],
        ),
      ]);
    });

    test('REFERENCE_DISPOSE', () {
      final TestClass testClass = TestClass(testManager);
      testChannel.createNewPair(testClass);

      methodCallLog.clear();

      testChannel.disposePair(testClass);
      expect(testManager.isPaired(testClass), isFalse);
      expect(methodCallLog, <Matcher>[
        isMethodCall(
          'REFERENCE_DISPOSE',
          arguments: <Object>[
            'test_channel',
            RemoteReference('test_reference_id'),
          ],
        ),
      ]);
    });
  });
}

class TestManager extends MethodChannelManager {
  TestManager() : super('test_method_channel') {
    registerHandler('test_channel', mockHandler);
  }

  final MockHandler mockHandler = MockHandler();

  @override
  String getNewReferenceId() {
    return 'test_reference_id';
  }
}

class MockHandler = Mock with ReferenceChannelHandler<TestClass>;

class TestClass with Referencable<TestClass> {
  TestClass(this.manager);

  final ReferenceChannelManager manager;

  @override
  ReferenceChannel<TestClass> get referenceChannel => ReferenceChannel(
        manager,
        'test_channel',
      );
}
