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
  interface $Camera {
    Object release() throws Exception;

    Object startPreview() throws Exception;

    Object stopPreview() throws Exception;

    Object attachPreviewToTexture() throws Exception;

    Object releaseTexture() throws Exception;
  }

  interface $CameraInfo {
    Integer getCameraId();

    Integer getFacing();

    Integer getOrientation();


  }

  static class $CameraCreationArgs {

  }

  static class $CameraInfoCreationArgs {
    Integer cameraId;
    Integer facing;
    Integer orientation;
  }

  static class $CameraChannel extends TypeChannel<$Camera> {
    $CameraChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_camera/android/camera/Camera");
    }

    Completable<Object> $invokeGetAllCameraInfo() {
      return invokeStaticMethod("getAllCameraInfo", Arrays.<Object>asList());
    }

    Completable<Object> $invokeOpen(Integer cameraId) {
      return invokeStaticMethod("open", Arrays.<Object>asList(cameraId));
    }

    Completable<Object> $invokeRelease($Camera instance) {
      return invokeMethod(instance, "release", Arrays.<Object>asList());
    }

    Completable<Object> $invokeStartPreview($Camera instance) {
      return invokeMethod(instance, "startPreview", Arrays.<Object>asList());
    }

    Completable<Object> $invokeStopPreview($Camera instance) {
      return invokeMethod(instance, "stopPreview", Arrays.<Object>asList());
    }

    Completable<Object> $invokeAttachPreviewToTexture($Camera instance) {
      return invokeMethod(instance, "attachPreviewToTexture", Arrays.<Object>asList());
    }

    Completable<Object> $invokeReleaseTexture($Camera instance) {
      return invokeMethod(instance, "releaseTexture", Arrays.<Object>asList());
    }
  }

  static class $CameraInfoChannel extends TypeChannel<$CameraInfo> {
    $CameraInfoChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_camera/android/camera/CameraInfo");
    }


  }

  static class $CameraHandler implements TypeChannelHandler<$Camera> {
    $Camera onCreate(TypeChannelMessenger messenger, $CameraCreationArgs args)
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

    @Override
    public void onInstanceAdded(TypeChannelMessenger messenger, $Camera instance)
        throws Exception {
    }

    @Override
    public void onInstanceRemoved(TypeChannelMessenger messenger, $Camera instance)
        throws Exception {
    }
  }

  static class $CameraInfoHandler implements TypeChannelHandler<$CameraInfo> {
    $CameraInfo onCreate(TypeChannelMessenger messenger, $CameraInfoCreationArgs args)
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

    @Override
    public void onInstanceAdded(TypeChannelMessenger messenger, $CameraInfo instance)
        throws Exception {
    }

    @Override
    public void onInstanceRemoved(TypeChannelMessenger messenger, $CameraInfo instance)
        throws Exception {
    }
  }
}
