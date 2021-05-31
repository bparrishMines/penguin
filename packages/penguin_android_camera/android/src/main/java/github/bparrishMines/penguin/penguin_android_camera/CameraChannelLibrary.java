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
    
    void $release();
    
    void $startPreview();
    
    void $stopPreview();
    
    Integer $attachPreviewTexture();
    
    void $releasePreviewTexture();
    
    void $unlock();
    
    void $reconnect();
    
    void $takePicture($ShutterCallback shutter,$PictureCallback raw,$PictureCallback postView,$PictureCallback jpeg);
    
    void $autoFocus($AutoFocusCallback callback);
    
    void $cancelAutoFocus();
    
    void $setDisplayOrientation(Integer degrees);
    
    void $setErrorCallback($ErrorCallback callback);
    
    void $startSmoothZoom(Integer value);
    
    void $stopSmoothZoom();
    
    $CameraParameters $getParameters();
    
    void $setParameters($CameraParameters parameters);
    
  }
  
  public interface $CameraParameters {
    
    Boolean $getAutoExposureLock();
    
    List<$CameraArea> $getFocusAreas();
    
    List<Double> $getFocusDistances();
    
    Integer $getMaxExposureCompensation();
    
    Integer $getMaxNumFocusAreas();
    
    Integer $getMinExposureCompensation();
    
    List<String> $getSupportedFocusModes();
    
    Boolean $isAutoExposureLockSupported();
    
    Boolean $isZoomSupported();
    
    void $setAutoExposureLock(Boolean toggle);
    
    void $setExposureCompensation(Integer value);
    
    void $setFocusAreas(List<$CameraArea> focusAreas);
    
    void $setFocusMode(String value);
    
    String $getFlashMode();
    
    Integer $getMaxZoom();
    
    $CameraSize $getPictureSize();
    
    $CameraSize $getPreviewSize();
    
    List<$CameraSize> $getSupportedPreviewSizes();
    
    List<$CameraSize> $getSupportedPictureSizes();
    
    List<String> $getSupportedFlashModes();
    
    Integer $getZoom();
    
    Boolean $isSmoothZoomSupported();
    
    void $setFlashMode(String mode);
    
    void $setPictureSize(Integer width,Integer height);
    
    void $setRecordingHint(Boolean hint);
    
    void $setRotation(Integer rotation);
    
    void $setZoom(Integer value);
    
    void $setPreviewSize(Integer width,Integer height);
    
    Integer $getExposureCompensation();
    
    Double $getExposureCompensationStep();
    
  }
  
  public interface $CameraArea {
    
  }
  
  public interface $CameraRect {
    
  }
  
  public interface $CameraSize {
    
  }
  
  public interface $ErrorCallback {
    
    void $onError(Integer error);
    
  }
  
  public interface $AutoFocusCallback {
    
    void $onAutoFocus(Boolean success);
    
  }
  
  public interface $ShutterCallback {
    
    void $onShutter();
    
  }
  
  public interface $PictureCallback {
    
    void $onPictureTaken(byte[] data);
    
  }
  
  public interface $CameraInfo {
    
  }
  
  public interface $MediaRecorder {
    
    void $setCamera($Camera camera);
    
    void $setVideoSource(Integer source);
    
    void $setOutputFilePath(String path);
    
    void $setOutputFormat(Integer format);
    
    void $setVideoEncoder(Integer encoder);
    
    void $setAudioSource(Integer source);
    
    void $setAudioEncoder(Integer encoder);
    
    void $prepare();
    
    void $start();
    
    void $stop();
    
    void $release();
    
    void $pause();
    
    void $resume();
    
  }
  

  
  public static class $CameraChannel extends TypeChannel<$Camera> {
    public $CameraChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/Camera");
    }

    public Completable<PairedInstance> $$create($Camera $instance, boolean $owner) {
      return createNewInstancePair($instance, Arrays.<Object>asList(), $owner);
    }

    
    public Completable<Object> $getAllCameraInfo() {
      return invokeStaticMethod("getAllCameraInfo", Arrays.<Object>asList());
    }
    
    public Completable<Object> $open(Integer cameraId) {
      return invokeStaticMethod("open", Arrays.<Object>asList(cameraId));
    }
    

    
    public Completable<Object> $release($Camera $instance) {
      return invokeMethod($instance, "release", Arrays.<Object>asList());
    }
    
    public Completable<Object> $startPreview($Camera $instance) {
      return invokeMethod($instance, "startPreview", Arrays.<Object>asList());
    }
    
    public Completable<Object> $stopPreview($Camera $instance) {
      return invokeMethod($instance, "stopPreview", Arrays.<Object>asList());
    }
    
    public Completable<Object> $attachPreviewTexture($Camera $instance) {
      return invokeMethod($instance, "attachPreviewTexture", Arrays.<Object>asList());
    }
    
    public Completable<Object> $releasePreviewTexture($Camera $instance) {
      return invokeMethod($instance, "releasePreviewTexture", Arrays.<Object>asList());
    }
    
    public Completable<Object> $unlock($Camera $instance) {
      return invokeMethod($instance, "unlock", Arrays.<Object>asList());
    }
    
    public Completable<Object> $reconnect($Camera $instance) {
      return invokeMethod($instance, "reconnect", Arrays.<Object>asList());
    }
    
    public Completable<Object> $takePicture($Camera $instance,$ShutterCallback shutter,$PictureCallback raw,$PictureCallback postView,$PictureCallback jpeg) {
      return invokeMethod($instance, "takePicture", Arrays.<Object>asList(shutter,raw,postView,jpeg));
    }
    
    public Completable<Object> $autoFocus($Camera $instance,$AutoFocusCallback callback) {
      return invokeMethod($instance, "autoFocus", Arrays.<Object>asList(callback));
    }
    
    public Completable<Object> $cancelAutoFocus($Camera $instance) {
      return invokeMethod($instance, "cancelAutoFocus", Arrays.<Object>asList());
    }
    
    public Completable<Object> $setDisplayOrientation($Camera $instance,Integer degrees) {
      return invokeMethod($instance, "setDisplayOrientation", Arrays.<Object>asList(degrees));
    }
    
    public Completable<Object> $setErrorCallback($Camera $instance,$ErrorCallback callback) {
      return invokeMethod($instance, "setErrorCallback", Arrays.<Object>asList(callback));
    }
    
    public Completable<Object> $startSmoothZoom($Camera $instance,Integer value) {
      return invokeMethod($instance, "startSmoothZoom", Arrays.<Object>asList(value));
    }
    
    public Completable<Object> $stopSmoothZoom($Camera $instance) {
      return invokeMethod($instance, "stopSmoothZoom", Arrays.<Object>asList());
    }
    
    public Completable<Object> $getParameters($Camera $instance) {
      return invokeMethod($instance, "getParameters", Arrays.<Object>asList());
    }
    
    public Completable<Object> $setParameters($Camera $instance,$CameraParameters parameters) {
      return invokeMethod($instance, "setParameters", Arrays.<Object>asList(parameters));
    }
    
  }
  
  public static class $CameraParametersChannel extends TypeChannel<$CameraParameters> {
    public $CameraParametersChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/CameraParameters");
    }

    public Completable<PairedInstance> $$create($CameraParameters $instance, boolean $owner) {
      return createNewInstancePair($instance, Arrays.<Object>asList(), $owner);
    }

    

    
    public Completable<Object> $getAutoExposureLock($CameraParameters $instance) {
      return invokeMethod($instance, "getAutoExposureLock", Arrays.<Object>asList());
    }
    
    public Completable<Object> $getFocusAreas($CameraParameters $instance) {
      return invokeMethod($instance, "getFocusAreas", Arrays.<Object>asList());
    }
    
    public Completable<Object> $getFocusDistances($CameraParameters $instance) {
      return invokeMethod($instance, "getFocusDistances", Arrays.<Object>asList());
    }
    
    public Completable<Object> $getMaxExposureCompensation($CameraParameters $instance) {
      return invokeMethod($instance, "getMaxExposureCompensation", Arrays.<Object>asList());
    }
    
    public Completable<Object> $getMaxNumFocusAreas($CameraParameters $instance) {
      return invokeMethod($instance, "getMaxNumFocusAreas", Arrays.<Object>asList());
    }
    
    public Completable<Object> $getMinExposureCompensation($CameraParameters $instance) {
      return invokeMethod($instance, "getMinExposureCompensation", Arrays.<Object>asList());
    }
    
    public Completable<Object> $getSupportedFocusModes($CameraParameters $instance) {
      return invokeMethod($instance, "getSupportedFocusModes", Arrays.<Object>asList());
    }
    
    public Completable<Object> $isAutoExposureLockSupported($CameraParameters $instance) {
      return invokeMethod($instance, "isAutoExposureLockSupported", Arrays.<Object>asList());
    }
    
    public Completable<Object> $isZoomSupported($CameraParameters $instance) {
      return invokeMethod($instance, "isZoomSupported", Arrays.<Object>asList());
    }
    
    public Completable<Object> $setAutoExposureLock($CameraParameters $instance,Boolean toggle) {
      return invokeMethod($instance, "setAutoExposureLock", Arrays.<Object>asList(toggle));
    }
    
    public Completable<Object> $setExposureCompensation($CameraParameters $instance,Integer value) {
      return invokeMethod($instance, "setExposureCompensation", Arrays.<Object>asList(value));
    }
    
    public Completable<Object> $setFocusAreas($CameraParameters $instance,List<$CameraArea> focusAreas) {
      return invokeMethod($instance, "setFocusAreas", Arrays.<Object>asList(focusAreas));
    }
    
    public Completable<Object> $setFocusMode($CameraParameters $instance,String value) {
      return invokeMethod($instance, "setFocusMode", Arrays.<Object>asList(value));
    }
    
    public Completable<Object> $getFlashMode($CameraParameters $instance) {
      return invokeMethod($instance, "getFlashMode", Arrays.<Object>asList());
    }
    
    public Completable<Object> $getMaxZoom($CameraParameters $instance) {
      return invokeMethod($instance, "getMaxZoom", Arrays.<Object>asList());
    }
    
    public Completable<Object> $getPictureSize($CameraParameters $instance) {
      return invokeMethod($instance, "getPictureSize", Arrays.<Object>asList());
    }
    
    public Completable<Object> $getPreviewSize($CameraParameters $instance) {
      return invokeMethod($instance, "getPreviewSize", Arrays.<Object>asList());
    }
    
    public Completable<Object> $getSupportedPreviewSizes($CameraParameters $instance) {
      return invokeMethod($instance, "getSupportedPreviewSizes", Arrays.<Object>asList());
    }
    
    public Completable<Object> $getSupportedPictureSizes($CameraParameters $instance) {
      return invokeMethod($instance, "getSupportedPictureSizes", Arrays.<Object>asList());
    }
    
    public Completable<Object> $getSupportedFlashModes($CameraParameters $instance) {
      return invokeMethod($instance, "getSupportedFlashModes", Arrays.<Object>asList());
    }
    
    public Completable<Object> $getZoom($CameraParameters $instance) {
      return invokeMethod($instance, "getZoom", Arrays.<Object>asList());
    }
    
    public Completable<Object> $isSmoothZoomSupported($CameraParameters $instance) {
      return invokeMethod($instance, "isSmoothZoomSupported", Arrays.<Object>asList());
    }
    
    public Completable<Object> $setFlashMode($CameraParameters $instance,String mode) {
      return invokeMethod($instance, "setFlashMode", Arrays.<Object>asList(mode));
    }
    
    public Completable<Object> $setPictureSize($CameraParameters $instance,Integer width,Integer height) {
      return invokeMethod($instance, "setPictureSize", Arrays.<Object>asList(width,height));
    }
    
    public Completable<Object> $setRecordingHint($CameraParameters $instance,Boolean hint) {
      return invokeMethod($instance, "setRecordingHint", Arrays.<Object>asList(hint));
    }
    
    public Completable<Object> $setRotation($CameraParameters $instance,Integer rotation) {
      return invokeMethod($instance, "setRotation", Arrays.<Object>asList(rotation));
    }
    
    public Completable<Object> $setZoom($CameraParameters $instance,Integer value) {
      return invokeMethod($instance, "setZoom", Arrays.<Object>asList(value));
    }
    
    public Completable<Object> $setPreviewSize($CameraParameters $instance,Integer width,Integer height) {
      return invokeMethod($instance, "setPreviewSize", Arrays.<Object>asList(width,height));
    }
    
    public Completable<Object> $getExposureCompensation($CameraParameters $instance) {
      return invokeMethod($instance, "getExposureCompensation", Arrays.<Object>asList());
    }
    
    public Completable<Object> $getExposureCompensationStep($CameraParameters $instance) {
      return invokeMethod($instance, "getExposureCompensationStep", Arrays.<Object>asList());
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

    

    
    public Completable<Object> $setCamera($MediaRecorder $instance,$Camera camera) {
      return invokeMethod($instance, "setCamera", Arrays.<Object>asList(camera));
    }
    
    public Completable<Object> $setVideoSource($MediaRecorder $instance,Integer source) {
      return invokeMethod($instance, "setVideoSource", Arrays.<Object>asList(source));
    }
    
    public Completable<Object> $setOutputFilePath($MediaRecorder $instance,String path) {
      return invokeMethod($instance, "setOutputFilePath", Arrays.<Object>asList(path));
    }
    
    public Completable<Object> $setOutputFormat($MediaRecorder $instance,Integer format) {
      return invokeMethod($instance, "setOutputFormat", Arrays.<Object>asList(format));
    }
    
    public Completable<Object> $setVideoEncoder($MediaRecorder $instance,Integer encoder) {
      return invokeMethod($instance, "setVideoEncoder", Arrays.<Object>asList(encoder));
    }
    
    public Completable<Object> $setAudioSource($MediaRecorder $instance,Integer source) {
      return invokeMethod($instance, "setAudioSource", Arrays.<Object>asList(source));
    }
    
    public Completable<Object> $setAudioEncoder($MediaRecorder $instance,Integer encoder) {
      return invokeMethod($instance, "setAudioEncoder", Arrays.<Object>asList(encoder));
    }
    
    public Completable<Object> $prepare($MediaRecorder $instance) {
      return invokeMethod($instance, "prepare", Arrays.<Object>asList());
    }
    
    public Completable<Object> $start($MediaRecorder $instance) {
      return invokeMethod($instance, "start", Arrays.<Object>asList());
    }
    
    public Completable<Object> $stop($MediaRecorder $instance) {
      return invokeMethod($instance, "stop", Arrays.<Object>asList());
    }
    
    public Completable<Object> $release($MediaRecorder $instance) {
      return invokeMethod($instance, "release", Arrays.<Object>asList());
    }
    
    public Completable<Object> $pause($MediaRecorder $instance) {
      return invokeMethod($instance, "pause", Arrays.<Object>asList());
    }
    
    public Completable<Object> $resume($MediaRecorder $instance) {
      return invokeMethod($instance, "resume", Arrays.<Object>asList());
    }
    
  }
  

  
  public static class $CameraHandler implements TypeChannelHandler<$Camera> {
    public $Camera $$create(TypeChannelMessenger messenger)
        throws Exception {
      throw new UnsupportedOperationException();
    }

    
    public List<$CameraInfo> $getAllCameraInfo(TypeChannelMessenger messenger)
        throws Exception {
      throw new UnsupportedOperationException();
    }
    
    public $Camera $open(TypeChannelMessenger messenger,Integer cameraId)
        throws Exception {
      throw new UnsupportedOperationException();
    }
    

    
    public void $release($Camera $instance) throws Exception {
       return  $instance
          .$release();
    }
    
    public void $startPreview($Camera $instance) throws Exception {
       return  $instance
          .$startPreview();
    }
    
    public void $stopPreview($Camera $instance) throws Exception {
       return  $instance
          .$stopPreview();
    }
    
    public Integer $attachPreviewTexture($Camera $instance) throws Exception {
       $instance
          .$attachPreviewTexture();
    }
    
    public void $releasePreviewTexture($Camera $instance) throws Exception {
       return  $instance
          .$releasePreviewTexture();
    }
    
    public void $unlock($Camera $instance) throws Exception {
       return  $instance
          .$unlock();
    }
    
    public void $reconnect($Camera $instance) throws Exception {
       return  $instance
          .$reconnect();
    }
    
    public void $takePicture($Camera $instance,$ShutterCallback shutter,$PictureCallback raw,$PictureCallback postView,$PictureCallback jpeg) throws Exception {
       return  $instance
          .$takePicture( shutter  raw  postView  jpeg );
    }
    
    public void $autoFocus($Camera $instance,$AutoFocusCallback callback) throws Exception {
       return  $instance
          .$autoFocus( callback );
    }
    
    public void $cancelAutoFocus($Camera $instance) throws Exception {
       return  $instance
          .$cancelAutoFocus();
    }
    
    public void $setDisplayOrientation($Camera $instance,Integer degrees) throws Exception {
       return  $instance
          .$setDisplayOrientation( degrees );
    }
    
    public void $setErrorCallback($Camera $instance,$ErrorCallback callback) throws Exception {
       return  $instance
          .$setErrorCallback( callback );
    }
    
    public void $startSmoothZoom($Camera $instance,Integer value) throws Exception {
       return  $instance
          .$startSmoothZoom( value );
    }
    
    public void $stopSmoothZoom($Camera $instance) throws Exception {
       return  $instance
          .$stopSmoothZoom();
    }
    
    public $CameraParameters $getParameters($Camera $instance) throws Exception {
       $instance
          .$getParameters();
    }
    
    public void $setParameters($Camera $instance,$CameraParameters parameters) throws Exception {
       return  $instance
          .$setParameters( parameters );
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

    

    
    public Boolean $getAutoExposureLock($CameraParameters $instance) throws Exception {
       $instance
          .$getAutoExposureLock();
    }
    
    public List<$CameraArea> $getFocusAreas($CameraParameters $instance) throws Exception {
       $instance
          .$getFocusAreas();
    }
    
    public List<Double> $getFocusDistances($CameraParameters $instance) throws Exception {
       $instance
          .$getFocusDistances();
    }
    
    public Integer $getMaxExposureCompensation($CameraParameters $instance) throws Exception {
       $instance
          .$getMaxExposureCompensation();
    }
    
    public Integer $getMaxNumFocusAreas($CameraParameters $instance) throws Exception {
       $instance
          .$getMaxNumFocusAreas();
    }
    
    public Integer $getMinExposureCompensation($CameraParameters $instance) throws Exception {
       $instance
          .$getMinExposureCompensation();
    }
    
    public List<String> $getSupportedFocusModes($CameraParameters $instance) throws Exception {
       $instance
          .$getSupportedFocusModes();
    }
    
    public Boolean $isAutoExposureLockSupported($CameraParameters $instance) throws Exception {
       $instance
          .$isAutoExposureLockSupported();
    }
    
    public Boolean $isZoomSupported($CameraParameters $instance) throws Exception {
       $instance
          .$isZoomSupported();
    }
    
    public void $setAutoExposureLock($CameraParameters $instance,Boolean toggle) throws Exception {
       return  $instance
          .$setAutoExposureLock( toggle );
    }
    
    public void $setExposureCompensation($CameraParameters $instance,Integer value) throws Exception {
       return  $instance
          .$setExposureCompensation( value );
    }
    
    public void $setFocusAreas($CameraParameters $instance,List<$CameraArea> focusAreas) throws Exception {
       return  $instance
          .$setFocusAreas( focusAreas );
    }
    
    public void $setFocusMode($CameraParameters $instance,String value) throws Exception {
       return  $instance
          .$setFocusMode( value );
    }
    
    public String $getFlashMode($CameraParameters $instance) throws Exception {
       $instance
          .$getFlashMode();
    }
    
    public Integer $getMaxZoom($CameraParameters $instance) throws Exception {
       $instance
          .$getMaxZoom();
    }
    
    public $CameraSize $getPictureSize($CameraParameters $instance) throws Exception {
       $instance
          .$getPictureSize();
    }
    
    public $CameraSize $getPreviewSize($CameraParameters $instance) throws Exception {
       $instance
          .$getPreviewSize();
    }
    
    public List<$CameraSize> $getSupportedPreviewSizes($CameraParameters $instance) throws Exception {
       $instance
          .$getSupportedPreviewSizes();
    }
    
    public List<$CameraSize> $getSupportedPictureSizes($CameraParameters $instance) throws Exception {
       $instance
          .$getSupportedPictureSizes();
    }
    
    public List<String> $getSupportedFlashModes($CameraParameters $instance) throws Exception {
       $instance
          .$getSupportedFlashModes();
    }
    
    public Integer $getZoom($CameraParameters $instance) throws Exception {
       $instance
          .$getZoom();
    }
    
    public Boolean $isSmoothZoomSupported($CameraParameters $instance) throws Exception {
       $instance
          .$isSmoothZoomSupported();
    }
    
    public void $setFlashMode($CameraParameters $instance,String mode) throws Exception {
       return  $instance
          .$setFlashMode( mode );
    }
    
    public void $setPictureSize($CameraParameters $instance,Integer width,Integer height) throws Exception {
       return  $instance
          .$setPictureSize( width  height );
    }
    
    public void $setRecordingHint($CameraParameters $instance,Boolean hint) throws Exception {
       return  $instance
          .$setRecordingHint( hint );
    }
    
    public void $setRotation($CameraParameters $instance,Integer rotation) throws Exception {
       return  $instance
          .$setRotation( rotation );
    }
    
    public void $setZoom($CameraParameters $instance,Integer value) throws Exception {
       return  $instance
          .$setZoom( value );
    }
    
    public void $setPreviewSize($CameraParameters $instance,Integer width,Integer height) throws Exception {
       return  $instance
          .$setPreviewSize( width  height );
    }
    
    public Integer $getExposureCompensation($CameraParameters $instance) throws Exception {
       $instance
          .$getExposureCompensation();
    }
    
    public Double $getExposureCompensationStep($CameraParameters $instance) throws Exception {
       $instance
          .$getExposureCompensationStep();
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

    

    
    public void $onError($ErrorCallback $instance,Integer error) throws Exception {
       return  $instance
          .$onError( error );
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
        
        case "onError":
          return $onError(instance,(Integer) arguments.get(0));
        
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

    

    
    public void $onAutoFocus($AutoFocusCallback $instance,Boolean success) throws Exception {
       return  $instance
          .$onAutoFocus( success );
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
        
        case "onAutoFocus":
          return $onAutoFocus(instance,(Boolean) arguments.get(0));
        
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

    

    
    public void $onShutter($ShutterCallback $instance) throws Exception {
       return  $instance
          .$onShutter();
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
        
        case "onShutter":
          return $onShutter(instance);
        
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

    

    
    public void $onPictureTaken($PictureCallback $instance,byte[] data) throws Exception {
       return  $instance
          .$onPictureTaken( data );
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
        
        case "onPictureTaken":
          return $onPictureTaken(instance,(byte[]) arguments.get(0));
        
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

    

    
    public void $setCamera($MediaRecorder $instance,$Camera camera) throws Exception {
       return  $instance
          .$setCamera( camera );
    }
    
    public void $setVideoSource($MediaRecorder $instance,Integer source) throws Exception {
       return  $instance
          .$setVideoSource( source );
    }
    
    public void $setOutputFilePath($MediaRecorder $instance,String path) throws Exception {
       return  $instance
          .$setOutputFilePath( path );
    }
    
    public void $setOutputFormat($MediaRecorder $instance,Integer format) throws Exception {
       return  $instance
          .$setOutputFormat( format );
    }
    
    public void $setVideoEncoder($MediaRecorder $instance,Integer encoder) throws Exception {
       return  $instance
          .$setVideoEncoder( encoder );
    }
    
    public void $setAudioSource($MediaRecorder $instance,Integer source) throws Exception {
       return  $instance
          .$setAudioSource( source );
    }
    
    public void $setAudioEncoder($MediaRecorder $instance,Integer encoder) throws Exception {
       return  $instance
          .$setAudioEncoder( encoder );
    }
    
    public void $prepare($MediaRecorder $instance) throws Exception {
       return  $instance
          .$prepare();
    }
    
    public void $start($MediaRecorder $instance) throws Exception {
       return  $instance
          .$start();
    }
    
    public void $stop($MediaRecorder $instance) throws Exception {
       return  $instance
          .$stop();
    }
    
    public void $release($MediaRecorder $instance) throws Exception {
       return  $instance
          .$release();
    }
    
    public void $pause($MediaRecorder $instance) throws Exception {
       return  $instance
          .$pause();
    }
    
    public void $resume($MediaRecorder $instance) throws Exception {
       return  $instance
          .$resume();
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
