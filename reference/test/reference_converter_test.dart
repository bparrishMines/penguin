import 'package:flutter_test/flutter_test.dart';
import 'package:reference/reference.dart';

import 'reference_matchers.dart';

void main() {
  group('$StandardInstanceConverter', () {
    final StandardInstanceConverter converter = StandardInstanceConverter();
    late TestManager testManager;

    setUp(() {
      testManager = TestManager();
    });

    test('convertForRemoteManager handles paired Object', () {
      final PairedInstance remoteReference = PairedInstance('test_id');
      testManager.onReceiveCreateNewInstancePair(
        'test_channel',
        remoteReference,
        <Object>[],
      );

      expect(
        converter.convertForRemoteManager(
            testManager, testManager.testHandler.testClassInstance),
        remoteReference,
      );
    });

    test('convertForRemoteManager handles unpaired $PairableInstance', () {
      expect(
        converter.convertForRemoteManager(testManager, TestClass(testManager)),
        isUnpairedInstance('test_channel', <Object>[]),
      );
    });

    test('convertForRemoteManager handles unpaired non-$PairableInstance', () {
      expect(
        converter.convertForRemoteManager(testManager, 'potato'),
        equals('potato'),
      );
    });

    test('convertForLocalManager handles $PairedInstance', () {
      final PairedInstance remoteReference = PairedInstance('test_id');
      testManager.onReceiveCreateNewInstancePair(
        'test_channel',
        remoteReference,
        <Object>[],
      );

      expect(
        converter.convertForLocalManager(testManager, remoteReference),
        testManager.testHandler.testClassInstance,
      );
    });

    test('convertForLocalManager handles $NewUnpairedInstance', () async {
      converter.convertForLocalManager(
        testManager,
        NewUnpairedInstance('test_channel', <Object>[]),
      );
    });
  });
}

class TestManager extends TypeChannelManager {
  TestManager() {
    testHandler = TestHandler(this);
    registerHandler('test_channel', testHandler);
  }

  late final TestHandler testHandler;

  @override
  TypeChannelMessenger get messenger => throw UnimplementedError();
}

class TestHandler with TypeChannelHandler<TestClass> {
  TestHandler(TestManager manager) : testClassInstance = TestClass(manager);

  final TestClass testClassInstance;

  @override
  TestClass createInstance(
    TypeChannelManager manager,
    List<Object?> arguments,
  ) {
    return testClassInstance;
  }

  @override
  List<Object?> getCreationArguments(
      TypeChannelManager manager, TestClass instance) {
    return <Object?>[];
  }

  @override
  Object? invokeMethod(TypeChannelManager manager, TestClass instance,
      String methodName, List<Object?> arguments) {
    return 'return_value';
  }

  @override
  Object? invokeStaticMethod(TypeChannelManager manager, String methodName,
      List<Object?> arguments) {
    return 'return_value';
  }
}

class TestClass with PairableInstance<TestClass> {
  TestClass(this.manager);

  final TypeChannelManager manager;

  @override
  TypeChannel<TestClass> get typeChannel => TypeChannel<TestClass>(
        manager,
        'test_channel',
      );
}
