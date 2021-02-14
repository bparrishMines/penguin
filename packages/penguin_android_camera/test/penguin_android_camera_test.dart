import 'package:flutter_test/flutter_test.dart';
import 'package:penguin_android_camera/channels.dart';
import 'package:penguin_android_camera/penguin_android_camera.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  PenguinAndroidCamera.initialize();

  group('$CameraInfo', () {
    test('facing constants', () {
      // These must remain constant with
      // https://developer.android.com/reference/android/hardware/Camera.CameraInfo#CAMERA_FACING_BACK
      // https://developer.android.com/reference/android/hardware/Camera.CameraInfo#CAMERA_FACING_BACK
      expect(CameraInfo.cameraFacingBack, 0);
      expect(CameraInfo.cameraFacingFront, 1);
    });
  });

  group('$Camera', () {
    late TypeChannelMessenger testMessenger;

    setUp(() {
      testMessenger = TestMessenger();
      Channels.cameraChannel = CameraChannel(testMessenger)
        ..setHandler(CameraHandler());
    });

    test('attachPreviewTexture', () async {
      final Camera camera = Camera();
      await testMessenger.createNewInstancePair(
        Channels.cameraChannel.name,
        camera,
      );

      int textureId = await camera.attachPreviewTexture();
      expect(textureId, 5);

      textureId = await camera.attachPreviewTexture();
      expect(textureId, 5);
    });
  });
}

class TestMessenger extends TypeChannelMessenger {
  @override
  TypeChannelMessageDispatcher get messageDispatcher => TestMessageDispatcher();
}

class TestMessageDispatcher implements TypeChannelMessageDispatcher {
  @override
  Future<void> sendCreateNewInstancePair(
    String channelName,
    PairedInstance pairedInstance,
    List<Object?> arguments,
  ) {
    return Future<void>.value();
  }

  @override
  Future<void> sendDisposePair(
    String channelName,
    PairedInstance pairedInstance,
  ) {
    throw UnimplementedError();
  }

  @override
  Future<Object?> sendInvokeMethod(
    String channelName,
    PairedInstance pairedInstance,
    String methodName,
    List<Object?> arguments,
  ) async {
    return 5;
  }

  @override
  Future<Object?> sendInvokeMethodOnUnpairedInstance(
    NewUnpairedInstance unpairedInstance,
    String methodName,
    List<Object?> arguments,
  ) {
    throw UnimplementedError();
  }

  @override
  Future<Object?> sendInvokeStaticMethod(
    String channelName,
    String methodName,
    List<Object?> arguments,
  ) {
    throw UnimplementedError();
  }
}
