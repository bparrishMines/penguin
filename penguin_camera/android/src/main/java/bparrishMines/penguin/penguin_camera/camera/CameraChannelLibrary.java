// GENERATED CODE - DO NOT MODIFY BY HAND

package bparrishMines.penguin.penguin_camera.camera;

import androidx.annotation.NonNull;
import github.penguin.reference.async.Completable;
import github.penguin.reference.reference.ReferenceChannel;
import github.penguin.reference.reference.ReferenceChannelHandler;
import github.penguin.reference.reference.ReferenceChannelManager;
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

  static class $CameraChannel extends ReferenceChannel<$Camera> {
    $CameraChannel(@NonNull ReferenceChannelManager manager) {
      super(manager, "penguin_camera/android/camera/Camera");
    }

    Completable<Object> $invokeGetAllCameraInfo() {
      return invokeStaticMethod("getAllCameraInfo", Arrays.<Object>asList());
    }

Completable<Object> $invokeOpen(Integer cameraId) {
      return invokeStaticMethod("open", Arrays.<Object>asList(cameraId));
    }

    Completable<Object> $invokeRelease($Camera instance) {
      final String $methodName = "release";
      final List<Object> $arguments = Arrays.<Object>asList();

      if (manager.isPaired(instance)) return invokeMethod(instance, $methodName, $arguments);
      return invokeMethodOnUnpairedReference(instance, $methodName, $arguments);
    }

Completable<Object> $invokeStartPreview($Camera instance) {
      final String $methodName = "startPreview";
      final List<Object> $arguments = Arrays.<Object>asList();

      if (manager.isPaired(instance)) return invokeMethod(instance, $methodName, $arguments);
      return invokeMethodOnUnpairedReference(instance, $methodName, $arguments);
    }

Completable<Object> $invokeStopPreview($Camera instance) {
      final String $methodName = "stopPreview";
      final List<Object> $arguments = Arrays.<Object>asList();

      if (manager.isPaired(instance)) return invokeMethod(instance, $methodName, $arguments);
      return invokeMethodOnUnpairedReference(instance, $methodName, $arguments);
    }

Completable<Object> $invokeAttachPreviewToTexture($Camera instance) {
      final String $methodName = "attachPreviewToTexture";
      final List<Object> $arguments = Arrays.<Object>asList();

      if (manager.isPaired(instance)) return invokeMethod(instance, $methodName, $arguments);
      return invokeMethodOnUnpairedReference(instance, $methodName, $arguments);
    }

Completable<Object> $invokeReleaseTexture($Camera instance) {
      final String $methodName = "releaseTexture";
      final List<Object> $arguments = Arrays.<Object>asList();

      if (manager.isPaired(instance)) return invokeMethod(instance, $methodName, $arguments);
      return invokeMethodOnUnpairedReference(instance, $methodName, $arguments);
    }
  }

static class $CameraInfoChannel extends ReferenceChannel<$CameraInfo> {
    $CameraInfoChannel(@NonNull ReferenceChannelManager manager) {
      super(manager, "penguin_camera/android/camera/CameraInfo");
    }

    

    
  }

  static class $CameraHandler implements ReferenceChannelHandler<$Camera> {
    $Camera onCreate(ReferenceChannelManager manager, $CameraCreationArgs args)
        throws Exception {
      return null;
    }

    public Object $onGetAllCameraInfo(ReferenceChannelManager manager)
        throws Exception {
      return null;
    }
public Object $onOpen(ReferenceChannelManager manager, Integer cameraId)
        throws Exception {
      return null;
    }

    @Override
    public Object invokeStaticMethod(
        ReferenceChannelManager manager, String methodName, List<Object> arguments)
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
        ReferenceChannelManager manager, $Camera instance) {
      return Arrays.<Object>asList();
    }

    @Override
    public $Camera createInstance(ReferenceChannelManager manager, List<Object> arguments)
        throws Exception {
      final $CameraCreationArgs args = new $CameraCreationArgs();
      
      return onCreate(manager, args);
    }

    @Override
    public Object invokeMethod(
        ReferenceChannelManager manager,
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
    public void onInstanceDisposed(ReferenceChannelManager manager, $Camera instance)
        throws Exception {}
  }
static class $CameraInfoHandler implements ReferenceChannelHandler<$CameraInfo> {
    $CameraInfo onCreate(ReferenceChannelManager manager, $CameraInfoCreationArgs args)
        throws Exception {
      return null;
    }

    

    @Override
    public Object invokeStaticMethod(
        ReferenceChannelManager manager, String methodName, List<Object> arguments)
        throws Exception {
      switch (methodName) {
        
      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke static method %s", methodName));
    }

    @Override
    public List<Object> getCreationArguments(
        ReferenceChannelManager manager, $CameraInfo instance) {
      return Arrays.<Object>asList(instance.getCameraId(),instance.getFacing(),instance.getOrientation());
    }

    @Override
    public $CameraInfo createInstance(ReferenceChannelManager manager, List<Object> arguments)
        throws Exception {
      final $CameraInfoCreationArgs args = new $CameraInfoCreationArgs();
      args.cameraId = (Integer) arguments.get(0);
args.facing = (Integer) arguments.get(1);
args.orientation = (Integer) arguments.get(2);
      return onCreate(manager, args);
    }

    @Override
    public Object invokeMethod(
        ReferenceChannelManager manager,
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
    public void onInstanceDisposed(ReferenceChannelManager manager, $CameraInfo instance)
        throws Exception {}
  }
}
