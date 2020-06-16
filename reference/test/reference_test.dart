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
        <Object>[
          'Hello',
          UnpairedReference(0, <Object>[]),
          <Object>[
            UnpairedReference(0, <Object>[]),
          ],
          <Object, Object>{
            1.1: UnpairedReference(0, <Object>[]),
          },
        ],
      );

      expect(
        testManager.getPairedLocalReference(RemoteReference('apple')),
        result,
      );
      expect(
        testManager.getPairedRemoteReference(result),
        RemoteReference('apple'),
      );

      expect(
        verify(testManager.localHandler
                .create(testManager, TestClass, captureAny))
            .captured,
        <Matcher>[
          isEmpty,
          isEmpty,
          isEmpty,
          containsAllInOrder(<Matcher>[
            equals('Hello'),
            isA<TestClass>(),
            contains(isA<TestClass>()),
            containsPair(1.1, isA<TestClass>()),
          ]),
        ],
      );
    });

    test('invokeLocalMethod', () {
      when(testManager.localHandler.create(testManager, TestClass, any))
          .thenReturn(TestClass());

      final TestClass testClass = testManager.pairWithNewLocalReference(
        RemoteReference('chi'),
        0,
      );

      testManager.invokeLocalMethod(
        testClass,
        'aMethod',
        <Object>[
          'Hello',
          UnpairedReference(0, <Object>[]),
          <Object>[
            UnpairedReference(0, <Object>[]),
          ],
          <Object, Object>{
            1.1: UnpairedReference(0, <Object>[]),
          },
        ],
      );

      expect(
        verify(
          testManager.localHandler.invokeMethod(
            testManager,
            testClass,
            'aMethod',
            captureAny,
          ),
        ).captured.single,
        <Matcher>[
          equals('Hello'),
          isA<TestClass>(),
          contains(isA<TestClass>()),
          containsPair(1.1, isA<TestClass>()),
        ],
      );
    });

    test('invokeLocalMethod converts returned ${LocalReference}s', () {
      when(testManager.localHandler.create(testManager, TestClass, any))
          .thenReturn(TestClass());

      when(testManager.remoteHandler.getCreationArguments(any))
          .thenReturn(<Object>[]);

      final TestClass caller = testManager.pairWithNewLocalReference(
        RemoteReference('chi'),
        0,
      );

      final TestClass hasRemoteRef = testManager.pairWithNewLocalReference(
        RemoteReference('ro'),
        0,
      );

      when(testManager.localHandler
              .invokeMethod(testManager, caller, 'aMethod', any))
          .thenReturn(<Object>[TestClass(), hasRemoteRef, null]);

      final Object result = testManager.invokeLocalMethod(caller, 'aMethod');

      expect(
        result,
        <Matcher>[
          isUnpairedReference(0, <Object>[], null),
          equals(RemoteReference('ro')),
          isNull,
        ],
      );
    });

    test('invokeLocalMethodOnUnpairedReference', () {
      when(testManager.localHandler.create(testManager, TestClass, any))
          .thenReturn(TestClass());

      testManager.invokeLocalMethodOnUnpairedReference(
        UnpairedReference(0, <Object>[]),
        'aMethod',
        <Object>[
          'Hello',
          UnpairedReference(0, <Object>[]),
          <Object>[
            UnpairedReference(0, <Object>[]),
          ],
          <Object, Object>{
            1.1: UnpairedReference(0, <Object>[]),
          },
        ],
      );

      expect(
        verify(
          testManager.localHandler.invokeMethod(
            testManager,
            argThat(isA<TestClass>()),
            'aMethod',
            captureAny,
          ),
        ).captured.single,
        <Matcher>[
          equals('Hello'),
          isA<TestClass>(),
          contains(isA<TestClass>()),
          containsPair(1.1, isA<TestClass>()),
        ],
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

      final List<List<Object>> responses = [
        <Object>[
          'Hello',
          TestClass(),
          <Object>[TestClass()],
          <Object, Object>{1.1: TestClass()},
        ],
        <Object>[],
        <Object>[],
        <Object>[],
      ];
      when(testManager.remoteHandler.getCreationArguments(any))
          .thenAnswer((_) => responses.removeAt(0));

      final RemoteReference remoteReference =
          await testManager.pairWithNewRemoteReference(
        testClass,
      );

      expect(remoteReference, isNotNull);
      expect(testManager.getPairedLocalReference(remoteReference), testClass);
      expect(testManager.getPairedRemoteReference(testClass), remoteReference);
      expect(
        verify(testManager.remoteHandler.create(remoteReference, 0, captureAny))
            .captured
            .single,
        <Matcher>[
          equals('Hello'),
          isUnpairedReference(0, <Object>[], null),
          contains(isUnpairedReference(0, <Object>[], null)),
          containsPair(
            1.1,
            isUnpairedReference(0, <Object>[], null),
          ),
        ],
      );
    });

    test('invokeRemoteMethod', () async {
      final testClass = TestClass();
      testManager.pairWithNewRemoteReference(testClass);

      when(testManager.remoteHandler.getCreationArguments(any))
          .thenReturn(<Object>[]);

      await testManager.invokeRemoteMethod(
        testManager.getPairedRemoteReference(testClass),
        'aMethod',
        <Object>[
          'Hello',
          TestClass(),
          <Object>[TestClass()],
          <Object, Object>{1.1: TestClass()},
        ],
      );

      expect(
        verify(
          testManager.remoteHandler.invokeMethod(
            testManager.getPairedRemoteReference(testClass),
            'aMethod',
            captureAny,
          ),
        ).captured.single,
        <Matcher>[
          equals('Hello'),
          isUnpairedReference(0, <Object>[], null),
          contains(isUnpairedReference(0, <Object>[], null)),
          containsPair(
            1.1,
            isUnpairedReference(0, <Object>[], null),
          ),
        ],
      );
    });

    test('invokeRemoteMethod converts returned ${RemoteReference}s', () async {
      final RemoteReference remoteReference =
          await testManager.pairWithNewRemoteReference(TestClass());

      final TestClass hasRemoteRef = TestClass();
      final RemoteReference hasLocalRef =
          await testManager.pairWithNewRemoteReference(hasRemoteRef);

      when(testManager.localHandler.create(testManager, TestClass, any))
          .thenReturn(TestClass());

      when(testManager.remoteHandler
              .invokeMethod(remoteReference, 'aMethod', any))
          .thenAnswer(
        (_) => Future<Object>.value(
          <Object>[
            UnpairedReference(0, <Object>[]),
            hasLocalRef,
            null,
          ],
        ),
      );

      final Object result = await testManager.invokeRemoteMethod(
        remoteReference,
        'aMethod',
      );

      expect(result, <Matcher>[isA<TestClass>(), equals(hasRemoteRef), isNull]);
    });

    test(
      'invokeRemoteMethodOnUnpairedReference',
      () async {
        when(testManager.remoteHandler.getCreationArguments(any))
            .thenReturn(<Object>[]);

        await testManager.invokeRemoteMethodOnUnpairedReference(
          TestClass(),
          'aMethod',
          <Object>[
            'Hello',
            TestClass(),
            <Object>[TestClass()],
            <Object, Object>{1.1: TestClass()},
          ],
        );

        final List<Object> captured = verify(
          testManager.remoteHandler.invokeMethodOnUnpairedReference(
            captureAny,
            'aMethod',
            captureAny,
          ),
        ).captured;

        expect(captured[0], isUnpairedReference(0, <Object>[], null));
        expect(
          captured[1],
          <Matcher>[
            equals('Hello'),
            isUnpairedReference(0, <Object>[], null),
            contains(isUnpairedReference(0, <Object>[], null)),
            containsPair(
              1.1,
              isUnpairedReference(0, <Object>[], null),
            ),
          ],
        );
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

    test('pairWithNewLocalReference', () {
      pool.add(testManager1);
      pool.add(testManager2);

      when(testManager1.localHandler.create(testManager1, TestClass, any))
          .thenReturn(TestClass());

      when(testManager2.localHandler.create(testManager2, TestClass2, any))
          .thenReturn(TestClass2());

      testManager1.pairWithNewLocalReference(
        RemoteReference('apple'),
        0,
        <Object>[
          'Hello',
          UnpairedReference(0, <Object>[], 'id1'),
          UnpairedReference(0, <Object>[], 'id2'),
          <Object>[
            UnpairedReference(0, <Object>[], 'id1'),
          ],
          <Object, Object>{
            1.1: UnpairedReference(0, <Object>[], 'id1'),
          },
        ],
      );

      expect(
        verify(testManager1.localHandler
                .create(testManager1, TestClass, captureAny))
            .captured,
        <Matcher>[
          isEmpty,
          isEmpty,
          isEmpty,
          containsAllInOrder(<Matcher>[
            equals('Hello'),
            isA<TestClass>(),
            isA<TestClass2>(),
            contains(isA<TestClass>()),
            containsPair(1.1, isA<TestClass>()),
          ]),
        ],
      );
    });

    test('pairWithNewRemoteReference', () async {
      pool.add(testManager1);
      pool.add(testManager2);

      final List<List<Object>> responses = [
        <Object>[
          'Hello',
          TestClass(),
          TestClass2(),
          <Object>[TestClass()],
          <Object, Object>{1.1: TestClass()},
        ],
        <Object>[],
        <Object>[],
        <Object>[],
      ];
      when(testManager1.remoteHandler.getCreationArguments(any))
          .thenAnswer((_) => responses.removeAt(0));

      when(testManager2.remoteHandler.getCreationArguments(any))
          .thenReturn(<Object>[]);

      final testClass = TestClass();
      final RemoteReference remoteReference =
          await testManager1.pairWithNewRemoteReference(testClass);

      expect(
        verify(
          testManager1.remoteHandler.create(remoteReference, 0, captureAny),
        ).captured.single,
        <Matcher>[
          equals('Hello'),
          isUnpairedReference(0, <Object>[], 'id1'),
          isUnpairedReference(0, <Object>[], 'id2'),
          contains(isUnpairedReference(0, <Object>[], 'id1')),
          containsPair(
            1.1,
            isUnpairedReference(0, <Object>[], 'id1'),
          ),
        ],
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
