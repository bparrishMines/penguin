// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:reference/reference.dart';

import 'package:android_hardware/android_hardware.dart';

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

typedef $OnErrorListener = dynamic Function(
  int what,
  int extra,
);

typedef $OnInfoListener = dynamic Function(
  int what,
  int extra,
);

class $OnErrorListenerChannel extends TypeChannel<Object> {
  $OnErrorListenerChannel(TypeChannelMessenger messenger)
      : super(messenger, 'android_media/media_recorder/OnErrorListener');

  Future<PairedInstance?> $$create(
    $OnErrorListener $instance, {
    required bool $owner,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[],
      owner: $owner,
    );
  }

  Future<Object?> _invoke(
    $OnErrorListener $instance,
    int what,
    int extra,
  ) {
    return sendInvokeMethod(
      $instance,
      '',
      <Object?>[
        what,
        extra,
      ],
    );
  }
}

class $OnInfoListenerChannel extends TypeChannel<Object> {
  $OnInfoListenerChannel(TypeChannelMessenger messenger)
      : super(messenger, 'android_media/media_recorder/OnInfoListener');

  Future<PairedInstance?> $$create(
    $OnInfoListener $instance, {
    required bool $owner,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[],
      owner: $owner,
    );
  }

  Future<Object?> _invoke(
    $OnInfoListener $instance,
    int what,
    int extra,
  ) {
    return sendInvokeMethod(
      $instance,
      '',
      <Object?>[
        what,
        extra,
      ],
    );
  }
}

class $OnErrorListenerHandler implements TypeChannelHandler<Object> {
  $OnErrorListenerHandler(this.implementations);

  final $LibraryImplementations implementations;

  @override
  $OnErrorListener createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    function(
      int what,
      int extra,
    ) {
      implementations.channelOnErrorListener._invoke(
        function,
        what,
        extra,
      );
    }

    return function;
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    covariant $OnErrorListener instance,
    String methodName,
    List<Object?> arguments,
  ) {
    return instance(
      arguments[0] as int,
      arguments[1] as int,
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

class $OnInfoListenerHandler implements TypeChannelHandler<Object> {
  $OnInfoListenerHandler(this.implementations);

  final $LibraryImplementations implementations;

  @override
  $OnInfoListener createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    function(
      int what,
      int extra,
    ) {
      implementations.channelOnInfoListener._invoke(
        function,
        what,
        extra,
      );
    }

    return function;
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    covariant $OnInfoListener instance,
    String methodName,
    List<Object?> arguments,
  ) {
    return instance(
      arguments[0] as int,
      arguments[1] as int,
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

mixin $MediaRecorder {}

mixin $CamcorderProfile {}

class $MediaRecorderChannel extends TypeChannel<$MediaRecorder> {
  $MediaRecorderChannel(TypeChannelMessenger messenger)
      : super(messenger, 'android_media/media_recorder/MediaRecorder');

  Future<PairedInstance?> $create$(
    $MediaRecorder $instance, {
    required bool $owner,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        '',
      ],
      owner: $owner,
    );
  }

  Future<Object?> $getAudioSourceMax() {
    return sendInvokeStaticMethod(
      'getAudioSourceMax',
      <Object?>[],
    );
  }

  Future<Object?> $setCamera(
    $MediaRecorder $instance,
    Camera camera,
  ) {
    return sendInvokeMethod(
      $instance,
      'setCamera',
      <Object?>[
        camera,
      ],
    );
  }

  Future<Object?> $setVideoSource(
    $MediaRecorder $instance,
    int source,
  ) {
    return sendInvokeMethod(
      $instance,
      'setVideoSource',
      <Object?>[
        source,
      ],
    );
  }

  Future<Object?> $setOutputFilePath(
    $MediaRecorder $instance,
    String path,
  ) {
    return sendInvokeMethod(
      $instance,
      'setOutputFilePath',
      <Object?>[
        path,
      ],
    );
  }

  Future<Object?> $setOutputFormat(
    $MediaRecorder $instance,
    int format,
  ) {
    return sendInvokeMethod(
      $instance,
      'setOutputFormat',
      <Object?>[
        format,
      ],
    );
  }

  Future<Object?> $setVideoEncoder(
    $MediaRecorder $instance,
    int encoder,
  ) {
    return sendInvokeMethod(
      $instance,
      'setVideoEncoder',
      <Object?>[
        encoder,
      ],
    );
  }

  Future<Object?> $setAudioSource(
    $MediaRecorder $instance,
    int source,
  ) {
    return sendInvokeMethod(
      $instance,
      'setAudioSource',
      <Object?>[
        source,
      ],
    );
  }

  Future<Object?> $setAudioEncoder(
    $MediaRecorder $instance,
    int encoder,
  ) {
    return sendInvokeMethod(
      $instance,
      'setAudioEncoder',
      <Object?>[
        encoder,
      ],
    );
  }

  Future<Object?> $prepare(
    $MediaRecorder $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'prepare',
      <Object?>[],
    );
  }

  Future<Object?> $start(
    $MediaRecorder $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'start',
      <Object?>[],
    );
  }

  Future<Object?> $stop(
    $MediaRecorder $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'stop',
      <Object?>[],
    );
  }

  Future<Object?> $release(
    $MediaRecorder $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'release',
      <Object?>[],
    );
  }

  Future<Object?> $pause(
    $MediaRecorder $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'pause',
      <Object?>[],
    );
  }

  Future<Object?> $resume(
    $MediaRecorder $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'resume',
      <Object?>[],
    );
  }

  Future<Object?> $getMaxAmplitude(
    $MediaRecorder $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'getMaxAmplitude',
      <Object?>[],
    );
  }

  Future<Object?> $reset(
    $MediaRecorder $instance,
  ) {
    return sendInvokeMethod(
      $instance,
      'reset',
      <Object?>[],
    );
  }

  Future<Object?> $setAudioChannels(
    $MediaRecorder $instance,
    int numChannels,
  ) {
    return sendInvokeMethod(
      $instance,
      'setAudioChannels',
      <Object?>[
        numChannels,
      ],
    );
  }

  Future<Object?> $setAudioEncodingBitRate(
    $MediaRecorder $instance,
    int bitRate,
  ) {
    return sendInvokeMethod(
      $instance,
      'setAudioEncodingBitRate',
      <Object?>[
        bitRate,
      ],
    );
  }

  Future<Object?> $setAudioSamplingRate(
    $MediaRecorder $instance,
    int samplingRate,
  ) {
    return sendInvokeMethod(
      $instance,
      'setAudioSamplingRate',
      <Object?>[
        samplingRate,
      ],
    );
  }

  Future<Object?> $setCaptureRate(
    $MediaRecorder $instance,
    double fps,
  ) {
    return sendInvokeMethod(
      $instance,
      'setCaptureRate',
      <Object?>[
        fps,
      ],
    );
  }

  Future<Object?> $setLocation(
    $MediaRecorder $instance,
    double latitude,
    double longitude,
  ) {
    return sendInvokeMethod(
      $instance,
      'setLocation',
      <Object?>[
        latitude,
        longitude,
      ],
    );
  }

  Future<Object?> $setMaxDuration(
    $MediaRecorder $instance,
    int maxDurationMs,
  ) {
    return sendInvokeMethod(
      $instance,
      'setMaxDuration',
      <Object?>[
        maxDurationMs,
      ],
    );
  }

  Future<Object?> $setMaxFileSize(
    $MediaRecorder $instance,
    int maxFilesizeBytes,
  ) {
    return sendInvokeMethod(
      $instance,
      'setMaxFileSize',
      <Object?>[
        maxFilesizeBytes,
      ],
    );
  }

  Future<Object?> $setOnErrorListener(
    $MediaRecorder $instance,
    $OnErrorListener onError,
  ) {
    return sendInvokeMethod(
      $instance,
      'setOnErrorListener',
      <Object?>[
        onError,
      ],
    );
  }

  Future<Object?> $setOnInfoListener(
    $MediaRecorder $instance,
    $OnInfoListener onInfo,
  ) {
    return sendInvokeMethod(
      $instance,
      'setOnInfoListener',
      <Object?>[
        onInfo,
      ],
    );
  }

  Future<Object?> $setOrientationHint(
    $MediaRecorder $instance,
    int degrees,
  ) {
    return sendInvokeMethod(
      $instance,
      'setOrientationHint',
      <Object?>[
        degrees,
      ],
    );
  }

  Future<Object?> $setVideoEncodingBitRate(
    $MediaRecorder $instance,
    int bitRate,
  ) {
    return sendInvokeMethod(
      $instance,
      'setVideoEncodingBitRate',
      <Object?>[
        bitRate,
      ],
    );
  }

  Future<Object?> $setVideoFrameRate(
    $MediaRecorder $instance,
    int rate,
  ) {
    return sendInvokeMethod(
      $instance,
      'setVideoFrameRate',
      <Object?>[
        rate,
      ],
    );
  }

  Future<Object?> $setVideoSize(
    $MediaRecorder $instance,
    int width,
    int height,
  ) {
    return sendInvokeMethod(
      $instance,
      'setVideoSize',
      <Object?>[
        width,
        height,
      ],
    );
  }

  Future<Object?> $setProfile(
    $MediaRecorder $instance,
    $CamcorderProfile profile,
  ) {
    return sendInvokeMethod(
      $instance,
      'setProfile',
      <Object?>[
        profile,
      ],
    );
  }

  Future<Object?> $setNextOutputFilePath(
    $MediaRecorder $instance,
    String path,
  ) {
    return sendInvokeMethod(
      $instance,
      'setNextOutputFilePath',
      <Object?>[
        path,
      ],
    );
  }
}

class $CamcorderProfileChannel extends TypeChannel<$CamcorderProfile> {
  $CamcorderProfileChannel(TypeChannelMessenger messenger)
      : super(messenger, 'android_media/media_recorder/CamcorderProfile');

  Future<PairedInstance?> $create$(
    $CamcorderProfile $instance, {
    required bool $owner,
    required int audioBitRate,
    required int audioChannels,
    required int audioCodec,
    required int audioSampleRate,
    required int duration,
    required int fileFormat,
    required int quality,
    required int videoBitRate,
    required int videoCodec,
    required int videoFrameHeight,
    required int videoFrameRate,
    required int videoFrameWidth,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        '',
        audioBitRate,
        audioChannels,
        audioCodec,
        audioSampleRate,
        duration,
        fileFormat,
        quality,
        videoBitRate,
        videoCodec,
        videoFrameHeight,
        videoFrameRate,
        videoFrameWidth,
      ],
      owner: $owner,
    );
  }

  Future<Object?> $get(
    int cameraId,
    int quality,
  ) {
    return sendInvokeStaticMethod(
      'get',
      <Object?>[
        cameraId,
        quality,
      ],
    );
  }

  Future<Object?> $hasProfile(
    int cameraId,
    int quality,
  ) {
    return sendInvokeStaticMethod(
      'hasProfile',
      <Object?>[
        cameraId,
        quality,
      ],
    );
  }
}

class $MediaRecorderHandler implements TypeChannelHandler<$MediaRecorder> {
  $MediaRecorder $create$(
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
  $MediaRecorder createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    final String constructorName = arguments[0] as String;
    switch (constructorName) {
      case '':
        return $create$(
          messenger,
        );
    }

    throw ArgumentError.value(
      constructorName,
      'constructorName',
      'Unable to invoke constructor of',
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $MediaRecorder instance,
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

class $CamcorderProfileHandler
    implements TypeChannelHandler<$CamcorderProfile> {
  $CamcorderProfile $create$(
    TypeChannelMessenger messenger,
    int audioBitRate,
    int audioChannels,
    int audioCodec,
    int audioSampleRate,
    int duration,
    int fileFormat,
    int quality,
    int videoBitRate,
    int videoCodec,
    int videoFrameHeight,
    int videoFrameRate,
    int videoFrameWidth,
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
  $CamcorderProfile createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    final String constructorName = arguments[0] as String;
    switch (constructorName) {
      case '':
        return $create$(
          messenger,
          arguments[1] as int,
          arguments[2] as int,
          arguments[3] as int,
          arguments[4] as int,
          arguments[5] as int,
          arguments[6] as int,
          arguments[7] as int,
          arguments[8] as int,
          arguments[9] as int,
          arguments[10] as int,
          arguments[11] as int,
          arguments[12] as int,
        );
    }

    throw ArgumentError.value(
      constructorName,
      'constructorName',
      'Unable to invoke constructor of',
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $CamcorderProfile instance,
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

  $MediaRecorderChannel get channelMediaRecorder =>
      $MediaRecorderChannel(messenger);
  $MediaRecorderHandler get handlerMediaRecorder => $MediaRecorderHandler();

  $CamcorderProfileChannel get channelCamcorderProfile =>
      $CamcorderProfileChannel(messenger);
  $CamcorderProfileHandler get handlerCamcorderProfile =>
      $CamcorderProfileHandler();

  $OnErrorListenerChannel get channelOnErrorListener =>
      $OnErrorListenerChannel(messenger);
  $OnErrorListenerHandler get handlerOnErrorListener =>
      $OnErrorListenerHandler(this);

  $OnInfoListenerChannel get channelOnInfoListener =>
      $OnInfoListenerChannel(messenger);
  $OnInfoListenerHandler get handlerOnInfoListener =>
      $OnInfoListenerHandler(this);
}

class $ChannelRegistrar {
  $ChannelRegistrar(this.implementations);

  final $LibraryImplementations implementations;

  void registerHandlers() {
    implementations.channelMediaRecorder.setHandler(
      implementations.handlerMediaRecorder,
    );

    implementations.channelCamcorderProfile.setHandler(
      implementations.handlerCamcorderProfile,
    );

    implementations.channelOnErrorListener.setHandler(
      implementations.handlerOnErrorListener,
    );

    implementations.channelOnInfoListener.setHandler(
      implementations.handlerOnInfoListener,
    );
  }

  void unregisterHandlers() {
    implementations.channelMediaRecorder.removeHandler();

    implementations.channelCamcorderProfile.removeHandler();

    implementations.channelOnErrorListener.removeHandler();

    implementations.channelOnInfoListener.removeHandler();
  }
}
