// GENERATED CODE - DO NOT MODIFY BY HAND


package github.bparrishMines.penguin.penguin_android_camera;


import androidx.annotation.NonNull;

import java.util.Arrays;
import java.util.List;

import github.penguin.reference.async.Completable;
import github.penguin.reference.reference.PairedInstance;
import github.penguin.reference.reference.TypeChannel;
import github.penguin.reference.reference.TypeChannelHandler;
import github.penguin.reference.reference.TypeChannelMessenger;

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

public class CameraChannelLibrary {
  
  public interface $Camera {
    
    
    Object release() throws Exception;
    
    
    
    Object startPreview();
    
    
    
    Object stopPreview();
    
    
    
    Object attachPreviewTexture();
    
    
    
    Object releasePreviewTexture();
    
    
    
    Object unlock();
    
    
    
    Object reconnect();
    
    
    
    Object takePicture($ShutterCallback shutter,$PictureCallback raw,$PictureCallback postView,$PictureCallback jpeg);
    
    
    
    Object autoFocus($AutoFocusCallback callback);
    
    
    
    Object cancelAutoFocus();
    
    
    
    Object setDisplayOrientation(Integer degrees);
    
    
    
    Object setErrorCallback($ErrorCallback callback);
    
    
    
    Object startSmoothZoom(Integer value);
    
    
    
    Object stopSmoothZoom();
    
    
    
    Object getParameters();
    
    
    
    Object setParameters($CameraParameters parameters);
    
    
  }
  
  public interface $CameraParameters {
    
    
    Object getAutoExposureLock();
    
    
    
    Object getFocusAreas();
    
    
    
    Object getFocusDistances();
    
    
    
    Object getMaxExposureCompensation();
    
    
    
    Object getMaxNumFocusAreas();
    
    
    
    Object getMinExposureCompensation();
    
    
    
    Object getSupportedFocusModes();
    
    
    
    Object isAutoExposureLockSupported();
    
    
    
    Object isZoomSupported();
    
    
    
    Object setAutoExposureLock(Boolean toggle);
    
    
    
    Object setExposureCompensation(Integer value);
    
    
    
    Object setFocusAreas(List<$CameraArea> focusAreas);
    
    
    
    Object setFocusMode(String value);
    
    
    
    Object getFlashMode();
    
    
    
    Object getMaxZoom();
    
    
    
    Object getPictureSize();
    
    
    
    Object getPreviewSize();
    
    
    
    Object getSupportedPreviewSizes();
    
    
    
    Object getSupportedPictureSizes();
    
    
    
    Object getSupportedFlashModes();
    
    
    
    Object getZoom();
    
    
    
    Object isSmoothZoomSupported();
    
    
    
    Object setFlashMode(String mode);
    
    
    
    Object setPictureSize(Integer width,Integer height);
    
    
    
    Object setRecordingHint(Boolean hint);
    
    
    
    Object setRotation(Integer rotation);
    
    
    
    Object setZoom(Integer value);
    
    
    
    Object setPreviewSize(Integer width,Integer height);
    
    
    
    Object getExposureCompensation();
    
    
    
    Object getExposureCompensationStep();
    
    
  }
  
  public interface $CameraArea {
    
  }
  
  public interface $CameraRect {
    
  }
  
  public interface $CameraSize {
    
  }
  
  public interface $ErrorCallback {
    
    
    
  }
  
  public interface $AutoFocusCallback {
    
    
    
  }
  
  public interface $ShutterCallback {
    
    
    
  }
  
  public interface $PictureCallback {
    
    
    
  }
  
  public interface $CameraInfo {
    
  }
  
  public interface $MediaRecorder {
    
    
    Object setCamera($Camera camera);
    
    
    
    Object setVideoSource(Integer source);
    
    
    
    Object setOutputFilePath(String path);
    
    
    
    Object setOutputFormat(Integer format);
    
    
    
    Object setVideoEncoder(Integer encoder);
    
    
    
    Object setAudioSource(Integer source);
    
    
    
    Object setAudioEncoder(Integer encoder);
    
    
    
    Object prepare();
    
    
    
    Object start();
    
    
    
    Object stop();
    
    
    
    Object release();
    
    
    
    Object pause();
    
    
    
    Object resume();
    
    
  }
  

  
  public static class $CameraChannel extends TypeChannel<$Camera> {
    public $CameraChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/Camera");
    }

    public Completable<PairedInstance> $$create($Camera $instance, boolean $owner) {
      return createNewInstancePair($instance, Arrays.<Object>asList(), $owner);
    }

    
    
    
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  }
  
  public static class $CameraParametersChannel extends TypeChannel<$CameraParameters> {
    public $CameraParametersChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/CameraParameters");
    }

    public Completable<PairedInstance> $$create($CameraParameters $instance, boolean $owner) {
      return createNewInstancePair($instance, Arrays.<Object>asList(), $owner);
    }

    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  }
  
  public static class $CameraAreaChannel extends TypeChannel<$CameraArea> {
    public $CameraAreaChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/CameraArea");
    }

    public Completable<PairedInstance> $$create($CameraArea $instance, boolean $owner,$CameraRect rect,Integer weight) {
      return createNewInstancePair($instance, Arrays.<Object>asList(rect,weight), $owner);
    }

    

    
  }
  
  public static class $CameraRectChannel extends TypeChannel<$CameraRect> {
    public $CameraRectChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/CameraArea");
    }

    public Completable<PairedInstance> $$create($CameraRect $instance, boolean $owner,Integer top,Integer bottom,Integer right,Integer left) {
      return createNewInstancePair($instance, Arrays.<Object>asList(top,bottom,right,left), $owner);
    }

    

    
  }
  
  public static class $CameraSizeChannel extends TypeChannel<$CameraSize> {
    public $CameraSizeChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/CameraSize");
    }

    public Completable<PairedInstance> $$create($CameraSize $instance, boolean $owner,Integer width,Integer height) {
      return createNewInstancePair($instance, Arrays.<Object>asList(width,height), $owner);
    }

    

    
  }
  
  public static class $ErrorCallbackChannel extends TypeChannel<$ErrorCallback> {
    public $ErrorCallbackChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/ErrorCallback");
    }

    public Completable<PairedInstance> $$create($ErrorCallback $instance, boolean $owner) {
      return createNewInstancePair($instance, Arrays.<Object>asList(), $owner);
    }

    

    
    
    public Completable<Object> $onError($ErrorCallback $instance,Integer error) {
      return invokeMethod($instance, "onError", Arrays.<Object>asList(error));
    }
    
    
  }
  
  public static class $AutoFocusCallbackChannel extends TypeChannel<$AutoFocusCallback> {
    public $AutoFocusCallbackChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/AutoFocusCallback");
    }

    public Completable<PairedInstance> $$create($AutoFocusCallback $instance, boolean $owner) {
      return createNewInstancePair($instance, Arrays.<Object>asList(), $owner);
    }

    

    
    
    public Completable<Object> $onAutoFocus($AutoFocusCallback $instance,Boolean success) {
      return invokeMethod($instance, "onAutoFocus", Arrays.<Object>asList(success));
    }
    
    
  }
  
  public static class $ShutterCallbackChannel extends TypeChannel<$ShutterCallback> {
    public $ShutterCallbackChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/ShutterCallback");
    }

    public Completable<PairedInstance> $$create($ShutterCallback $instance, boolean $owner) {
      return createNewInstancePair($instance, Arrays.<Object>asList(), $owner);
    }

    

    
    
    public Completable<Object> $onShutter($ShutterCallback $instance) {
      return invokeMethod($instance, "onShutter", Arrays.<Object>asList());
    }
    
    
  }
  
  public static class $PictureCallbackChannel extends TypeChannel<$PictureCallback> {
    public $PictureCallbackChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/PictureCallback");
    }

    public Completable<PairedInstance> $$create($PictureCallback $instance, boolean $owner) {
      return createNewInstancePair($instance, Arrays.<Object>asList(), $owner);
    }

    

    
    
    public Completable<Object> $onPictureTaken($PictureCallback $instance,byte[] data) {
      return invokeMethod($instance, "onPictureTaken", Arrays.<Object>asList(data));
    }
    
    
  }
  
  public static class $CameraInfoChannel extends TypeChannel<$CameraInfo> {
    public $CameraInfoChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/CameraInfo");
    }

    public Completable<PairedInstance> $$create($CameraInfo $instance, boolean $owner,Integer cameraId,Integer facing,Integer orientation) {
      return createNewInstancePair($instance, Arrays.<Object>asList(cameraId,facing,orientation), $owner);
    }

    

    
  }
  
  public static class $MediaRecorderChannel extends TypeChannel<$MediaRecorder> {
    public $MediaRecorderChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/MediaRecorder");
    }

    public Completable<PairedInstance> $$create($MediaRecorder $instance, boolean $owner) {
      return createNewInstancePair($instance, Arrays.<Object>asList(), $owner);
    }

    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  }
  

  
  public static class $CameraHandler implements TypeChannelHandler<$Camera> {
    public $Camera $$create(TypeChannelMessenger messenger)
        throws Exception {
      throw new UnsupportedOperationException();
    }

    
    
    public Object $getAllCameraInfo(TypeChannelMessenger messenger)
        throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public Object $open(TypeChannelMessenger messenger,Integer cameraId)
        throws Exception {
      throw new UnsupportedOperationException();
    }
    
    

    
    
    public Object $release($Camera $instance) throws Exception {
      return $instance.release();
    }
    
    
    
    public Object $startPreview($Camera $instance) throws Exception {
      return $instance.startPreview();
    }
    
    
    
    public Object $stopPreview($Camera $instance) throws Exception {
      return $instance.stopPreview();
    }
    
    
    
    public Object $attachPreviewTexture($Camera $instance) throws Exception {
      return $instance.attachPreviewTexture();
    }
    
    
    
    public Object $releasePreviewTexture($Camera $instance) throws Exception {
      return $instance.releasePreviewTexture();
    }
    
    
    
    public Object $unlock($Camera $instance) throws Exception {
      return $instance.unlock();
    }
    
    
    
    public Object $reconnect($Camera $instance) throws Exception {
      return $instance.reconnect();
    }
    
    
    
    public Object $takePicture($Camera $instance,$ShutterCallback shutter,$PictureCallback raw,$PictureCallback postView,$PictureCallback jpeg) throws Exception {
      return $instance.takePicture( shutter , raw , postView , jpeg );
    }
    
    
    
    public Object $autoFocus($Camera $instance,$AutoFocusCallback callback) throws Exception {
      return $instance.autoFocus( callback );
    }
    
    
    
    public Object $cancelAutoFocus($Camera $instance) throws Exception {
      return $instance.cancelAutoFocus();
    }
    
    
    
    public Object $setDisplayOrientation($Camera $instance,Integer degrees) throws Exception {
      return $instance.setDisplayOrientation( degrees );
    }
    
    
    
    public Object $setErrorCallback($Camera $instance,$ErrorCallback callback) throws Exception {
      return $instance.setErrorCallback( callback );
    }
    
    
    
    public Object $startSmoothZoom($Camera $instance,Integer value) throws Exception {
      return $instance.startSmoothZoom( value );
    }
    
    
    
    public Object $stopSmoothZoom($Camera $instance) throws Exception {
      return $instance.stopSmoothZoom();
    }
    
    
    
    public Object $getParameters($Camera $instance) throws Exception {
      return $instance.getParameters();
    }
    
    
    
    public Object $setParameters($Camera $instance,$CameraParameters parameters) throws Exception {
      return $instance.setParameters( parameters );
    }
    
    

    @Override
    public Object invokeStaticMethod(
        TypeChannelMessenger messenger, String methodName, List<Object> arguments)
        throws Exception {
      switch (methodName) {
        
        
        case "getAllCameraInfo":
          return $getAllCameraInfo(messenger);
        
        
        
        case "open":
          return $open(messenger,(Integer) arguments.get(0));
        
        
      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke static method %s", methodName));
    }

    @Override
    public $Camera createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      return $$create(messenger);
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        $Camera instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      switch(methodName) {
        
        
        case "release":
          return $release(instance);
        
        
        
        case "startPreview":
          return $startPreview(instance);
        
        
        
        case "stopPreview":
          return $stopPreview(instance);
        
        
        
        case "attachPreviewTexture":
          return $attachPreviewTexture(instance);
        
        
        
        case "releasePreviewTexture":
          return $releasePreviewTexture(instance);
        
        
        
        case "unlock":
          return $unlock(instance);
        
        
        
        case "reconnect":
          return $reconnect(instance);
        
        
        
        case "takePicture":
          return $takePicture(instance,($ShutterCallback) arguments.get(0),($PictureCallback) arguments.get(1),($PictureCallback) arguments.get(2),($PictureCallback) arguments.get(3));
        
        
        
        case "autoFocus":
          return $autoFocus(instance,($AutoFocusCallback) arguments.get(0));
        
        
        
        case "cancelAutoFocus":
          return $cancelAutoFocus(instance);
        
        
        
        case "setDisplayOrientation":
          return $setDisplayOrientation(instance,(Integer) arguments.get(0));
        
        
        
        case "setErrorCallback":
          return $setErrorCallback(instance,($ErrorCallback) arguments.get(0));
        
        
        
        case "startSmoothZoom":
          return $startSmoothZoom(instance,(Integer) arguments.get(0));
        
        
        
        case "stopSmoothZoom":
          return $stopSmoothZoom(instance);
        
        
        
        case "getParameters":
          return $getParameters(instance);
        
        
        
        case "setParameters":
          return $setParameters(instance,($CameraParameters) arguments.get(0));
        
        
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }
  
  public static class $CameraParametersHandler implements TypeChannelHandler<$CameraParameters> {
    public $CameraParameters $$create(TypeChannelMessenger messenger)
        throws Exception {
      throw new UnsupportedOperationException();
    }

    

    
    
    public Object $getAutoExposureLock($CameraParameters $instance) throws Exception {
      return $instance.getAutoExposureLock();
    }
    
    
    
    public Object $getFocusAreas($CameraParameters $instance) throws Exception {
      return $instance.getFocusAreas();
    }
    
    
    
    public Object $getFocusDistances($CameraParameters $instance) throws Exception {
      return $instance.getFocusDistances();
    }
    
    
    
    public Object $getMaxExposureCompensation($CameraParameters $instance) throws Exception {
      return $instance.getMaxExposureCompensation();
    }
    
    
    
    public Object $getMaxNumFocusAreas($CameraParameters $instance) throws Exception {
      return $instance.getMaxNumFocusAreas();
    }
    
    
    
    public Object $getMinExposureCompensation($CameraParameters $instance) throws Exception {
      return $instance.getMinExposureCompensation();
    }
    
    
    
    public Object $getSupportedFocusModes($CameraParameters $instance) throws Exception {
      return $instance.getSupportedFocusModes();
    }
    
    
    
    public Object $isAutoExposureLockSupported($CameraParameters $instance) throws Exception {
      return $instance.isAutoExposureLockSupported();
    }
    
    
    
    public Object $isZoomSupported($CameraParameters $instance) throws Exception {
      return $instance.isZoomSupported();
    }
    
    
    
    public Object $setAutoExposureLock($CameraParameters $instance,Boolean toggle) throws Exception {
      return $instance.setAutoExposureLock( toggle );
    }
    
    
    
    public Object $setExposureCompensation($CameraParameters $instance,Integer value) throws Exception {
      return $instance.setExposureCompensation( value );
    }
    
    
    
    public Object $setFocusAreas($CameraParameters $instance,List<$CameraArea> focusAreas) throws Exception {
      return $instance.setFocusAreas( focusAreas );
    }
    
    
    
    public Object $setFocusMode($CameraParameters $instance,String value) throws Exception {
      return $instance.setFocusMode( value );
    }
    
    
    
    public Object $getFlashMode($CameraParameters $instance) throws Exception {
      return $instance.getFlashMode();
    }
    
    
    
    public Object $getMaxZoom($CameraParameters $instance) throws Exception {
      return $instance.getMaxZoom();
    }
    
    
    
    public Object $getPictureSize($CameraParameters $instance) throws Exception {
      return $instance.getPictureSize();
    }
    
    
    
    public Object $getPreviewSize($CameraParameters $instance) throws Exception {
      return $instance.getPreviewSize();
    }
    
    
    
    public Object $getSupportedPreviewSizes($CameraParameters $instance) throws Exception {
      return $instance.getSupportedPreviewSizes();
    }
    
    
    
    public Object $getSupportedPictureSizes($CameraParameters $instance) throws Exception {
      return $instance.getSupportedPictureSizes();
    }
    
    
    
    public Object $getSupportedFlashModes($CameraParameters $instance) throws Exception {
      return $instance.getSupportedFlashModes();
    }
    
    
    
    public Object $getZoom($CameraParameters $instance) throws Exception {
      return $instance.getZoom();
    }
    
    
    
    public Object $isSmoothZoomSupported($CameraParameters $instance) throws Exception {
      return $instance.isSmoothZoomSupported();
    }
    
    
    
    public Object $setFlashMode($CameraParameters $instance,String mode) throws Exception {
      return $instance.setFlashMode( mode );
    }
    
    
    
    public Object $setPictureSize($CameraParameters $instance,Integer width,Integer height) throws Exception {
      return $instance.setPictureSize( width , height );
    }
    
    
    
    public Object $setRecordingHint($CameraParameters $instance,Boolean hint) throws Exception {
      return $instance.setRecordingHint( hint );
    }
    
    
    
    public Object $setRotation($CameraParameters $instance,Integer rotation) throws Exception {
      return $instance.setRotation( rotation );
    }
    
    
    
    public Object $setZoom($CameraParameters $instance,Integer value) throws Exception {
      return $instance.setZoom( value );
    }
    
    
    
    public Object $setPreviewSize($CameraParameters $instance,Integer width,Integer height) throws Exception {
      return $instance.setPreviewSize( width , height );
    }
    
    
    
    public Object $getExposureCompensation($CameraParameters $instance) throws Exception {
      return $instance.getExposureCompensation();
    }
    
    
    
    public Object $getExposureCompensationStep($CameraParameters $instance) throws Exception {
      return $instance.getExposureCompensationStep();
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
    public $CameraParameters createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      return $$create(messenger);
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        $CameraParameters instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      switch(methodName) {
        
        
        case "getAutoExposureLock":
          return $getAutoExposureLock(instance);
        
        
        
        case "getFocusAreas":
          return $getFocusAreas(instance);
        
        
        
        case "getFocusDistances":
          return $getFocusDistances(instance);
        
        
        
        case "getMaxExposureCompensation":
          return $getMaxExposureCompensation(instance);
        
        
        
        case "getMaxNumFocusAreas":
          return $getMaxNumFocusAreas(instance);
        
        
        
        case "getMinExposureCompensation":
          return $getMinExposureCompensation(instance);
        
        
        
        case "getSupportedFocusModes":
          return $getSupportedFocusModes(instance);
        
        
        
        case "isAutoExposureLockSupported":
          return $isAutoExposureLockSupported(instance);
        
        
        
        case "isZoomSupported":
          return $isZoomSupported(instance);
        
        
        
        case "setAutoExposureLock":
          return $setAutoExposureLock(instance,(Boolean) arguments.get(0));
        
        
        
        case "setExposureCompensation":
          return $setExposureCompensation(instance,(Integer) arguments.get(0));
        
        
        
        case "setFocusAreas":
          return $setFocusAreas(instance,(List<$CameraArea>) arguments.get(0));
        
        
        
        case "setFocusMode":
          return $setFocusMode(instance,(String) arguments.get(0));
        
        
        
        case "getFlashMode":
          return $getFlashMode(instance);
        
        
        
        case "getMaxZoom":
          return $getMaxZoom(instance);
        
        
        
        case "getPictureSize":
          return $getPictureSize(instance);
        
        
        
        case "getPreviewSize":
          return $getPreviewSize(instance);
        
        
        
        case "getSupportedPreviewSizes":
          return $getSupportedPreviewSizes(instance);
        
        
        
        case "getSupportedPictureSizes":
          return $getSupportedPictureSizes(instance);
        
        
        
        case "getSupportedFlashModes":
          return $getSupportedFlashModes(instance);
        
        
        
        case "getZoom":
          return $getZoom(instance);
        
        
        
        case "isSmoothZoomSupported":
          return $isSmoothZoomSupported(instance);
        
        
        
        case "setFlashMode":
          return $setFlashMode(instance,(String) arguments.get(0));
        
        
        
        case "setPictureSize":
          return $setPictureSize(instance,(Integer) arguments.get(0),(Integer) arguments.get(1));
        
        
        
        case "setRecordingHint":
          return $setRecordingHint(instance,(Boolean) arguments.get(0));
        
        
        
        case "setRotation":
          return $setRotation(instance,(Integer) arguments.get(0));
        
        
        
        case "setZoom":
          return $setZoom(instance,(Integer) arguments.get(0));
        
        
        
        case "setPreviewSize":
          return $setPreviewSize(instance,(Integer) arguments.get(0),(Integer) arguments.get(1));
        
        
        
        case "getExposureCompensation":
          return $getExposureCompensation(instance);
        
        
        
        case "getExposureCompensationStep":
          return $getExposureCompensationStep(instance);
        
        
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }
  
  public static class $CameraAreaHandler implements TypeChannelHandler<$CameraArea> {
    public $CameraArea $$create(TypeChannelMessenger messenger,$CameraRect rect,Integer weight)
        throws Exception {
      throw new UnsupportedOperationException();
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
    public $CameraArea createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      return $$create(messenger,($CameraRect) arguments.get(0),(Integer) arguments.get(1));
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        $CameraArea instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      switch(methodName) {
        
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }
  
  public static class $CameraRectHandler implements TypeChannelHandler<$CameraRect> {
    public $CameraRect $$create(TypeChannelMessenger messenger,Integer top,Integer bottom,Integer right,Integer left)
        throws Exception {
      throw new UnsupportedOperationException();
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
    public $CameraRect createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      return $$create(messenger,(Integer) arguments.get(0),(Integer) arguments.get(1),(Integer) arguments.get(2),(Integer) arguments.get(3));
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        $CameraRect instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      switch(methodName) {
        
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }
  
  public static class $CameraSizeHandler implements TypeChannelHandler<$CameraSize> {
    public $CameraSize $$create(TypeChannelMessenger messenger,Integer width,Integer height)
        throws Exception {
      throw new UnsupportedOperationException();
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
    public $CameraSize createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      return $$create(messenger,(Integer) arguments.get(0),(Integer) arguments.get(1));
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        $CameraSize instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      switch(methodName) {
        
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }
  
  public static class $ErrorCallbackHandler implements TypeChannelHandler<$ErrorCallback> {
    public $ErrorCallback $$create(TypeChannelMessenger messenger)
        throws Exception {
      throw new UnsupportedOperationException();
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
    public $ErrorCallback createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      return $$create(messenger);
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        $ErrorCallback instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      switch(methodName) {
        
        
        
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }
  
  public static class $AutoFocusCallbackHandler implements TypeChannelHandler<$AutoFocusCallback> {
    public $AutoFocusCallback $$create(TypeChannelMessenger messenger)
        throws Exception {
      throw new UnsupportedOperationException();
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
    public $AutoFocusCallback createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      return $$create(messenger);
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        $AutoFocusCallback instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      switch(methodName) {
        
        
        
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }
  
  public static class $ShutterCallbackHandler implements TypeChannelHandler<$ShutterCallback> {
    public $ShutterCallback $$create(TypeChannelMessenger messenger)
        throws Exception {
      throw new UnsupportedOperationException();
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
    public $ShutterCallback createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      return $$create(messenger);
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        $ShutterCallback instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      switch(methodName) {
        
        
        
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }
  
  public static class $PictureCallbackHandler implements TypeChannelHandler<$PictureCallback> {
    public $PictureCallback $$create(TypeChannelMessenger messenger)
        throws Exception {
      throw new UnsupportedOperationException();
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
    public $PictureCallback createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      return $$create(messenger);
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        $PictureCallback instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      switch(methodName) {
        
        
        
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }
  
  public static class $CameraInfoHandler implements TypeChannelHandler<$CameraInfo> {
    public $CameraInfo $$create(TypeChannelMessenger messenger,Integer cameraId,Integer facing,Integer orientation)
        throws Exception {
      throw new UnsupportedOperationException();
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
    public $CameraInfo createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      return $$create(messenger,(Integer) arguments.get(0),(Integer) arguments.get(1),(Integer) arguments.get(2));
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        $CameraInfo instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      switch(methodName) {
        
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }
  
  public static class $MediaRecorderHandler implements TypeChannelHandler<$MediaRecorder> {
    public $MediaRecorder $$create(TypeChannelMessenger messenger)
        throws Exception {
      throw new UnsupportedOperationException();
    }

    

    
    
    public Object $setCamera($MediaRecorder $instance,$Camera camera) throws Exception {
      return $instance.setCamera( camera );
    }
    
    
    
    public Object $setVideoSource($MediaRecorder $instance,Integer source) throws Exception {
      return $instance.setVideoSource( source );
    }
    
    
    
    public Object $setOutputFilePath($MediaRecorder $instance,String path) throws Exception {
      return $instance.setOutputFilePath( path );
    }
    
    
    
    public Object $setOutputFormat($MediaRecorder $instance,Integer format) throws Exception {
      return $instance.setOutputFormat( format );
    }
    
    
    
    public Object $setVideoEncoder($MediaRecorder $instance,Integer encoder) throws Exception {
      return $instance.setVideoEncoder( encoder );
    }
    
    
    
    public Object $setAudioSource($MediaRecorder $instance,Integer source) throws Exception {
      return $instance.setAudioSource( source );
    }
    
    
    
    public Object $setAudioEncoder($MediaRecorder $instance,Integer encoder) throws Exception {
      return $instance.setAudioEncoder( encoder );
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
    public $MediaRecorder createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      return $$create(messenger);
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        $MediaRecorder instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      switch(methodName) {
        
        
        case "setCamera":
          return $setCamera(instance,($Camera) arguments.get(0));
        
        
        
        case "setVideoSource":
          return $setVideoSource(instance,(Integer) arguments.get(0));
        
        
        
        case "setOutputFilePath":
          return $setOutputFilePath(instance,(String) arguments.get(0));
        
        
        
        case "setOutputFormat":
          return $setOutputFormat(instance,(Integer) arguments.get(0));
        
        
        
        case "setVideoEncoder":
          return $setVideoEncoder(instance,(Integer) arguments.get(0));
        
        
        
        case "setAudioSource":
          return $setAudioSource(instance,(Integer) arguments.get(0));
        
        
        
        case "setAudioEncoder":
          return $setAudioEncoder(instance,(Integer) arguments.get(0));
        
        
        
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

    
    public $CameraChannel getChannelCamera() {
      return new $CameraChannel(messenger);
    }

    public $CameraHandler getHandlerCamera() {
      return new $CameraHandler();
    }
    
    public $CameraParametersChannel getChannelCameraParameters() {
      return new $CameraParametersChannel(messenger);
    }

    public $CameraParametersHandler getHandlerCameraParameters() {
      return new $CameraParametersHandler();
    }
    
    public $CameraAreaChannel getChannelCameraArea() {
      return new $CameraAreaChannel(messenger);
    }

    public $CameraAreaHandler getHandlerCameraArea() {
      return new $CameraAreaHandler();
    }
    
    public $CameraRectChannel getChannelCameraRect() {
      return new $CameraRectChannel(messenger);
    }

    public $CameraRectHandler getHandlerCameraRect() {
      return new $CameraRectHandler();
    }
    
    public $CameraSizeChannel getChannelCameraSize() {
      return new $CameraSizeChannel(messenger);
    }

    public $CameraSizeHandler getHandlerCameraSize() {
      return new $CameraSizeHandler();
    }
    
    public $ErrorCallbackChannel getChannelErrorCallback() {
      return new $ErrorCallbackChannel(messenger);
    }

    public $ErrorCallbackHandler getHandlerErrorCallback() {
      return new $ErrorCallbackHandler();
    }
    
    public $AutoFocusCallbackChannel getChannelAutoFocusCallback() {
      return new $AutoFocusCallbackChannel(messenger);
    }

    public $AutoFocusCallbackHandler getHandlerAutoFocusCallback() {
      return new $AutoFocusCallbackHandler();
    }
    
    public $ShutterCallbackChannel getChannelShutterCallback() {
      return new $ShutterCallbackChannel(messenger);
    }

    public $ShutterCallbackHandler getHandlerShutterCallback() {
      return new $ShutterCallbackHandler();
    }
    
    public $PictureCallbackChannel getChannelPictureCallback() {
      return new $PictureCallbackChannel(messenger);
    }

    public $PictureCallbackHandler getHandlerPictureCallback() {
      return new $PictureCallbackHandler();
    }
    
    public $CameraInfoChannel getChannelCameraInfo() {
      return new $CameraInfoChannel(messenger);
    }

    public $CameraInfoHandler getHandlerCameraInfo() {
      return new $CameraInfoHandler();
    }
    
    public $MediaRecorderChannel getChannelMediaRecorder() {
      return new $MediaRecorderChannel(messenger);
    }

    public $MediaRecorderHandler getHandlerMediaRecorder() {
      return new $MediaRecorderHandler();
    }
    
  }

  public static class $ChannelRegistrar {
    public final $LibraryImplementations implementations;

    public $ChannelRegistrar($LibraryImplementations implementations) {
      this.implementations = implementations;
    }


    public void registerHandlers() {
      
      implementations.getChannelCamera().setHandler(implementations.getHandlerCamera());
      
      implementations.getChannelCameraParameters().setHandler(implementations.getHandlerCameraParameters());
      
      implementations.getChannelCameraArea().setHandler(implementations.getHandlerCameraArea());
      
      implementations.getChannelCameraRect().setHandler(implementations.getHandlerCameraRect());
      
      implementations.getChannelCameraSize().setHandler(implementations.getHandlerCameraSize());
      
      implementations.getChannelErrorCallback().setHandler(implementations.getHandlerErrorCallback());
      
      implementations.getChannelAutoFocusCallback().setHandler(implementations.getHandlerAutoFocusCallback());
      
      implementations.getChannelShutterCallback().setHandler(implementations.getHandlerShutterCallback());
      
      implementations.getChannelPictureCallback().setHandler(implementations.getHandlerPictureCallback());
      
      implementations.getChannelCameraInfo().setHandler(implementations.getHandlerCameraInfo());
      
      implementations.getChannelMediaRecorder().setHandler(implementations.getHandlerMediaRecorder());
      
    }

    public void unregisterHandlers() {
      
      implementations.getChannelCamera().removeHandler();
      
      implementations.getChannelCameraParameters().removeHandler();
      
      implementations.getChannelCameraArea().removeHandler();
      
      implementations.getChannelCameraRect().removeHandler();
      
      implementations.getChannelCameraSize().removeHandler();
      
      implementations.getChannelErrorCallback().removeHandler();
      
      implementations.getChannelAutoFocusCallback().removeHandler();
      
      implementations.getChannelShutterCallback().removeHandler();
      
      implementations.getChannelPictureCallback().removeHandler();
      
      implementations.getChannelCameraInfo().removeHandler();
      
      implementations.getChannelMediaRecorder().removeHandler();
      
    }
  }
}
