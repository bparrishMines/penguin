// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:reference/reference.dart';

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

mixin $CaptureDeviceInput {
  $CaptureDevice get device;
}

mixin $CaptureSession {
  List<$CaptureDeviceInput> get inputs;
  Future<void> startRunning();

  Future<void> stopRunning();
}

mixin $CaptureDevice {
  String get uniqueId;
  int get position;
}

mixin $PreviewController {
  $CaptureSession get captureSession;
}

class $CaptureDeviceInputCreationArgs {
  late $CaptureDevice device;
}

class $CaptureSessionCreationArgs {
  late List<$CaptureDeviceInput> inputs;
}

class $CaptureDeviceCreationArgs {
  late String uniqueId;
  late int position;
}

class $PreviewControllerCreationArgs {
  late $CaptureSession captureSession;
}

class $CaptureDeviceInputChannel extends TypeChannel<$CaptureDeviceInput> {
  $CaptureDeviceInputChannel(TypeChannelMessenger messenger)
      : super(messenger, 'captureDeviceInput');
}

class $CaptureSessionChannel extends TypeChannel<$CaptureSession> {
  $CaptureSessionChannel(TypeChannelMessenger messenger)
      : super(messenger, 'captureSession');

  Future<Object?> $invokeStartRunning(
    $CaptureSession instance,
  ) {
    return sendInvokeMethod(
      instance,
      'startRunning',
      <Object?>[],
    );
  }

  Future<Object?> $invokeStopRunning(
    $CaptureSession instance,
  ) {
    return sendInvokeMethod(
      instance,
      'stopRunning',
      <Object?>[],
    );
  }
}

class $CaptureDeviceChannel extends TypeChannel<$CaptureDevice> {
  $CaptureDeviceChannel(TypeChannelMessenger messenger)
      : super(messenger, 'captureDevice');

  Future<Object?> $invokeDevicesWithMediaType(String mediaType) {
    return sendInvokeStaticMethod(
      'devicesWithMediaType',
      <Object?>[mediaType],
    );
  }
}

class $PreviewControllerChannel extends TypeChannel<$PreviewController> {
  $PreviewControllerChannel(TypeChannelMessenger messenger)
      : super(messenger, 'previewController');
}

class $CaptureDeviceInputHandler
    implements TypeChannelHandler<$CaptureDeviceInput> {
  $CaptureDeviceInputHandler({
    this.onCreate,
    this.onAdded,
    this.onRemoved,
  });

  final $CaptureDeviceInput Function(
    TypeChannelMessenger messenger,
    $CaptureDeviceInputCreationArgs args,
  )? onCreate;

  final void Function(
      TypeChannelMessenger messenger, $CaptureDeviceInput instance)? onAdded;

  final void Function(
      TypeChannelMessenger messenger, $CaptureDeviceInput instance)? onRemoved;

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
    $CaptureDeviceInput instance,
  ) {
    return <Object?>[instance.device];
  }

  @override
  $CaptureDeviceInput createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return onCreate!(
      messenger,
      $CaptureDeviceInputCreationArgs()
        ..device = arguments[0] as $CaptureDevice,
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $CaptureDeviceInput instance,
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
    $CaptureDeviceInput instance,
  ) {
    if (onAdded != null) onAdded!(messenger, instance);
  }

  @override
  void onInstanceRemoved(
    TypeChannelMessenger messenger,
    $CaptureDeviceInput instance,
  ) {
    if (onRemoved != null) onRemoved!(messenger, instance);
  }
}

class $CaptureSessionHandler implements TypeChannelHandler<$CaptureSession> {
  $CaptureSessionHandler({
    this.onCreate,
    this.onAdded,
    this.onRemoved,
  });

  final $CaptureSession Function(
    TypeChannelMessenger messenger,
    $CaptureSessionCreationArgs args,
  )? onCreate;

  final void Function(TypeChannelMessenger messenger, $CaptureSession instance)?
      onAdded;

  final void Function(TypeChannelMessenger messenger, $CaptureSession instance)?
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
    $CaptureSession instance,
  ) {
    return <Object?>[instance.inputs];
  }

  @override
  $CaptureSession createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return onCreate!(
      messenger,
      $CaptureSessionCreationArgs()
        ..inputs = arguments[0] as List<$CaptureDeviceInput>,
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $CaptureSession instance,
    String methodName,
    List<Object?> arguments,
  ) {
    // ignore: prefer_final_locals, prefer_function_declarations_over_variables
    Function method = () {};
    switch (methodName) {
      case 'startRunning':
        method = () => instance.startRunning();
        break;
      case 'stopRunning':
        method = () => instance.stopRunning();
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
    $CaptureSession instance,
  ) {
    if (onAdded != null) onAdded!(messenger, instance);
  }

  @override
  void onInstanceRemoved(
    TypeChannelMessenger messenger,
    $CaptureSession instance,
  ) {
    if (onRemoved != null) onRemoved!(messenger, instance);
  }
}

class $CaptureDeviceHandler implements TypeChannelHandler<$CaptureDevice> {
  $CaptureDeviceHandler({
    this.onCreate,
    this.onAdded,
    this.onRemoved,
    this.$onDevicesWithMediaType,
  });

  final $CaptureDevice Function(
    TypeChannelMessenger messenger,
    $CaptureDeviceCreationArgs args,
  )? onCreate;

  final void Function(TypeChannelMessenger messenger, $CaptureDevice instance)?
      onAdded;

  final void Function(TypeChannelMessenger messenger, $CaptureDevice instance)?
      onRemoved;

  final Future<List<$CaptureDevice>> Function(
          TypeChannelMessenger messenger, String mediaType)?
      $onDevicesWithMediaType;

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
    String methodName,
    List<Object?> arguments,
  ) {
    // ignore: prefer_final_locals, prefer_function_declarations_over_variables
    Function method = () {};
    switch (methodName) {
      case 'devicesWithMediaType':
        method =
            () => $onDevicesWithMediaType!(messenger, arguments[0] as String);
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
    $CaptureDevice instance,
  ) {
    return <Object?>[instance.uniqueId, instance.position];
  }

  @override
  $CaptureDevice createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return onCreate!(
      messenger,
      $CaptureDeviceCreationArgs()
        ..uniqueId = arguments[0] as String
        ..position = arguments[1] as int,
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $CaptureDevice instance,
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
    $CaptureDevice instance,
  ) {
    if (onAdded != null) onAdded!(messenger, instance);
  }

  @override
  void onInstanceRemoved(
    TypeChannelMessenger messenger,
    $CaptureDevice instance,
  ) {
    if (onRemoved != null) onRemoved!(messenger, instance);
  }
}

class $PreviewControllerHandler
    implements TypeChannelHandler<$PreviewController> {
  $PreviewControllerHandler({
    this.onCreate,
    this.onAdded,
    this.onRemoved,
  });

  final $PreviewController Function(
    TypeChannelMessenger messenger,
    $PreviewControllerCreationArgs args,
  )? onCreate;

  final void Function(
      TypeChannelMessenger messenger, $PreviewController instance)? onAdded;

  final void Function(
      TypeChannelMessenger messenger, $PreviewController instance)? onRemoved;

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
    $PreviewController instance,
  ) {
    return <Object?>[instance.captureSession];
  }

  @override
  $PreviewController createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return onCreate!(
      messenger,
      $PreviewControllerCreationArgs()
        ..captureSession = arguments[0] as $CaptureSession,
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $PreviewController instance,
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
    $PreviewController instance,
  ) {
    if (onAdded != null) onAdded!(messenger, instance);
  }

  @override
  void onInstanceRemoved(
    TypeChannelMessenger messenger,
    $PreviewController instance,
  ) {
    if (onRemoved != null) onRemoved!(messenger, instance);
  }
}
