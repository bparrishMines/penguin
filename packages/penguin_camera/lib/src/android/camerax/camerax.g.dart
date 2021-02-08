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
  $UseCaseChannel(TypeChannelMessenger messenger)
      : super(messenger, 'penguin_camera/android/camerax/UseCase');
}

class $PreviewChannel extends TypeChannel<$Preview> {
  $PreviewChannel(TypeChannelMessenger messenger)
      : super(messenger, 'penguin_camera/android/camerax/Preview');

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
  $SuccessListenerChannel(TypeChannelMessenger messenger)
      : super(messenger, 'penguin_camera/android/camerax/SuccessListener');

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
  $ProcessCameraProviderChannel(TypeChannelMessenger messenger)
      : super(
            messenger, 'penguin_camera/android/camerax/ProcessCameraProvider');

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
  $CameraChannel(TypeChannelMessenger messenger)
      : super(messenger, 'penguin_camera/android/camerax/Camera');
}

class $CameraSelectorChannel extends TypeChannel<$CameraSelector> {
  $CameraSelectorChannel(TypeChannelMessenger messenger)
      : super(messenger, 'penguin_camera/android/camerax/CameraSelector');
}

class $UseCaseHandler implements TypeChannelHandler<$UseCase> {
  $UseCaseHandler({
    this.onCreate,
    this.onAdded,
    this.onRemoved,
  });

  final $UseCase Function(
    TypeChannelMessenger messenger,
    $UseCaseCreationArgs args,
  )? onCreate;

  final void Function(TypeChannelMessenger messenger, $UseCase instance)?
      onAdded;

  final void Function(TypeChannelMessenger messenger, $UseCase instance)?
      onRemoved;

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
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
    TypeChannelMessenger messenger,
    $UseCase instance,
  ) {
    return <Object?>[];
  }

  @override
  $UseCase createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return onCreate!(
      messenger,
      $UseCaseCreationArgs(),
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
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
  void onInstanceAdded(
    TypeChannelMessenger messenger,
    $UseCase instance,
  ) {
    if (onAdded != null) onAdded!(messenger, instance);
  }

  @override
  void onInstanceRemoved(
    TypeChannelMessenger messenger,
    $UseCase instance,
  ) {
    if (onRemoved != null) onRemoved!(messenger, instance);
  }
}

class $PreviewHandler implements TypeChannelHandler<$Preview> {
  $PreviewHandler({
    this.onCreate,
    this.onAdded,
    this.onRemoved,
  });

  final $Preview Function(
    TypeChannelMessenger messenger,
    $PreviewCreationArgs args,
  )? onCreate;

  final void Function(TypeChannelMessenger messenger, $Preview instance)?
      onAdded;

  final void Function(TypeChannelMessenger messenger, $Preview instance)?
      onRemoved;

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
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
    TypeChannelMessenger messenger,
    $Preview instance,
  ) {
    return <Object?>[];
  }

  @override
  $Preview createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return onCreate!(
      messenger,
      $PreviewCreationArgs(),
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
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
  void onInstanceAdded(
    TypeChannelMessenger messenger,
    $Preview instance,
  ) {
    if (onAdded != null) onAdded!(messenger, instance);
  }

  @override
  void onInstanceRemoved(
    TypeChannelMessenger messenger,
    $Preview instance,
  ) {
    if (onRemoved != null) onRemoved!(messenger, instance);
  }
}

class $SuccessListenerHandler implements TypeChannelHandler<$SuccessListener> {
  $SuccessListenerHandler({
    this.onCreate,
    this.onAdded,
    this.onRemoved,
  });

  final $SuccessListener Function(
    TypeChannelMessenger messenger,
    $SuccessListenerCreationArgs args,
  )? onCreate;

  final void Function(
      TypeChannelMessenger messenger, $SuccessListener instance)? onAdded;

  final void Function(
      TypeChannelMessenger messenger, $SuccessListener instance)? onRemoved;

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
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
    TypeChannelMessenger messenger,
    $SuccessListener instance,
  ) {
    return <Object?>[];
  }

  @override
  $SuccessListener createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return onCreate!(
      messenger,
      $SuccessListenerCreationArgs(),
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
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
  void onInstanceAdded(
    TypeChannelMessenger messenger,
    $SuccessListener instance,
  ) {
    if (onAdded != null) onAdded!(messenger, instance);
  }

  @override
  void onInstanceRemoved(
    TypeChannelMessenger messenger,
    $SuccessListener instance,
  ) {
    if (onRemoved != null) onRemoved!(messenger, instance);
  }
}

class $ProcessCameraProviderHandler
    implements TypeChannelHandler<$ProcessCameraProvider> {
  $ProcessCameraProviderHandler({
    this.onCreate,
    this.onAdded,
    this.onRemoved,
    this.$onInitialize,
  });

  final $ProcessCameraProvider Function(
    TypeChannelMessenger messenger,
    $ProcessCameraProviderCreationArgs args,
  )? onCreate;

  final void Function(
      TypeChannelMessenger messenger, $ProcessCameraProvider instance)? onAdded;

  final void Function(
          TypeChannelMessenger messenger, $ProcessCameraProvider instance)?
      onRemoved;

  final void Function(
          TypeChannelMessenger messenger, $SuccessListener successListener)?
      $onInitialize;

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
    String methodName,
    List<Object?> arguments,
  ) {
    // ignore: prefer_final_locals, prefer_function_declarations_over_variables
    Function method = () {};
    switch (methodName) {
      case 'initialize':
        method =
            () => $onInitialize!(messenger, arguments[0] as $SuccessListener);
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
    TypeChannelMessenger messenger,
    $ProcessCameraProvider instance,
  ) {
    return <Object?>[];
  }

  @override
  $ProcessCameraProvider createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return onCreate!(
      messenger,
      $ProcessCameraProviderCreationArgs(),
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
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
  void onInstanceAdded(
    TypeChannelMessenger messenger,
    $ProcessCameraProvider instance,
  ) {
    if (onAdded != null) onAdded!(messenger, instance);
  }

  @override
  void onInstanceRemoved(
    TypeChannelMessenger messenger,
    $ProcessCameraProvider instance,
  ) {
    if (onRemoved != null) onRemoved!(messenger, instance);
  }
}

class $CameraHandler implements TypeChannelHandler<$Camera> {
  $CameraHandler({
    this.onCreate,
    this.onAdded,
    this.onRemoved,
  });

  final $Camera Function(
    TypeChannelMessenger messenger,
    $CameraCreationArgs args,
  )? onCreate;

  final void Function(TypeChannelMessenger messenger, $Camera instance)?
      onAdded;

  final void Function(TypeChannelMessenger messenger, $Camera instance)?
      onRemoved;

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
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
    TypeChannelMessenger messenger,
    $Camera instance,
  ) {
    return <Object?>[];
  }

  @override
  $Camera createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return onCreate!(
      messenger,
      $CameraCreationArgs(),
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
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
  void onInstanceAdded(
    TypeChannelMessenger messenger,
    $Camera instance,
  ) {
    if (onAdded != null) onAdded!(messenger, instance);
  }

  @override
  void onInstanceRemoved(
    TypeChannelMessenger messenger,
    $Camera instance,
  ) {
    if (onRemoved != null) onRemoved!(messenger, instance);
  }
}

class $CameraSelectorHandler implements TypeChannelHandler<$CameraSelector> {
  $CameraSelectorHandler({
    this.onCreate,
    this.onAdded,
    this.onRemoved,
  });

  final $CameraSelector Function(
    TypeChannelMessenger messenger,
    $CameraSelectorCreationArgs args,
  )? onCreate;

  final void Function(TypeChannelMessenger messenger, $CameraSelector instance)?
      onAdded;

  final void Function(TypeChannelMessenger messenger, $CameraSelector instance)?
      onRemoved;

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
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
    TypeChannelMessenger messenger,
    $CameraSelector instance,
  ) {
    return <Object?>[instance.lensFacing];
  }

  @override
  $CameraSelector createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return onCreate!(
      messenger,
      $CameraSelectorCreationArgs()..lensFacing = arguments[0] as int,
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
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
  void onInstanceAdded(
    TypeChannelMessenger messenger,
    $CameraSelector instance,
  ) {
    if (onAdded != null) onAdded!(messenger, instance);
  }

  @override
  void onInstanceRemoved(
    TypeChannelMessenger messenger,
    $CameraSelector instance,
  ) {
    if (onRemoved != null) onRemoved!(messenger, instance);
  }
}
