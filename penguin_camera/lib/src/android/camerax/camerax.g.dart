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
  late int lensFacing;
}

class $UseCaseChannel extends TypeChannel<$UseCase> {
  $UseCaseChannel(TypeChannelManager manager)
      : super(manager, 'penguin_camera/android/camerax/UseCase');
}

class $PreviewChannel extends TypeChannel<$Preview> {
  $PreviewChannel(TypeChannelManager manager)
      : super(manager, 'penguin_camera/android/camerax/Preview');

  Future<Object?> $invokeAttachToTexture(
    $Preview instance,
  ) {
    return invokeMethod(
      instance,
      'attachToTexture',
      <Object?>[],
    );
  }

  Future<Object?> $invokeReleaseTexture(
    $Preview instance,
  ) {
    return invokeMethod(
      instance,
      'releaseTexture',
      <Object?>[],
    );
  }
}

class $SuccessListenerChannel extends TypeChannel<$SuccessListener> {
  $SuccessListenerChannel(TypeChannelManager manager)
      : super(manager, 'penguin_camera/android/camerax/SuccessListener');

  Future<Object?> $invokeOnSuccess(
    $SuccessListener instance,
  ) {
    return invokeMethod(
      instance,
      'onSuccess',
      <Object?>[],
    );
  }

  Future<Object?> $invokeOnError(
      $SuccessListener instance, String code, String message) {
    return invokeMethod(
      instance,
      'onError',
      <Object?>[code, message],
    );
  }
}

class $ProcessCameraProviderChannel
    extends TypeChannel<$ProcessCameraProvider> {
  $ProcessCameraProviderChannel(TypeChannelManager manager)
      : super(manager, 'penguin_camera/android/camerax/ProcessCameraProvider');

  Future<Object?> $invokeInitialize($SuccessListener successListener) {
    return invokeStaticMethod(
      'initialize',
      <Object?>[successListener],
    );
  }

  Future<Object?> $invokeBindToLifecycle($ProcessCameraProvider instance,
      $CameraSelector selector, $UseCase useCase) {
    return invokeMethod(
      instance,
      'bindToLifecycle',
      <Object?>[selector, useCase],
    );
  }

  Future<Object?> $invokeUnbindAll(
    $ProcessCameraProvider instance,
  ) {
    return invokeMethod(
      instance,
      'unbindAll',
      <Object?>[],
    );
  }
}

class $CameraChannel extends TypeChannel<$Camera> {
  $CameraChannel(TypeChannelManager manager)
      : super(manager, 'penguin_camera/android/camerax/Camera');
}

class $CameraSelectorChannel extends TypeChannel<$CameraSelector> {
  $CameraSelectorChannel(TypeChannelManager manager)
      : super(manager, 'penguin_camera/android/camerax/CameraSelector');
}

class $UseCaseHandler implements TypeChannelHandler<$UseCase> {
  $UseCaseHandler({
    this.onCreate,
    this.onDispose,
  });

  final $UseCase Function(
      TypeChannelManager manager, $UseCaseCreationArgs args)? onCreate;

  final void Function(TypeChannelManager manager, $UseCase instance)? onDispose;

  @override
  Object? invokeStaticMethod(
    TypeChannelManager manager,
    String methodName,
    List<Object?> arguments,
  ) {
    // ignore: prefer_final_locals, prefer_function_declarations_over_variables
    Function method = () {};
    switch (methodName) {
      default:
        throw ArgumentError.value(
          methodName,
          'methodName',
          'Unable to invoke static method `$methodName`',
        );
    }

    // ignore: dead_code
    return method();
  }

  @override
  List<Object?> getCreationArguments(
    TypeChannelManager manager,
    $UseCase instance,
  ) {
    return <Object?>[];
  }

  @override
  $UseCase createInstance(
    TypeChannelManager manager,
    List<Object?> arguments,
  ) {
    return onCreate!(
      manager,
      $UseCaseCreationArgs(),
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelManager manager,
    $UseCase instance,
    String methodName,
    List<Object?> arguments,
  ) {
    // ignore: prefer_final_locals, prefer_function_declarations_over_variables
    Function method = () {};
    switch (methodName) {
      default:
        throw ArgumentError.value(
          instance,
          'instance',
          'Unable to invoke method `$methodName` on',
        );
    }

    // ignore: dead_code
    return method();
  }

  @override
  void onInstanceDisposed(TypeChannelManager manager, $UseCase instance) {
    if (onDispose != null) onDispose!(manager, instance);
  }
}

class $PreviewHandler implements TypeChannelHandler<$Preview> {
  $PreviewHandler({
    this.onCreate,
    this.onDispose,
  });

  final $Preview Function(
      TypeChannelManager manager, $PreviewCreationArgs args)? onCreate;

  final void Function(TypeChannelManager manager, $Preview instance)? onDispose;

  @override
  Object? invokeStaticMethod(
    TypeChannelManager manager,
    String methodName,
    List<Object?> arguments,
  ) {
    // ignore: prefer_final_locals, prefer_function_declarations_over_variables
    Function method = () {};
    switch (methodName) {
      default:
        throw ArgumentError.value(
          methodName,
          'methodName',
          'Unable to invoke static method `$methodName`',
        );
    }

    // ignore: dead_code
    return method();
  }

  @override
  List<Object?> getCreationArguments(
    TypeChannelManager manager,
    $Preview instance,
  ) {
    return <Object?>[];
  }

  @override
  $Preview createInstance(
    TypeChannelManager manager,
    List<Object?> arguments,
  ) {
    return onCreate!(
      manager,
      $PreviewCreationArgs(),
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelManager manager,
    $Preview instance,
    String methodName,
    List<Object?> arguments,
  ) {
    // ignore: prefer_final_locals, prefer_function_declarations_over_variables
    Function method = () {};
    switch (methodName) {
      case 'attachToTexture':
        method = () => instance.attachToTexture();
        break;
      case 'releaseTexture':
        method = () => instance.releaseTexture();
        break;
      default:
        throw ArgumentError.value(
          instance,
          'instance',
          'Unable to invoke method `$methodName` on',
        );
    }

    // ignore: dead_code
    return method();
  }

  @override
  void onInstanceDisposed(TypeChannelManager manager, $Preview instance) {
    if (onDispose != null) onDispose!(manager, instance);
  }
}

class $SuccessListenerHandler implements TypeChannelHandler<$SuccessListener> {
  $SuccessListenerHandler({
    this.onCreate,
    this.onDispose,
  });

  final $SuccessListener Function(
      TypeChannelManager manager, $SuccessListenerCreationArgs args)? onCreate;

  final void Function(TypeChannelManager manager, $SuccessListener instance)?
      onDispose;

  @override
  Object? invokeStaticMethod(
    TypeChannelManager manager,
    String methodName,
    List<Object?> arguments,
  ) {
    // ignore: prefer_final_locals, prefer_function_declarations_over_variables
    Function method = () {};
    switch (methodName) {
      default:
        throw ArgumentError.value(
          methodName,
          'methodName',
          'Unable to invoke static method `$methodName`',
        );
    }

    // ignore: dead_code
    return method();
  }

  @override
  List<Object?> getCreationArguments(
    TypeChannelManager manager,
    $SuccessListener instance,
  ) {
    return <Object?>[];
  }

  @override
  $SuccessListener createInstance(
    TypeChannelManager manager,
    List<Object?> arguments,
  ) {
    return onCreate!(
      manager,
      $SuccessListenerCreationArgs(),
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelManager manager,
    $SuccessListener instance,
    String methodName,
    List<Object?> arguments,
  ) {
    // ignore: prefer_final_locals, prefer_function_declarations_over_variables
    Function method = () {};
    switch (methodName) {
      case 'onSuccess':
        method = () => instance.onSuccess();
        break;
      case 'onError':
        method = () =>
            instance.onError(arguments[0] as String, arguments[1] as String);
        break;
      default:
        throw ArgumentError.value(
          instance,
          'instance',
          'Unable to invoke method `$methodName` on',
        );
    }

    // ignore: dead_code
    return method();
  }

  @override
  void onInstanceDisposed(
      TypeChannelManager manager, $SuccessListener instance) {
    if (onDispose != null) onDispose!(manager, instance);
  }
}

class $ProcessCameraProviderHandler
    implements TypeChannelHandler<$ProcessCameraProvider> {
  $ProcessCameraProviderHandler(
      {this.onCreate, this.onDispose, this.$onInitialize});

  final $ProcessCameraProvider Function(
          TypeChannelManager manager, $ProcessCameraProviderCreationArgs args)?
      onCreate;

  final void Function(
      TypeChannelManager manager, $ProcessCameraProvider instance)? onDispose;

  final void Function(
          TypeChannelManager manager, $SuccessListener successListener)?
      $onInitialize;

  @override
  Object? invokeStaticMethod(
    TypeChannelManager manager,
    String methodName,
    List<Object?> arguments,
  ) {
    // ignore: prefer_final_locals, prefer_function_declarations_over_variables
    Function method = () {};
    switch (methodName) {
      case 'initialize':
        method =
            () => $onInitialize!(manager, arguments[0] as $SuccessListener);
        break;
      default:
        throw ArgumentError.value(
          methodName,
          'methodName',
          'Unable to invoke static method `$methodName`',
        );
    }

    // ignore: dead_code
    return method();
  }

  @override
  List<Object?> getCreationArguments(
    TypeChannelManager manager,
    $ProcessCameraProvider instance,
  ) {
    return <Object?>[];
  }

  @override
  $ProcessCameraProvider createInstance(
    TypeChannelManager manager,
    List<Object?> arguments,
  ) {
    return onCreate!(
      manager,
      $ProcessCameraProviderCreationArgs(),
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelManager manager,
    $ProcessCameraProvider instance,
    String methodName,
    List<Object?> arguments,
  ) {
    // ignore: prefer_final_locals, prefer_function_declarations_over_variables
    Function method = () {};
    switch (methodName) {
      case 'bindToLifecycle':
        method = () => instance.bindToLifecycle(
            arguments[0] as $CameraSelector, arguments[1] as $UseCase);
        break;
      case 'unbindAll':
        method = () => instance.unbindAll();
        break;
      default:
        throw ArgumentError.value(
          instance,
          'instance',
          'Unable to invoke method `$methodName` on',
        );
    }

    // ignore: dead_code
    return method();
  }

  @override
  void onInstanceDisposed(
      TypeChannelManager manager, $ProcessCameraProvider instance) {
    if (onDispose != null) onDispose!(manager, instance);
  }
}

class $CameraHandler implements TypeChannelHandler<$Camera> {
  $CameraHandler({
    this.onCreate,
    this.onDispose,
  });

  final $Camera Function(TypeChannelManager manager, $CameraCreationArgs args)?
      onCreate;

  final void Function(TypeChannelManager manager, $Camera instance)? onDispose;

  @override
  Object? invokeStaticMethod(
    TypeChannelManager manager,
    String methodName,
    List<Object?> arguments,
  ) {
    // ignore: prefer_final_locals, prefer_function_declarations_over_variables
    Function method = () {};
    switch (methodName) {
      default:
        throw ArgumentError.value(
          methodName,
          'methodName',
          'Unable to invoke static method `$methodName`',
        );
    }

    // ignore: dead_code
    return method();
  }

  @override
  List<Object?> getCreationArguments(
    TypeChannelManager manager,
    $Camera instance,
  ) {
    return <Object?>[];
  }

  @override
  $Camera createInstance(
    TypeChannelManager manager,
    List<Object?> arguments,
  ) {
    return onCreate!(
      manager,
      $CameraCreationArgs(),
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelManager manager,
    $Camera instance,
    String methodName,
    List<Object?> arguments,
  ) {
    // ignore: prefer_final_locals, prefer_function_declarations_over_variables
    Function method = () {};
    switch (methodName) {
      default:
        throw ArgumentError.value(
          instance,
          'instance',
          'Unable to invoke method `$methodName` on',
        );
    }

    // ignore: dead_code
    return method();
  }

  @override
  void onInstanceDisposed(TypeChannelManager manager, $Camera instance) {
    if (onDispose != null) onDispose!(manager, instance);
  }
}

class $CameraSelectorHandler implements TypeChannelHandler<$CameraSelector> {
  $CameraSelectorHandler({
    this.onCreate,
    this.onDispose,
  });

  final $CameraSelector Function(
      TypeChannelManager manager, $CameraSelectorCreationArgs args)? onCreate;

  final void Function(TypeChannelManager manager, $CameraSelector instance)?
      onDispose;

  @override
  Object? invokeStaticMethod(
    TypeChannelManager manager,
    String methodName,
    List<Object?> arguments,
  ) {
    // ignore: prefer_final_locals, prefer_function_declarations_over_variables
    Function method = () {};
    switch (methodName) {
      default:
        throw ArgumentError.value(
          methodName,
          'methodName',
          'Unable to invoke static method `$methodName`',
        );
    }

    // ignore: dead_code
    return method();
  }

  @override
  List<Object?> getCreationArguments(
    TypeChannelManager manager,
    $CameraSelector instance,
  ) {
    return <Object?>[instance.lensFacing];
  }

  @override
  $CameraSelector createInstance(
    TypeChannelManager manager,
    List<Object?> arguments,
  ) {
    return onCreate!(
      manager,
      $CameraSelectorCreationArgs()..lensFacing = arguments[0] as int,
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelManager manager,
    $CameraSelector instance,
    String methodName,
    List<Object?> arguments,
  ) {
    // ignore: prefer_final_locals, prefer_function_declarations_over_variables
    Function method = () {};
    switch (methodName) {
      default:
        throw ArgumentError.value(
          instance,
          'instance',
          'Unable to invoke method `$methodName` on',
        );
    }

    // ignore: dead_code
    return method();
  }

  @override
  void onInstanceDisposed(
      TypeChannelManager manager, $CameraSelector instance) {
    if (onDispose != null) onDispose!(manager, instance);
  }
}
