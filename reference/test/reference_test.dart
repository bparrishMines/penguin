import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:reference/reference.dart';

import 'reference_matchers.dart';

void main() {
  group('$RemoteReferenceMap', () {
    TestReferencePairManager testManager;

    setUp(() {
      testManager = TestReferencePairManager()..initialize();
    });

    test('pairWithNewLocalReference', () {
      when(testManager.localHandler.createInstance(testManager, TestClass, any))
          .thenReturn(TestClass());

      final TestClass result = testManager.onReceiveCreateNewPair(
        RemoteReference('apple'),
        0,
      );

      expect(
        testManager.getPairedLocalReference(RemoteReference('apple')),
        result,
      );
      expect(
        testManager.getPairedRemoteReference(result),
        RemoteReference('apple'),
      );

      verifyInOrder([
        testManager.converter.mock.convertForLocalManager(
          testManager,
          argThat(isEmpty),
        ),
        testManager.localHandler.createInstance(
          testManager,
          TestClass,
          argThat(isEmpty),
        ),
      ]);
    });

    test('pairWithNewLocalReference returns null', () {
      when(testManager.localHandler.createInstance(testManager, TestClass, any))
          .thenReturn(TestClass());

      testManager.onReceiveCreateNewPair(RemoteReference('apple'), 0);
      expect(
        testManager.onReceiveCreateNewPair(RemoteReference('apple'), 0),
        isNull,
      );
    });

    test('invokeLocalStaticMethod', () {
      testManager.onReceiveInvokeStaticMethod(TestClass, 'aStaticMethod');
      verifyInOrder([
        testManager.converter.mock.convertForLocalManager(
          testManager,
          argThat(isNull),
        ),
        testManager.localHandler.sendInvokeStaticMethod(
          testManager,
          TestClass,
          'aStaticMethod',
          argThat(isEmpty),
        ),
        testManager.converter.mock.convertForRemoteManager(
          testManager,
          argThat(isNull),
        ),
      ]);
    });

    test('invokeLocalMethod', () {
      when(testManager.localHandler.createInstance(testManager, TestClass, any))
          .thenAnswer((_) => TestClass());

      final TestClass testClass = testManager.onReceiveCreateNewPair(
        RemoteReference('chi'),
        0,
      );

      testManager.onReceiveInvokeMethod(testClass, 'aMethod');

      verifyInOrder([
        testManager.converter.mock.convertForLocalManager(
          testManager,
          argThat(isNull),
        ),
        testManager.localHandler.sendInvokeMethod(
          testManager,
          testClass,
          'aMethod',
          argThat(isEmpty),
        ),
        testManager.converter.mock.convertForRemoteManager(
          testManager,
          argThat(isNull),
        ),
      ]);
    });

    test('invokeLocalMethodOnUnpairedReference', () {
      when(testManager.localHandler.createInstance(testManager, TestClass, any))
          .thenReturn(TestClass());

      testManager.onReceiveInvokeMethodOnUnpairedReference(
        UnpairedReference(0, <Object>[]),
        'aMethod',
      );

      verify(
        testManager.localHandler.sendInvokeMethod(
          testManager,
          argThat(isA<TestClass>()),
          'aMethod',
          argThat(isEmpty),
        ),
      );
    });

    test('disposePairWithRemoteReference', () {
      when(testManager.localHandler.createInstance(testManager, TestClass, any))
          .thenReturn(TestClass());

      final TestClass testClass = testManager.onReceiveCreateNewPair(
        RemoteReference('tea'),
        0,
      );

      testManager.onReceiveDisposePair(RemoteReference('tea'));

      verify(
          testManager.localHandler.onInstanceDisposed(testManager, testClass));
      expect(
        testManager.getPairedLocalReference(RemoteReference('tea')),
        isNull,
      );
      expect(testManager.getPairedRemoteReference(testClass), isNull);
    });

    test('pairWithNewRemoteReference', () async {
      final TestClass testClass = TestClass();

      when(testManager.remoteHandler.getCreationArguments(any))
          .thenReturn(<Object>[]);

      final RemoteReference remoteReference =
          await testManager.pairWithNewRemoteReference(
        testClass,
      );

      expect(remoteReference, isNotNull);
      expect(testManager.getPairedLocalReference(remoteReference), testClass);
      expect(testManager.getPairedRemoteReference(testClass), remoteReference);
      verifyInOrder([
        testManager.converter.mock.convertForRemoteManager(
          testManager,
          argThat(isEmpty),
        ),
        testManager.remoteHandler
            .createInstance(remoteReference, 0, argThat(isEmpty)),
      ]);
    });

    test('pairWithNewRemoteReference returns null', () async {
      final TestClass testClass = TestClass();

      when(testManager.remoteHandler.getCreationArguments(any))
          .thenReturn(<Object>[]);

      testManager.pairWithNewRemoteReference(testClass);
      expect(
        testManager.pairWithNewRemoteReference(testClass),
        completion(isNull),
      );
    });

    test('invokeRemoteStaticMethod', () async {
      await testManager.invokeStaticMethod(TestClass, 'aStaticMethod');
      verifyInOrder([
        testManager.converter.mock.convertForRemoteManager(
          testManager,
          argThat(isNull),
        ),
        testManager.remoteHandler.sendInvokeStaticMethod(
          0,
          'aStaticMethod',
          argThat(isEmpty),
        ),
        testManager.converter.mock.convertForLocalManager(
          testManager,
          argThat(isNull),
        ),
      ]);
    });

    test('invokeRemoteMethod', () async {
      final testClass = TestClass();
      testManager.pairWithNewRemoteReference(testClass);

      when(testManager.remoteHandler.getCreationArguments(any))
          .thenReturn(<Object>[]);

      await testManager.invokeMethod(
        testManager.getPairedRemoteReference(testClass),
        'aMethod',
      );

      verifyInOrder([
        testManager.converter.mock.convertForRemoteManager(
          testManager,
          argThat(isNull),
        ),
        testManager.remoteHandler.sendInvokeMethod(
          testManager.getPairedRemoteReference(testClass),
          'aMethod',
          argThat(isEmpty),
        ),
      ]);
    });

    test(
      'invokeRemoteMethodOnUnpairedReference',
      () async {
        when(testManager.remoteHandler.getCreationArguments(any))
            .thenReturn(<Object>[]);

        await testManager.invokeMethodOnUnpairedReference(
          TestClass(),
          'aMethod',
        );

        verify(testManager.converter.convertForRemoteManager(
          testManager,
          any,
        )).called(2);
        verify(testManager.remoteHandler.sendInvokeMethodOnUnpairedReference(
          argThat(isUnpairedReference(0, <Object>[], null)),
          'aMethod',
          argThat(isEmpty),
        ));
      },
    );

    test('disposePairWithLocalReference', () async {
      final testClass = TestClass();

      final RemoteReference remoteReference =
          await testManager.pairWithNewRemoteReference(
        testClass,
      );
      testManager.disposePair(testClass);

      expect(testManager.getPairedLocalReference(remoteReference), isNull);
      expect(testManager.getPairedRemoteReference(testClass), isNull);
    });
  });

  group('$PoolableReferencePairManager', () {
    ReferencePairManagerPool pool;
    TestPoolableReferencePairManager testManager1;
    TestPoolableReferencePairManager testManager2;

    setUp(() {
      pool = ReferencePairManagerPool();
      testManager1 = TestPoolableReferencePairManager(<Type>[TestClass], 'id1')
        ..initialize();
      testManager2 = TestPoolableReferencePairManager(<Type>[TestClass2], 'id2')
        ..initialize();
    });

    test('add', () {
      expect(pool.add(testManager1), isTrue);
      expect(pool.add(testManager1), isTrue);
      expect(
        pool.add(TestPoolableReferencePairManager(<Type>[TestClass], 'id3')),
        isFalse,
      );
      expect(
        pool.add(TestPoolableReferencePairManager(<Type>[TestClass2], 'id1')),
        isFalse,
      );
      expect(pool.add(testManager2), isTrue);
    });

    test('remove', () {
      pool.add(testManager1);
      pool.remove(testManager1);

      expect(
        pool.add(TestPoolableReferencePairManager(<Type>[TestClass], 'id1')),
        isTrue,
      );
    });
  });
}

class TestClass with LocalReference {
  @override
  Type get referenceType => TestClass;
}

class TestClass2 extends TestClass {
  @override
  Type get referenceType => TestClass2;
}

class TestReferencePairManager extends RemoteReferenceMap {
  TestReferencePairManager() : super(<Type>[TestClass]);

  @override
  final MockLocalHandler localHandler = MockLocalHandler();

  @override
  final MockRemoteHandler remoteHandler = MockRemoteHandler();

  @override
  final SpyReferenceConverter converter = SpyReferenceConverter();
}

class TestPoolableReferencePairManager extends PoolableReferencePairManager {
  TestPoolableReferencePairManager(
    List<Type> supportedTypes,
    String poolId,
  ) : super(supportedTypes, poolId);

  @override
  final MockLocalHandler localHandler = MockLocalHandler();

  @override
  final MockRemoteHandler remoteHandler = MockRemoteHandler();
}

class MockRemoteHandler extends Mock implements MessageSender {}

class MockLocalHandler extends Mock implements ReferenceChannelHandler {}

class MockReferenceConverter extends Mock implements ReferenceConverter {}

class SpyReferenceConverter extends StandardReferenceConverter {
  SpyReferenceConverter();

  final ReferenceConverter mock = MockReferenceConverter();

  @override
  Object convertForRemoteManager(
    RemoteReferenceMap manager,
    Object object,
  ) {
    mock.convertForRemoteManager(manager, object);
    return super.convertForRemoteManager(manager, object);
  }

  @override
  Object convertForLocalManager(
    RemoteReferenceMap manager,
    Object object,
  ) {
    mock.convertForLocalManager(manager, object);
    return super.convertForLocalManager(manager, object);
  }
}
