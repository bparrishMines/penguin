import 'package:flutter_test/flutter_test.dart';
//import 'package:mockito/mockito.dart';
import 'package:reference/reference.dart';

import 'reference_matchers.dart';

void main() {
  group('$StandardReferenceConverter', () {
    final StandardReferenceConverter converter = StandardReferenceConverter();
    late TestManager testManager;

    setUp(() {
      testManager = TestManager();
    });

    test('convertForRemoteManager handles paired Object', () {
      final PairedReference remoteReference = PairedReference('test_id');
      testManager.onReceiveCreateNewPair(
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

    test('convertForRemoteManager handles unpaired $Referencable', () {
      expect(
        converter.convertForRemoteManager(testManager, TestClass(testManager)),
        isUnpairedReference('test_channel', <Object>[]),
      );
    });

    test('convertForRemoteManager handles unpaired non-$Referencable', () {
      expect(
        converter.convertForRemoteManager(testManager, 'potato'),
        equals('potato'),
      );
    });

    test('convertForLocalManager handles $PairedReference', () {
      final PairedReference remoteReference = PairedReference('test_id');
      testManager.onReceiveCreateNewPair(
        'test_channel',
        remoteReference,
        <Object>[],
      );

      expect(
        converter.convertForLocalManager(testManager, remoteReference),
        testManager.testHandler.testClassInstance,
      );
    });

    test('convertForLocalManager handles $UnpairedReference', () async {
      converter.convertForLocalManager(
        testManager,
        UnpairedReference('test_channel', <Object>[]),
      );
    });
  });
}

class TestManager extends ReferenceChannelManager {
  TestManager() {
    testHandler = TestHandler(this);
    registerHandler('test_channel', testHandler);
  }

  late final TestHandler testHandler;

  @override
  ReferenceChannelMessenger get messenger => throw UnimplementedError();
}

class TestHandler with ReferenceChannelHandler<TestClass> {
  TestHandler(TestManager manager) : testClassInstance = TestClass(manager);

  final TestClass testClassInstance;

  @override
  TestClass createInstance(
    ReferenceChannelManager manager,
    List<Object?> arguments,
  ) {
    return testClassInstance;
  }

  @override
  List<Object?> getCreationArguments(
      ReferenceChannelManager manager, TestClass instance) {
    return <Object?>[];
  }

  @override
  Object? invokeMethod(ReferenceChannelManager manager, TestClass instance,
      String methodName, List<Object?> arguments) {
    return 'return_value';
  }

  @override
  Object? invokeStaticMethod(ReferenceChannelManager manager, String methodName,
      List<Object?> arguments) {
    return 'return_value';
  }
}

class TestClass with Referencable<TestClass> {
  TestClass(this.manager);

  final ReferenceChannelManager manager;

  @override
  ReferenceChannel<TestClass> get referenceChannel => ReferenceChannel(
        manager,
        'test_channel',
      );
}
