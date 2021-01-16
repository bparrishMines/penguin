// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:reference/reference.dart';

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

mixin $UseCase {}

mixin $Preview {
  Future<int> attachToTexture();

  Future<void> releaseTexture();
}

mixin $SuccessListener {
  void onSuccess();

  void onError(String code, String message);
}

mixin $ProcessCameraProvider {
  Future<$Camera> bindToLifecycle($CameraSelector selector, $UseCase useCase);

  Future<void> unbindAll();
}

mixin $Camera {}

mixin $CameraSelector {
  int get lensFacing;
}

class $UseCaseCreationArgs {}

class $PreviewCreationArgs {}

class $SuccessListenerCreationArgs {}

class $ProcessCameraProviderCreationArgs {}

class $CameraCreationArgs {}

class $CameraSelectorCreationArgs {
  int lensFacing;
}

class $UseCaseChannel extends ReferenceChannel<$UseCase> {
  $UseCaseChannel(ReferenceChannelManager manager)
      : super(manager, 'penguin_camera/usecase');
}

class $PreviewChannel extends ReferenceChannel<$Preview> {
  $PreviewChannel(ReferenceChannelManager manager)
      : super(manager, 'penguin_camera/preview');

  Future<Object> $invokeAttachToTexture(
    $Preview instance,
  ) {
    final String $methodName = 'attachToTexture';
    final List<Object> $arguments = <Object>[];

    if (manager.isPaired(instance)) {
      return invokeMethod(instance, $methodName, $arguments);
    }

    return invokeMethodOnUnpairedReference(instance, $methodName, $arguments);
  }

  Future<Object> $invokeReleaseTexture(
    $Preview instance,
  ) {
    final String $methodName = 'releaseTexture';
    final List<Object> $arguments = <Object>[];

    if (manager.isPaired(instance)) {
      return invokeMethod(instance, $methodName, $arguments);
    }

    return invokeMethodOnUnpairedReference(instance, $methodName, $arguments);
  }
}

class $SuccessListenerChannel extends ReferenceChannel<$SuccessListener> {
  $SuccessListenerChannel(ReferenceChannelManager manager)
      : super(manager, 'penguin_camera/successlistener');

  Future<Object> $invokeOnSuccess(
    $SuccessListener instance,
  ) {
    final String $methodName = 'onSuccess';
    final List<Object> $arguments = <Object>[];

    if (manager.isPaired(instance)) {
      return invokeMethod(instance, $methodName, $arguments);
    }

    return invokeMethodOnUnpairedReference(instance, $methodName, $arguments);
  }

  Future<Object> $invokeOnError(
      $SuccessListener instance, String code, String message) {
    final String $methodName = 'onError';
    final List<Object> $arguments = <Object>[code, message];

    if (manager.isPaired(instance)) {
      return invokeMethod(instance, $methodName, $arguments);
    }

    return invokeMethodOnUnpairedReference(instance, $methodName, $arguments);
  }
}

class $ProcessCameraProviderChannel
    extends ReferenceChannel<$ProcessCameraProvider> {
  $ProcessCameraProviderChannel(ReferenceChannelManager manager)
      : super(manager, 'penguin_camera/processcameraprovider');

  Future<Object> $invokeInitialize($SuccessListener successListener) {
    return invokeStaticMethod(
      'initialize',
      <Object>[successListener],
    );
  }

  Future<Object> $invokeBindToLifecycle($ProcessCameraProvider instance,
      $CameraSelector selector, $UseCase useCase) {
    final String $methodName = 'bindToLifecycle';
    final List<Object> $arguments = <Object>[selector, useCase];

    if (manager.isPaired(instance)) {
      return invokeMethod(instance, $methodName, $arguments);
    }

    return invokeMethodOnUnpairedReference(instance, $methodName, $arguments);
  }

  Future<Object> $invokeUnbindAll(
    $ProcessCameraProvider instance,
  ) {
    final String $methodName = 'unbindAll';
    final List<Object> $arguments = <Object>[];

    if (manager.isPaired(instance)) {
      return invokeMethod(instance, $methodName, $arguments);
    }

    return invokeMethodOnUnpairedReference(instance, $methodName, $arguments);
  }
}

class $CameraChannel extends ReferenceChannel<$Camera> {
  $CameraChannel(ReferenceChannelManager manager)
      : super(manager, 'penguin_camera/camera');
}

class $CameraSelectorChannel extends ReferenceChannel<$CameraSelector> {
  $CameraSelectorChannel(ReferenceChannelManager manager)
      : super(manager, 'penguin_camera/cameraselector');
}

class $UseCaseHandler implements ReferenceChannelHandler<$UseCase> {
  $UseCaseHandler({
    this.onCreate,
    this.onDispose,
  });

  final $UseCase Function(
      ReferenceChannelManager manager, $UseCaseCreationArgs args) onCreate;

  final void Function(ReferenceChannelManager manager, $UseCase instance)
      onDispose;

  @override
  Object invokeStaticMethod(
    ReferenceChannelManager manager,
    String methodName,
    List<Object> arguments,
  ) {
    Function method;
    switch (methodName) {
    }

    if (method != null) return method();

    throw ArgumentError.value(
      methodName,
      'methodName',
      'Unable to invoke static method `$methodName`',
    );
  }

  @override
  List<Object> getCreationArguments(
    ReferenceChannelManager manager,
    $UseCase instance,
  ) {
    return <Object>[];
  }

  @override
  $UseCase createInstance(
    ReferenceChannelManager manager,
    List<Object> arguments,
  ) {
    return onCreate(
      manager,
      $UseCaseCreationArgs(),
    );
  }

  @override
  Object invokeMethod(
    ReferenceChannelManager manager,
    $UseCase instance,
    String methodName,
    List<Object> arguments,
  ) {
    Function method;
    switch (methodName) {
    }

    if (method != null) return method();
    throw ArgumentError.value(
      instance,
      'instance',
      'Unable to invoke method `$methodName` on',
    );
  }

  @override
  void onInstanceDisposed(
    ReferenceChannelManager manager,
    $UseCase instance,
  ) {
    if (onDispose != null) onDispose(manager, instance);
  }
}

class $PreviewHandler implements ReferenceChannelHandler<$Preview> {
  $PreviewHandler({
    this.onCreate,
    this.onDispose,
  });

  final $Preview Function(
      ReferenceChannelManager manager, $PreviewCreationArgs args) onCreate;

  final void Function(ReferenceChannelManager manager, $Preview instance)
      onDispose;

  @override
  Object invokeStaticMethod(
    ReferenceChannelManager manager,
    String methodName,
    List<Object> arguments,
  ) {
    Function method;
    switch (methodName) {
    }

    if (method != null) return method();

    throw ArgumentError.value(
      methodName,
      'methodName',
      'Unable to invoke static method `$methodName`',
    );
  }

  @override
  List<Object> getCreationArguments(
    ReferenceChannelManager manager,
    $Preview instance,
  ) {
    return <Object>[];
  }

  @override
  $Preview createInstance(
    ReferenceChannelManager manager,
    List<Object> arguments,
  ) {
    return onCreate(
      manager,
      $PreviewCreationArgs(),
    );
  }

  @override
  Object invokeMethod(
    ReferenceChannelManager manager,
    $Preview instance,
    String methodName,
    List<Object> arguments,
  ) {
    Function method;
    switch (methodName) {
      case 'attachToTexture':
        method = () => instance.attachToTexture();
        break;
      case 'releaseTexture':
        method = () => instance.releaseTexture();
    }

    if (method != null) return method();
    throw ArgumentError.value(
      instance,
      'instance',
      'Unable to invoke method `$methodName` on',
    );
  }

  @override
  void onInstanceDisposed(
    ReferenceChannelManager manager,
    $Preview instance,
  ) {
    if (onDispose != null) onDispose(manager, instance);
  }
}

class $SuccessListenerHandler
    implements ReferenceChannelHandler<$SuccessListener> {
  $SuccessListenerHandler({
    this.onCreate,
    this.onDispose,
  });

  final $SuccessListener Function(
          ReferenceChannelManager manager, $SuccessListenerCreationArgs args)
      onCreate;

  final void Function(
      ReferenceChannelManager manager, $SuccessListener instance) onDispose;

  @override
  Object invokeStaticMethod(
    ReferenceChannelManager manager,
    String methodName,
    List<Object> arguments,
  ) {
    Function method;
    switch (methodName) {
    }

    if (method != null) return method();

    throw ArgumentError.value(
      methodName,
      'methodName',
      'Unable to invoke static method `$methodName`',
    );
  }

  @override
  List<Object> getCreationArguments(
    ReferenceChannelManager manager,
    $SuccessListener instance,
  ) {
    return <Object>[];
  }

  @override
  $SuccessListener createInstance(
    ReferenceChannelManager manager,
    List<Object> arguments,
  ) {
    return onCreate(
      manager,
      $SuccessListenerCreationArgs(),
    );
  }

  @override
  Object invokeMethod(
    ReferenceChannelManager manager,
    $SuccessListener instance,
    String methodName,
    List<Object> arguments,
  ) {
    Function method;
    switch (methodName) {
      case 'onSuccess':
        method = () => instance.onSuccess();
        break;
      case 'onError':
        method = () => instance.onError(arguments[0], arguments[1]);
    }

    if (method != null) return method();
    throw ArgumentError.value(
      instance,
      'instance',
      'Unable to invoke method `$methodName` on',
    );
  }

  @override
  void onInstanceDisposed(
    ReferenceChannelManager manager,
    $SuccessListener instance,
  ) {
    if (onDispose != null) onDispose(manager, instance);
  }
}

class $ProcessCameraProviderHandler
    implements ReferenceChannelHandler<$ProcessCameraProvider> {
  $ProcessCameraProviderHandler(
      {this.onCreate, this.onDispose, this.$onInitialize});

  final $ProcessCameraProvider Function(ReferenceChannelManager manager,
      $ProcessCameraProviderCreationArgs args) onCreate;

  final void Function(
          ReferenceChannelManager manager, $ProcessCameraProvider instance)
      onDispose;

  final void Function(
          ReferenceChannelManager manager, $SuccessListener successListener)
      $onInitialize;

  @override
  Object invokeStaticMethod(
    ReferenceChannelManager manager,
    String methodName,
    List<Object> arguments,
  ) {
    Function method;
    switch (methodName) {
      case 'initialize':
        method = () => $onInitialize(manager, arguments[0]);
    }

    if (method != null) return method();

    throw ArgumentError.value(
      methodName,
      'methodName',
      'Unable to invoke static method `$methodName`',
    );
  }

  @override
  List<Object> getCreationArguments(
    ReferenceChannelManager manager,
    $ProcessCameraProvider instance,
  ) {
    return <Object>[];
  }

  @override
  $ProcessCameraProvider createInstance(
    ReferenceChannelManager manager,
    List<Object> arguments,
  ) {
    return onCreate(
      manager,
      $ProcessCameraProviderCreationArgs(),
    );
  }

  @override
  Object invokeMethod(
    ReferenceChannelManager manager,
    $ProcessCameraProvider instance,
    String methodName,
    List<Object> arguments,
  ) {
    Function method;
    switch (methodName) {
      case 'bindToLifecycle':
        method = () => instance.bindToLifecycle(arguments[0], arguments[1]);
        break;
      case 'unbindAll':
        method = () => instance.unbindAll();
    }

    if (method != null) return method();
    throw ArgumentError.value(
      instance,
      'instance',
      'Unable to invoke method `$methodName` on',
    );
  }

  @override
  void onInstanceDisposed(
    ReferenceChannelManager manager,
    $ProcessCameraProvider instance,
  ) {
    if (onDispose != null) onDispose(manager, instance);
  }
}

class $CameraHandler implements ReferenceChannelHandler<$Camera> {
  $CameraHandler({
    this.onCreate,
    this.onDispose,
  });

  final $Camera Function(
      ReferenceChannelManager manager, $CameraCreationArgs args) onCreate;

  final void Function(ReferenceChannelManager manager, $Camera instance)
      onDispose;

  @override
  Object invokeStaticMethod(
    ReferenceChannelManager manager,
    String methodName,
    List<Object> arguments,
  ) {
    Function method;
    switch (methodName) {
    }

    if (method != null) return method();

    throw ArgumentError.value(
      methodName,
      'methodName',
      'Unable to invoke static method `$methodName`',
    );
  }

  @override
  List<Object> getCreationArguments(
    ReferenceChannelManager manager,
    $Camera instance,
  ) {
    return <Object>[];
  }

  @override
  $Camera createInstance(
    ReferenceChannelManager manager,
    List<Object> arguments,
  ) {
    return onCreate(
      manager,
      $CameraCreationArgs(),
    );
  }

  @override
  Object invokeMethod(
    ReferenceChannelManager manager,
    $Camera instance,
    String methodName,
    List<Object> arguments,
  ) {
    Function method;
    switch (methodName) {
    }

    if (method != null) return method();
    throw ArgumentError.value(
      instance,
      'instance',
      'Unable to invoke method `$methodName` on',
    );
  }

  @override
  void onInstanceDisposed(
    ReferenceChannelManager manager,
    $Camera instance,
  ) {
    if (onDispose != null) onDispose(manager, instance);
  }
}

class $CameraSelectorHandler
    implements ReferenceChannelHandler<$CameraSelector> {
  $CameraSelectorHandler({
    this.onCreate,
    this.onDispose,
  });

  final $CameraSelector Function(
          ReferenceChannelManager manager, $CameraSelectorCreationArgs args)
      onCreate;

  final void Function(ReferenceChannelManager manager, $CameraSelector instance)
      onDispose;

  @override
  Object invokeStaticMethod(
    ReferenceChannelManager manager,
    String methodName,
    List<Object> arguments,
  ) {
    Function method;
    switch (methodName) {
    }

    if (method != null) return method();

    throw ArgumentError.value(
      methodName,
      'methodName',
      'Unable to invoke static method `$methodName`',
    );
  }

  @override
  List<Object> getCreationArguments(
    ReferenceChannelManager manager,
    $CameraSelector instance,
  ) {
    return <Object>[instance.lensFacing];
  }

  @override
  $CameraSelector createInstance(
    ReferenceChannelManager manager,
    List<Object> arguments,
  ) {
    return onCreate(
      manager,
      $CameraSelectorCreationArgs()..lensFacing = arguments[0],
    );
  }

  @override
  Object invokeMethod(
    ReferenceChannelManager manager,
    $CameraSelector instance,
    String methodName,
    List<Object> arguments,
  ) {
    Function method;
    switch (methodName) {
    }

    if (method != null) return method();
    throw ArgumentError.value(
      instance,
      'instance',
      'Unable to invoke method `$methodName` on',
    );
  }

  @override
  void onInstanceDisposed(
    ReferenceChannelManager manager,
    $CameraSelector instance,
  ) {
    if (onDispose != null) onDispose(manager, instance);
  }
}
