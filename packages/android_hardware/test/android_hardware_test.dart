import 'package:flutter_test/flutter_test.dart';
import 'package:android_hardware/channels.dart';
import 'package:android_hardware/android_hardware.dart';
import 'package:reference/reference.dart';
import 'package:reference/src/type_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('$CameraInfo', () {
    test('facing constants', () {
      // These must remain constant with
      // https://developer.android.com/reference/android/hardware/Camera.CameraInfo#CAMERA_FACING_BACK
      // https://developer.android.com/reference/android/hardware/Camera.CameraInfo#CAMERA_FACING_FRONT
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
          .instance.implementations.channelCamera.messenger.instanceManager
          .addStrongReference(
        instance: camera,
        instanceId: 'camera_id',
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

class TestInstanceManager implements InstanceManager {
  final Map<Object, String> instanceToInstanceId = <Object, String>{};
  final Map<String, Object> instanceIdToInstance = <String, Object>{};

  @override
  Object? getInstance(String instanceId) {
    return instanceIdToInstance[instanceId];
  }

  @override
  String? getInstanceId(Object instance) {
    return instanceToInstanceId[instance];
  }

  @override
  bool containsInstance(Object instance) {
    return instanceToInstanceId.containsKey(instance);
  }

  @override
  void removeInstance(String instanceId) {
    final Object? instance = instanceIdToInstance.remove(instanceId);
    instanceToInstanceId.remove(instance);
  }

  @override
  bool addStrongReference({required Object instance, String? instanceId}) {
    if (containsInstance(true)) return false;

    final String newId = instanceId ?? generateUniqueInstanceId(instance);
    instanceToInstanceId[instance] = newId;
    instanceIdToInstance[newId] = instance;
    return true;
  }

  @override
  bool addWeakReference({
    required Object instance,
    String? instanceId,
    required void Function(String instanceId) onFinalize,
  }) {
    if (containsInstance(true)) return false;
    final String newId = instanceId ?? generateUniqueInstanceId(instance);
    return addStrongReference(instance: instance, instanceId: newId);
  }

  @override
  String generateUniqueInstanceId(Object instance) {
    return '$instance${instance.hashCode}';
  }

  @override
  bool addTemporaryStrongReference({
    required Object instance,
    String? instanceId,
    required void Function(String instanceId) onFinalize,
  }) {
    return addWeakReference(
      instance: instance,
      instanceId: instanceId,
      onFinalize: onFinalize,
    );
  }
}

class TestMessenger extends TypeChannelMessenger {
  @override
  final InstanceManager instanceManager = TestInstanceManager();

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
