import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:reference/reference.dart';

import 'reference_matchers.dart';

void main() {
  group('$StandardReferenceConverter', () {
    final StandardReferenceConverter converter = StandardReferenceConverter();
    TestManager testManager;

    setUp(() {
      testManager = TestManager();
    });

    test('convertForRemoteManager handles paired Object', () async {
      final TestClass testClass = TestClass(testManager);

      when(testManager.mockHandler.createInstance(testManager, any))
          .thenReturn(testClass);

      final RemoteReference remoteReference = RemoteReference('test_id');
      testManager.onReceiveCreateNewPair(
        'test_channel',
        remoteReference,
        <Object>[],
      );

      expect(
        converter.convertForRemoteManager(testManager, testClass),
        remoteReference,
      );
    });

    test('convertForRemoteManager handles unpaired $Referencable', () async {
      when(testManager.mockHandler.getCreationArguments(testManager, any))
          .thenReturn(<Object>[]);

      expect(
        converter.convertForRemoteManager(testManager, TestClass(testManager)),
        isUnpairedReference('test_channel', <Object>[]),
      );
    });

    test('convertForRemoteManager handles unpaired non-$Referencable',
        () async {
      expect(
        converter.convertForRemoteManager(testManager, 'potato'),
        equals('potato'),
      );
    });

    test('convertForLocalManager handles $RemoteReference', () async {
      final TestClass testClass = TestClass(testManager);

      when(testManager.mockHandler.createInstance(testManager, any))
          .thenReturn(testClass);

      final RemoteReference remoteReference = RemoteReference('test_id');
      testManager.onReceiveCreateNewPair(
        'test_channel',
        remoteReference,
        <Object>[],
      );

      expect(
        converter.convertForLocalManager(testManager, remoteReference),
        testClass,
      );
    });

    test('convertForLocalManager handles $UnpairedReference', () async {
      final TestClass testClass = TestClass(testManager);

      when(testManager.mockHandler.createInstance(testManager, any))
          .thenReturn(testClass);

      converter.convertForLocalManager(
        testManager,
        UnpairedReference('test_channel', <Object>[]),
      );
    });
  });
}

class TestManager extends ReferenceChannelManager {
  TestManager() {
    registerHandler('test_channel', mockHandler);
  }

  final MockHandler mockHandler = MockHandler();

  @override
  ReferenceChannelMessenger get messenger => throw UnimplementedError();
}

class MockHandler = Mock with ReferenceChannelHandler<TestClass>;

class TestClass with Referencable<TestClass> {
  TestClass(this.manager);

  final ReferenceChannelManager manager;

  @override
  ReferenceChannel<TestClass> get referenceChannel => ReferenceChannel(
        manager,
        'test_channel',
      );
}
