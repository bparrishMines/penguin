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

public class CameraChannelLibrary {
  public interface $Camera {
    

    Object release() throws Exception;
Object startPreview() throws Exception;
Object stopPreview() throws Exception;
Object attachPreviewTexture() throws Exception;
Object releasePreviewTexture() throws Exception;
Object unlock() throws Exception;
Object reconnect() throws Exception;
Object takePicture($ShutterCallback shutter,$PictureCallback raw,$PictureCallback postView,$PictureCallback jpeg) throws Exception;
Object autoFocus($AutoFocusCallback callback) throws Exception;
Object cancelAutoFocus() throws Exception;
Object setDisplayOrientation(Integer degrees) throws Exception;
Object setErrorCallback($ErrorCallback callback) throws Exception;
Object startSmoothZoom(Integer value) throws Exception;
Object stopSmoothZoom() throws Exception;
Object getParameters() throws Exception;
Object setParameters($CameraParameters parameters) throws Exception;
  }
public interface $CameraParameters {
    

    Object getAutoExposureLock() throws Exception;
Object getFocusAreas() throws Exception;
Object getFocusDistances() throws Exception;
Object getMaxExposureCompensation() throws Exception;
Object getMaxNumFocusAreas() throws Exception;
Object getMinExposureCompensation() throws Exception;
Object getSupportedFocusModes() throws Exception;
Object isAutoExposureLockSupported() throws Exception;
Object isZoomSupported() throws Exception;
Object setAutoExposureLock(Boolean toggle) throws Exception;
Object setExposureCompensation(Integer value) throws Exception;
Object setFocusAreas(List<$CameraArea> focusAreas) throws Exception;
Object setFocusMode(String value) throws Exception;
Object getFlashMode() throws Exception;
Object getMaxZoom() throws Exception;
Object getPictureSize() throws Exception;
Object getPreviewSize() throws Exception;
Object getSupportedPreviewSizes() throws Exception;
Object getSupportedPictureSizes() throws Exception;
Object getSupportedFlashModes() throws Exception;
Object getZoom() throws Exception;
Object isSmoothZoomSupported() throws Exception;
Object setFlashMode(String mode) throws Exception;
Object setPictureSize(Integer width,Integer height) throws Exception;
Object setRecordingHint(Boolean hint) throws Exception;
Object setRotation(Integer rotation) throws Exception;
Object setZoom(Integer value) throws Exception;
Object setPreviewSize(Integer width,Integer height) throws Exception;
Object getExposureCompensation() throws Exception;
Object getExposureCompensationStep() throws Exception;
  }
public interface $CameraArea {
    $CameraRect getRect();
Integer getWeight();
Boolean getCreateInstancePair();

    
  }
public interface $CameraRect {
    Integer getTop();
Integer getBottom();
Integer getRight();
Integer getLeft();
Boolean getCreateInstancePair();

    
  }
public interface $CameraSize {
    Integer getWidth();
Integer getHeight();

    Object toString() throws Exception;
  }
public interface $ErrorCallback {
    

    Object onError(Integer error) throws Exception;
  }
public interface $AutoFocusCallback {
    

    Object onAutoFocus(Boolean success) throws Exception;
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
Object pause() throws Exception;
Object resume() throws Exception;
  }

  public static class $CameraCreationArgs {
    
  }

static class $CameraParametersCreationArgs {
    
  }

static class $CameraAreaCreationArgs {
    public $CameraRect rect;
public Integer weight;
public Boolean createInstancePair;
  }

static class $CameraRectCreationArgs {
    public Integer top;
public Integer bottom;
public Integer right;
public Integer left;
public Boolean createInstancePair;
  }

static class $CameraSizeCreationArgs {
    public Integer width;
public Integer height;
  }

static class $ErrorCallbackCreationArgs {
    
  }

static class $AutoFocusCallbackCreationArgs {
    
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
      return invokeStaticMethod("getAllCameraInfo", Arrays.<Object>asList());
    }

public Completable<Object> $invokeOpen(Integer cameraId) {
      return invokeStaticMethod("open", Arrays.<Object>asList(cameraId));
    }

    public Completable<Object> $invokeRelease($Camera instance) {
      return invokeMethod(instance, "release", Arrays.<Object>asList());
    }

public Completable<Object> $invokeStartPreview($Camera instance) {
      return invokeMethod(instance, "startPreview", Arrays.<Object>asList());
    }

public Completable<Object> $invokeStopPreview($Camera instance) {
      return invokeMethod(instance, "stopPreview", Arrays.<Object>asList());
    }

public Completable<Object> $invokeAttachPreviewTexture($Camera instance) {
      return invokeMethod(instance, "attachPreviewTexture", Arrays.<Object>asList());
    }

public Completable<Object> $invokeReleasePreviewTexture($Camera instance) {
      return invokeMethod(instance, "releasePreviewTexture", Arrays.<Object>asList());
    }

public Completable<Object> $invokeUnlock($Camera instance) {
      return invokeMethod(instance, "unlock", Arrays.<Object>asList());
    }

public Completable<Object> $invokeReconnect($Camera instance) {
      return invokeMethod(instance, "reconnect", Arrays.<Object>asList());
    }

public Completable<Object> $invokeTakePicture($Camera instance, $ShutterCallback shutter , $PictureCallback raw , $PictureCallback postView , $PictureCallback jpeg) {
      return invokeMethod(instance, "takePicture", Arrays.<Object>asList(shutter, raw, postView, jpeg));
    }

public Completable<Object> $invokeAutoFocus($Camera instance, $AutoFocusCallback callback) {
      return invokeMethod(instance, "autoFocus", Arrays.<Object>asList(callback));
    }

public Completable<Object> $invokeCancelAutoFocus($Camera instance) {
      return invokeMethod(instance, "cancelAutoFocus", Arrays.<Object>asList());
    }

public Completable<Object> $invokeSetDisplayOrientation($Camera instance, Integer degrees) {
      return invokeMethod(instance, "setDisplayOrientation", Arrays.<Object>asList(degrees));
    }

public Completable<Object> $invokeSetErrorCallback($Camera instance, $ErrorCallback callback) {
      return invokeMethod(instance, "setErrorCallback", Arrays.<Object>asList(callback));
    }

public Completable<Object> $invokeStartSmoothZoom($Camera instance, Integer value) {
      return invokeMethod(instance, "startSmoothZoom", Arrays.<Object>asList(value));
    }

public Completable<Object> $invokeStopSmoothZoom($Camera instance) {
      return invokeMethod(instance, "stopSmoothZoom", Arrays.<Object>asList());
    }

public Completable<Object> $invokeGetParameters($Camera instance) {
      return invokeMethod(instance, "getParameters", Arrays.<Object>asList());
    }

public Completable<Object> $invokeSetParameters($Camera instance, $CameraParameters parameters) {
      return invokeMethod(instance, "setParameters", Arrays.<Object>asList(parameters));
    }
  }

public static class $CameraParametersChannel extends TypeChannel<$CameraParameters> {
    public $CameraParametersChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/CameraParameters");
    }

    

    public Completable<Object> $invokeGetAutoExposureLock($CameraParameters instance) {
      return invokeMethod(instance, "getAutoExposureLock", Arrays.<Object>asList());
    }

public Completable<Object> $invokeGetFocusAreas($CameraParameters instance) {
      return invokeMethod(instance, "getFocusAreas", Arrays.<Object>asList());
    }

public Completable<Object> $invokeGetFocusDistances($CameraParameters instance) {
      return invokeMethod(instance, "getFocusDistances", Arrays.<Object>asList());
    }

public Completable<Object> $invokeGetMaxExposureCompensation($CameraParameters instance) {
      return invokeMethod(instance, "getMaxExposureCompensation", Arrays.<Object>asList());
    }

public Completable<Object> $invokeGetMaxNumFocusAreas($CameraParameters instance) {
      return invokeMethod(instance, "getMaxNumFocusAreas", Arrays.<Object>asList());
    }

public Completable<Object> $invokeGetMinExposureCompensation($CameraParameters instance) {
      return invokeMethod(instance, "getMinExposureCompensation", Arrays.<Object>asList());
    }

public Completable<Object> $invokeGetSupportedFocusModes($CameraParameters instance) {
      return invokeMethod(instance, "getSupportedFocusModes", Arrays.<Object>asList());
    }

public Completable<Object> $invokeIsAutoExposureLockSupported($CameraParameters instance) {
      return invokeMethod(instance, "isAutoExposureLockSupported", Arrays.<Object>asList());
    }

public Completable<Object> $invokeIsZoomSupported($CameraParameters instance) {
      return invokeMethod(instance, "isZoomSupported", Arrays.<Object>asList());
    }

public Completable<Object> $invokeSetAutoExposureLock($CameraParameters instance, Boolean toggle) {
      return invokeMethod(instance, "setAutoExposureLock", Arrays.<Object>asList(toggle));
    }

public Completable<Object> $invokeSetExposureCompensation($CameraParameters instance, Integer value) {
      return invokeMethod(instance, "setExposureCompensation", Arrays.<Object>asList(value));
    }

public Completable<Object> $invokeSetFocusAreas($CameraParameters instance, List<$CameraArea> focusAreas) {
      return invokeMethod(instance, "setFocusAreas", Arrays.<Object>asList(focusAreas));
    }

public Completable<Object> $invokeSetFocusMode($CameraParameters instance, String value) {
      return invokeMethod(instance, "setFocusMode", Arrays.<Object>asList(value));
    }

public Completable<Object> $invokeGetFlashMode($CameraParameters instance) {
      return invokeMethod(instance, "getFlashMode", Arrays.<Object>asList());
    }

public Completable<Object> $invokeGetMaxZoom($CameraParameters instance) {
      return invokeMethod(instance, "getMaxZoom", Arrays.<Object>asList());
    }

public Completable<Object> $invokeGetPictureSize($CameraParameters instance) {
      return invokeMethod(instance, "getPictureSize", Arrays.<Object>asList());
    }

public Completable<Object> $invokeGetPreviewSize($CameraParameters instance) {
      return invokeMethod(instance, "getPreviewSize", Arrays.<Object>asList());
    }

public Completable<Object> $invokeGetSupportedPreviewSizes($CameraParameters instance) {
      return invokeMethod(instance, "getSupportedPreviewSizes", Arrays.<Object>asList());
    }

public Completable<Object> $invokeGetSupportedPictureSizes($CameraParameters instance) {
      return invokeMethod(instance, "getSupportedPictureSizes", Arrays.<Object>asList());
    }

public Completable<Object> $invokeGetSupportedFlashModes($CameraParameters instance) {
      return invokeMethod(instance, "getSupportedFlashModes", Arrays.<Object>asList());
    }

public Completable<Object> $invokeGetZoom($CameraParameters instance) {
      return invokeMethod(instance, "getZoom", Arrays.<Object>asList());
    }

public Completable<Object> $invokeIsSmoothZoomSupported($CameraParameters instance) {
      return invokeMethod(instance, "isSmoothZoomSupported", Arrays.<Object>asList());
    }

public Completable<Object> $invokeSetFlashMode($CameraParameters instance, String mode) {
      return invokeMethod(instance, "setFlashMode", Arrays.<Object>asList(mode));
    }

public Completable<Object> $invokeSetPictureSize($CameraParameters instance, Integer width , Integer height) {
      return invokeMethod(instance, "setPictureSize", Arrays.<Object>asList(width, height));
    }

public Completable<Object> $invokeSetRecordingHint($CameraParameters instance, Boolean hint) {
      return invokeMethod(instance, "setRecordingHint", Arrays.<Object>asList(hint));
    }

public Completable<Object> $invokeSetRotation($CameraParameters instance, Integer rotation) {
      return invokeMethod(instance, "setRotation", Arrays.<Object>asList(rotation));
    }

public Completable<Object> $invokeSetZoom($CameraParameters instance, Integer value) {
      return invokeMethod(instance, "setZoom", Arrays.<Object>asList(value));
    }

public Completable<Object> $invokeSetPreviewSize($CameraParameters instance, Integer width , Integer height) {
      return invokeMethod(instance, "setPreviewSize", Arrays.<Object>asList(width, height));
    }

public Completable<Object> $invokeGetExposureCompensation($CameraParameters instance) {
      return invokeMethod(instance, "getExposureCompensation", Arrays.<Object>asList());
    }

public Completable<Object> $invokeGetExposureCompensationStep($CameraParameters instance) {
      return invokeMethod(instance, "getExposureCompensationStep", Arrays.<Object>asList());
    }
  }

public static class $CameraAreaChannel extends TypeChannel<$CameraArea> {
    public $CameraAreaChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/CameraArea");
    }

    

    
  }

public static class $CameraRectChannel extends TypeChannel<$CameraRect> {
    public $CameraRectChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/CameraArea");
    }

    

    
  }

public static class $CameraSizeChannel extends TypeChannel<$CameraSize> {
    public $CameraSizeChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/CameraSize");
    }

    

    public Completable<Object> $invokeToString($CameraSize instance) {
      return invokeMethod(instance, "toString", Arrays.<Object>asList());
    }
  }

public static class $ErrorCallbackChannel extends TypeChannel<$ErrorCallback> {
    public $ErrorCallbackChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/ErrorCallback");
    }

    

    public Completable<Object> $invokeOnError($ErrorCallback instance, Integer error) {
      return invokeMethod(instance, "onError", Arrays.<Object>asList(error));
    }
  }

public static class $AutoFocusCallbackChannel extends TypeChannel<$AutoFocusCallback> {
    public $AutoFocusCallbackChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/AutoFocusCallback");
    }

    

    public Completable<Object> $invokeOnAutoFocus($AutoFocusCallback instance, Boolean success) {
      return invokeMethod(instance, "onAutoFocus", Arrays.<Object>asList(success));
    }
  }

public static class $ShutterCallbackChannel extends TypeChannel<$ShutterCallback> {
    public $ShutterCallbackChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/ShutterCallback");
    }

    

    public Completable<Object> $invokeOnShutter($ShutterCallback instance) {
      return invokeMethod(instance, "onShutter", Arrays.<Object>asList());
    }
  }

public static class $PictureCallbackChannel extends TypeChannel<$PictureCallback> {
    public $PictureCallbackChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/PictureCallback");
    }

    

    public Completable<Object> $invokeOnPictureTaken($PictureCallback instance, byte[] data) {
      return invokeMethod(instance, "onPictureTaken", Arrays.<Object>asList(data));
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
      return invokeMethod(instance, "setCamera", Arrays.<Object>asList(camera));
    }

public Completable<Object> $invokeSetVideoSource($MediaRecorder instance, Integer source) {
      return invokeMethod(instance, "setVideoSource", Arrays.<Object>asList(source));
    }

public Completable<Object> $invokeSetOutputFilePath($MediaRecorder instance, String path) {
      return invokeMethod(instance, "setOutputFilePath", Arrays.<Object>asList(path));
    }

public Completable<Object> $invokeSetOutputFormat($MediaRecorder instance, Integer format) {
      return invokeMethod(instance, "setOutputFormat", Arrays.<Object>asList(format));
    }

public Completable<Object> $invokeSetVideoEncoder($MediaRecorder instance, Integer encoder) {
      return invokeMethod(instance, "setVideoEncoder", Arrays.<Object>asList(encoder));
    }

public Completable<Object> $invokeSetAudioSource($MediaRecorder instance, Integer source) {
      return invokeMethod(instance, "setAudioSource", Arrays.<Object>asList(source));
    }

public Completable<Object> $invokeSetAudioEncoder($MediaRecorder instance, Integer encoder) {
      return invokeMethod(instance, "setAudioEncoder", Arrays.<Object>asList(encoder));
    }

public Completable<Object> $invokePrepare($MediaRecorder instance) {
      return invokeMethod(instance, "prepare", Arrays.<Object>asList());
    }

public Completable<Object> $invokeStart($MediaRecorder instance) {
      return invokeMethod(instance, "start", Arrays.<Object>asList());
    }

public Completable<Object> $invokeStop($MediaRecorder instance) {
      return invokeMethod(instance, "stop", Arrays.<Object>asList());
    }

public Completable<Object> $invokeRelease($MediaRecorder instance) {
      return invokeMethod(instance, "release", Arrays.<Object>asList());
    }

public Completable<Object> $invokePause($MediaRecorder instance) {
      return invokeMethod(instance, "pause", Arrays.<Object>asList());
    }

public Completable<Object> $invokeResume($MediaRecorder instance) {
      return invokeMethod(instance, "resume", Arrays.<Object>asList());
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
  }
public static class $CameraParametersHandler implements TypeChannelHandler<$CameraParameters> {
    public $CameraParameters onCreate(TypeChannelMessenger messenger, $CameraParametersCreationArgs args)
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
        TypeChannelMessenger messenger, $CameraParameters instance) {
      return Arrays.<Object>asList();
    }

    @Override
    public $CameraParameters createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      final $CameraParametersCreationArgs args = new $CameraParametersCreationArgs();
      
      return onCreate(messenger, args);
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        $CameraParameters instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      for (Method method : $CameraParameters.class.getMethods()) {
        if (method.getName().equals(methodName)) {
          return method.invoke(instance, arguments.toArray());
        }
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }
public static class $CameraAreaHandler implements TypeChannelHandler<$CameraArea> {
    public $CameraArea onCreate(TypeChannelMessenger messenger, $CameraAreaCreationArgs args)
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
        TypeChannelMessenger messenger, $CameraArea instance) {
      return Arrays.<Object>asList(instance.getRect(),instance.getWeight(),instance.getCreateInstancePair());
    }

    @Override
    public $CameraArea createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      final $CameraAreaCreationArgs args = new $CameraAreaCreationArgs();
      args.rect = ($CameraRect) arguments.get(0);
args.weight = (Integer) arguments.get(1);
args.createInstancePair = (Boolean) arguments.get(2);
      return onCreate(messenger, args);
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        $CameraArea instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      for (Method method : $CameraArea.class.getMethods()) {
        if (method.getName().equals(methodName)) {
          return method.invoke(instance, arguments.toArray());
        }
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }
public static class $CameraRectHandler implements TypeChannelHandler<$CameraRect> {
    public $CameraRect onCreate(TypeChannelMessenger messenger, $CameraRectCreationArgs args)
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
        TypeChannelMessenger messenger, $CameraRect instance) {
      return Arrays.<Object>asList(instance.getTop(),instance.getBottom(),instance.getRight(),instance.getLeft(),instance.getCreateInstancePair());
    }

    @Override
    public $CameraRect createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      final $CameraRectCreationArgs args = new $CameraRectCreationArgs();
      args.top = (Integer) arguments.get(0);
args.bottom = (Integer) arguments.get(1);
args.right = (Integer) arguments.get(2);
args.left = (Integer) arguments.get(3);
args.createInstancePair = (Boolean) arguments.get(4);
      return onCreate(messenger, args);
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        $CameraRect instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      for (Method method : $CameraRect.class.getMethods()) {
        if (method.getName().equals(methodName)) {
          return method.invoke(instance, arguments.toArray());
        }
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }
public static class $CameraSizeHandler implements TypeChannelHandler<$CameraSize> {
    public $CameraSize onCreate(TypeChannelMessenger messenger, $CameraSizeCreationArgs args)
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
        TypeChannelMessenger messenger, $CameraSize instance) {
      return Arrays.<Object>asList(instance.getWidth(),instance.getHeight());
    }

    @Override
    public $CameraSize createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      final $CameraSizeCreationArgs args = new $CameraSizeCreationArgs();
      args.width = (Integer) arguments.get(0);
args.height = (Integer) arguments.get(1);
      return onCreate(messenger, args);
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        $CameraSize instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      for (Method method : $CameraSize.class.getMethods()) {
        if (method.getName().equals(methodName)) {
          return method.invoke(instance, arguments.toArray());
        }
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }
public static class $ErrorCallbackHandler implements TypeChannelHandler<$ErrorCallback> {
    public $ErrorCallback onCreate(TypeChannelMessenger messenger, $ErrorCallbackCreationArgs args)
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
        TypeChannelMessenger messenger, $ErrorCallback instance) {
      return Arrays.<Object>asList();
    }

    @Override
    public $ErrorCallback createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      final $ErrorCallbackCreationArgs args = new $ErrorCallbackCreationArgs();
      
      return onCreate(messenger, args);
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        $ErrorCallback instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      for (Method method : $ErrorCallback.class.getMethods()) {
        if (method.getName().equals(methodName)) {
          return method.invoke(instance, arguments.toArray());
        }
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }
public static class $AutoFocusCallbackHandler implements TypeChannelHandler<$AutoFocusCallback> {
    public $AutoFocusCallback onCreate(TypeChannelMessenger messenger, $AutoFocusCallbackCreationArgs args)
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
        TypeChannelMessenger messenger, $AutoFocusCallback instance) {
      return Arrays.<Object>asList();
    }

    @Override
    public $AutoFocusCallback createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      final $AutoFocusCallbackCreationArgs args = new $AutoFocusCallbackCreationArgs();
      
      return onCreate(messenger, args);
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        $AutoFocusCallback instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      for (Method method : $AutoFocusCallback.class.getMethods()) {
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
      return Arrays.<Object>asList();
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

  public static class $LibraryImplementations {
    public final TypeChannelMessenger messenger;

    public $LibraryImplementations(TypeChannelMessenger messenger) {
      this.messenger = messenger;
    }

    public $CameraChannel getCameraChannel() {
      return new $CameraChannel(messenger);
    }
public $CameraParametersChannel getCameraParametersChannel() {
      return new $CameraParametersChannel(messenger);
    }
public $CameraAreaChannel getCameraAreaChannel() {
      return new $CameraAreaChannel(messenger);
    }
public $CameraRectChannel getCameraRectChannel() {
      return new $CameraRectChannel(messenger);
    }
public $CameraSizeChannel getCameraSizeChannel() {
      return new $CameraSizeChannel(messenger);
    }
public $ErrorCallbackChannel getErrorCallbackChannel() {
      return new $ErrorCallbackChannel(messenger);
    }
public $AutoFocusCallbackChannel getAutoFocusCallbackChannel() {
      return new $AutoFocusCallbackChannel(messenger);
    }
public $ShutterCallbackChannel getShutterCallbackChannel() {
      return new $ShutterCallbackChannel(messenger);
    }
public $PictureCallbackChannel getPictureCallbackChannel() {
      return new $PictureCallbackChannel(messenger);
    }
public $CameraInfoChannel getCameraInfoChannel() {
      return new $CameraInfoChannel(messenger);
    }
public $MediaRecorderChannel getMediaRecorderChannel() {
      return new $MediaRecorderChannel(messenger);
    }

    public $CameraHandler getCameraHandler() {
      return new $CameraHandler();
    }
public $CameraParametersHandler getCameraParametersHandler() {
      return new $CameraParametersHandler();
    }
public $CameraAreaHandler getCameraAreaHandler() {
      return new $CameraAreaHandler();
    }
public $CameraRectHandler getCameraRectHandler() {
      return new $CameraRectHandler();
    }
public $CameraSizeHandler getCameraSizeHandler() {
      return new $CameraSizeHandler();
    }
public $ErrorCallbackHandler getErrorCallbackHandler() {
      return new $ErrorCallbackHandler();
    }
public $AutoFocusCallbackHandler getAutoFocusCallbackHandler() {
      return new $AutoFocusCallbackHandler();
    }
public $ShutterCallbackHandler getShutterCallbackHandler() {
      return new $ShutterCallbackHandler();
    }
public $PictureCallbackHandler getPictureCallbackHandler() {
      return new $PictureCallbackHandler();
    }
public $CameraInfoHandler getCameraInfoHandler() {
      return new $CameraInfoHandler();
    }
public $MediaRecorderHandler getMediaRecorderHandler() {
      return new $MediaRecorderHandler();
    }
  }

  public static class $ChannelRegistrar {
    public final $LibraryImplementations implementations;

    public $ChannelRegistrar($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    public void registerHandlers() {
      implementations.getCameraChannel().setHandler(implementations.getCameraHandler());
implementations.getCameraParametersChannel().setHandler(implementations.getCameraParametersHandler());
implementations.getCameraAreaChannel().setHandler(implementations.getCameraAreaHandler());
implementations.getCameraRectChannel().setHandler(implementations.getCameraRectHandler());
implementations.getCameraSizeChannel().setHandler(implementations.getCameraSizeHandler());
implementations.getErrorCallbackChannel().setHandler(implementations.getErrorCallbackHandler());
implementations.getAutoFocusCallbackChannel().setHandler(implementations.getAutoFocusCallbackHandler());
implementations.getShutterCallbackChannel().setHandler(implementations.getShutterCallbackHandler());
implementations.getPictureCallbackChannel().setHandler(implementations.getPictureCallbackHandler());
implementations.getCameraInfoChannel().setHandler(implementations.getCameraInfoHandler());
implementations.getMediaRecorderChannel().setHandler(implementations.getMediaRecorderHandler());
    }

    public void unregisterHandlers() {
      implementations.getCameraChannel().removeHandler();
implementations.getCameraParametersChannel().removeHandler();
implementations.getCameraAreaChannel().removeHandler();
implementations.getCameraRectChannel().removeHandler();
implementations.getCameraSizeChannel().removeHandler();
implementations.getErrorCallbackChannel().removeHandler();
implementations.getAutoFocusCallbackChannel().removeHandler();
implementations.getShutterCallbackChannel().removeHandler();
implementations.getPictureCallbackChannel().removeHandler();
implementations.getCameraInfoChannel().removeHandler();
implementations.getMediaRecorderChannel().removeHandler();
    }
  }
}
