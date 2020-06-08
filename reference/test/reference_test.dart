import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:reference/reference.dart';

import 'reference_matchers.dart';

void main() {
  group('$ReferencePairManager', () {
    test('createLocalReferenceFor', () {
      final allArguments = <List<dynamic>>[];

      final manager = TestReferencePairManager(
        <Type>[TestClass],
        "test_id",
        localHandler: TestLocalHandler(
          onCreateLocalReference: (
            ReferencePairManager referencePairManager,
            Type referenceType,
            List<dynamic> arguments,
          ) {
            allArguments.add(arguments);
            return TestClass();
          },
        ),
      )..initialize();

      final TestClass result = manager.createLocalReferenceFor(
        RemoteReference('apple'),
        0,
        <dynamic>[
          'Hello',
          UnpairedRemoteReference(0, <dynamic>[], "test_id"),
          <dynamic>[
            UnpairedRemoteReference(0, <dynamic>[], "test_id"),
          ],
          <dynamic, dynamic>{
            1.1: UnpairedRemoteReference(0, <dynamic>[], "test_id"),
          },
        ],
      );

      expect(manager.localReferenceFor(RemoteReference('apple')), result);
      expect(manager.remoteReferenceFor(result), RemoteReference('apple'));
      expect(
        allArguments,
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

    test('executeLocalMethodFor', () {
      final methodArguments = <dynamic>[];
      final manager = TestReferencePairManager(
        <Type>[TestClass],
        "test_id",
        localHandler: TestLocalHandler(
          onCreateLocalReference: (
            ReferencePairManager referencePairManager,
            Type referenceType,
            List<dynamic> arguments,
          ) {
            return TestClass();
          },
          onExecuteLocalMethod: (
            ReferencePairManager referencePairManager,
            LocalReference localReference,
            String methodName,
            List<dynamic> arguments,
          ) {
            if (methodName == 'aMethod') methodArguments.addAll(arguments);
            return null;
          },
        ),
      )..initialize();

      manager.createLocalReferenceFor(RemoteReference('chi'), 0);
      manager.executeLocalMethodFor(
        RemoteReference('chi'),
        'aMethod',
        <dynamic>[
          'Hello',
          UnpairedRemoteReference(0, <dynamic>[], "test_id"),
          <dynamic>[
            UnpairedRemoteReference(0, <dynamic>[], "test_id"),
          ],
          <dynamic, dynamic>{
            1.1: UnpairedRemoteReference(0, <dynamic>[], "test_id"),
          },
        ],
      );

      expect(methodArguments, <Matcher>[
        equals('Hello'),
        isA<TestClass>(),
        contains(isA<TestClass>()),
        containsPair(1.1, isA<TestClass>()),
      ]);
    });

    test('disposeLocalReferenceFor', () {
      final manager = TestReferencePairManager(
        <Type>[TestClass],
        "test_id",
        localHandler: TestLocalHandler(
          onCreateLocalReference: (
            ReferencePairManager referencePairManager,
            Type referenceType,
            List<dynamic> arguments,
          ) {
            return TestClass();
          },
        ),
      )..initialize();

      final TestClass result = manager.createLocalReferenceFor(
        RemoteReference('tea'),
        0,
      );
      manager.disposeLocalReferenceFor(RemoteReference('tea'));

      expect(manager.localReferenceFor(RemoteReference('tea')), isNull);
      expect(manager.remoteReferenceFor(result), isNull);
    });

    test('createRemoteReferenceFor', () async {
      final creationArguments = <dynamic>[];
      bool firstCall = true;

      final manager = TestReferencePairManager(
        <Type>[TestClass],
        "test_id",
        remoteHandler: TestRemoteHandler(
          onCreationArgumentsFor: (LocalReference localReference) {
            if (localReference is TestClass && firstCall) {
              firstCall = false;
              return <dynamic>[
                'Hello',
                TestClass(),
                <dynamic>[TestClass()],
                <dynamic, dynamic>{1.1: TestClass()},
              ];
            }

            return <dynamic>[];
          },
          onCreateRemoteReference: (
            RemoteReference remoteReference,
            int typeId,
            List<dynamic> arguments,
          ) {
            creationArguments.addAll(arguments);
            return Future<void>.value();
          },
        ),
      )..initialize();

      final testClass = TestClass();
      final RemoteReference remoteReference =
          await manager.createRemoteReferenceFor(
        testClass,
      );

      expect(remoteReference, isNotNull);
      expect(manager.localReferenceFor(remoteReference), testClass);
      expect(manager.remoteReferenceFor(testClass), remoteReference);
      expect(creationArguments, <Matcher>[
        equals('Hello'),
        isUnpairedRemoteReference(0, <dynamic>[], "test_id"),
        contains(isUnpairedRemoteReference(0, <dynamic>[], "test_id")),
        containsPair(
          1.1,
          isUnpairedRemoteReference(0, <dynamic>[], "test_id"),
        ),
      ]);
    });

    test('executeRemoteMethodFor', () async {
      final methodArguments = <dynamic>[];

      final manager = TestReferencePairManager(
        <Type>[TestClass],
        "test_id",
        remoteHandler: TestRemoteHandler(
          onCreationArgumentsFor: (LocalReference localReference) {
            return <dynamic>[];
          },
          onCreateRemoteReference: (
            RemoteReference remoteReference,
            int typeId,
            List<dynamic> arguments,
          ) {
            return Future<void>.value();
          },
          onExecuteRemoteMethod: (
            RemoteReference remoteReference,
            String methodName,
            List<dynamic> arguments,
          ) {
            methodArguments.addAll(arguments);
            return Future<void>.value();
          },
        ),
      )..initialize();

      final testClass = TestClass();
      manager.createRemoteReferenceFor(testClass);
      await manager.executeRemoteMethodFor(
        testClass,
        'aMethod',
        <dynamic>[
          'Hello',
          TestClass(),
          <dynamic>[TestClass()],
          <dynamic, dynamic>{1.1: TestClass()},
        ],
      );

      expect(methodArguments, <Matcher>[
        equals('Hello'),
        isUnpairedRemoteReference(0, <dynamic>[], "test_id"),
        contains(isUnpairedRemoteReference(0, <dynamic>[], "test_id")),
        containsPair(
          1.1,
          isUnpairedRemoteReference(0, <dynamic>[], "test_id"),
        ),
      ]);
    });
  });

  test('disposeRemoteReferenceFor', () async {
    final manager = TestReferencePairManager(
      <Type>[TestClass],
      "test_id",
      remoteHandler: TestRemoteHandler(
        onCreationArgumentsFor: (LocalReference localReference) {
          return <dynamic>[];
        },
        onCreateRemoteReference: (
          RemoteReference remoteReference,
          int typeId,
          List<dynamic> arguments,
        ) {
          return Future<void>.value();
        },
      ),
    )..initialize();

    final testClass = TestClass();
    final RemoteReference remoteReference =
        await manager.createRemoteReferenceFor(
      testClass,
    );
    manager.disposeRemoteReferenceFor(testClass);

    expect(manager.localReferenceFor(remoteReference), isNull);
    expect(manager.remoteReferenceFor(testClass), isNull);
  });

  group('$PoolableReferencePairManager', () {
    ReferencePairManagerPool pool;

    setUp(() {
      pool = ReferencePairManagerPool();
    });

    test('add', () {
      final manager1 = TestReferencePairManager(<Type>[TestClass], "test_id")
        ..initialize();

      final manager2 = TestReferencePairManager(<Type>[TestClass2], "test_id2")
        ..initialize();

      expect(pool.add(manager1), isTrue);
      expect(pool.add(manager1), isFalse);
      expect(
        pool.add(TestReferencePairManager(<Type>[TestClass], "test_id3")),
        isFalse,
      );
      expect(pool.add(manager2), isTrue);
    });

    test('remove', () {
      final manager1 = TestReferencePairManager(<Type>[TestClass], "test_id")
        ..initialize();

      final manager2 = TestReferencePairManager(<Type>[TestClass2], "test_id2")
        ..initialize();

      pool.add(manager1);
      pool.add(manager2);

      pool.remove(manager1);
      pool.remove(manager2);

      expect(pool.add(manager1), isTrue);
      expect(pool.add(manager2), isTrue);
    });

    test('createLocalReferenceFor', () {
      final allArguments = <List<dynamic>>[];

      final manager1 = TestReferencePairManager(
        <Type>[TestClass],
        "test_id",
        localHandler: TestLocalHandler(
          onCreateLocalReference: (
            ReferencePairManager referencePairManager,
            Type referenceType,
            List<dynamic> arguments,
          ) {
            allArguments.add(arguments);
            return TestClass();
          },
        ),
      )..initialize();

      final manager2 = TestReferencePairManager(
        <Type>[TestClass2],
        "test_id2",
        localHandler: TestLocalHandler(
          onCreateLocalReference: (
            ReferencePairManager referencePairManager,
            Type referenceType,
            List<dynamic> arguments,
          ) {
            return TestClass2();
          },
        ),
      )..initialize();

      pool.add(manager1);
      pool.add(manager2);

      manager1.createLocalReferenceFor(
        RemoteReference('apple'),
        0,
        <dynamic>[
          'Hello',
          UnpairedRemoteReference(0, <dynamic>[], "test_id2"),
          UnpairedRemoteReference(0, <dynamic>[], "test_id"),
          <dynamic>[
            UnpairedRemoteReference(0, <dynamic>[], "test_id"),
          ],
          <dynamic, dynamic>{
            1.1: UnpairedRemoteReference(0, <dynamic>[], "test_id"),
          },
        ],
      );

      expect(
        allArguments,
        <Matcher>[
          isEmpty,
          isEmpty,
          isEmpty,
          containsAllInOrder(<Matcher>[
            equals('Hello'),
            isA<TestClass2>(),
            isA<TestClass>(),
            contains(isA<TestClass>()),
            containsPair(1.1, isA<TestClass>()),
          ]),
        ],
      );
    });

    test('createRemoteReferenceFor', () async {
      final creationArguments = <dynamic>[];
      bool firstCall = true;

      final manager1 = TestReferencePairManager(
        <Type>[TestClass],
        "test_id",
        remoteHandler: TestRemoteHandler(
          onCreationArgumentsFor: (LocalReference localReference) {
            if (localReference is TestClass && firstCall) {
              firstCall = false;
              return <dynamic>[
                'Hello',
                TestClass2(),
                TestClass(),
                <dynamic>[TestClass()],
                <dynamic, dynamic>{1.1: TestClass()},
              ];
            }

            return <dynamic>[];
          },
          onCreateRemoteReference: (
            RemoteReference remoteReference,
            int typeId,
            List<dynamic> arguments,
          ) {
            creationArguments.addAll(arguments);
            return Future<void>.value();
          },
        ),
      )..initialize();

      final manager2 = TestReferencePairManager(
        <Type>[TestClass2],
        "test_id2",
        remoteHandler: TestRemoteHandler(
          onCreationArgumentsFor: (LocalReference localReference) {
            if (localReference is TestClass2) return <dynamic>[];
            return null;
          },
          onCreateRemoteReference: (
            RemoteReference remoteReference,
            int typeId,
            List<dynamic> arguments,
          ) {
            return Future<void>.value();
          },
        ),
      )..initialize();

      pool.add(manager1);
      pool.add(manager2);

      final testClass = TestClass();
      await manager1.createRemoteReferenceFor(testClass);

      expect(creationArguments, <Matcher>[
        equals('Hello'),
        isUnpairedRemoteReference(0, <dynamic>[], "test_id2"),
        isUnpairedRemoteReference(0, <dynamic>[], "test_id"),
        contains(isUnpairedRemoteReference(0, <dynamic>[], "test_id")),
        containsPair(
          1.1,
          isUnpairedRemoteReference(0, <dynamic>[], "test_id"),
        ),
      ]);
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

class TestReferencePairManager extends PoolableReferencePairManager {
  TestReferencePairManager(
    List<Type> supportedTypes,
    String poolId, {
    this.localHandler,
    this.remoteHandler,
  }) : super(supportedTypes, poolId);

  @override
  final TestLocalHandler localHandler;
  @override
  final TestRemoteHandler remoteHandler;
}

class TestRemoteHandler implements RemoteReferenceCommunicationHandler {
  const TestRemoteHandler({
    this.onCreationArgumentsFor,
    this.onCreateRemoteReference,
    this.onExecuteRemoteMethod,
  });

  final List<dynamic> Function(LocalReference localReference)
      onCreationArgumentsFor;

  final Future<void> Function(
    RemoteReference remoteReference,
    int typeId,
    List<dynamic> arguments,
  ) onCreateRemoteReference;

  final Future<dynamic> Function(
    RemoteReference remoteReference,
    String methodName,
    List<dynamic> arguments,
  ) onExecuteRemoteMethod;

  @override
  List<dynamic> creationArgumentsFor(LocalReference localReference) {
    return onCreationArgumentsFor(localReference);
  }

  @override
  Future<void> createRemoteReference(
    RemoteReference remoteReference,
    int typeId,
    List<dynamic> arguments,
  ) {
    return onCreateRemoteReference(remoteReference, typeId, arguments);
  }

  @override
  Future<void> disposeRemoteReference(RemoteReference remoteReference) {
    return Future<void>.value();
  }

  @override
  Future<dynamic> executeRemoteMethod(
    RemoteReference remoteReference,
    String methodName,
    List<dynamic> arguments,
  ) {
    return onExecuteRemoteMethod(remoteReference, methodName, arguments);
  }
}

class TestLocalHandler implements LocalReferenceCommunicationHandler {
  const TestLocalHandler({
    this.onCreateLocalReference,
    this.onExecuteLocalMethod,
  });

  final LocalReference Function(
    ReferencePairManager referencePairManager,
    Type referenceType,
    List<dynamic> arguments,
  ) onCreateLocalReference;

  final dynamic Function(
    ReferencePairManager referencePairManager,
    LocalReference localReference,
    String methodName,
    List<dynamic> arguments,
  ) onExecuteLocalMethod;

  @override
  LocalReference createLocalReference(
    ReferencePairManager referencePairManager,
    Type referenceType,
    List<dynamic> arguments,
  ) {
    return onCreateLocalReference(
      referencePairManager,
      referenceType,
      arguments,
    );
  }

  @override
  void disposeLocalReference(
    ReferencePairManager referencePairManager,
    LocalReference localReference,
  ) {
    // Do nothing.
  }

  @override
  dynamic executeLocalMethod(
    ReferencePairManager referencePairManager,
    LocalReference localReference,
    String methodName,
    List<dynamic> arguments,
  ) {
    return onExecuteLocalMethod(
      referencePairManager,
      localReference,
      methodName,
      arguments,
    );
  }
}
