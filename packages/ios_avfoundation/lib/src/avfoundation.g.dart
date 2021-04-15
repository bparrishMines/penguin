// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:reference/reference.dart';

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

mixin $CaptureDeviceInput {
  $CaptureDevice get device;
}

mixin $CaptureInput {}

mixin $CaptureSession {
  Future<void> addInput($CaptureInput input);

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

class $CaptureInputCreationArgs {}

class $CaptureSessionCreationArgs {}

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

class $CaptureInputChannel extends TypeChannel<$CaptureInput> {
  $CaptureInputChannel(TypeChannelMessenger messenger)
      : super(messenger, 'captureInput');
}

class $CaptureSessionChannel extends TypeChannel<$CaptureSession> {
  $CaptureSessionChannel(TypeChannelMessenger messenger)
      : super(messenger, 'captureSession');

  Future<Object?> $invokeAddInput(
      $CaptureSession instance, $CaptureInput input) {
    return sendInvokeMethod(
      instance,
      'addInput',
      <Object?>[input],
    );
  }

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
  $CaptureDeviceInput onCreate(
    TypeChannelMessenger messenger,
    $CaptureDeviceInputCreationArgs args,
  ) {
    throw UnimplementedError();
  }

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
    return onCreate(
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
}

class $CaptureInputHandler implements TypeChannelHandler<$CaptureInput> {
  $CaptureInput onCreate(
    TypeChannelMessenger messenger,
    $CaptureInputCreationArgs args,
  ) {
    throw UnimplementedError();
  }

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
    $CaptureInput instance,
  ) {
    return <Object?>[];
  }

  @override
  $CaptureInput createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return onCreate(
      messenger,
      $CaptureInputCreationArgs(),
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $CaptureInput instance,
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
}

class $CaptureSessionHandler implements TypeChannelHandler<$CaptureSession> {
  $CaptureSession onCreate(
    TypeChannelMessenger messenger,
    $CaptureSessionCreationArgs args,
  ) {
    throw UnimplementedError();
  }

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
    return <Object?>[];
  }

  @override
  $CaptureSession createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return onCreate(
      messenger,
      $CaptureSessionCreationArgs(),
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
      case 'addInput':
        method = () => instance.addInput(arguments[0] as $CaptureInput);
        break;
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
}

class $CaptureDeviceHandler implements TypeChannelHandler<$CaptureDevice> {
  $CaptureDevice onCreate(
    TypeChannelMessenger messenger,
    $CaptureDeviceCreationArgs args,
  ) {
    throw UnimplementedError();
  }

  double $onDevicesWithMediaType(
      TypeChannelMessenger messenger, String mediaType) {
    throw UnimplementedError();
  }

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
            () => $onDevicesWithMediaType(messenger, arguments[0] as String);
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
    return onCreate(
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
}

class $PreviewControllerHandler
    implements TypeChannelHandler<$PreviewController> {
  $PreviewController onCreate(
    TypeChannelMessenger messenger,
    $PreviewControllerCreationArgs args,
  ) {
    throw UnimplementedError();
  }

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
    return onCreate(
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
}

mixin $LibraryImplementations {
  $CaptureDeviceInputChannel get captureDeviceInputChannel;
  $CaptureInputChannel get captureInputChannel;
  $CaptureSessionChannel get captureSessionChannel;
  $CaptureDeviceChannel get captureDeviceChannel;
  $PreviewControllerChannel get previewControllerChannel;
  $CaptureDeviceInputHandler get captureDeviceInputHandler;
  $CaptureInputHandler get captureInputHandler;
  $CaptureSessionHandler get captureSessionHandler;
  $CaptureDeviceHandler get captureDeviceHandler;
  $PreviewControllerHandler get previewControllerHandler;
}

class $ChannelRegistrar {
  $ChannelRegistrar(this.implementations);

  final $LibraryImplementations implementations;

  void registerHandlers() {
    implementations.captureDeviceInputChannel.setHandler(
      implementations.captureDeviceInputHandler,
    );
    implementations.captureInputChannel.setHandler(
      implementations.captureInputHandler,
    );
    implementations.captureSessionChannel.setHandler(
      implementations.captureSessionHandler,
    );
    implementations.captureDeviceChannel.setHandler(
      implementations.captureDeviceHandler,
    );
    implementations.previewControllerChannel.setHandler(
      implementations.previewControllerHandler,
    );
  }

  void unregisterHandlers() {
    implementations.captureDeviceInputChannel.removeHandler();
    implementations.captureInputChannel.removeHandler();
    implementations.captureSessionChannel.removeHandler();
    implementations.captureDeviceChannel.removeHandler();
    implementations.previewControllerChannel.removeHandler();
  }
}
