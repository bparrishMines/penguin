import 'dart:async';

// import 'package:penguin_camera/src/android/camerax/camerax.g.dart';
import 'package:penguin_camera/src/android/camerax/camerax.g.dart';
import 'package:reference/annotations.dart';
import 'package:reference/reference.dart';

// class _CameraXReferenceManager extends $ReferencePairManager {
//   _CameraXReferenceManager()
//       : super('bparrishMines.penguin/penguin_camera/camerax');
//
//   @override
//   $LocalHandler get localHandler => $LocalHandler(
//         createCamera: (ReferencePairManager manager, $CameraCreationArgs args) {
//           return Camera();
//         },
//         createProcessCameraProvider: (ReferencePairManager manager,
//             $ProcessCameraProviderCreationArgs args) {
//           return ProcessCameraProvider._();
//         },
//       );
// }
//
// final _CameraXReferenceManager _manager = _CameraXReferenceManager();

@Channel('penguin_camera/usecase')
abstract class UseCase with $UseCase, UnpairedReferenceParameter {}

@Channel('penguin_camera/preview')
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
  String get referenceChannelName => 'penguin_camera/preview';
}

@Channel('penguin_camera/successlistener')
abstract class SuccessListener with $SuccessListener {
  static final $SuccessListenerChannel _channel = $SuccessListenerChannel(
    MethodChannelReferenceChannelManager.instance,
  )..registerHandler($SuccessListenerHandler());

  @override
  void onSuccess();

  @override
  void onError(String code, String message);
}

@Channel('penguin_camera/processcameraprovider')
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
    if (useCase is Preview) Preview._channel.createNewPair(useCase);
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

@Channel('penguin_camera/camera')
class Camera with $Camera {
  static final $CameraChannel _channel = $CameraChannel(
    MethodChannelReferenceChannelManager.instance,
  )..registerHandler(
      $CameraHandler(
        onCreate: (_, args) => Camera(),
      ),
    );
}

@Channel('penguin_camera/cameraselector')
class CameraSelector with $CameraSelector, UnpairedReferenceParameter {
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
  String get referenceChannelName {
    Preview._channel;
    SuccessListener._channel;
    ProcessCameraProvider._channel;
    Camera._channel;
    return _channel.channelName;
  }
}
