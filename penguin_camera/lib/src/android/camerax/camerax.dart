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
abstract class UseCase with $UseCase, Referencable {}

@Reference('penguin_camera/android/camerax/Preview')
class Preview extends UseCase with $Preview {
  Preview();

  static final $PreviewChannel _channel = $PreviewChannel(
    MethodChannelReferenceChannelManager.instance,
  )..registerHandler(
      $PreviewHandler(
        onCreate: (_, __) => Preview(),
      ),
    );

  int _currentTexture;

  @override
  Future<int> attachToTexture() async {
    _channel.createNewPair(this);
    return _currentTexture ??= await _channel.$invokeAttachToTexture(this);
  }

  @override
  Future<void> releaseTexture() async {
    if (_currentTexture == null || !_channel.manager.isPaired(this)) return;

    _currentTexture = null;
    return _channel.$invokeReleaseTexture(this);
  }

  @override
  ReferenceChannel get referenceChannel => _channel;
}

@Reference('penguin_camera/android/camerax/SuccessListener')
abstract class SuccessListener with $SuccessListener {
  static final $SuccessListenerChannel _channel = $SuccessListenerChannel(
    MethodChannelReferenceChannelManager.instance,
  )..registerHandler($SuccessListenerHandler());

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
    MethodChannelReferenceChannelManager.instance,
  )..registerHandler(
          $ProcessCameraProviderHandler(
            onCreate: (_, args) => ProcessCameraProvider._(),
          ),
        );

  static ProcessCameraProvider _instance;

  Set<Object> _dependentReferences = <Object>{};

  static ProcessCameraProvider get instance => _instance;

  static void initialize(SuccessListener successListener) {
    if (_instance != null) {
      successListener.onSuccess();
      return;
    }
    _instance = ProcessCameraProvider._();
    _channel.createNewPair(instance);

    SuccessListener._channel.createNewPair(successListener);
    _channel.$invokeInitialize(successListener);
  }

  @override
  Future<Camera> bindToLifecycle(
    covariant CameraSelector selector,
    covariant UseCase useCase,
  ) async {
    useCase.referenceChannel.createNewPair(useCase);
    _dependentReferences.add(useCase);

    final Camera camera = await _channel.$invokeBindToLifecycle(
      this,
      selector,
      useCase,
    );
    _dependentReferences.add(camera);
    return camera;
  }

  Future<void> unbindAll() async {
    for (Object object in _dependentReferences) {
      final String channel = (object as UnpairedReference).handlerChannel;
      _channel.manager.messenger.sendDisposePair(channel, object);
    }
    _dependentReferences.clear();

    return _channel.$invokeUnbindAll(this);
  }
}

@Reference('penguin_camera/android/camerax/Camera')
class Camera with $Camera {
  static final $CameraChannel _channel = $CameraChannel(
    MethodChannelReferenceChannelManager.instance,
  )..registerHandler(
      $CameraHandler(
        onCreate: (_, args) => Camera(),
      ),
    );
}

@Reference('penguin_camera/android/camerax/CameraSelector')
class CameraSelector with $CameraSelector, Referencable {
  CameraSelector(this.lensFacing);

  static final $CameraSelectorChannel _channel = $CameraSelectorChannel(
    MethodChannelReferenceChannelManager.instance,
  )..registerHandler(
      $CameraSelectorHandler(
        onCreate: (_, args) => CameraSelector(args.lensFacing),
      ),
    );

  static const lensFacingFront = 0;
  static const lensFacingBack = 1;

  final int lensFacing;

  @override
  ReferenceChannel get referenceChannel => _channel;
}
