import 'dart:async';

import 'package:reference/annotations.dart';
import 'package:reference/reference.dart';

import 'camerax.g.dart';

void initializeChannels() {
  Preview._channel; // ignore: unnecessary_statements
  SuccessListener._channel; // ignore: unnecessary_statements
  ProcessCameraProvider._channel; // ignore: unnecessary_statements
  Camera._channel; // ignore: unnecessary_statements
  CameraSelector._channel; // ignore: unnecessary_statements
}

@Reference('penguin_camera/android/camerax/UseCase')
abstract class UseCase with $UseCase, PairableInstance {}

@Reference('penguin_camera/android/camerax/Preview')
class Preview extends UseCase with $Preview {
  Preview();

  static final $PreviewChannel _channel = $PreviewChannel(
    MethodChannelManager.instance,
  )..setHandler(
      $PreviewHandler(
        onCreate: (_, __) => Preview(),
      ),
    );

  int? _currentTexture;

  @override
  Future<int> attachToTexture() async {
    _channel.createNewInstancePair(this);
    return _currentTexture ??=
        await _channel.$invokeAttachToTexture(this) as int;
  }

  @override
  Future<void> releaseTexture() async {
    if (_currentTexture == null || !_channel.manager.isPaired(this)) return;

    _currentTexture = null;
    await _channel.$invokeReleaseTexture(this);
  }

  @override
  TypeChannel<$Preview> get typeChannel => _channel;
}

@Reference('penguin_camera/android/camerax/SuccessListener')
abstract class SuccessListener with $SuccessListener {
  static final $SuccessListenerChannel _channel = $SuccessListenerChannel(
    MethodChannelManager.instance,
  )..setHandler($SuccessListenerHandler());

  @override
  void onSuccess();

  @override
  void onError(String code, String message);
}

@Reference('penguin_camera/android/camerax/ProcessCameraProvider')
class ProcessCameraProvider with $ProcessCameraProvider {
  ProcessCameraProvider._();

  static final $ProcessCameraProviderChannel _channel =
      $ProcessCameraProviderChannel(
    MethodChannelManager.instance,
  )..setHandler(
          $ProcessCameraProviderHandler(
            onCreate: (_, args) => ProcessCameraProvider._(),
          ),
        );

  static ProcessCameraProvider _instance = _EmptyProcessCameraProvider();

  Set<PairableInstance> _dependentInstances = <PairableInstance>{};

  static ProcessCameraProvider get instance => _instance;

  static void initialize(SuccessListener successListener) {
    if (_instance is _EmptyProcessCameraProvider) {
      successListener.onSuccess();
      return;
    }
    _instance = ProcessCameraProvider._();
    _channel.createNewInstancePair(instance);

    SuccessListener._channel.createNewInstancePair(successListener);
    _channel.$invokeInitialize(successListener);
  }

  @override
  Future<Camera> bindToLifecycle(
    covariant CameraSelector selector,
    covariant UseCase useCase,
  ) async {
    useCase.typeChannel.createNewInstancePair(useCase);
    _dependentInstances.add(useCase);

    final Camera camera = await _channel.$invokeBindToLifecycle(
      this,
      selector,
      useCase,
    ) as Camera;
    _dependentInstances.add(camera);
    return camera;
  }

  Future<void> unbindAll() async {
    for (PairableInstance instance in _dependentInstances) {
      instance.typeChannel.disposePair(instance);
    }
    _dependentInstances.clear();

    await _channel.$invokeUnbindAll(this);
  }
}

@Reference('penguin_camera/android/camerax/Camera')
class Camera with $Camera, PairableInstance {
  static final $CameraChannel _channel = $CameraChannel(
    MethodChannelManager.instance,
  )..setHandler(
      $CameraHandler(
        onCreate: (_, args) => Camera(),
      ),
    );

  @override
  TypeChannel<$Camera> get typeChannel => _channel;
}

@Reference('penguin_camera/android/camerax/CameraSelector')
class CameraSelector with $CameraSelector, PairableInstance {
  CameraSelector(this.lensFacing);

  static final $CameraSelectorChannel _channel = $CameraSelectorChannel(
    MethodChannelManager.instance,
  )..setHandler(
      $CameraSelectorHandler(
        onCreate: (_, args) => CameraSelector(args.lensFacing),
      ),
    );

  static const lensFacingFront = 0;
  static const lensFacingBack = 1;

  final int lensFacing;

  @override
  TypeChannel<$CameraSelector> get typeChannel => _channel;
}

class _EmptyProcessCameraProvider implements ProcessCameraProvider {
  @override
  Set<PairableInstance> _dependentInstances = <PairableInstance>{};

  @override
  Future<Camera> bindToLifecycle(
      covariant CameraSelector selector, covariant UseCase useCase) {
    throw UnimplementedError();
  }

  @override
  Future<void> unbindAll() {
    throw UnimplementedError();
  }
}
