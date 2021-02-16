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
Object attachPreviewTexture() throws Exception;
Object releasePreviewTexture() throws Exception;
Object unlock() throws Exception;
Object takePicture($ShutterCallback shutter,$PictureCallback raw,$PictureCallback postView,$PictureCallback jpeg) throws Exception;
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

    Object prepare() throws Exception;
Object start() throws Exception;
Object stop() throws Exception;
Object release() throws Exception;
  }

  static class $CameraCreationArgs {
    
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
  }

  static class $CameraChannel extends TypeChannel<$Camera> {
    $CameraChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/Camera");
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

Completable<Object> $invokeAttachPreviewTexture($Camera instance) {
      return invokeMethod(instance, "attachPreviewTexture", Arrays.<Object>asList());
    }

Completable<Object> $invokeReleasePreviewTexture($Camera instance) {
      return invokeMethod(instance, "releasePreviewTexture", Arrays.<Object>asList());
    }

Completable<Object> $invokeUnlock($Camera instance) {
      return invokeMethod(instance, "unlock", Arrays.<Object>asList());
    }

Completable<Object> $invokeTakePicture($Camera instance, $ShutterCallback shutter , $PictureCallback raw , $PictureCallback postView , $PictureCallback jpeg) {
      return invokeMethod(instance, "takePicture", Arrays.<Object>asList(shutter, raw, postView, jpeg));
    }
  }

static class $ShutterCallbackChannel extends TypeChannel<$ShutterCallback> {
    $ShutterCallbackChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/ShutterCallback");
    }

    

    Completable<Object> $invokeOnShutter($ShutterCallback instance) {
      return invokeMethod(instance, "onShutter", Arrays.<Object>asList());
    }
  }

static class $PictureCallbackChannel extends TypeChannel<$PictureCallback> {
    $PictureCallbackChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/PictureCallback");
    }

    

    Completable<Object> $invokeOnPictureTaken($PictureCallback instance, byte[] data) {
      return invokeMethod(instance, "onPictureTaken", Arrays.<Object>asList(data));
    }
  }

static class $CameraInfoChannel extends TypeChannel<$CameraInfo> {
    $CameraInfoChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/CameraInfo");
    }

    

    
  }

static class $MediaRecorderChannel extends TypeChannel<$MediaRecorder> {
    $MediaRecorderChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/MediaRecorder");
    }

    

    Completable<Object> $invokePrepare($MediaRecorder instance) {
      return invokeMethod(instance, "prepare", Arrays.<Object>asList());
    }

Completable<Object> $invokeStart($MediaRecorder instance) {
      return invokeMethod(instance, "start", Arrays.<Object>asList());
    }

Completable<Object> $invokeStop($MediaRecorder instance) {
      return invokeMethod(instance, "stop", Arrays.<Object>asList());
    }

Completable<Object> $invokeRelease($MediaRecorder instance) {
      return invokeMethod(instance, "release", Arrays.<Object>asList());
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
      return Arrays.<Object>asList();
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
static class $ShutterCallbackHandler implements TypeChannelHandler<$ShutterCallback> {
    $ShutterCallback onCreate(TypeChannelMessenger messenger, $ShutterCallbackCreationArgs args)
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
      return Arrays.<Object>asList();
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

    @Override
    public void onInstanceAdded(TypeChannelMessenger messenger, $ShutterCallback instance)
        throws Exception {
    }

    @Override
    public void onInstanceRemoved(TypeChannelMessenger messenger, $ShutterCallback instance)
        throws Exception {
    }
  }
static class $PictureCallbackHandler implements TypeChannelHandler<$PictureCallback> {
    $PictureCallback onCreate(TypeChannelMessenger messenger, $PictureCallbackCreationArgs args)
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
      return Arrays.<Object>asList();
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

    @Override
    public void onInstanceAdded(TypeChannelMessenger messenger, $PictureCallback instance)
        throws Exception {
    }

    @Override
    public void onInstanceRemoved(TypeChannelMessenger messenger, $PictureCallback instance)
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
      return Arrays.<Object>asList(instance.getCameraId(),instance.getFacing(),instance.getOrientation());
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
static class $MediaRecorderHandler implements TypeChannelHandler<$MediaRecorder> {
    $MediaRecorder onCreate(TypeChannelMessenger messenger, $MediaRecorderCreationArgs args)
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
      return Arrays.<Object>asList(instance.getCamera(),instance.getOutputFormat(),instance.getOutputFilePath(),instance.getVideoEncoder());
    }

    @Override
    public $MediaRecorder createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      final $MediaRecorderCreationArgs args = new $MediaRecorderCreationArgs();
      args.camera = ($Camera) arguments.get(0);
args.outputFormat = (Integer) arguments.get(1);
args.outputFilePath = (String) arguments.get(2);
args.videoEncoder = (Integer) arguments.get(3);
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

    @Override
    public void onInstanceAdded(TypeChannelMessenger messenger, $MediaRecorder instance)
        throws Exception {
    }

    @Override
    public void onInstanceRemoved(TypeChannelMessenger messenger, $MediaRecorder instance)
        throws Exception {
    }
  }
}
