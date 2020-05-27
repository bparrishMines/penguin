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
            TypeReference typeReference,
            List<dynamic> arguments,
          ) {
            allArguments.add(arguments);
            return TestClass();
          },
        ),
      )..initialize();

      final TestClass result = manager.createLocalReferenceFor(
        RemoteReference('apple'),
        TypeReference(0),
        <dynamic>[
          'Hello',
          UnpairedRemoteReference(TypeReference(0), <dynamic>[]),
          <dynamic>[
            UnpairedRemoteReference(TypeReference(0), <dynamic>[]),
          ],
          <dynamic, dynamic>{
            1.1: UnpairedRemoteReference(TypeReference(0), <dynamic>[]),
          },
        ],
      );

      expect(result, isA<TestClass>());
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

    // TODO: Test return values
    test('executeLocalMethodFor', () {
      final methodArguments = <dynamic>[];
      final manager = TestReferencePairManager(
        localHandler: TestLocalHandler(
          onCreateLocalReference: (
            ReferencePairManager referencePairManager,
            TypeReference typeReference,
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

      manager.createLocalReferenceFor(RemoteReference('chi'), TypeReference(0));
      manager.executeLocalMethodFor(
        RemoteReference('chi'),
        'aMethod',
        <dynamic>[
          'Hello',
          UnpairedRemoteReference(TypeReference(0), <dynamic>[]),
          <dynamic>[
            UnpairedRemoteReference(TypeReference(0), <dynamic>[]),
          ],
          <dynamic, dynamic>{
            1.1: UnpairedRemoteReference(TypeReference(0), <dynamic>[]),
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
            TypeReference typeReference,
            List<dynamic> arguments,
          ) {
            return TestClass();
          },
        ),
      )..initialize();

      final TestClass result = manager.createLocalReferenceFor(
        RemoteReference('tea'),
        TypeReference(0),
      );
      manager.disposeLocalReferenceFor(RemoteReference('tea'));

      expect(manager.localReferenceFor(RemoteReference('tea')), isNull);
      expect(manager.remoteReferenceFor(result), isNull);
    });

    test('createRemoteReferenceFor', () async {
      final creationArguments = <dynamic>[];
      bool firstCall = false;

      final manager = TestReferencePairManager(
        remoteHandler: TestRemoteHandler(
          onCreationArgumentsFor: (LocalReference localReference) {
            if (localReference is TestClass && !firstCall) {
              firstCall = true;
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
            TypeReference typeReference,
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
        isUnpairedRemoteReference(TypeReference(0), <dynamic>[]),
        contains(isUnpairedRemoteReference(TypeReference(0), <dynamic>[])),
        containsPair(
          1.1,
          isUnpairedRemoteReference(TypeReference(0), <dynamic>[]),
        ),
      ]);
    });

    // TODO: test return values
    test('executeRemoteMethodFor', () async {
      final methodArguments = <dynamic>[];

      final manager = TestReferencePairManager(
        remoteHandler: TestRemoteHandler(
          onCreationArgumentsFor: (LocalReference localReference) {
            return <dynamic>[];
          },
          onCreateRemoteReference: (
            RemoteReference remoteReference,
            TypeReference typeReference,
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
        isUnpairedRemoteReference(TypeReference(0), <dynamic>[]),
        contains(isUnpairedRemoteReference(TypeReference(0), <dynamic>[])),
        containsPair(
          1.1,
          isUnpairedRemoteReference(TypeReference(0), <dynamic>[]),
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
          TypeReference typeReference,
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

class TestClass with LocalReference {}

class TestReferencePairManager extends ReferencePairManager {
  TestReferencePairManager({this.localHandler, this.remoteHandler});

  @override
  final TestLocalHandler localHandler;
  @override
  final TestRemoteHandler remoteHandler;

  @override
  TypeReference typeReferenceFor(LocalReference localReference) {
    if (localReference is TestClass) return TypeReference(0);
    throw UnsupportedError('message');
  }
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
    TypeReference typeReference,
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
    TypeReference typeReference,
    List<dynamic> arguments,
  ) {
    return onCreateRemoteReference(remoteReference, typeReference, arguments);
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
    TypeReference typeReference,
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
    TypeReference typeReference,
    List<dynamic> arguments,
  ) {
    return onCreateLocalReference(
      referencePairManager,
      typeReference,
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
