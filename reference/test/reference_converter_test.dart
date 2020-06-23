import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:reference/reference.dart';

import 'reference_matchers.dart';

void main() {
  group('$StandardReferenceConverter', () {
    final StandardReferenceConverter converter = StandardReferenceConverter();
    TestReferencePairManager testManager;

    setUp(() {
      testManager = TestReferencePairManager()..initialize();
    });

    test('convertForRemoteManager handles paired $LocalReference', () async {
      final TestClass testClass = TestClass();

      final RemoteReference remoteReference =
          await testManager.pairWithNewRemoteReference(testClass);

      expect(
        converter.convertForRemoteManager(testManager, testClass),
        remoteReference,
      );
    });

    test('convertForRemoteManager handles unpaired $LocalReference', () async {
      when(testManager.remoteHandler.getCreationArguments(any))
          .thenReturn(<Object>[]);

      expect(
        converter.convertForRemoteManager(testManager, TestClass()),
        isUnpairedReference(0, <Object>[], null),
      );
    });

    test('convertForRemoteManager handles $List', () async {
      final List<List<Object>> creationArguments = <List<Object>>[
        <Object>[TestClass()],
        <Object>[],
      ];

      when(testManager.remoteHandler.getCreationArguments(any))
          .thenAnswer((_) => creationArguments.removeAt(0));

      expect(
        converter.convertForRemoteManager(testManager, <Object>[TestClass()]),
        contains(isUnpairedReference(
          0,
          <Object>[isUnpairedReference(0, <Object>[], null)],
          null,
        )),
      );
    });

    test('convertForRemoteManager handles $Map', () async {
      final List<List<Object>> creationArguments = <List<Object>>[
        <Object>[TestClass()],
        <Object>[],
        <Object>[TestClass()],
        <Object>[],
      ];

      when(testManager.remoteHandler.getCreationArguments(any))
          .thenAnswer((_) => creationArguments.removeAt(0));

      final Map<Object, Object> result = converter.convertForRemoteManager(
        testManager,
        <Object, Object>{TestClass(): TestClass()},
      );

      expect(
        result.keys,
        contains(isUnpairedReference(
          0,
          <Object>[isUnpairedReference(0, <Object>[], null)],
          null,
        )),
      );
      expect(
        result.values.toList(),
        contains(isUnpairedReference(
          0,
          <Object>[isUnpairedReference(0, <Object>[], null)],
          null,
        )),
      );
    });

    test('convertForRemoteManager handles non-$LocalReference', () async {
      expect(
        converter.convertForRemoteManager(testManager, 'potato'),
        equals('potato'),
      );
    });

    test('convertForLocalManager handles $RemoteReference', () async {
      final TestClass testClass = TestClass();

      final RemoteReference remoteReference =
          await testManager.pairWithNewRemoteReference(testClass);

      expect(
        converter.convertForLocalManager(testManager, remoteReference),
        testClass,
      );
    });

    test('convertForLocalManager handles $UnpairedReference', () async {
      when(testManager.localHandler.create(any, any, any))
          .thenReturn(TestClass());

      expect(
        converter.convertForLocalManager(
          testManager,
          UnpairedReference(0, <Object>[]),
        ),
        isA<TestClass>(),
      );
    });

    test('convertForLocalManager handles $List', () async {
      final TestClass testClass = TestClass();

      final RemoteReference remoteReference =
          await testManager.pairWithNewRemoteReference(testClass);

      expect(
        converter.convertForLocalManager(
          testManager,
          <Object>[remoteReference],
        ),
        contains(testClass),
      );
    });

    test('convertForLocalManager handles $Map', () async {
      final TestClass testClass1 = TestClass();
      final TestClass testClass2 = TestClass();

      final RemoteReference remoteReference1 =
          await testManager.pairWithNewRemoteReference(testClass1);
      final RemoteReference remoteReference2 =
          await testManager.pairWithNewRemoteReference(testClass2);

      final Map<Object, Object> result = converter.convertForLocalManager(
        testManager,
        <Object, Object>{remoteReference1: remoteReference2},
      );

      expect(result, containsPair(testClass1, testClass2));
    });

    test('convertForLocalManager handles non-$LocalReference', () async {
      expect(
        converter.convertForLocalManager(testManager, 'potato'),
        equals('potato'),
      );
    });
  });

  group('$PoolableReferenceConverter', () {
    PoolableReferenceConverter converter;
    ReferencePairManagerPool pool;

    TestPoolableReferencePairManager testManager1;
    TestPoolableReferencePairManager testManager2;

    setUp(() {
      testManager1 = TestPoolableReferencePairManager(<Type>[TestClass], 'id1')
        ..initialize();

      testManager2 = TestPoolableReferencePairManager(<Type>[TestClass2], 'id2')
        ..initialize();

      pool = ReferencePairManagerPool()..add(testManager1)..add(testManager2);

      converter = PoolableReferenceConverter(
        'id1',
        <ReferencePairManagerPool>{pool},
      );
    });

    test('convertForRemoteManager handles paired $LocalReference', () async {
      final TestClass testClass1 = TestClass();
      final TestClass testClass2 = TestClass2();

      final RemoteReference remoteReference1 =
          await testManager1.pairWithNewRemoteReference(testClass1);

      final RemoteReference remoteReference2 =
          await testManager2.pairWithNewRemoteReference(testClass2);

      expect(
        converter.convertForRemoteManager(testManager1, testClass1),
        remoteReference1,
      );

      expect(
        converter.convertForRemoteManager(testManager1, testClass2),
        remoteReference2,
      );
    });

    test('convertForRemoteManager handles unpaired $LocalReference', () async {
      when(testManager1.remoteHandler.getCreationArguments(any))
          .thenReturn(<Object>[]);

      when(testManager2.remoteHandler.getCreationArguments(any))
          .thenReturn(<Object>[]);

      expect(
        converter.convertForRemoteManager(testManager1, TestClass()),
        isUnpairedReference(0, <Object>[], 'id1'),
      );

      expect(
        converter.convertForRemoteManager(testManager1, TestClass2()),
        isUnpairedReference(0, <Object>[], 'id2'),
      );
    });

    test('convertForLocalManager handles $RemoteReference', () async {
      final TestClass testClass1 = TestClass();
      final TestClass testClass2 = TestClass2();

      final RemoteReference remoteReference1 =
          await testManager1.pairWithNewRemoteReference(testClass1);

      final RemoteReference remoteReference2 =
          await testManager2.pairWithNewRemoteReference(testClass2);

      expect(
        converter.convertForLocalManager(testManager1, remoteReference1),
        testClass1,
      );

      expect(
        converter.convertForLocalManager(testManager1, remoteReference2),
        testClass2,
      );
    });

    test('convertForLocalManager handles $UnpairedReference', () async {
      when(testManager1.localHandler.create(any, any, any))
          .thenReturn(TestClass());

      when(testManager2.localHandler.create(any, any, any))
          .thenReturn(TestClass2());

      expect(
        converter.convertForLocalManager(
          testManager1,
          UnpairedReference(0, <Object>[], 'id1'),
        ),
        isA<TestClass>(),
      );
      expect(
        converter.convertForLocalManager(
          testManager2,
          UnpairedReference(0, <Object>[], 'id2'),
        ),
        isA<TestClass2>(),
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
