import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:reference/reference.dart';

void main() {
  group('$ReferenceChannelManager', () {
    late TestManager testManager;

    setUp(() {
      testManager = TestManager();
    });

    test('onReceiveCreateNewPair', () {
      final TestClass testClass = TestClass(testManager);

      when(testManager.mockHandler.createInstance(testManager, <Object>[]))
          .thenReturn(testClass);

      expect(
        testManager.onReceiveCreateNewPair(
          'test_channel',
          RemoteReference('test_id'),
          <Object>[],
        ),
        testClass,
      );
      expect(testManager.isPaired(testClass), isTrue);
      expect(
        testManager.onReceiveCreateNewPair(
          '',
          RemoteReference('test_id'),
          <Object>[],
        ),
        isNull,
      );
    });

    test('onReceiveInvokeStaticMethod', () {
      testManager.onReceiveInvokeStaticMethod(
        'test_channel',
        'aStaticMethod',
        <Object>[],
      );

      verify(testManager.mockHandler.invokeStaticMethod(
        testManager,
        'aStaticMethod',
        <Object>[],
      ));
    });

    test('createUnpairedReference', () {
      when(testManager.mockHandler.getCreationArguments(testManager, any))
          .thenReturn(<Object>[]);

      final UnpairedReference unpairedReference =
          testManager.createUnpairedReference(
        'test_channel',
        TestClass(testManager),
      );
      expect(unpairedReference.channelName, 'test_channel');
      expect(unpairedReference.creationArguments, isEmpty);
    });

    test('onReceiveInvokeMethod', () {
      final TestClass testClass = TestClass(testManager);

      when(testManager.mockHandler.createInstance(testManager, <Object>[]))
          .thenReturn(testClass);

      testManager.onReceiveCreateNewPair(
        'test_channel',
        RemoteReference('test_id'),
        <Object>[],
      );

      testManager.onReceiveInvokeMethod(
        'test_channel',
        RemoteReference('test_id'),
        'aMethod',
        <Object>[],
      );
      verify(testManager.mockHandler.invokeMethod(
        testManager,
        testClass,
        'aMethod',
        <Object>[],
      ));
    });

    test('onReceiveInvokeMethodOnUnpairedReference', () {
      final TestClass testClass = TestClass(testManager);

      when(testManager.mockHandler.createInstance(testManager, <Object>[]))
          .thenReturn(testClass);

      expect(
        testManager.onReceiveInvokeMethodOnUnpairedReference(
          UnpairedReference('test_channel', <Object>[]),
          'aMethod',
          <Object>[],
        ),
        isNull,
      );

      verify(testManager.mockHandler.invokeMethod(
        testManager,
        testClass,
        'aMethod',
        <Object>[],
      ));
    });

    test('onReceiveDisposePair', () {
      final TestClass testClass = TestClass(testManager);

      when(testManager.mockHandler.createInstance(testManager, <Object>[]))
          .thenReturn(testClass);

      testManager.onReceiveCreateNewPair(
        'test_channel',
        RemoteReference('test_id'),
        <Object>[],
      );
      testManager.onReceiveDisposePair(
        'test_channel',
        RemoteReference('test_id'),
      );
      expect(testManager.isPaired(testClass), isFalse);
    });
  });

  group('$ReferenceChannel', () {
    TestManager testManager;
    ReferenceChannel<TestClass> testChannel;

    setUp(() {
      testManager = TestManager();
      testChannel = ReferenceChannel<TestClass>(testManager, 'test_channel');
    });

    test('createNewPair', () {
      final TestClass testClass = TestClass(testManager);

      when(testManager.mockHandler.getCreationArguments(testManager, testClass))
          .thenReturn(<Object>[]);

      when(testManager.mockMessenger.sendCreateNewPair(
        'test_channel',
        RemoteReference('test_reference_id'),
        <Object>[],
      )).thenAnswer((_) => Future<void>.value());

      expect(
        testChannel.createNewPair(testClass),
        completion(RemoteReference('test_reference_id')),
      );
      expect(testChannel.createNewPair(testClass), completion(isNull));
    });

    test('invokeStaticMethod', () {
      when(testManager.mockMessenger.sendInvokeStaticMethod(
        'test_channel',
        'aStaticMethod',
        <Object>[],
      )).thenAnswer((_) => Future<Object>.value('return_value'));

      expect(
        testChannel.invokeStaticMethod('aStaticMethod', <Object>[]),
        completion('return_value'),
      );
    });

    test('invokeMethod', () async {
      final TestClass testClass = TestClass(testManager);

      when(testManager.mockHandler.getCreationArguments(testManager, testClass))
          .thenReturn(<Object>[]);

      when(testManager.mockMessenger.sendInvokeMethod(
        'test_channel',
        RemoteReference('test_reference_id'),
        'aMethod',
        <Object>[],
      )).thenAnswer((_) => Future<Object>.value('return_value'));

      testChannel.createNewPair(testClass);
      expect(
        testChannel.invokeMethod(testClass, 'aMethod', <Object>[]),
        completion('return_value'),
      );
    });

    test(
      'invokeMethodOnUnpairedReference',
      () async {
        final TestClass testClass = TestClass(testManager);

        when(
          testManager.mockHandler.getCreationArguments(testManager, testClass),
        ).thenReturn(<Object>[]);

        when(testManager.mockMessenger.sendInvokeMethodOnUnpairedReference(
          any,
          'aMethod',
          <Object>[],
        )).thenAnswer((_) => Future<Object>.value('return_value'));

        expect(
          testChannel.invokeMethodOnUnpairedReference(
            TestClass(testManager),
            'aMethod',
            <Object>[],
          ),
          completion('return_value'),
        );
      },
    );

    test('disposePair', () async {
      final testClass = TestClass(testManager);

      when(testManager.mockHandler.getCreationArguments(testManager, testClass))
          .thenReturn(<Object>[]);

      testChannel.createNewPair(testClass);
      expect(testChannel.disposePair(testClass), completion(isNull));
      verify(testManager.mockMessenger.sendDisposePair(
        'test_channel',
        RemoteReference('test_reference_id'),
      ));
    });
  });
}

class TestManager extends ReferenceChannelManager {
  TestManager() {
    registerHandler('test_channel', mockHandler);
  }

  final MockHandler mockHandler = MockHandler();

  MockMessenger get mockMessenger => messenger;

  @override
  final MockMessenger messenger = MockMessenger();

  @override
  String getNewReferenceId() {
    return 'test_reference_id';
  }
}

class MockHandler = Mock with ReferenceChannelHandler<TestClass>;
class MockMessenger = Mock with ReferenceChannelMessenger;

class TestClass with Referencable<TestClass> {
  TestClass(this.manager);

  final ReferenceChannelManager manager;

  @override
  ReferenceChannel<TestClass> get referenceChannel => ReferenceChannel(
        manager,
        'test_channel',
      );
}
