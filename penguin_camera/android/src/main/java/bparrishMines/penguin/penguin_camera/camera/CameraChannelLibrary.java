// GENERATED CODE - DO NOT MODIFY BY HAND

package bparrishMines.penguin.penguin_camera.camera;

import androidx.annotation.NonNull;
import github.penguin.reference.async.Completable;
import github.penguin.reference.reference.TypeChannel;
import github.penguin.reference.reference.TypeChannelHandler;
import github.penguin.reference.reference.TypeChannelManager;
import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.List;

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
    $CameraChannel(@NonNull TypeChannelManager manager) {
      super(manager, "penguin_camera/android/camera/Camera");
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
    $CameraInfoChannel(@NonNull TypeChannelManager manager) {
      super(manager, "penguin_camera/android/camera/CameraInfo");
    }
}

  static class $CameraHandler implements TypeChannelHandler<$Camera> {
    $Camera onCreate(TypeChannelManager manager, $CameraCreationArgs args)
        throws Exception {
      return null;
    }

    public Object $onGetAllCameraInfo(TypeChannelManager manager)
        throws Exception {
      return null;
    }
public Object $onOpen(TypeChannelManager manager, Integer cameraId)
        throws Exception {
      return null;
    }

    @Override
    public Object invokeStaticMethod(
        TypeChannelManager manager, String methodName, List<Object> arguments)
        throws Exception {
      switch (methodName) {
        case "getAllCameraInfo":
          return $onGetAllCameraInfo(manager);
case "open":
          return $onOpen(manager, (Integer) arguments.get(0));
      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke static method %s", methodName));
    }

    @Override
    public List<Object> getCreationArguments(
        TypeChannelManager manager, $Camera instance) {
      return Arrays.<Object>asList();
    }

    @Override
    public $Camera createInstance(TypeChannelManager manager, List<Object> arguments)
        throws Exception {
      final $CameraCreationArgs args = new $CameraCreationArgs();
      
      return onCreate(manager, args);
    }

    @Override
    public Object invokeMethod(
        TypeChannelManager manager,
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
    public void onInstanceDisposed(TypeChannelManager manager, $Camera instance)
        throws Exception {}
  }
static class $CameraInfoHandler implements TypeChannelHandler<$CameraInfo> {
    $CameraInfo onCreate(TypeChannelManager manager, $CameraInfoCreationArgs args)
        throws Exception {
      return null;
    }

    

    @Override
    public Object invokeStaticMethod(
        TypeChannelManager manager, String methodName, List<Object> arguments)
        throws Exception {
      switch (methodName) {
        
      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke static method %s", methodName));
    }

    @Override
    public List<Object> getCreationArguments(
        TypeChannelManager manager, $CameraInfo instance) {
      return Arrays.<Object>asList(instance.getCameraId(),instance.getFacing(),instance.getOrientation());
    }

    @Override
    public $CameraInfo createInstance(TypeChannelManager manager, List<Object> arguments)
        throws Exception {
      final $CameraInfoCreationArgs args = new $CameraInfoCreationArgs();
      args.cameraId = (Integer) arguments.get(0);
args.facing = (Integer) arguments.get(1);
args.orientation = (Integer) arguments.get(2);
      return onCreate(manager, args);
    }

    @Override
    public Object invokeMethod(
        TypeChannelManager manager,
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
    public void onInstanceDisposed(TypeChannelManager manager, $CameraInfo instance)
        throws Exception {}
  }
}
