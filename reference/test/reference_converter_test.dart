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

    test('convertAllLocalReferences handles paired $LocalReference', () async {
      final TestClass testClass = TestClass();

      final RemoteReference remoteReference =
          await testManager.pairWithNewRemoteReference(testClass);

      expect(
        converter.convertAllLocalReferences(testManager, testClass),
        remoteReference,
      );
    });

    test('convertAllLocalReferences handles unpaired $LocalReference',
        () async {
      when(testManager.remoteHandler.getCreationArguments(any))
          .thenReturn(<Object>[]);

      expect(
        converter.convertAllLocalReferences(testManager, TestClass()),
        isUnpairedReference(0, <Object>[], null),
      );
    });

    test('convertAllLocalReferences handles $List', () async {
      final List<List<Object>> creationArguments = <List<Object>>[
        <Object>[TestClass()],
        <Object>[],
      ];

      when(testManager.remoteHandler.getCreationArguments(any))
          .thenAnswer((_) => creationArguments.removeAt(0));

      expect(
        converter.convertAllLocalReferences(testManager, <Object>[TestClass()]),
        contains(isUnpairedReference(
          0,
          <Object>[isUnpairedReference(0, <Object>[], null)],
          null,
        )),
      );
    });

    test('convertAllLocalReferences handles $Map', () async {
      final List<List<Object>> creationArguments = <List<Object>>[
        <Object>[TestClass()],
        <Object>[],
        <Object>[TestClass()],
        <Object>[],
      ];

      when(testManager.remoteHandler.getCreationArguments(any))
          .thenAnswer((_) => creationArguments.removeAt(0));

      final Map<Object, Object> result = converter.convertAllLocalReferences(
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

    test('convertAllLocalReferences handles $String', () async {
      expect(
        converter.convertAllLocalReferences(testManager, 'potato'),
        equals('potato'),
      );
    });

    test('convertAllRemoteReferences handles $RemoteReference', () async {
      final TestClass testClass = TestClass();

      final RemoteReference remoteReference =
          await testManager.pairWithNewRemoteReference(testClass);

      expect(
        converter.convertAllRemoteReferences(testManager, remoteReference),
        testClass,
      );
    });

    test('convertAllRemoteReferences handles $UnpairedReference', () async {
      when(testManager.localHandler.create(any, any, any))
          .thenReturn(TestClass());

      expect(
        converter.convertAllRemoteReferences(
          testManager,
          UnpairedReference(0, <Object>[]),
        ),
        isA<TestClass>(),
      );
    });

    test('convertAllRemoteReferences handles $List', () async {
      final TestClass testClass = TestClass();

      final RemoteReference remoteReference =
          await testManager.pairWithNewRemoteReference(testClass);

      expect(
        converter.convertAllRemoteReferences(
          testManager,
          <Object>[remoteReference],
        ),
        contains(testClass),
      );
    });

    test('convertAllLocalReferences handles $Map', () async {
      final TestClass testClass1 = TestClass();
      final TestClass testClass2 = TestClass();

      final RemoteReference remoteReference1 =
          await testManager.pairWithNewRemoteReference(testClass1);
      final RemoteReference remoteReference2 =
          await testManager.pairWithNewRemoteReference(testClass2);

      final Map<Object, Object> result = converter.convertAllRemoteReferences(
        testManager,
        <Object, Object>{remoteReference1: remoteReference2},
      );

      expect(result, containsPair(testClass1, testClass2));
    });
  });

  group('$PoolableReferenceConverter', () {

  });
}

class TestClass with LocalReference {
  @override
  Type get referenceType => TestClass;
}

class TestReferencePairManager extends ReferencePairManager {
  TestReferencePairManager() : super(<Type>[TestClass]);

  @override
  final MockLocalHandler localHandler = MockLocalHandler();

  @override
  final MockRemoteHandler remoteHandler = MockRemoteHandler();
}

class MockRemoteHandler extends Mock
    implements RemoteReferenceCommunicationHandler {}

class MockLocalHandler extends Mock
    implements LocalReferenceCommunicationHandler {}
