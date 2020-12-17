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

  group('$MethodChannelReferenceChannelManager', () {
    // final List<MethodCall> methodCallLog = <MethodCall>[];
    // TestReferencePairManager testManager;
    //
    // setUp(() {
    //   methodCallLog.clear();
    //   testManager = TestReferencePairManager()..initialize();
    //   testManager.channel.setMockMethodCallHandler(
    //     (MethodCall methodCall) async {
    //       methodCallLog.add(methodCall);
    //       if (methodCall.method == 'REFERENCE_METHOD') {
    //         switch (methodCall.arguments[1]) {
    //           case 'aMethod':
    //             return 'polo';
    //         }
    //       } else if (methodCall.method == 'REFERENCE_STATIC_METHOD') {
    //         switch (methodCall.arguments[1]) {
    //           case 'aStaticMethod':
    //             return 14;
    //         }
    //       }
    //       return null;
    //     },
    //   );
    // });
    //
    // test('pairWithNewRemoteReference', () async {
    //   final TestClass testClass = TestClass();
    //
    //   testManager.pairWithNewRemoteReference(testClass);
    //   final RemoteReference remoteReference =
    //       testManager.getPairedRemoteReference(testClass);
    //
    //   expect(methodCallLog, <Matcher>[
    //     isMethodCallWithMatchers('REFERENCE_CREATE', arguments: <Object>[
    //       remoteReference,
    //       0,
    //       <Object>[],
    //     ]),
    //   ]);
    // });
    //
    // test('invokeRemoteStaticMethod', () async {
    //   final int result = await testManager.invokeStaticMethod(
    //     TestClass,
    //     'aStaticMethod',
    //   );
    //
    //   expect(result, equals(14));
    //   expect(methodCallLog, <Matcher>[
    //     isMethodCallWithMatchers('REFERENCE_STATIC_METHOD', arguments: <Object>[
    //       0,
    //       'aStaticMethod',
    //       <Object>[],
    //     ]),
    //   ]);
    // });
    //
    // test('invokeRemoteMethod', () async {
    //   final TestClass testClass = TestClass();
    //   testManager.pairWithNewRemoteReference(testClass);
    //   methodCallLog.clear();
    //
    //   final String result = await testManager.invokeMethod(
    //     testManager.getPairedRemoteReference(testClass),
    //     'aMethod',
    //   );
    //
    //   expect(result, equals('polo'));
    //   expect(methodCallLog, <Matcher>[
    //     isMethodCallWithMatchers('REFERENCE_METHOD', arguments: <Object>[
    //       testManager.getPairedRemoteReference(testClass),
    //       'aMethod',
    //       <Object>[],
    //     ]),
    //   ]);
    // });
    //
    // test('invokeRemoteMethodOnUnpairedReference', () async {
    //   final String result = await testManager.invokeMethodOnUnpairedReference(
    //       TestClass(), 'aMethod');
    //
    //   expect(result, equals('polo'));
    //   expect(methodCallLog, <Matcher>[
    //     isMethodCallWithMatchers('REFERENCE_METHOD', arguments: <Object>[
    //       isUnpairedReference(0, <Object>[], null),
    //       'aMethod',
    //       <Object>[],
    //     ]),
    //   ]);
    // });
    //
    // test('disposePairWithLocalReference', () async {
    //   final TestClass testClass = TestClass();
    //
    //   testManager.pairWithNewRemoteReference(testClass);
    //   final RemoteReference remoteReference =
    //       testManager.getPairedRemoteReference(testClass);
    //   methodCallLog.clear();
    //
    //   testManager.disposePair(testClass);
    //
    //   expect(methodCallLog, <Matcher>[
    //     isMethodCall(
    //       'REFERENCE_DISPOSE',
    //       arguments: remoteReference,
    //     ),
    //   ]);
    // });
    //
    // test('pairWithNewLocalReference', () async {
    //   when(testManager.localHandler.createInstance(testManager, TestClass, any))
    //       .thenReturn(TestClass());
    //
    //   await testManager.channel.binaryMessenger.handlePlatformMessage(
    //     'test_channel',
    //     testManager.channel.codec.encodeMethodCall(
    //       MethodCall(
    //         'REFERENCE_CREATE',
    //         <Object>[
    //           RemoteReference('aowejea;io'),
    //           0,
    //           <Object>[],
    //         ],
    //       ),
    //     ),
    //     (ByteData data) {},
    //   );
    //
    //   final TestClass testClass =
    //       testManager.getPairedLocalReference(RemoteReference('aowejea;io'));
    //
    //   expect(testClass, isNotNull);
    // });
    //
    // test('invokeLocalStaticMethod', () async {
    //   when(
    //     testManager.localHandler.sendInvokeStaticMethod(
    //       testManager,
    //       TestClass,
    //       'aStaticMethod',
    //       <Object>[],
    //     ),
    //   ).thenReturn('OJ');
    //
    //   final Completer<String> responseCompleter = Completer<String>();
    //   await testManager.channel.binaryMessenger.handlePlatformMessage(
    //     'test_channel',
    //     testManager.channel.codec.encodeMethodCall(
    //       MethodCall(
    //         'REFERENCE_STATIC_METHOD',
    //         <Object>[0, 'aStaticMethod', <Object>[]],
    //       ),
    //     ),
    //     (ByteData data) {
    //       responseCompleter.complete(
    //         testManager.channel.codec.decodeEnvelope(data),
    //       );
    //     },
    //   );
    //
    //   verify(testManager.localHandler.sendInvokeStaticMethod(
    //     testManager,
    //     TestClass,
    //     'aStaticMethod',
    //     any,
    //   ));
    //   expect(responseCompleter.future, completion('OJ'));
    // });
    //
    // test('invokeLocalMethod', () async {
    //   final TestClass testClass = TestClass();
    //
    //   testManager.pairWithNewRemoteReference(testClass);
    //
    //   when(
    //     testManager.localHandler.sendInvokeMethod(
    //       testManager,
    //       testClass,
    //       'aMethod',
    //       <Object>[],
    //     ),
    //   ).thenReturn('Apple pie');
    //
    //   final Completer<String> responseCompleter = Completer<String>();
    //   await testManager.channel.binaryMessenger.handlePlatformMessage(
    //     'test_channel',
    //     testManager.channel.codec.encodeMethodCall(
    //       MethodCall(
    //         'REFERENCE_METHOD',
    //         <Object>[
    //           testManager.getPairedRemoteReference(testClass),
    //           'aMethod',
    //           <Object>[],
    //         ],
    //       ),
    //     ),
    //     (ByteData data) {
    //       responseCompleter.complete(
    //         testManager.channel.codec.decodeEnvelope(data),
    //       );
    //     },
    //   );
    //
    //   verify(testManager.localHandler.sendInvokeMethod(
    //     testManager,
    //     testClass,
    //     'aMethod',
    //     any,
    //   ));
    //   expect(responseCompleter.future, completion('Apple pie'));
    // });
    //
    // test('invokeLocalMethodOnUnpairedReference', () async {
    //   when(testManager.localHandler.createInstance(testManager, TestClass, any))
    //       .thenReturn(TestClass());
    //
    //   when(
    //     testManager.localHandler.sendInvokeMethod(
    //       testManager,
    //       any,
    //       'aMethod',
    //       <Object>[],
    //     ),
    //   ).thenReturn('Apple pie');
    //
    //   final Completer<String> responseCompleter = Completer<String>();
    //   await testManager.channel.binaryMessenger.handlePlatformMessage(
    //     'test_channel',
    //     testManager.channel.codec.encodeMethodCall(
    //       MethodCall(
    //         'REFERENCE_METHOD',
    //         <Object>[
    //           UnpairedReference(0, <dynamic>[]),
    //           'aMethod',
    //           <Object>[],
    //         ],
    //       ),
    //     ),
    //     (ByteData data) {
    //       responseCompleter.complete(
    //         testManager.channel.codec.decodeEnvelope(data),
    //       );
    //     },
    //   );
    //
    //   verify(testManager.localHandler.sendInvokeMethod(
    //     testManager,
    //     any,
    //     'aMethod',
    //     any,
    //   ));
    //   expect(responseCompleter.future, completion('Apple pie'));
    // });
    //
    // test('disposePairWithRemoteReference', () async {
    //   final TestClass testClass = TestClass();
    //
    //   final RemoteReference remoteReference =
    //       await testManager.pairWithNewRemoteReference(testClass);
    //
    //   await testManager.channel.binaryMessenger.handlePlatformMessage(
    //     'test_channel',
    //     testManager.channel.codec.encodeMethodCall(
    //       MethodCall(
    //         'REFERENCE_DISPOSE',
    //         remoteReference,
    //       ),
    //     ),
    //     (ByteData data) {},
    //   );
    //
    //   verify(
    //       testManager.localHandler.onInstanceDisposed(testManager, testClass));
    //   expect(testManager.getPairedLocalReference(remoteReference), isNull);
    // });
  });
}

// class TestClass with LocalReference {
//   @override
//   Type get referenceType => TestClass;
// }
//
// class TestReferencePairManager extends MethodChannelReferenceChannelManager {
//   TestReferencePairManager() : super(<Type>[TestClass], 'test_channel');
//
//   final MockLocalHandler _localHandler = MockLocalHandler();
//
//   @override
//   ReferenceChannelHandler get localHandler => _localHandler;
//
//   @override
//   MethodChannelReferenceChannelMessenger get remoteHandler =>
//       TestRemoteHandler();
// }
//
// class TestRemoteHandler extends MethodChannelReferenceChannelMessenger {
//   TestRemoteHandler() : super('test_channel');
//
//   @override
//   List<Object> getCreationArguments(LocalReference localReference) {
//     return <Object>[];
//   }
// }
//
// class MockLocalHandler extends Mock implements ReferenceChannelHandler {}
