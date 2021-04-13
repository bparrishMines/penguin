import 'package:flutter_test/flutter_test.dart';
import 'package:penguin_android_camera/channels.dart';
import 'package:penguin_android_camera/penguin_android_camera.dart';
import 'package:reference/reference.dart';
import 'package:reference/src/type_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

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
    setUp(() {
      ChannelRegistrar.instance =
          ChannelRegistrar(TestLibraryImplementations());
    });

    test('attachPreviewTexture', () async {
      final Camera camera = Camera();
      ChannelRegistrar
          .instance.implementations.cameraChannel.messenger.instancePairManager
          .addPair(
        camera,
        'camera_id',
        owner: true,
      );

      int textureId = await camera.attachPreviewTexture();
      expect(textureId, 5);

      textureId = await camera.attachPreviewTexture();
      expect(textureId, 5);
    });
  });
}

class TestLibraryImplementations extends LibraryImplementations {
  TestLibraryImplementations() : super(TestMessenger());
}

class TestInstancePairManager implements InstancePairManager {
  final Map<Object, String> instanceToInstanceId = <Object, String>{};
  final Map<String, Object> instanceIdToInstance = <String, Object>{};

  @override
  bool addPair(Object instance, String instanceId, {required bool owner}) {
    if (isPaired(true)) return false;
    instanceToInstanceId[instance] = instanceId;
    instanceIdToInstance[instanceId] = instance;
    return true;
  }

  @override
  Object? getInstance(String instanceId) {
    return instanceIdToInstance[instanceId];
  }

  @override
  String? getInstanceId(Object instance) {
    return instanceToInstanceId[instance];
  }

  @override
  bool isPaired(Object instance) {
    return instanceToInstanceId.containsKey(instance);
  }

  @override
  void removePair(String instanceId) {
    final Object? instance = instanceIdToInstance.remove(instanceId);
    instanceToInstanceId.remove(instance);
  }
}

class TestMessenger extends TypeChannelMessenger {
  @override
  final InstancePairManager instancePairManager = TestInstancePairManager();

  @override
  final TypeChannelMessageDispatcher messageDispatcher =
      TestMessageDispatcher();
}

class TestMessageDispatcher implements TypeChannelMessageDispatcher {
  @override
  Future<void> sendCreateNewInstancePair(
    String channelName,
    PairedInstance pairedInstance,
    List<Object?> arguments, {
    required bool owner,
  }) {
    return Future<void>.value();
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
  Future<Object?> sendInvokeStaticMethod(
    String channelName,
    String methodName,
    List<Object?> arguments,
  ) {
    throw UnimplementedError();
  }

  @override
  Future<void> sendDisposeInstancePair(PairedInstance pairedInstance) {
    throw UnimplementedError();
  }
}
