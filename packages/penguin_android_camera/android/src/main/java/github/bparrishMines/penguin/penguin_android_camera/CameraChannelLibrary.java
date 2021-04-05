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

  public interface $ShutterCallback {


    Object onShutter() throws Exception;
  }

  public interface $PictureCallback {


    Object onPictureTaken(byte[] data) throws Exception;
  }

  public interface $CameraInfo {
    Integer getCameraId();

    Integer getFacing();

    Integer getOrientation();


  }

  public interface $MediaRecorder {


    Object setCamera($Camera camera) throws Exception;

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
  }

  public interface $LibraryImplementations {
    $CameraChannel getCameraChannel();

    $ShutterCallbackChannel getShutterCallbackChannel();

    $PictureCallbackChannel getPictureCallbackChannel();

    $CameraInfoChannel getCameraInfoChannel();

    $MediaRecorderChannel getMediaRecorderChannel();

    $CameraHandler getCameraHandler();

    $ShutterCallbackHandler getShutterCallbackHandler();

    $PictureCallbackHandler getPictureCallbackHandler();

    $CameraInfoHandler getCameraInfoHandler();

    $MediaRecorderHandler getMediaRecorderHandler();
  }

  public static class $CameraCreationArgs {

  }

  static class $ShutterCallbackCreationArgs {

  }

  static class $PictureCallbackCreationArgs {

  }

  static class $CameraInfoCreationArgs {
    public Integer cameraId;
    public Integer facing;
    public Integer orientation;
  }

  static class $MediaRecorderCreationArgs {

  }

  public static class $CameraChannel extends TypeChannel<$Camera> {
    public $CameraChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/Camera");
    }

    public Completable<Object> $invokeGetAllCameraInfo() {
      return invokeStaticMethod("getAllCameraInfo", Arrays.asList());
    }

    public Completable<Object> $invokeOpen(Integer cameraId) {
      return invokeStaticMethod("open", Arrays.asList(cameraId));
    }

    public Completable<Object> $invokeRelease($Camera instance) {
      return invokeMethod(instance, "release", Arrays.asList());
    }

    public Completable<Object> $invokeStartPreview($Camera instance) {
      return invokeMethod(instance, "startPreview", Arrays.asList());
    }

    public Completable<Object> $invokeStopPreview($Camera instance) {
      return invokeMethod(instance, "stopPreview", Arrays.asList());
    }

    public Completable<Object> $invokeAttachPreviewTexture($Camera instance) {
      return invokeMethod(instance, "attachPreviewTexture", Arrays.asList());
    }

    public Completable<Object> $invokeReleasePreviewTexture($Camera instance) {
      return invokeMethod(instance, "releasePreviewTexture", Arrays.asList());
    }

    public Completable<Object> $invokeUnlock($Camera instance) {
      return invokeMethod(instance, "unlock", Arrays.asList());
    }

    public Completable<Object> $invokeTakePicture($Camera instance, $ShutterCallback shutter, $PictureCallback raw, $PictureCallback postView, $PictureCallback jpeg) {
      return invokeMethod(instance, "takePicture", Arrays.asList(shutter, raw, postView, jpeg));
    }
  }

  public static class $ShutterCallbackChannel extends TypeChannel<$ShutterCallback> {
    public $ShutterCallbackChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/ShutterCallback");
    }


    public Completable<Object> $invokeOnShutter($ShutterCallback instance) {
      return invokeMethod(instance, "onShutter", Arrays.asList());
    }
  }

  public static class $PictureCallbackChannel extends TypeChannel<$PictureCallback> {
    public $PictureCallbackChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/PictureCallback");
    }


    public Completable<Object> $invokeOnPictureTaken($PictureCallback instance, byte[] data) {
      return invokeMethod(instance, "onPictureTaken", Arrays.asList(data));
    }
  }

  public static class $CameraInfoChannel extends TypeChannel<$CameraInfo> {
    public $CameraInfoChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/CameraInfo");
    }


  }

  public static class $MediaRecorderChannel extends TypeChannel<$MediaRecorder> {
    public $MediaRecorderChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/MediaRecorder");
    }


    public Completable<Object> $invokeSetCamera($MediaRecorder instance, $Camera camera) {
      return invokeMethod(instance, "setCamera", Arrays.asList(camera));
    }

    public Completable<Object> $invokeSetVideoSource($MediaRecorder instance, Integer source) {
      return invokeMethod(instance, "setVideoSource", Arrays.asList(source));
    }

    public Completable<Object> $invokeSetOutputFilePath($MediaRecorder instance, String path) {
      return invokeMethod(instance, "setOutputFilePath", Arrays.asList(path));
    }

    public Completable<Object> $invokeSetOutputFormat($MediaRecorder instance, Integer format) {
      return invokeMethod(instance, "setOutputFormat", Arrays.asList(format));
    }

    public Completable<Object> $invokeSetVideoEncoder($MediaRecorder instance, Integer encoder) {
      return invokeMethod(instance, "setVideoEncoder", Arrays.asList(encoder));
    }

    public Completable<Object> $invokeSetAudioSource($MediaRecorder instance, Integer source) {
      return invokeMethod(instance, "setAudioSource", Arrays.asList(source));
    }

    public Completable<Object> $invokeSetAudioEncoder($MediaRecorder instance, Integer encoder) {
      return invokeMethod(instance, "setAudioEncoder", Arrays.asList(encoder));
    }

    public Completable<Object> $invokePrepare($MediaRecorder instance) {
      return invokeMethod(instance, "prepare", Arrays.asList());
    }

    public Completable<Object> $invokeStart($MediaRecorder instance) {
      return invokeMethod(instance, "start", Arrays.asList());
    }

    public Completable<Object> $invokeStop($MediaRecorder instance) {
      return invokeMethod(instance, "stop", Arrays.asList());
    }

    public Completable<Object> $invokeRelease($MediaRecorder instance) {
      return invokeMethod(instance, "release", Arrays.asList());
    }
  }

  public static class $CameraHandler implements TypeChannelHandler<$Camera> {
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

  public static class $ShutterCallbackHandler implements TypeChannelHandler<$ShutterCallback> {
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

  public static class $PictureCallbackHandler implements TypeChannelHandler<$PictureCallback> {
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

  public static class $CameraInfoHandler implements TypeChannelHandler<$CameraInfo> {
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

  public static class $MediaRecorderHandler implements TypeChannelHandler<$MediaRecorder> {
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
      return Arrays.asList();
    }

    @Override
    public $MediaRecorder createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      final $MediaRecorderCreationArgs args = new $MediaRecorderCreationArgs();

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

  public static class $ChannelRegistrar {
    public final $LibraryImplementations implementations;

    public $ChannelRegistrar($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    public void registerHandlers() {
      implementations.getCameraChannel().setHandler(implementations.getCameraHandler());
      implementations.getShutterCallbackChannel().setHandler(implementations.getShutterCallbackHandler());
      implementations.getPictureCallbackChannel().setHandler(implementations.getPictureCallbackHandler());
      implementations.getCameraInfoChannel().setHandler(implementations.getCameraInfoHandler());
      implementations.getMediaRecorderChannel().setHandler(implementations.getMediaRecorderHandler());
    }

    public void unregisterHandlers() {
      implementations.getCameraChannel().removeHandler();
      implementations.getShutterCallbackChannel().removeHandler();
      implementations.getPictureCallbackChannel().removeHandler();
      implementations.getCameraInfoChannel().removeHandler();
      implementations.getMediaRecorderChannel().removeHandler();
    }
  }
}
