import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:reference/reference.dart';

import 'reference_matchers.dart';

void main() {
  group('$ReferencePairManager', () {
    test('createLocalReferenceFor', () {
      final allArguments = <List<dynamic>>[];

      final manager = TestReferencePairManager(
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
          UnpairedRemoteReference(0, <dynamic>[]),
          <dynamic>[
            UnpairedRemoteReference(0, <dynamic>[]),
          ],
          <dynamic, dynamic>{
            1.1: UnpairedRemoteReference(0, <dynamic>[]),
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
          UnpairedRemoteReference(0, <dynamic>[]),
          <dynamic>[
            UnpairedRemoteReference(0, <dynamic>[]),
          ],
          <dynamic, dynamic>{
            1.1: UnpairedRemoteReference(0, <dynamic>[]),
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
        isUnpairedRemoteReference(0, <dynamic>[]),
        contains(isUnpairedRemoteReference(0, <dynamic>[])),
        containsPair(
          1.1,
          isUnpairedRemoteReference(0, <dynamic>[]),
        ),
      ]);
    });

    test('executeRemoteMethodFor', () async {
      final methodArguments = <dynamic>[];

      final manager = TestReferencePairManager(
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
        isUnpairedRemoteReference(0, <dynamic>[]),
        contains(isUnpairedRemoteReference(0, <dynamic>[])),
        containsPair(
          1.1,
          isUnpairedRemoteReference(0, <dynamic>[]),
        ),
      ]);
    });
  });

  test('disposeRemoteReferenceFor', () async {
    final manager = TestReferencePairManager(
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
}

class TestClass with LocalReference {
  @override
  Type get referenceType => TestClass;
}

class TestReferencePairManager extends ReferencePairManager {
  TestReferencePairManager({this.localHandler, this.remoteHandler})
      : super(<Type>[TestClass]);

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
