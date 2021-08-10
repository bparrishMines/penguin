// GENERATED CODE - DO NOT MODIFY BY HAND

package dev.penguin.android_media;

import androidx.annotation.NonNull;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import dev.penguin.android_hardware.CameraProxy;
import github.penguin.reference.async.Completable;
import github.penguin.reference.reference.PairedInstance;
import github.penguin.reference.reference.TypeChannel;
import github.penguin.reference.reference.TypeChannelHandler;
import github.penguin.reference.reference.TypeChannelMessenger;

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

public class MediaRecorderChannelLibrary {

  public interface $MediaRecorder {

    Object setCamera(CameraProxy camera) throws Exception;

    Object setVideoSource(Integer source) throws Exception;

    Object setOutputFilePath(String path) throws Exception;

    Object setOutputFormat(Integer format) throws Exception;

    Object setVideoEncoder(Integer encoder) throws Exception;

    Object setAudioSource(Integer source) throws Exception;

    Object setAudioEncoder(Integer encoder) throws Exception;

    Object prepare() throws Exception;

    Object start() throws Exception;

    Object stop() throws Exception;

    Object release() throws Exception;

    Object pause() throws Exception;

    Object resume() throws Exception;

    Object getMaxAmplitude() throws Exception;

    Object reset() throws Exception;

    Object setAudioChannels(Integer numChannels) throws Exception;

    Object setAudioEncodingBitRate(Integer bitRate) throws Exception;

    Object setAudioSamplingRate(Integer samplingRate) throws Exception;

    Object setCaptureRate(Double fps) throws Exception;

    Object setLocation(Double latitude, Double longitude) throws Exception;

    Object setMaxDuration(Integer maxDurationMs) throws Exception;

    Object setMaxFileSize(Integer maxFilesizeBytes) throws Exception;

    Object setOnErrorListener($OnErrorListener onError) throws Exception;

    Object setOnInfoListener($OnInfoListener onInfo) throws Exception;

    Object setOrientationHint(Integer degrees) throws Exception;

    Object setVideoEncodingBitRate(Integer bitRate) throws Exception;

    Object setVideoFrameRate(Integer rate) throws Exception;

    Object setVideoSize(Integer width, Integer height) throws Exception;

    Object setProfile($CamcorderProfile profile) throws Exception;
  }

  public interface $CamcorderProfile {}

  public abstract static class $OnErrorListener {
    public abstract Object invoke(Integer what, Integer extra);
  }

  public abstract static class $OnInfoListener {
    public abstract Object invoke(Integer what, Integer extra);
  }

  public static class $OnErrorListenerChannel extends TypeChannel<$OnErrorListener> {
    public $OnErrorListenerChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "android_media/media_recorder/OnErrorListener");
    }

    public Completable<PairedInstance> $$create($OnErrorListener $instance, boolean $owner) {
      return createNewInstancePair($instance, Collections.emptyList(), $owner);
    }

    private Completable<Object> invoke($OnErrorListener $instance, Integer what, Integer extra) {
      return invokeMethod($instance, "", Arrays.asList(what, extra));
    }
  }

  public static class $OnInfoListenerChannel extends TypeChannel<$OnInfoListener> {
    public $OnInfoListenerChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "android_media/media_recorder/OnInfoListener");
    }

    public Completable<PairedInstance> $$create($OnInfoListener $instance, boolean $owner) {
      return createNewInstancePair($instance, Collections.emptyList(), $owner);
    }

    private Completable<Object> invoke($OnInfoListener $instance, Integer what, Integer extra) {
      return invokeMethod($instance, "", Arrays.asList(what, extra));
    }
  }

  public static class $OnErrorListenerHandler implements TypeChannelHandler<$OnErrorListener> {
    public final $LibraryImplementations implementations;

    public $OnErrorListenerHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    @Override
    public $OnErrorListener createInstance(TypeChannelMessenger messenger, List<Object> arguments) {
      return new $OnErrorListener() {
        @Override
        public Object invoke(Integer what, Integer extra) {
          return implementations.getChannelOnErrorListener().invoke(this, what, extra);
        }
      };
    }

    @Override
    public Void invokeStaticMethod(
        TypeChannelMessenger messenger, String methodName, List<Object> arguments) {
      throw new UnsupportedOperationException();
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        $OnErrorListener instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      return instance.invoke((Integer) arguments.get(0), (Integer) arguments.get(1));
    }
  }

  public static class $OnInfoListenerHandler implements TypeChannelHandler<$OnInfoListener> {
    public final $LibraryImplementations implementations;

    public $OnInfoListenerHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    @Override
    public $OnInfoListener createInstance(TypeChannelMessenger messenger, List<Object> arguments) {
      return new $OnInfoListener() {
        @Override
        public Object invoke(Integer what, Integer extra) {
          return implementations.getChannelOnInfoListener().invoke(this, what, extra);
        }
      };
    }

    @Override
    public Void invokeStaticMethod(
        TypeChannelMessenger messenger, String methodName, List<Object> arguments) {
      throw new UnsupportedOperationException();
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        $OnInfoListener instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      return instance.invoke((Integer) arguments.get(0), (Integer) arguments.get(1));
    }
  }

  public static class $MediaRecorderChannel extends TypeChannel<$MediaRecorder> {
    public $MediaRecorderChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "android_media/media_recorder/MediaRecorder");
    }

    public Completable<PairedInstance> $create$($MediaRecorder $instance, boolean $owner) {
      return createNewInstancePair($instance, Arrays.asList(""), $owner);
    }
  }

  public static class $CamcorderProfileChannel extends TypeChannel<$CamcorderProfile> {
    public $CamcorderProfileChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "android_media/media_recorder/CamcorderProfile");
    }

    public Completable<PairedInstance> $create$(
        $CamcorderProfile $instance,
        boolean $owner,
        Integer audioBitRate,
        Integer audioChannels,
        Integer audioCodec,
        Integer audioSampleRate,
        Integer duration,
        Integer fileFormat,
        Integer quality,
        Integer videoBitRate,
        Integer videoCodec,
        Integer videoFrameHeight,
        Integer videoFrameRate,
        Integer videoFrameWidth) {
      return createNewInstancePair(
          $instance,
          Arrays.asList(
              "",
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
              videoFrameWidth),
          $owner);
    }
  }

  public static class $MediaRecorderHandler implements TypeChannelHandler<$MediaRecorder> {

    public $MediaRecorder $create$(TypeChannelMessenger messenger) throws Exception {
      throw new UnsupportedOperationException();
    }

    public Object $getAudioSourceMax(TypeChannelMessenger messenger) throws Exception {
      throw new UnsupportedOperationException();
    }

    public Object $setCamera($MediaRecorder $instance, CameraProxy camera) throws Exception {
      return $instance.setCamera(camera);
    }

    public Object $setVideoSource($MediaRecorder $instance, Integer source) throws Exception {
      return $instance.setVideoSource(source);
    }

    public Object $setOutputFilePath($MediaRecorder $instance, String path) throws Exception {
      return $instance.setOutputFilePath(path);
    }

    public Object $setOutputFormat($MediaRecorder $instance, Integer format) throws Exception {
      return $instance.setOutputFormat(format);
    }

    public Object $setVideoEncoder($MediaRecorder $instance, Integer encoder) throws Exception {
      return $instance.setVideoEncoder(encoder);
    }

    public Object $setAudioSource($MediaRecorder $instance, Integer source) throws Exception {
      return $instance.setAudioSource(source);
    }

    public Object $setAudioEncoder($MediaRecorder $instance, Integer encoder) throws Exception {
      return $instance.setAudioEncoder(encoder);
    }

    public Object $prepare($MediaRecorder $instance) throws Exception {
      return $instance.prepare();
    }

    public Object $start($MediaRecorder $instance) throws Exception {
      return $instance.start();
    }

    public Object $stop($MediaRecorder $instance) throws Exception {
      return $instance.stop();
    }

    public Object $release($MediaRecorder $instance) throws Exception {
      return $instance.release();
    }

    public Object $pause($MediaRecorder $instance) throws Exception {
      return $instance.pause();
    }

    public Object $resume($MediaRecorder $instance) throws Exception {
      return $instance.resume();
    }

    public Object $getMaxAmplitude($MediaRecorder $instance) throws Exception {
      return $instance.getMaxAmplitude();
    }

    public Object $reset($MediaRecorder $instance) throws Exception {
      return $instance.reset();
    }

    public Object $setAudioChannels($MediaRecorder $instance, Integer numChannels)
        throws Exception {
      return $instance.setAudioChannels(numChannels);
    }

    public Object $setAudioEncodingBitRate($MediaRecorder $instance, Integer bitRate)
        throws Exception {
      return $instance.setAudioEncodingBitRate(bitRate);
    }

    public Object $setAudioSamplingRate($MediaRecorder $instance, Integer samplingRate)
        throws Exception {
      return $instance.setAudioSamplingRate(samplingRate);
    }

    public Object $setCaptureRate($MediaRecorder $instance, Double fps) throws Exception {
      return $instance.setCaptureRate(fps);
    }

    public Object $setLocation($MediaRecorder $instance, Double latitude, Double longitude)
        throws Exception {
      return $instance.setLocation(latitude, longitude);
    }

    public Object $setMaxDuration($MediaRecorder $instance, Integer maxDurationMs)
        throws Exception {
      return $instance.setMaxDuration(maxDurationMs);
    }

    public Object $setMaxFileSize($MediaRecorder $instance, Integer maxFilesizeBytes)
        throws Exception {
      return $instance.setMaxFileSize(maxFilesizeBytes);
    }

    public Object $setOnErrorListener($MediaRecorder $instance, $OnErrorListener onError)
        throws Exception {
      return $instance.setOnErrorListener(onError);
    }

    public Object $setOnInfoListener($MediaRecorder $instance, $OnInfoListener onInfo)
        throws Exception {
      return $instance.setOnInfoListener(onInfo);
    }

    public Object $setOrientationHint($MediaRecorder $instance, Integer degrees) throws Exception {
      return $instance.setOrientationHint(degrees);
    }

    public Object $setVideoEncodingBitRate($MediaRecorder $instance, Integer bitRate)
        throws Exception {
      return $instance.setVideoEncodingBitRate(bitRate);
    }

    public Object $setVideoFrameRate($MediaRecorder $instance, Integer rate) throws Exception {
      return $instance.setVideoFrameRate(rate);
    }

    public Object $setVideoSize($MediaRecorder $instance, Integer width, Integer height)
        throws Exception {
      return $instance.setVideoSize(width, height);
    }

    public Object $setProfile($MediaRecorder $instance, $CamcorderProfile profile)
        throws Exception {
      return $instance.setProfile(profile);
    }

    @Override
    public Object invokeStaticMethod(
        TypeChannelMessenger messenger, String methodName, List<Object> arguments)
        throws Exception {
      switch (methodName) {
        case "getAudioSourceMax":
          return $getAudioSourceMax(messenger);
      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke static method %s", methodName));
    }

    @Override
    public $MediaRecorder createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      final String constructorName = (String) arguments.get(0);
      switch (constructorName) {
        case "":
          return $create$(messenger);
      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke constructor of %s", constructorName));
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        $MediaRecorder instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      switch (methodName) {
        case "setCamera":
          return $setCamera(instance, (CameraProxy) arguments.get(0));

        case "setVideoSource":
          return $setVideoSource(instance, (Integer) arguments.get(0));

        case "setOutputFilePath":
          return $setOutputFilePath(instance, (String) arguments.get(0));

        case "setOutputFormat":
          return $setOutputFormat(instance, (Integer) arguments.get(0));

        case "setVideoEncoder":
          return $setVideoEncoder(instance, (Integer) arguments.get(0));

        case "setAudioSource":
          return $setAudioSource(instance, (Integer) arguments.get(0));

        case "setAudioEncoder":
          return $setAudioEncoder(instance, (Integer) arguments.get(0));

        case "prepare":
          return $prepare(instance);

        case "start":
          return $start(instance);

        case "stop":
          return $stop(instance);

        case "release":
          return $release(instance);

        case "pause":
          return $pause(instance);

        case "resume":
          return $resume(instance);

        case "getMaxAmplitude":
          return $getMaxAmplitude(instance);

        case "reset":
          return $reset(instance);

        case "setAudioChannels":
          return $setAudioChannels(instance, (Integer) arguments.get(0));

        case "setAudioEncodingBitRate":
          return $setAudioEncodingBitRate(instance, (Integer) arguments.get(0));

        case "setAudioSamplingRate":
          return $setAudioSamplingRate(instance, (Integer) arguments.get(0));

        case "setCaptureRate":
          return $setCaptureRate(instance, (Double) arguments.get(0));

        case "setLocation":
          return $setLocation(instance, (Double) arguments.get(0), (Double) arguments.get(1));

        case "setMaxDuration":
          return $setMaxDuration(instance, (Integer) arguments.get(0));

        case "setMaxFileSize":
          return $setMaxFileSize(instance, (Integer) arguments.get(0));

        case "setOnErrorListener":
          return $setOnErrorListener(instance, ($OnErrorListener) arguments.get(0));

        case "setOnInfoListener":
          return $setOnInfoListener(instance, ($OnInfoListener) arguments.get(0));

        case "setOrientationHint":
          return $setOrientationHint(instance, (Integer) arguments.get(0));

        case "setVideoEncodingBitRate":
          return $setVideoEncodingBitRate(instance, (Integer) arguments.get(0));

        case "setVideoFrameRate":
          return $setVideoFrameRate(instance, (Integer) arguments.get(0));

        case "setVideoSize":
          return $setVideoSize(instance, (Integer) arguments.get(0), (Integer) arguments.get(1));

        case "setProfile":
          return $setProfile(instance, ($CamcorderProfile) arguments.get(0));
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }

  public static class $CamcorderProfileHandler implements TypeChannelHandler<$CamcorderProfile> {

    public $CamcorderProfile $create$(
        TypeChannelMessenger messenger,
        Integer audioBitRate,
        Integer audioChannels,
        Integer audioCodec,
        Integer audioSampleRate,
        Integer duration,
        Integer fileFormat,
        Integer quality,
        Integer videoBitRate,
        Integer videoCodec,
        Integer videoFrameHeight,
        Integer videoFrameRate,
        Integer videoFrameWidth)
        throws Exception {
      throw new UnsupportedOperationException();
    }

    public Object $get(TypeChannelMessenger messenger, Integer cameraId, Integer quality)
        throws Exception {
      throw new UnsupportedOperationException();
    }

    public Object $hasProfile(TypeChannelMessenger messenger, Integer cameraId, Integer quality)
        throws Exception {
      throw new UnsupportedOperationException();
    }

    @Override
    public Object invokeStaticMethod(
        TypeChannelMessenger messenger, String methodName, List<Object> arguments)
        throws Exception {
      switch (methodName) {
        case "get":
          return $get(messenger, (Integer) arguments.get(0), (Integer) arguments.get(1));

        case "hasProfile":
          return $hasProfile(messenger, (Integer) arguments.get(0), (Integer) arguments.get(1));
      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke static method %s", methodName));
    }

    @Override
    public $CamcorderProfile createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      final String constructorName = (String) arguments.get(0);
      switch (constructorName) {
        case "":
          return $create$(
              messenger,
              (Integer) arguments.get(1),
              (Integer) arguments.get(2),
              (Integer) arguments.get(3),
              (Integer) arguments.get(4),
              (Integer) arguments.get(5),
              (Integer) arguments.get(6),
              (Integer) arguments.get(7),
              (Integer) arguments.get(8),
              (Integer) arguments.get(9),
              (Integer) arguments.get(10),
              (Integer) arguments.get(11),
              (Integer) arguments.get(12));
      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke constructor of %s", constructorName));
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        $CamcorderProfile instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      switch (methodName) {
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }

  public static class $LibraryImplementations {
    public final TypeChannelMessenger messenger;

    public $LibraryImplementations(TypeChannelMessenger messenger) {
      this.messenger = messenger;
    }

    public $MediaRecorderChannel getChannelMediaRecorder() {
      return new $MediaRecorderChannel(messenger);
    }

    public $MediaRecorderHandler getHandlerMediaRecorder() {
      return new $MediaRecorderHandler();
    }

    public $CamcorderProfileChannel getChannelCamcorderProfile() {
      return new $CamcorderProfileChannel(messenger);
    }

    public $CamcorderProfileHandler getHandlerCamcorderProfile() {
      return new $CamcorderProfileHandler();
    }

    public $OnErrorListenerChannel getChannelOnErrorListener() {
      return new $OnErrorListenerChannel(messenger);
    }

    public $OnErrorListenerHandler getHandlerOnErrorListener() {
      return new $OnErrorListenerHandler(this);
    }

    public $OnInfoListenerChannel getChannelOnInfoListener() {
      return new $OnInfoListenerChannel(messenger);
    }

    public $OnInfoListenerHandler getHandlerOnInfoListener() {
      return new $OnInfoListenerHandler(this);
    }
  }

  public static class $ChannelRegistrar {
    public final $LibraryImplementations implementations;

    public $ChannelRegistrar($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    public void registerHandlers() {

      implementations
          .getChannelMediaRecorder()
          .setHandler(implementations.getHandlerMediaRecorder());

      implementations
          .getChannelCamcorderProfile()
          .setHandler(implementations.getHandlerCamcorderProfile());

      implementations
          .getChannelOnErrorListener()
          .setHandler(implementations.getHandlerOnErrorListener());

      implementations
          .getChannelOnInfoListener()
          .setHandler(implementations.getHandlerOnInfoListener());
    }

    public void unregisterHandlers() {

      implementations.getChannelMediaRecorder().removeHandler();

      implementations.getChannelCamcorderProfile().removeHandler();

      implementations.getChannelOnErrorListener().removeHandler();

      implementations.getChannelOnInfoListener().removeHandler();
    }
  }
}
