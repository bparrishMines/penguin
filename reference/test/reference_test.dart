import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:reference/reference.dart';

import 'reference_matchers.dart';

void main() {
  group('$ReferencePairManager', () {
    TestReferencePairManager testManager;

    setUp(() {
      testManager = TestReferencePairManager()..initialize();
    });

    test('pairWithNewLocalReference', () {
      when(testManager.localHandler.create(testManager, TestClass, any))
          .thenReturn(TestClass());

      final TestClass result = testManager.pairWithNewLocalReference(
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
        testManager.localHandler.create(
          testManager,
          TestClass,
          argThat(isEmpty),
        ),
      ]);
    });

    test('pairWithNewLocalReference returns null', () {
      when(testManager.localHandler.create(testManager, TestClass, any))
          .thenReturn(TestClass());

      testManager.pairWithNewLocalReference(RemoteReference('apple'), 0);
      expect(
        testManager.pairWithNewLocalReference(RemoteReference('apple'), 0),
        isNull,
      );
    });

    test('invokeLocalStaticMethod', () {
      testManager.invokeLocalStaticMethod(TestClass, 'aStaticMethod');
      verifyInOrder([
        testManager.converter.mock.convertForLocalManager(
          testManager,
          argThat(isNull),
        ),
        testManager.localHandler.invokeStaticMethod(
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
      when(testManager.localHandler.create(testManager, TestClass, any))
          .thenAnswer((_) => TestClass());

      final TestClass testClass = testManager.pairWithNewLocalReference(
        RemoteReference('chi'),
        0,
      );

      testManager.invokeLocalMethod(testClass, 'aMethod');

      verifyInOrder([
        testManager.converter.mock.convertForLocalManager(
          testManager,
          argThat(isNull),
        ),
        testManager.localHandler.invokeMethod(
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
      when(testManager.localHandler.create(testManager, TestClass, any))
          .thenReturn(TestClass());

      testManager.invokeLocalMethodOnUnpairedReference(
        UnpairedReference(0, <Object>[]),
        'aMethod',
      );

      verify(
        testManager.localHandler.invokeMethod(
          testManager,
          argThat(isA<TestClass>()),
          'aMethod',
          argThat(isEmpty),
        ),
      );
    });

    test('disposePairWithRemoteReference', () {
      when(testManager.localHandler.create(testManager, TestClass, any))
          .thenReturn(TestClass());

      final TestClass testClass = testManager.pairWithNewLocalReference(
        RemoteReference('tea'),
        0,
      );

      testManager.disposePairWithRemoteReference(RemoteReference('tea'));

      verify(testManager.localHandler.dispose(testManager, testClass));
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
        testManager.remoteHandler.create(remoteReference, 0, argThat(isEmpty)),
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
      await testManager.invokeRemoteStaticMethod(TestClass, 'aStaticMethod');
      verifyInOrder([
        testManager.converter.mock.convertForRemoteManager(
          testManager,
          argThat(isNull),
        ),
        testManager.remoteHandler.invokeStaticMethod(
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

      await testManager.invokeRemoteMethod(
        testManager.getPairedRemoteReference(testClass),
        'aMethod',
      );

      verifyInOrder([
        testManager.converter.mock.convertForRemoteManager(
          testManager,
          argThat(isNull),
        ),
        testManager.remoteHandler.invokeMethod(
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

        await testManager.invokeRemoteMethodOnUnpairedReference(
          TestClass(),
          'aMethod',
        );

        verify(testManager.converter.convertForRemoteManager(
          testManager,
          any,
        )).called(2);
        verify(testManager.remoteHandler.invokeMethodOnUnpairedReference(
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
      testManager.disposePairWithLocalReference(testClass);

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

class TestReferencePairManager extends ReferencePairManager {
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

class MockRemoteHandler extends Mock
    implements RemoteReferenceCommunicationHandler {}

class MockLocalHandler extends Mock
    implements LocalReferenceCommunicationHandler {}

class MockReferenceConverter extends Mock implements ReferenceConverter {}

class SpyReferenceConverter extends StandardReferenceConverter {
  SpyReferenceConverter();

  final ReferenceConverter mock = MockReferenceConverter();

  @override
  Object convertForRemoteManager(
    ReferencePairManager manager,
    Object object,
  ) {
    mock.convertForRemoteManager(manager, object);
    return super.convertForRemoteManager(manager, object);
  }

  @override
  Object convertForLocalManager(
    ReferencePairManager manager,
    Object object,
  ) {
    mock.convertForLocalManager(manager, object);
    return super.convertForLocalManager(manager, object);
  }
}
