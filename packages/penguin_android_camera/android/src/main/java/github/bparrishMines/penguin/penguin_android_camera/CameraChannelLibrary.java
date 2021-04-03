// GENERATED CODE - DO NOT MODIFY BY HAND

package github.bparrishMines.penguin.penguin_android_camera;

import androidx.annotation.NonNull;

import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.List;

import github.penguin.reference.async.Completable;
import github.penguin.reference.reference.TypeChannel;
import github.penguin.reference.reference.TypeChannelHandler;
import github.penguin.reference.reference.TypeChannelMessenger;

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

class CameraChannelLibrary {
  public interface $Camera {


    Object release() throws Exception;

    Object startPreview() throws Exception;

    Object stopPreview() throws Exception;

    Object attachPreviewTexture() throws Exception;

    Object releasePreviewTexture() throws Exception;

    Object unlock() throws Exception;

    Object takePicture($ShutterCallback shutter, $PictureCallback raw, $PictureCallback postView, $PictureCallback jpeg) throws Exception;
  }

  interface $ShutterCallback {


    Object onShutter() throws Exception;
  }

  interface $PictureCallback {


    Object onPictureTaken(byte[] data) throws Exception;
  }

  interface $CameraInfo {
    Integer getCameraId();

    Integer getFacing();

    Integer getOrientation();


  }

  interface $MediaRecorder {
    $Camera getCamera();

    Integer getOutputFormat();

    String getOutputFilePath();

    Integer getVideoEncoder();

    Integer getAudioSource();

    Integer getAudioEncoder();

    Object prepare() throws Exception;

    Object start() throws Exception;

    Object stop() throws Exception;

    Object release() throws Exception;
  }

  public static class $CameraCreationArgs {

  }

  static class $ShutterCallbackCreationArgs {

  }

  static class $PictureCallbackCreationArgs {

  }

  static class $CameraInfoCreationArgs {
    Integer cameraId;
    Integer facing;
    Integer orientation;
  }

  static class $MediaRecorderCreationArgs {
    $Camera camera;
    Integer outputFormat;
    String outputFilePath;
    Integer videoEncoder;
    Integer audioSource;
    Integer audioEncoder;
  }

  public static class $CameraChannel extends TypeChannel<$Camera> {
    public $CameraChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/Camera");
    }

    public Completable<Object> $invokeGetAllCameraInfo() {
      return invokeStaticMethod("getAllCameraInfo", Arrays.asList());
    }

    Completable<Object> $invokeOpen(Integer cameraId) {
      return invokeStaticMethod("open", Arrays.asList(cameraId));
    }

    public Completable<Object> $invokeRelease($Camera instance) {
      return invokeMethod(instance, "release", Arrays.asList());
    }

    Completable<Object> $invokeStartPreview($Camera instance) {
      return invokeMethod(instance, "startPreview", Arrays.asList());
    }

    Completable<Object> $invokeStopPreview($Camera instance) {
      return invokeMethod(instance, "stopPreview", Arrays.asList());
    }

    Completable<Object> $invokeAttachPreviewTexture($Camera instance) {
      return invokeMethod(instance, "attachPreviewTexture", Arrays.asList());
    }

    Completable<Object> $invokeReleasePreviewTexture($Camera instance) {
      return invokeMethod(instance, "releasePreviewTexture", Arrays.asList());
    }

    Completable<Object> $invokeUnlock($Camera instance) {
      return invokeMethod(instance, "unlock", Arrays.asList());
    }

    Completable<Object> $invokeTakePicture($Camera instance, $ShutterCallback shutter, $PictureCallback raw, $PictureCallback postView, $PictureCallback jpeg) {
      return invokeMethod(instance, "takePicture", Arrays.asList(shutter, raw, postView, jpeg));
    }
  }

  static class $ShutterCallbackChannel extends TypeChannel<$ShutterCallback> {
    public $ShutterCallbackChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/ShutterCallback");
    }

    //public

    public Completable<Object> $invokeOnShutter($ShutterCallback instance) {
      return invokeMethod(instance, "onShutter", Arrays.asList());
    }
  }

  static class $PictureCallbackChannel extends TypeChannel<$PictureCallback> {
    public $PictureCallbackChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/PictureCallback");
    }

    //public

    public Completable<Object> $invokeOnPictureTaken($PictureCallback instance, byte[] data) {
      return invokeMethod(instance, "onPictureTaken", Arrays.asList(data));
    }
  }

  static class $CameraInfoChannel extends TypeChannel<$CameraInfo> {
    public $CameraInfoChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/CameraInfo");
    }

    //public

    //public
  }

  static class $MediaRecorderChannel extends TypeChannel<$MediaRecorder> {
    public $MediaRecorderChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/MediaRecorder");
    }

    //public

    public Completable<Object> $invokePrepare($MediaRecorder instance) {
      return invokeMethod(instance, "prepare", Arrays.asList());
    }

    Completable<Object> $invokeStart($MediaRecorder instance) {
      return invokeMethod(instance, "start", Arrays.asList());
    }

    Completable<Object> $invokeStop($MediaRecorder instance) {
      return invokeMethod(instance, "stop", Arrays.asList());
    }

    Completable<Object> $invokeRelease($MediaRecorder instance) {
      return invokeMethod(instance, "release", Arrays.asList());
    }
  }

  static class $CameraHandler implements TypeChannelHandler<$Camera> {
    public $Camera onCreate(TypeChannelMessenger messenger, $CameraCreationArgs args)
        throws Exception {
      return null;
    }

    public Object $onGetAllCameraInfo(TypeChannelMessenger messenger)
        throws Exception {
      return null;
    }

    public Object $onOpen(TypeChannelMessenger messenger, Integer cameraId)
        throws Exception {
      return null;
    }

    @Override
    public Object invokeStaticMethod(
        TypeChannelMessenger messenger, String methodName, List<Object> arguments)
        throws Exception {
      switch (methodName) {
        case "getAllCameraInfo":
          return $onGetAllCameraInfo(messenger);
        case "open":
          return $onOpen(messenger, (Integer) arguments.get(0));
      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke static method %s", methodName));
    }

    @Override
    public List<Object> getCreationArguments(
        TypeChannelMessenger messenger, $Camera instance) {
      return Arrays.asList();
    }

    @Override
    public $Camera createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      final $CameraCreationArgs args = new $CameraCreationArgs();

      return onCreate(messenger, args);
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        $Camera instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      for (Method method : $Camera.class.getMethods()) {
        if (method.getName().equals(methodName)) {
          return method.invoke(instance, arguments.toArray());
        }
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }

  /*
    public interface $Channels {
      void registerHandlers();
      void unregisterHandlers();
      $ClassTemplateChannel getClassTemplateChannel();
    }*/
  static class $ShutterCallbackHandler implements TypeChannelHandler<$ShutterCallback> {
    public $ShutterCallback onCreate(TypeChannelMessenger messenger, $ShutterCallbackCreationArgs args)
        throws Exception {
      return null;
    }


    @Override
    public Object invokeStaticMethod(
        TypeChannelMessenger messenger, String methodName, List<Object> arguments)
        throws Exception {
      switch (methodName) {

      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke static method %s", methodName));
    }

    @Override
    public List<Object> getCreationArguments(
        TypeChannelMessenger messenger, $ShutterCallback instance) {
      return Arrays.asList();
    }

    @Override
    public $ShutterCallback createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      final $ShutterCallbackCreationArgs args = new $ShutterCallbackCreationArgs();

      return onCreate(messenger, args);
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        $ShutterCallback instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      for (Method method : $ShutterCallback.class.getMethods()) {
        if (method.getName().equals(methodName)) {
          return method.invoke(instance, arguments.toArray());
        }
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }

  /*
    public interface $Channels {
      void registerHandlers();
      void unregisterHandlers();
      $ClassTemplateChannel getClassTemplateChannel();
    }
   */
  static class $PictureCallbackHandler implements TypeChannelHandler<$PictureCallback> {
    public $PictureCallback onCreate(TypeChannelMessenger messenger, $PictureCallbackCreationArgs args)
        throws Exception {
      return null;
    }


    @Override
    public Object invokeStaticMethod(
        TypeChannelMessenger messenger, String methodName, List<Object> arguments)
        throws Exception {
      switch (methodName) {

      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke static method %s", methodName));
    }

    @Override
    public List<Object> getCreationArguments(
        TypeChannelMessenger messenger, $PictureCallback instance) {
      return Arrays.asList();
    }

    @Override
    public $PictureCallback createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      final $PictureCallbackCreationArgs args = new $PictureCallbackCreationArgs();

      return onCreate(messenger, args);
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        $PictureCallback instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      for (Method method : $PictureCallback.class.getMethods()) {
        if (method.getName().equals(methodName)) {
          return method.invoke(instance, arguments.toArray());
        }
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }

  /*
    public interface $Channels {
      void registerHandlers();
      void unregisterHandlers();
      $ClassTemplateChannel getClassTemplateChannel();
    }*/
  static class $CameraInfoHandler implements TypeChannelHandler<$CameraInfo> {
    public $CameraInfo onCreate(TypeChannelMessenger messenger, $CameraInfoCreationArgs args)
        throws Exception {
      return null;
    }


    @Override
    public Object invokeStaticMethod(
        TypeChannelMessenger messenger, String methodName, List<Object> arguments)
        throws Exception {
      switch (methodName) {

      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke static method %s", methodName));
    }

    @Override
    public List<Object> getCreationArguments(
        TypeChannelMessenger messenger, $CameraInfo instance) {
      return Arrays.asList(instance.getCameraId(), instance.getFacing(), instance.getOrientation());
    }

    @Override
    public $CameraInfo createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      final $CameraInfoCreationArgs args = new $CameraInfoCreationArgs();
      args.cameraId = (Integer) arguments.get(0);
      args.facing = (Integer) arguments.get(1);
      args.orientation = (Integer) arguments.get(2);
      return onCreate(messenger, args);
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        $CameraInfo instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      for (Method method : $CameraInfo.class.getMethods()) {
        if (method.getName().equals(methodName)) {
          return method.invoke(instance, arguments.toArray());
        }
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }

  /*
    public interface $Channels {
      void registerHandlers();
      void unregisterHandlers();
      $ClassTemplateChannel getClassTemplateChannel();
    }*/
  static class $MediaRecorderHandler implements TypeChannelHandler<$MediaRecorder> {
    public $MediaRecorder onCreate(TypeChannelMessenger messenger, $MediaRecorderCreationArgs args)
        throws Exception {
      return null;
    }


    @Override
    public Object invokeStaticMethod(
        TypeChannelMessenger messenger, String methodName, List<Object> arguments)
        throws Exception {
      switch (methodName) {

      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke static method %s", methodName));
    }

    @Override
    public List<Object> getCreationArguments(
        TypeChannelMessenger messenger, $MediaRecorder instance) {
      return Arrays.asList(instance.getCamera(), instance.getOutputFormat(), instance.getOutputFilePath(), instance.getVideoEncoder(), instance.getAudioSource(), instance.getAudioEncoder());
    }

    @Override
    public $MediaRecorder createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      final $MediaRecorderCreationArgs args = new $MediaRecorderCreationArgs();
      args.camera = ($Camera) arguments.get(0);
      args.outputFormat = (Integer) arguments.get(1);
      args.outputFilePath = (String) arguments.get(2);
      args.videoEncoder = (Integer) arguments.get(3);
      args.audioSource = (Integer) arguments.get(4);
      args.audioEncoder = (Integer) arguments.get(5);
      return onCreate(messenger, args);
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        $MediaRecorder instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      for (Method method : $MediaRecorder.class.getMethods()) {
        if (method.getName().equals(methodName)) {
          return method.invoke(instance, arguments.toArray());
        }
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }
/*
  public interface $Channels {
    void registerHandlers();
    void unregisterHandlers();
    $ClassTemplateChannel getClassTemplateChannel();
  }

 */
}
