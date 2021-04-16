// GENERATED CODE - DO NOT MODIFY BY HAND

import 'dart:typed_data';

import 'package:reference/reference.dart';

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

mixin $CapturePhotoOutput {
  Future<void> capturePhoto(
      $CapturePhotoSettings settings, $CapturePhotoCaptureDelegate delegate);
}

mixin $CapturePhotoSettings {
  Map<String, Object> get processedFormat;
}

mixin $CapturePhotoCaptureDelegate {
  void didFinishProcessingPhoto($CapturePhoto photo);
}

mixin $CaptureOutput {}

mixin $CapturePhoto {
  Uint8List? get fileDataRepresentation;
}

mixin $CaptureDeviceInput {
  $CaptureDevice get device;
}

mixin $CaptureInput {}

mixin $CaptureSession {
  Future<void> addInput($CaptureInput input);

  Future<void> addOutput($CaptureOutput output);

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

class $CapturePhotoOutputCreationArgs {}

class $CapturePhotoSettingsCreationArgs {
  late Map<String, Object> processedFormat;
}

class $CapturePhotoCaptureDelegateCreationArgs {}

class $CaptureOutputCreationArgs {}

class $CapturePhotoCreationArgs {
  late Uint8List? fileDataRepresentation;
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

class $CapturePhotoOutputChannel extends TypeChannel<$CapturePhotoOutput> {
  $CapturePhotoOutputChannel(TypeChannelMessenger messenger)
      : super(messenger, 'capturePhotoOutput');

  Future<Object?> $invokeCapturePhoto($CapturePhotoOutput instance,
      $CapturePhotoSettings settings, $CapturePhotoCaptureDelegate delegate) {
    return sendInvokeMethod(
      instance,
      'capturePhoto',
      <Object?>[settings, delegate],
    );
  }
}

class $CapturePhotoSettingsChannel extends TypeChannel<$CapturePhotoSettings> {
  $CapturePhotoSettingsChannel(TypeChannelMessenger messenger)
      : super(messenger, 'CapturePhotoSettings');
}

class $CapturePhotoCaptureDelegateChannel
    extends TypeChannel<$CapturePhotoCaptureDelegate> {
  $CapturePhotoCaptureDelegateChannel(TypeChannelMessenger messenger)
      : super(messenger, 'CapturePhotoCaptureDelegate');

  Future<Object?> $invokeDidFinishProcessingPhoto(
      $CapturePhotoCaptureDelegate instance, $CapturePhoto photo) {
    return sendInvokeMethod(
      instance,
      'didFinishProcessingPhoto',
      <Object?>[photo],
    );
  }
}

class $CaptureOutputChannel extends TypeChannel<$CaptureOutput> {
  $CaptureOutputChannel(TypeChannelMessenger messenger)
      : super(messenger, 'CaptureOutput');
}

class $CapturePhotoChannel extends TypeChannel<$CapturePhoto> {
  $CapturePhotoChannel(TypeChannelMessenger messenger)
      : super(messenger, 'CapturePhoto');
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

  Future<Object?> $invokeAddOutput(
      $CaptureSession instance, $CaptureOutput output) {
    return sendInvokeMethod(
      instance,
      'addOutput',
      <Object?>[output],
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

class $CapturePhotoOutputHandler
    implements TypeChannelHandler<$CapturePhotoOutput> {
  $CapturePhotoOutput onCreate(
    TypeChannelMessenger messenger,
    $CapturePhotoOutputCreationArgs args,
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
    $CapturePhotoOutput instance,
  ) {
    return <Object?>[];
  }

  @override
  $CapturePhotoOutput createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return onCreate(
      messenger,
      $CapturePhotoOutputCreationArgs(),
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $CapturePhotoOutput instance,
    String methodName,
    List<Object?> arguments,
  ) {
    // ignore: prefer_final_locals, prefer_function_declarations_over_variables
    Function method = () {};
    switch (methodName) {
      case 'capturePhoto':
        method = () => instance.capturePhoto(
            arguments[0] as $CapturePhotoSettings,
            arguments[1] as $CapturePhotoCaptureDelegate);
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

class $CapturePhotoSettingsHandler
    implements TypeChannelHandler<$CapturePhotoSettings> {
  $CapturePhotoSettings onCreate(
    TypeChannelMessenger messenger,
    $CapturePhotoSettingsCreationArgs args,
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
    $CapturePhotoSettings instance,
  ) {
    return <Object?>[instance.processedFormat];
  }

  @override
  $CapturePhotoSettings createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return onCreate(
      messenger,
      $CapturePhotoSettingsCreationArgs()
        ..processedFormat = arguments[0] as Map<String, Object>,
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $CapturePhotoSettings instance,
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

class $CapturePhotoCaptureDelegateHandler
    implements TypeChannelHandler<$CapturePhotoCaptureDelegate> {
  $CapturePhotoCaptureDelegate onCreate(
    TypeChannelMessenger messenger,
    $CapturePhotoCaptureDelegateCreationArgs args,
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
    $CapturePhotoCaptureDelegate instance,
  ) {
    return <Object?>[];
  }

  @override
  $CapturePhotoCaptureDelegate createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return onCreate(
      messenger,
      $CapturePhotoCaptureDelegateCreationArgs(),
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $CapturePhotoCaptureDelegate instance,
    String methodName,
    List<Object?> arguments,
  ) {
    // ignore: prefer_final_locals, prefer_function_declarations_over_variables
    Function method = () {};
    switch (methodName) {
      case 'didFinishProcessingPhoto':
        method = () =>
            instance.didFinishProcessingPhoto(arguments[0] as $CapturePhoto);
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

class $CaptureOutputHandler implements TypeChannelHandler<$CaptureOutput> {
  $CaptureOutput onCreate(
    TypeChannelMessenger messenger,
    $CaptureOutputCreationArgs args,
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
    $CaptureOutput instance,
  ) {
    return <Object?>[];
  }

  @override
  $CaptureOutput createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return onCreate(
      messenger,
      $CaptureOutputCreationArgs(),
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $CaptureOutput instance,
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

class $CapturePhotoHandler implements TypeChannelHandler<$CapturePhoto> {
  $CapturePhoto onCreate(
    TypeChannelMessenger messenger,
    $CapturePhotoCreationArgs args,
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
    $CapturePhoto instance,
  ) {
    return <Object?>[instance.fileDataRepresentation];
  }

  @override
  $CapturePhoto createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return onCreate(
      messenger,
      $CapturePhotoCreationArgs()
        ..fileDataRepresentation = arguments[0] as Uint8List?,
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $CapturePhoto instance,
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
      case 'addOutput':
        method = () => instance.addOutput(arguments[0] as $CaptureOutput);
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
  $CapturePhotoOutputChannel get capturePhotoOutputChannel;
  $CapturePhotoSettingsChannel get capturePhotoSettingsChannel;
  $CapturePhotoCaptureDelegateChannel get capturePhotoCaptureDelegateChannel;
  $CaptureOutputChannel get captureOutputChannel;
  $CapturePhotoChannel get capturePhotoChannel;
  $CaptureDeviceInputChannel get captureDeviceInputChannel;
  $CaptureInputChannel get captureInputChannel;
  $CaptureSessionChannel get captureSessionChannel;
  $CaptureDeviceChannel get captureDeviceChannel;
  $PreviewControllerChannel get previewControllerChannel;
  $CapturePhotoOutputHandler get capturePhotoOutputHandler;
  $CapturePhotoSettingsHandler get capturePhotoSettingsHandler;
  $CapturePhotoCaptureDelegateHandler get capturePhotoCaptureDelegateHandler;
  $CaptureOutputHandler get captureOutputHandler;
  $CapturePhotoHandler get capturePhotoHandler;
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
    implementations.capturePhotoOutputChannel.setHandler(
      implementations.capturePhotoOutputHandler,
    );
    implementations.capturePhotoSettingsChannel.setHandler(
      implementations.capturePhotoSettingsHandler,
    );
    implementations.capturePhotoCaptureDelegateChannel.setHandler(
      implementations.capturePhotoCaptureDelegateHandler,
    );
    implementations.captureOutputChannel.setHandler(
      implementations.captureOutputHandler,
    );
    implementations.capturePhotoChannel.setHandler(
      implementations.capturePhotoHandler,
    );
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
    implementations.capturePhotoOutputChannel.removeHandler();
    implementations.capturePhotoSettingsChannel.removeHandler();
    implementations.capturePhotoCaptureDelegateChannel.removeHandler();
    implementations.captureOutputChannel.removeHandler();
    implementations.capturePhotoChannel.removeHandler();
    implementations.captureDeviceInputChannel.removeHandler();
    implementations.captureInputChannel.removeHandler();
    implementations.captureSessionChannel.removeHandler();
    implementations.captureDeviceChannel.removeHandler();
    implementations.previewControllerChannel.removeHandler();
  }
}
