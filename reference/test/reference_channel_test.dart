import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:reference/reference.dart';

import 'reference_matchers.dart';

void main() {
  group('$ReferenceChannelManager', () {
    TestManager testManager;

    setUp(() {
      testManager = TestManager();
    });

    test('onReceiveCreateNewPair', () {
      final TestClass testClass = TestClass(testManager);

      when(testManager.mockHandler.createInstance(testManager, <Object>[]))
          .thenReturn(testClass);

      final RemoteReference remoteReference = RemoteReference('test_id');

      expect(
        testManager.onReceiveCreateNewPair(
          'test_channel',
          remoteReference,
          <Object>[],
        ),
        testClass,
      );
      expect(testManager.isPaired(testClass), isTrue);
      expect(
        testManager.onReceiveCreateNewPair(
          '',
          remoteReference,
          <Object>[],
        ),
        isNull,
      );
    });

    test('onReceiveInvokeStaticMethod', () {
      testManager.onReceiveInvokeStaticMethod(
        'test_channel',
        'aStaticMethod',
        <Object>[],
      );

      verify(testManager.mockHandler.invokeStaticMethod(
        testManager,
        'aStaticMethod',
        <Object>[],
      ));
    });

    test('createUnpairedReference', () {
      when(testManager.mockHandler.getCreationArguments(testManager, any))
          .thenReturn(<Object>[]);

      final UnpairedReference unpairedReference =
          testManager.createUnpairedReference(
        'test_channel',
        TestClass(testManager),
      );
      expect(unpairedReference.handlerChannel, 'test_channel');
      expect(unpairedReference.creationArguments, isEmpty);
    });

    test('onReceiveInvokeMethod', () {
      final TestClass testClass = TestClass(testManager);

      when(testManager.mockHandler.createInstance(testManager, <Object>[]))
          .thenReturn(testClass);

      final RemoteReference remoteReference = RemoteReference('test_id');

      testManager.onReceiveCreateNewPair(
        'test_channel',
        remoteReference,
        <Object>[],
      );

      testManager.onReceiveInvokeMethod(
        'test_channel',
        remoteReference,
        'aMethod',
        <Object>[],
      );
      verify(testManager.mockHandler.invokeMethod(
        testManager,
        testClass,
        'aMethod',
        <Object>[],
      ));
    });

    test('onReceiveInvokeMethodOnUnpairedReference', () {
      final TestClass testClass = TestClass(testManager);

      when(testManager.mockHandler.createInstance(testManager, <Object>[]))
          .thenReturn(testClass);

      expect(
        testManager.onReceiveInvokeMethodOnUnpairedReference(
          UnpairedReference('test_channel', <Object>[]),
          'aMethod',
          <Object>[],
        ),
        isNull,
      );

      verify(testManager.mockHandler.invokeMethod(
        testManager,
        testClass,
        'aMethod',
        <Object>[],
      ));
    });

    test('onReceiveDisposePair', () {
      final TestClass testClass = TestClass(testManager);

      when(testManager.mockHandler.createInstance(testManager, <Object>[]))
          .thenReturn(testClass);

      final RemoteReference remoteReference = RemoteReference('test_id');

      testManager.onReceiveCreateNewPair(
        'test_channel',
        remoteReference,
        <Object>[],
      );
      testManager.onReceiveDisposePair('test_channel', remoteReference);
      expect(testManager.isPaired(testClass), isFalse);
    });
  });

  group('$ReferenceChannelMessenger', () {
    //
    // test('pairWithNewRemoteReference', () async {
    //   final TestClass testClass = TestClass();
    //
    //   when(testManager.remoteHandler.getCreationArguments(any))
    //       .thenReturn(<Object>[]);
    //
    //   final RemoteReference remoteReference =
    //       await testManager.pairWithNewRemoteReference(
    //     testClass,
    //   );
    //
    //   expect(remoteReference, isNotNull);
    //   expect(testManager.getPairedLocalReference(remoteReference), testClass);
    //   expect(testManager.getPairedRemoteReference(testClass), remoteReference);
    //   verifyInOrder([
    //     testManager.converter.mock.convertForRemoteManager(
    //       testManager,
    //       argThat(isEmpty),
    //     ),
    //     testManager.remoteHandler
    //         .createInstance(remoteReference, 0, argThat(isEmpty)),
    //   ]);
    // });
    //
    // test('pairWithNewRemoteReference returns null', () async {
    //   final TestClass testClass = TestClass();
    //
    //   when(testManager.remoteHandler.getCreationArguments(any))
    //       .thenReturn(<Object>[]);
    //
    //   testManager.pairWithNewRemoteReference(testClass);
    //   expect(
    //     testManager.pairWithNewRemoteReference(testClass),
    //     completion(isNull),
    //   );
    // });
    //
    // test('invokeRemoteStaticMethod', () async {
    //   await testManager.invokeStaticMethod(TestClass, 'aStaticMethod');
    //   verifyInOrder([
    //     testManager.converter.mock.convertForRemoteManager(
    //       testManager,
    //       argThat(isNull),
    //     ),
    //     testManager.remoteHandler.sendInvokeStaticMethod(
    //       0,
    //       'aStaticMethod',
    //       argThat(isEmpty),
    //     ),
    //     testManager.converter.mock.convertForLocalManager(
    //       testManager,
    //       argThat(isNull),
    //     ),
    //   ]);
    // });
    //
    // test('invokeRemoteMethod', () async {
    //   final testClass = TestClass();
    //   testManager.pairWithNewRemoteReference(testClass);
    //
    //   when(testManager.remoteHandler.getCreationArguments(any))
    //       .thenReturn(<Object>[]);
    //
    //   await testManager.invokeMethod(
    //     testManager.getPairedRemoteReference(testClass),
    //     'aMethod',
    //   );
    //
    //   verifyInOrder([
    //     testManager.converter.mock.convertForRemoteManager(
    //       testManager,
    //       argThat(isNull),
    //     ),
    //     testManager.remoteHandler.sendInvokeMethod(
    //       testManager.getPairedRemoteReference(testClass),
    //       'aMethod',
    //       argThat(isEmpty),
    //     ),
    //   ]);
    // });
    //
    // test(
    //   'invokeRemoteMethodOnUnpairedReference',
    //   () async {
    //     when(testManager.remoteHandler.getCreationArguments(any))
    //         .thenReturn(<Object>[]);
    //
    //     await testManager.invokeMethodOnUnpairedReference(
    //       TestClass(),
    //       'aMethod',
    //     );
    //
    //     verify(testManager.converter.convertForRemoteManager(
    //       testManager,
    //       any,
    //     )).called(2);
    //     verify(testManager.remoteHandler.sendInvokeMethodOnUnpairedReference(
    //       argThat(isUnpairedReference(0, <Object>[], null)),
    //       'aMethod',
    //       argThat(isEmpty),
    //     ));
    //   },
    // );
    //
    // test('disposePairWithLocalReference', () async {
    //   final testClass = TestClass();
    //
    //   final RemoteReference remoteReference =
    //       await testManager.pairWithNewRemoteReference(
    //     testClass,
    //   );
    //   testManager.disposePair(testClass);
    //
    //   expect(testManager.getPairedLocalReference(remoteReference), isNull);
    //   expect(testManager.getPairedRemoteReference(testClass), isNull);
    // });
  });
}

class TestManager extends ReferenceChannelManager {
  TestManager() {
    registerHandler('test_channel', mockHandler);
  }

  final MockHandler mockHandler = MockHandler();

  @override
  final MockMessenger messenger = MockMessenger();
}

class MockHandler = Mock with ReferenceChannelHandler<TestClass>;
class MockMessenger = Mock with ReferenceChannelMessenger;

class TestClass with Referencable<TestClass> {
  TestClass(this.manager);

  final ReferenceChannelManager manager;

  @override
  ReferenceChannel<TestClass> get referenceChannel => ReferenceChannel(
        manager,
        'test_channel',
      );
}

// class TestClass with LocalReference {
//   @override
//   Type get referenceType => TestClass;
// }
//
// class TestClass2 extends TestClass {
//   @override
//   Type get referenceType => TestClass2;
// }
//
// class TestReferencePairManager extends RemoteReferenceMap {
//   TestReferencePairManager() : super(<Type>[TestClass]);
//
//   @override
//   final MockLocalHandler localHandler = MockLocalHandler();
//
//   @override
//   final MockRemoteHandler remoteHandler = MockRemoteHandler();
//
//   @override
//   final SpyReferenceConverter converter = SpyReferenceConverter();
// }
//
// class TestPoolableReferencePairManager extends PoolableReferencePairManager {
//   TestPoolableReferencePairManager(
//     List<Type> supportedTypes,
//     String poolId,
//   ) : super(supportedTypes, poolId);
//
//   @override
//   final MockLocalHandler localHandler = MockLocalHandler();
//
//   @override
//   final MockRemoteHandler remoteHandler = MockRemoteHandler();
// }
//
// class MockRemoteHandler extends Mock implements MessageSender {}
//
// class MockLocalHandler extends Mock implements ReferenceChannelHandler {}
//
// class MockReferenceConverter extends Mock implements ReferenceConverter {}
//
// class SpyReferenceConverter extends StandardReferenceConverter {
//   SpyReferenceConverter();
//
//   final ReferenceConverter mock = MockReferenceConverter();
//
//   @override
//   Object convertForRemoteManager(
//     RemoteReferenceMap manager,
//     Object object,
//   ) {
//     mock.convertForRemoteManager(manager, object);
//     return super.convertForRemoteManager(manager, object);
//   }
//
//   @override
//   Object convertForLocalManager(
//     RemoteReferenceMap manager,
//     Object object,
//   ) {
//     mock.convertForLocalManager(manager, object);
//     return super.convertForLocalManager(manager, object);
//   }
// }
