// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:reference/reference.dart';

import 'dart:typed_data';

import 'avfoundation.dart';

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

typedef $FinishProcessingPhotoCallback = dynamic Function(
  CapturePhoto photo,
);

class $FinishProcessingPhotoCallbackChannel extends TypeChannel<Object> {
  $FinishProcessingPhotoCallbackChannel(TypeChannelMessenger messenger)
      : super(messenger,
            'ios_avfoundation/avfoundation/FinishProcessingPhotoCallback');

  Future<PairedInstance?> $$create(
    $FinishProcessingPhotoCallback $instance, {
    required bool $owner,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[],
      owner: $owner,
    );
  }

  Future<Object?> _invoke(
    $FinishProcessingPhotoCallback $instance,
    CapturePhoto photo,
  ) {
    return sendInvokeMethod(
      $instance,
      '',
      <Object?>[
        photo,
      ],
    );
  }
}

class $FinishProcessingPhotoCallbackHandler
    implements TypeChannelHandler<Object> {
  $FinishProcessingPhotoCallbackHandler(this.implementations);

  final $LibraryImplementations implementations;

  @override
  $FinishProcessingPhotoCallback createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    function(
      CapturePhoto photo,
    ) {
      implementations.channelFinishProcessingPhotoCallback._invoke(
        function,
        photo,
      );
    }

    return function;
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    covariant $FinishProcessingPhotoCallback instance,
    String methodName,
    List<Object?> arguments,
  ) {
    return instance(
      arguments[0] as CapturePhoto,
    );
  }

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
    String methodName,
    List<Object?> arguments,
  ) {
    throw UnimplementedError();
  }
}

mixin $CapturePhotoOutput {}

mixin $CapturePhotoSettings {}

mixin $CapturePhotoCaptureDelegate {}

mixin $CaptureOutput {}

mixin $CapturePhoto {}

mixin $CaptureDeviceInput {}

mixin $CaptureInput {}

mixin $CaptureSession {}

mixin $CaptureDevice {}

mixin $CaptureDeviceDiscoverySession {}

mixin $PreviewController {}

class $CapturePhotoOutputChannel extends TypeChannel<$CapturePhotoOutput> {
  $CapturePhotoOutputChannel(TypeChannelMessenger messenger)
      : super(messenger, 'ios_avfoundation/avfoundation/CapturePhotoOutput');

  Future<PairedInstance?> $$create(
    $CapturePhotoOutput $instance, {
    required bool $owner,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[],
      owner: $owner,
    );
  }

  Future<Object?> $capturePhoto(
    $CapturePhotoOutput $instance,
    $CapturePhotoSettings settings,
    $CapturePhotoCaptureDelegate delegate,
  ) {
    return sendInvokeMethod(
      $instance,
      'capturePhoto',
      <Object?>[
        settings,
        delegate,
      ],
    );
  }
}

class $CapturePhotoSettingsChannel extends TypeChannel<$CapturePhotoSettings> {
  $CapturePhotoSettingsChannel(TypeChannelMessenger messenger)
      : super(messenger, 'ios_avfoundation/avfoundation/CapturePhotoSettings');

  Future<PairedInstance?> $$create(
    $CapturePhotoSettings $instance, {
    required bool $owner,
    required Map processedFormat,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        processedFormat,
      ],
      owner: $owner,
    );
  }
}

class $CapturePhotoCaptureDelegateChannel
    extends TypeChannel<$CapturePhotoCaptureDelegate> {
  $CapturePhotoCaptureDelegateChannel(TypeChannelMessenger messenger)
      : super(messenger,
            'ios_avfoundation/avfoundation/CapturePhotoCaptureDelegate');

  Future<PairedInstance?> $$create(
    $CapturePhotoCaptureDelegate $instance, {
    required bool $owner,
    required $FinishProcessingPhotoCallback didFinishProcessingPhoto,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        didFinishProcessingPhoto,
      ],
      owner: $owner,
    );
  }
}

class $CaptureOutputChannel extends TypeChannel<$CaptureOutput> {
  $CaptureOutputChannel(TypeChannelMessenger messenger)
      : super(messenger, 'ios_avfoundation/avfoundation/CaptureOutput');

  Future<PairedInstance?> $$create(
    $CaptureOutput $instance, {
    required bool $owner,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[],
      owner: $owner,
    );
  }
}

class $CapturePhotoChannel extends TypeChannel<$CapturePhoto> {
  $CapturePhotoChannel(TypeChannelMessenger messenger)
      : super(messenger, 'ios_avfoundation/avfoundation/CapturePhoto');

  Future<PairedInstance?> $$create(
    $CapturePhoto $instance, {
    required bool $owner,
    required Uint8List? fileDataRepresentation,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        fileDataRepresentation,
      ],
      owner: $owner,
    );
  }
}

class $CaptureDeviceInputChannel extends TypeChannel<$CaptureDeviceInput> {
  $CaptureDeviceInputChannel(TypeChannelMessenger messenger)
      : super(messenger, 'ios_avfoundation/avfoundation/CaptureDeviceInput');

  Future<PairedInstance?> $$create(
    $CaptureDeviceInput $instance, {
    required bool $owner,
    required $CaptureDevice device,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        device,
      ],
      owner: $owner,
    );
  }
}

class $CaptureInputChannel extends TypeChannel<$CaptureInput> {
  $CaptureInputChannel(TypeChannelMessenger messenger)
      : super(messenger, 'ios_avfoundation/avfoundation/CaptureInput');

  Future<PairedInstance?> $$create(
    $CaptureInput $instance, {
    required bool $owner,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[],
      owner: $owner,
    );
  }
}

class $CaptureSessionChannel extends TypeChannel<$CaptureSession> {
  $CaptureSessionChannel(TypeChannelMessenger messenger)
      : super(messenger, 'ios_avfoundation/avfoundation/CaptureSession');

  Future<PairedInstance?> $$create(
    $CaptureSession $instance, {
    required bool $owner,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[],
      owner: $owner,
    );
  }

  Future<Object?> $addInput(
    $CaptureSession $instance,
    $CaptureInput input,
  ) {
    return sendInvokeMethod(
      $instance,
      'addInput',
      <Object?>[
        input,
      ],
    );
  }

  Future<Object?> $addOutput(
    $CaptureSession $instance,
    $CaptureOutput output,
  ) {
    return sendInvokeMethod(
      $instance,
      'addOutput',
      <Object?>[
        output,
      ],
    );
  }

  Future<Object?> $startRunning(
    $CaptureSession $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'startRunning',
      <Object?>[],
    );
  }

  Future<Object?> $stopRunning(
    $CaptureSession $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'stopRunning',
      <Object?>[],
    );
  }
}

class $CaptureDeviceChannel extends TypeChannel<$CaptureDevice> {
  $CaptureDeviceChannel(TypeChannelMessenger messenger)
      : super(messenger, 'ios_avfoundation/avfoundation/CaptureDevice');

  Future<PairedInstance?> $$create(
    $CaptureDevice $instance, {
    required bool $owner,
    required String uniqueId,
    required int position,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        uniqueId,
        position,
      ],
      owner: $owner,
    );
  }

  Future<Object?> $devicesWithMediaType(
    String mediaType,
  ) {
    return sendInvokeStaticMethod(
      'devicesWithMediaType',
      <Object?>[
        mediaType,
      ],
    );
  }
}

class $CaptureDeviceDiscoverySessionChannel
    extends TypeChannel<$CaptureDeviceDiscoverySession> {
  $CaptureDeviceDiscoverySessionChannel(TypeChannelMessenger messenger)
      : super(messenger,
            'ios_avfoundation/avfoundation/CaptureDeviceDiscoverySession');

  Future<PairedInstance?> $$create(
    $CaptureDeviceDiscoverySession $instance, {
    required bool $owner,
    required List<$CaptureDevice> devices,
    required List<List<$CaptureDevice>> supportedMultiCamDeviceSets,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        devices,
        supportedMultiCamDeviceSets,
      ],
      owner: $owner,
    );
  }

  Future<Object?> $discoverySessionWithDeviceTypes(
    List<String> deviceTypes,
    String? mediaType,
    int position,
  ) {
    return sendInvokeStaticMethod(
      'discoverySessionWithDeviceTypes',
      <Object?>[
        deviceTypes,
        mediaType,
        position,
      ],
    );
  }
}

class $PreviewControllerChannel extends TypeChannel<$PreviewController> {
  $PreviewControllerChannel(TypeChannelMessenger messenger)
      : super(messenger, 'ios_avfoundation/avfoundation/PreviewController');

  Future<PairedInstance?> $$create(
    $PreviewController $instance, {
    required bool $owner,
    required $CaptureSession captureSession,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        captureSession,
      ],
      owner: $owner,
    );
  }
}

class $CapturePhotoOutputHandler
    implements TypeChannelHandler<$CapturePhotoOutput> {
  $CapturePhotoOutput $$create(
    TypeChannelMessenger messenger,
  ) {
    throw UnimplementedError();
  }

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
    }

    throw ArgumentError.value(
      methodName,
      'methodName',
      'Unable to invoke static method `$methodName`',
    );
  }

  @override
  $CapturePhotoOutput createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return $$create(
      messenger,
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $CapturePhotoOutput instance,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
    }

    throw ArgumentError.value(
      instance,
      'instance',
      'Unable to invoke method `$methodName` on',
    );
  }
}

class $CapturePhotoSettingsHandler
    implements TypeChannelHandler<$CapturePhotoSettings> {
  $CapturePhotoSettings $$create(
    TypeChannelMessenger messenger,
    Map processedFormat,
  ) {
    throw UnimplementedError();
  }

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
    }

    throw ArgumentError.value(
      methodName,
      'methodName',
      'Unable to invoke static method `$methodName`',
    );
  }

  @override
  $CapturePhotoSettings createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return $$create(
      messenger,
      arguments[0] as Map,
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $CapturePhotoSettings instance,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
    }

    throw ArgumentError.value(
      instance,
      'instance',
      'Unable to invoke method `$methodName` on',
    );
  }
}

class $CapturePhotoCaptureDelegateHandler
    implements TypeChannelHandler<$CapturePhotoCaptureDelegate> {
  $CapturePhotoCaptureDelegate $$create(
    TypeChannelMessenger messenger,
    $FinishProcessingPhotoCallback didFinishProcessingPhoto,
  ) {
    throw UnimplementedError();
  }

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
    }

    throw ArgumentError.value(
      methodName,
      'methodName',
      'Unable to invoke static method `$methodName`',
    );
  }

  @override
  $CapturePhotoCaptureDelegate createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return $$create(
      messenger,
      arguments[0] as $FinishProcessingPhotoCallback,
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $CapturePhotoCaptureDelegate instance,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
    }

    throw ArgumentError.value(
      instance,
      'instance',
      'Unable to invoke method `$methodName` on',
    );
  }
}

class $CaptureOutputHandler implements TypeChannelHandler<$CaptureOutput> {
  $CaptureOutput $$create(
    TypeChannelMessenger messenger,
  ) {
    throw UnimplementedError();
  }

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
    }

    throw ArgumentError.value(
      methodName,
      'methodName',
      'Unable to invoke static method `$methodName`',
    );
  }

  @override
  $CaptureOutput createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return $$create(
      messenger,
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $CaptureOutput instance,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
    }

    throw ArgumentError.value(
      instance,
      'instance',
      'Unable to invoke method `$methodName` on',
    );
  }
}

class $CapturePhotoHandler implements TypeChannelHandler<$CapturePhoto> {
  $CapturePhoto $$create(
    TypeChannelMessenger messenger,
    Uint8List? fileDataRepresentation,
  ) {
    throw UnimplementedError();
  }

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
    }

    throw ArgumentError.value(
      methodName,
      'methodName',
      'Unable to invoke static method `$methodName`',
    );
  }

  @override
  $CapturePhoto createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return $$create(
      messenger,
      arguments[0] as Uint8List?,
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $CapturePhoto instance,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
    }

    throw ArgumentError.value(
      instance,
      'instance',
      'Unable to invoke method `$methodName` on',
    );
  }
}

class $CaptureDeviceInputHandler
    implements TypeChannelHandler<$CaptureDeviceInput> {
  $CaptureDeviceInput $$create(
    TypeChannelMessenger messenger,
    $CaptureDevice device,
  ) {
    throw UnimplementedError();
  }

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
    }

    throw ArgumentError.value(
      methodName,
      'methodName',
      'Unable to invoke static method `$methodName`',
    );
  }

  @override
  $CaptureDeviceInput createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return $$create(
      messenger,
      arguments[0] as $CaptureDevice,
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $CaptureDeviceInput instance,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
    }

    throw ArgumentError.value(
      instance,
      'instance',
      'Unable to invoke method `$methodName` on',
    );
  }
}

class $CaptureInputHandler implements TypeChannelHandler<$CaptureInput> {
  $CaptureInput $$create(
    TypeChannelMessenger messenger,
  ) {
    throw UnimplementedError();
  }

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
    }

    throw ArgumentError.value(
      methodName,
      'methodName',
      'Unable to invoke static method `$methodName`',
    );
  }

  @override
  $CaptureInput createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return $$create(
      messenger,
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $CaptureInput instance,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
    }

    throw ArgumentError.value(
      instance,
      'instance',
      'Unable to invoke method `$methodName` on',
    );
  }
}

class $CaptureSessionHandler implements TypeChannelHandler<$CaptureSession> {
  $CaptureSession $$create(
    TypeChannelMessenger messenger,
  ) {
    throw UnimplementedError();
  }

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
    }

    throw ArgumentError.value(
      methodName,
      'methodName',
      'Unable to invoke static method `$methodName`',
    );
  }

  @override
  $CaptureSession createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return $$create(
      messenger,
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $CaptureSession instance,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
    }

    throw ArgumentError.value(
      instance,
      'instance',
      'Unable to invoke method `$methodName` on',
    );
  }
}

class $CaptureDeviceHandler implements TypeChannelHandler<$CaptureDevice> {
  $CaptureDevice $$create(
    TypeChannelMessenger messenger,
    String uniqueId,
    int position,
  ) {
    throw UnimplementedError();
  }

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
    }

    throw ArgumentError.value(
      methodName,
      'methodName',
      'Unable to invoke static method `$methodName`',
    );
  }

  @override
  $CaptureDevice createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return $$create(
      messenger,
      arguments[0] as String,
      arguments[1] as int,
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $CaptureDevice instance,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
    }

    throw ArgumentError.value(
      instance,
      'instance',
      'Unable to invoke method `$methodName` on',
    );
  }
}

class $CaptureDeviceDiscoverySessionHandler
    implements TypeChannelHandler<$CaptureDeviceDiscoverySession> {
  $CaptureDeviceDiscoverySession $$create(
    TypeChannelMessenger messenger,
    List<$CaptureDevice> devices,
    List<List<$CaptureDevice>> supportedMultiCamDeviceSets,
  ) {
    throw UnimplementedError();
  }

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
    }

    throw ArgumentError.value(
      methodName,
      'methodName',
      'Unable to invoke static method `$methodName`',
    );
  }

  @override
  $CaptureDeviceDiscoverySession createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return $$create(
      messenger,
      (arguments[0] as List<dynamic>).map((_) => _ as $CaptureDevice).toList(),
      (arguments[1] as List<dynamic>)
          .map((_) =>
              (_ as List<dynamic>).map((_) => _ as $CaptureDevice).toList())
          .toList(),
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $CaptureDeviceDiscoverySession instance,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
    }

    throw ArgumentError.value(
      instance,
      'instance',
      'Unable to invoke method `$methodName` on',
    );
  }
}

class $PreviewControllerHandler
    implements TypeChannelHandler<$PreviewController> {
  $PreviewController $$create(
    TypeChannelMessenger messenger,
    $CaptureSession captureSession,
  ) {
    throw UnimplementedError();
  }

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
    }

    throw ArgumentError.value(
      methodName,
      'methodName',
      'Unable to invoke static method `$methodName`',
    );
  }

  @override
  $PreviewController createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return $$create(
      messenger,
      arguments[0] as $CaptureSession,
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $PreviewController instance,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
    }

    throw ArgumentError.value(
      instance,
      'instance',
      'Unable to invoke method `$methodName` on',
    );
  }
}

class $LibraryImplementations {
  $LibraryImplementations(this.messenger);

  final TypeChannelMessenger messenger;

  $CapturePhotoOutputChannel get channelCapturePhotoOutput =>
      $CapturePhotoOutputChannel(messenger);
  $CapturePhotoOutputHandler get handlerCapturePhotoOutput =>
      $CapturePhotoOutputHandler();

  $CapturePhotoSettingsChannel get channelCapturePhotoSettings =>
      $CapturePhotoSettingsChannel(messenger);
  $CapturePhotoSettingsHandler get handlerCapturePhotoSettings =>
      $CapturePhotoSettingsHandler();

  $CapturePhotoCaptureDelegateChannel get channelCapturePhotoCaptureDelegate =>
      $CapturePhotoCaptureDelegateChannel(messenger);
  $CapturePhotoCaptureDelegateHandler get handlerCapturePhotoCaptureDelegate =>
      $CapturePhotoCaptureDelegateHandler();

  $CaptureOutputChannel get channelCaptureOutput =>
      $CaptureOutputChannel(messenger);
  $CaptureOutputHandler get handlerCaptureOutput => $CaptureOutputHandler();

  $CapturePhotoChannel get channelCapturePhoto =>
      $CapturePhotoChannel(messenger);
  $CapturePhotoHandler get handlerCapturePhoto => $CapturePhotoHandler();

  $CaptureDeviceInputChannel get channelCaptureDeviceInput =>
      $CaptureDeviceInputChannel(messenger);
  $CaptureDeviceInputHandler get handlerCaptureDeviceInput =>
      $CaptureDeviceInputHandler();

  $CaptureInputChannel get channelCaptureInput =>
      $CaptureInputChannel(messenger);
  $CaptureInputHandler get handlerCaptureInput => $CaptureInputHandler();

  $CaptureSessionChannel get channelCaptureSession =>
      $CaptureSessionChannel(messenger);
  $CaptureSessionHandler get handlerCaptureSession => $CaptureSessionHandler();

  $CaptureDeviceChannel get channelCaptureDevice =>
      $CaptureDeviceChannel(messenger);
  $CaptureDeviceHandler get handlerCaptureDevice => $CaptureDeviceHandler();

  $CaptureDeviceDiscoverySessionChannel
      get channelCaptureDeviceDiscoverySession =>
          $CaptureDeviceDiscoverySessionChannel(messenger);
  $CaptureDeviceDiscoverySessionHandler
      get handlerCaptureDeviceDiscoverySession =>
          $CaptureDeviceDiscoverySessionHandler();

  $PreviewControllerChannel get channelPreviewController =>
      $PreviewControllerChannel(messenger);
  $PreviewControllerHandler get handlerPreviewController =>
      $PreviewControllerHandler();

  $FinishProcessingPhotoCallbackChannel
      get channelFinishProcessingPhotoCallback =>
          $FinishProcessingPhotoCallbackChannel(messenger);
  $FinishProcessingPhotoCallbackHandler
      get handlerFinishProcessingPhotoCallback =>
          $FinishProcessingPhotoCallbackHandler(this);
}

class $ChannelRegistrar {
  $ChannelRegistrar(this.implementations);

  final $LibraryImplementations implementations;

  void registerHandlers() {
    implementations.channelCapturePhotoOutput.setHandler(
      implementations.handlerCapturePhotoOutput,
    );

    implementations.channelCapturePhotoSettings.setHandler(
      implementations.handlerCapturePhotoSettings,
    );

    implementations.channelCapturePhotoCaptureDelegate.setHandler(
      implementations.handlerCapturePhotoCaptureDelegate,
    );

    implementations.channelCaptureOutput.setHandler(
      implementations.handlerCaptureOutput,
    );

    implementations.channelCapturePhoto.setHandler(
      implementations.handlerCapturePhoto,
    );

    implementations.channelCaptureDeviceInput.setHandler(
      implementations.handlerCaptureDeviceInput,
    );

    implementations.channelCaptureInput.setHandler(
      implementations.handlerCaptureInput,
    );

    implementations.channelCaptureSession.setHandler(
      implementations.handlerCaptureSession,
    );

    implementations.channelCaptureDevice.setHandler(
      implementations.handlerCaptureDevice,
    );

    implementations.channelCaptureDeviceDiscoverySession.setHandler(
      implementations.handlerCaptureDeviceDiscoverySession,
    );

    implementations.channelPreviewController.setHandler(
      implementations.handlerPreviewController,
    );

    implementations.channelFinishProcessingPhotoCallback.setHandler(
      implementations.handlerFinishProcessingPhotoCallback,
    );
  }

  void unregisterHandlers() {
    implementations.channelCapturePhotoOutput.removeHandler();

    implementations.channelCapturePhotoSettings.removeHandler();

    implementations.channelCapturePhotoCaptureDelegate.removeHandler();

    implementations.channelCaptureOutput.removeHandler();

    implementations.channelCapturePhoto.removeHandler();

    implementations.channelCaptureDeviceInput.removeHandler();

    implementations.channelCaptureInput.removeHandler();

    implementations.channelCaptureSession.removeHandler();

    implementations.channelCaptureDevice.removeHandler();

    implementations.channelCaptureDeviceDiscoverySession.removeHandler();

    implementations.channelPreviewController.removeHandler();

    implementations.channelFinishProcessingPhotoCallback.removeHandler();
  }
}
