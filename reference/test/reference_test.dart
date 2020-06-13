import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:reference/reference.dart';

import 'reference_matchers.dart';

void main() {
  // TODO: test only non-poolable reference
  group('$ReferencePairManager', () {
    test('pairWithNewLocalReference', () {
      final allArguments = <List<Object>>[];

      final manager = TestReferencePairManager(
        <Type>[TestClass],
        "test_id",
        localHandler: TestLocalHandler(
          onPairWithNewLocalReference: (
            ReferencePairManager referencePairManager,
            Type referenceType,
            List<Object> arguments,
          ) {
            allArguments.add(arguments);
            return TestClass();
          },
        ),
      )..initialize();

      final TestClass result = manager.pairWithNewLocalReference(
        RemoteReference('apple'),
        0,
        <Object>[
          'Hello',
          UnpairedRemoteReference(0, <Object>[], "test_id"),
          <Object>[
            UnpairedRemoteReference(0, <Object>[], "test_id"),
          ],
          <Object, Object>{
            1.1: UnpairedRemoteReference(0, <Object>[], "test_id"),
          },
        ],
      );

      expect(manager.getPairedLocalReference(RemoteReference('apple')), result);
      expect(
          manager.getPairedRemoteReference(result), RemoteReference('apple'));
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

    test('invokeLocalMethod', () {
      final methodArguments = <Object>[];
      final manager = TestReferencePairManager(
        <Type>[TestClass],
        "test_id",
        localHandler: TestLocalHandler(
          onPairWithNewLocalReference: (
            ReferencePairManager referencePairManager,
            Type referenceType,
            List<Object> arguments,
          ) {
            return TestClass();
          },
          onInvokeLocalMethod: (
            ReferencePairManager referencePairManager,
            LocalReference localReference,
            String methodName,
            List<Object> arguments,
          ) {
            if (methodName == 'aMethod') methodArguments.addAll(arguments);
            return null;
          },
        ),
      )..initialize();

      manager.pairWithNewLocalReference(RemoteReference('chi'), 0);
      manager.invokeLocalMethod(
        manager.getPairedLocalReference(RemoteReference('chi')),
        'aMethod',
        <Object>[
          'Hello',
          UnpairedRemoteReference(0, <Object>[], "test_id"),
          <Object>[
            UnpairedRemoteReference(0, <Object>[], "test_id"),
          ],
          <Object, Object>{
            1.1: UnpairedRemoteReference(0, <Object>[], "test_id"),
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

    test('disposePairWithRemoteReference', () {
      final manager = TestReferencePairManager(
        <Type>[TestClass],
        "test_id",
        localHandler: TestLocalHandler(
          onPairWithNewLocalReference: (
            ReferencePairManager referencePairManager,
            Type referenceType,
            List<Object> arguments,
          ) {
            return TestClass();
          },
        ),
      )..initialize();

      final TestClass result = manager.pairWithNewLocalReference(
        RemoteReference('tea'),
        0,
      );
      manager.disposePairWithRemoteReference(RemoteReference('tea'));

      expect(manager.getPairedLocalReference(RemoteReference('tea')), isNull);
      expect(manager.getPairedRemoteReference(result), isNull);
    });

    test('pairWithNewRemoteReference', () async {
      final creationArguments = <Object>[];
      bool firstCall = true;

      final manager = TestReferencePairManager(
        <Type>[TestClass],
        "test_id",
        remoteHandler: TestRemoteHandler(
          onGetCreationArguments: (LocalReference localReference) {
            if (localReference is TestClass && firstCall) {
              firstCall = false;
              return <Object>[
                'Hello',
                TestClass(),
                <Object>[TestClass()],
                <Object, Object>{1.1: TestClass()},
              ];
            }

            return <Object>[];
          },
          onPairWithNewRemoteReference: (
            RemoteReference remoteReference,
            int typeId,
            List<Object> arguments,
          ) {
            creationArguments.addAll(arguments);
            return Future<void>.value();
          },
        ),
      )..initialize();

      final testClass = TestClass();
      final RemoteReference remoteReference =
          await manager.pairWithNewRemoteReference(
        testClass,
      );

      expect(remoteReference, isNotNull);
      expect(manager.getPairedLocalReference(remoteReference), testClass);
      expect(manager.getPairedRemoteReference(testClass), remoteReference);
      expect(creationArguments, <Matcher>[
        equals('Hello'),
        isUnpairedRemoteReference(0, <Object>[], "test_id"),
        contains(isUnpairedRemoteReference(0, <Object>[], "test_id")),
        containsPair(
          1.1,
          isUnpairedRemoteReference(0, <Object>[], "test_id"),
        ),
      ]);
    });

    test('invokeRemoteMethod', () async {
      final methodArguments = <Object>[];

      final manager = TestReferencePairManager(
        <Type>[TestClass],
        "test_id",
        remoteHandler: TestRemoteHandler(
          onGetCreationArguments: (LocalReference localReference) {
            return <Object>[];
          },
          onPairWithNewRemoteReference: (
            RemoteReference remoteReference,
            int typeId,
            List<Object> arguments,
          ) {
            return Future<void>.value();
          },
          onInvokeRemoteMethod: (
            RemoteReference remoteReference,
            String methodName,
            List<Object> arguments,
          ) {
            methodArguments.addAll(arguments);
            return Future<void>.value();
          },
        ),
      )..initialize();

      final testClass = TestClass();
      manager.pairWithNewRemoteReference(testClass);
      await manager.invokeRemoteMethod(
        manager.getPairedRemoteReference(testClass),
        'aMethod',
        <Object>[
          'Hello',
          TestClass(),
          <Object>[TestClass()],
          <Object, Object>{1.1: TestClass()},
        ],
      );

      expect(methodArguments, <Matcher>[
        equals('Hello'),
        isUnpairedRemoteReference(0, <Object>[], "test_id"),
        contains(isUnpairedRemoteReference(0, <Object>[], "test_id")),
        containsPair(
          1.1,
          isUnpairedRemoteReference(0, <Object>[], "test_id"),
        ),
      ]);
    });
  });

  test('disposePairWithLocalReference', () async {
    final manager = TestReferencePairManager(
      <Type>[TestClass],
      "test_id",
      remoteHandler: TestRemoteHandler(
        onGetCreationArguments: (LocalReference localReference) {
          return <Object>[];
        },
        onPairWithNewRemoteReference: (
          RemoteReference remoteReference,
          int typeId,
          List<Object> arguments,
        ) {
          return Future<void>.value();
        },
      ),
    )..initialize();

    final testClass = TestClass();
    final RemoteReference remoteReference =
        await manager.pairWithNewRemoteReference(
      testClass,
    );
    manager.disposePairWithLocalReference(testClass);

    expect(manager.getPairedLocalReference(remoteReference), isNull);
    expect(manager.getPairedRemoteReference(testClass), isNull);
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

    test('pairWithNewLocalReference', () {
      final allArguments = <List<Object>>[];

      final manager1 = TestReferencePairManager(
        <Type>[TestClass],
        "test_id",
        localHandler: TestLocalHandler(
          onPairWithNewLocalReference: (
            ReferencePairManager referencePairManager,
            Type referenceType,
            List<Object> arguments,
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
          onPairWithNewLocalReference: (
            ReferencePairManager referencePairManager,
            Type referenceType,
            List<Object> arguments,
          ) {
            return TestClass2();
          },
        ),
      )..initialize();

      pool.add(manager1);
      pool.add(manager2);

      manager1.pairWithNewLocalReference(
        RemoteReference('apple'),
        0,
        <Object>[
          'Hello',
          UnpairedRemoteReference(0, <Object>[], "test_id2"),
          UnpairedRemoteReference(0, <Object>[], "test_id"),
          <Object>[
            UnpairedRemoteReference(0, <Object>[], "test_id"),
          ],
          <Object, Object>{
            1.1: UnpairedRemoteReference(0, <Object>[], "test_id"),
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

    test('pairWithNewRemoteReference', () async {
      final creationArguments = <Object>[];
      bool firstCall = true;

      final manager1 = TestReferencePairManager(
        <Type>[TestClass],
        "test_id",
        remoteHandler: TestRemoteHandler(
          onGetCreationArguments: (LocalReference localReference) {
            if (localReference is TestClass && firstCall) {
              firstCall = false;
              return <Object>[
                'Hello',
                TestClass2(),
                TestClass(),
                <Object>[TestClass()],
                <Object, Object>{1.1: TestClass()},
              ];
            }

            return <Object>[];
          },
          onPairWithNewRemoteReference: (
            RemoteReference remoteReference,
            int typeId,
            List<Object> arguments,
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
          onGetCreationArguments: (LocalReference localReference) {
            if (localReference is TestClass2) return <Object>[];
            return null;
          },
          onPairWithNewRemoteReference: (
            RemoteReference remoteReference,
            int typeId,
            List<Object> arguments,
          ) {
            return Future<void>.value();
          },
        ),
      )..initialize();

      pool.add(manager1);
      pool.add(manager2);

      final testClass = TestClass();
      await manager1.pairWithNewRemoteReference(testClass);

      expect(creationArguments, <Matcher>[
        equals('Hello'),
        isUnpairedRemoteReference(0, <Object>[], "test_id2"),
        isUnpairedRemoteReference(0, <Object>[], "test_id"),
        contains(isUnpairedRemoteReference(0, <Object>[], "test_id")),
        containsPair(
          1.1,
          isUnpairedRemoteReference(0, <Object>[], "test_id"),
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
    this.onGetCreationArguments,
    this.onPairWithNewRemoteReference,
    this.onInvokeRemoteMethod,
  });

  final List<Object> Function(LocalReference localReference)
      onGetCreationArguments;

  final Future<void> Function(
    RemoteReference remoteReference,
    int typeId,
    List<Object> arguments,
  ) onPairWithNewRemoteReference;

  final Future<Object> Function(
    RemoteReference remoteReference,
    String methodName,
    List<Object> arguments,
  ) onInvokeRemoteMethod;

  @override
  List<Object> getCreationArguments(LocalReference localReference) {
    return onGetCreationArguments(localReference);
  }

  @override
  Future<void> create(
    RemoteReference remoteReference,
    int typeId,
    List<Object> arguments,
  ) {
    return onPairWithNewRemoteReference(remoteReference, typeId, arguments);
  }

  @override
  Future<void> dispose(RemoteReference remoteReference) {
    return Future<void>.value();
  }

  @override
  Future<Object> invokeMethod(
    RemoteReference remoteReference,
    String methodName,
    List<Object> arguments,
  ) {
    return onInvokeRemoteMethod(remoteReference, methodName, arguments);
  }
}

class TestLocalHandler implements LocalReferenceCommunicationHandler {
  const TestLocalHandler({
    this.onPairWithNewLocalReference,
    this.onInvokeLocalMethod,
  });

  final LocalReference Function(
    ReferencePairManager referencePairManager,
    Type referenceType,
    List<Object> arguments,
  ) onPairWithNewLocalReference;

  final Object Function(
    ReferencePairManager referencePairManager,
    LocalReference localReference,
    String methodName,
    List<Object> arguments,
  ) onInvokeLocalMethod;

  @override
  LocalReference create(
    ReferencePairManager referencePairManager,
    Type referenceType,
    List<Object> arguments,
  ) {
    return onPairWithNewLocalReference(
      referencePairManager,
      referenceType,
      arguments,
    );
  }

  @override
  void dispose(
    ReferencePairManager referencePairManager,
    LocalReference localReference,
  ) {
    // Do nothing.
  }

  @override
  Object invokeMethod(
    ReferencePairManager referencePairManager,
    LocalReference localReference,
    String methodName,
    List<Object> arguments,
  ) {
    return onInvokeLocalMethod(
      referencePairManager,
      localReference,
      methodName,
      arguments,
    );
  }
}
