// GENERATED CODE - DO NOT MODIFY BY HAND


package github.bparrishMines.penguin.penguin_android_camera;


import androidx.annotation.NonNull;

import java.util.*;

import github.penguin.reference.async.Completable;
import github.penguin.reference.reference.PairedInstance;
import github.penguin.reference.reference.TypeChannel;
import github.penguin.reference.reference.TypeChannelHandler;
import github.penguin.reference.reference.TypeChannelMessenger;

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

public class CameraChannelLibrary {
  
  public static abstract class $ErrorCallback {
    public abstract Object invoke(Integer error);
  }
  
  public static abstract class $AutoFocusCallback {
    public abstract Object invoke(Boolean success);
  }
  
  public static abstract class $ShutterCallback {
    public abstract Object invoke();
  }
  
  public static abstract class $DataCallback {
    public abstract Object invoke(byte[] data);
  }
  
  public static abstract class $OnZoomChangeListener {
    public abstract Object invoke(Integer zoomValue,Boolean stopped);
  }
  
  public static abstract class $AutoFocusMoveCallback {
    public abstract Object invoke(Boolean start);
  }
  
  public static abstract class $OnErrorListener {
    public abstract Object invoke(Integer what,Integer extra);
  }
  
  public static abstract class $OnInfoListener {
    public abstract Object invoke(Integer what,Integer extra);
  }
  

  
  public static class $ErrorCallbackChannel extends TypeChannel<$ErrorCallback> {
    public $ErrorCallbackChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/ErrorCallback");
    }

    public Completable<PairedInstance> $$create($ErrorCallback $instance, boolean $owner) {
      return createNewInstancePair($instance, Collections.emptyList(), $owner);
    }

    private Completable<Object> invoke($ErrorCallback $instance
        ,Integer error) {
      return invokeMethod($instance, "", Arrays.<Object>asList(error));
    }
  }
  
  public static class $AutoFocusCallbackChannel extends TypeChannel<$AutoFocusCallback> {
    public $AutoFocusCallbackChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/AutoFocusCallback");
    }

    public Completable<PairedInstance> $$create($AutoFocusCallback $instance, boolean $owner) {
      return createNewInstancePair($instance, Collections.emptyList(), $owner);
    }

    private Completable<Object> invoke($AutoFocusCallback $instance
        ,Boolean success) {
      return invokeMethod($instance, "", Arrays.<Object>asList(success));
    }
  }
  
  public static class $ShutterCallbackChannel extends TypeChannel<$ShutterCallback> {
    public $ShutterCallbackChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/ShutterCallback");
    }

    public Completable<PairedInstance> $$create($ShutterCallback $instance, boolean $owner) {
      return createNewInstancePair($instance, Collections.emptyList(), $owner);
    }

    private Completable<Object> invoke($ShutterCallback $instance
        ) {
      return invokeMethod($instance, "", Arrays.<Object>asList());
    }
  }
  
  public static class $DataCallbackChannel extends TypeChannel<$DataCallback> {
    public $DataCallbackChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/DataCallback");
    }

    public Completable<PairedInstance> $$create($DataCallback $instance, boolean $owner) {
      return createNewInstancePair($instance, Collections.emptyList(), $owner);
    }

    private Completable<Object> invoke($DataCallback $instance
        ,byte[] data) {
      return invokeMethod($instance, "", Arrays.<Object>asList(data));
    }
  }
  
  public static class $OnZoomChangeListenerChannel extends TypeChannel<$OnZoomChangeListener> {
    public $OnZoomChangeListenerChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/OnZoomChangeListener");
    }

    public Completable<PairedInstance> $$create($OnZoomChangeListener $instance, boolean $owner) {
      return createNewInstancePair($instance, Collections.emptyList(), $owner);
    }

    private Completable<Object> invoke($OnZoomChangeListener $instance
        ,Integer zoomValue,Boolean stopped) {
      return invokeMethod($instance, "", Arrays.<Object>asList(zoomValue,stopped));
    }
  }
  
  public static class $AutoFocusMoveCallbackChannel extends TypeChannel<$AutoFocusMoveCallback> {
    public $AutoFocusMoveCallbackChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/AutoFocusMoveCallback");
    }

    public Completable<PairedInstance> $$create($AutoFocusMoveCallback $instance, boolean $owner) {
      return createNewInstancePair($instance, Collections.emptyList(), $owner);
    }

    private Completable<Object> invoke($AutoFocusMoveCallback $instance
        ,Boolean start) {
      return invokeMethod($instance, "", Arrays.<Object>asList(start));
    }
  }
  
  public static class $OnErrorListenerChannel extends TypeChannel<$OnErrorListener> {
    public $OnErrorListenerChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/OnErrorListener");
    }

    public Completable<PairedInstance> $$create($OnErrorListener $instance, boolean $owner) {
      return createNewInstancePair($instance, Collections.emptyList(), $owner);
    }

    private Completable<Object> invoke($OnErrorListener $instance
        ,Integer what,Integer extra) {
      return invokeMethod($instance, "", Arrays.<Object>asList(what,extra));
    }
  }
  
  public static class $OnInfoListenerChannel extends TypeChannel<$OnInfoListener> {
    public $OnInfoListenerChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/OnInfoListener");
    }

    public Completable<PairedInstance> $$create($OnInfoListener $instance, boolean $owner) {
      return createNewInstancePair($instance, Collections.emptyList(), $owner);
    }

    private Completable<Object> invoke($OnInfoListener $instance
        ,Integer what,Integer extra) {
      return invokeMethod($instance, "", Arrays.<Object>asList(what,extra));
    }
  }
  

  
  public static class $ErrorCallbackHandler implements TypeChannelHandler<$ErrorCallback> {
    public final $LibraryImplementations implementations;

    public $ErrorCallbackHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    @Override
    public $ErrorCallback createInstance(TypeChannelMessenger messenger, List<Object> arguments) {
      return new $ErrorCallback() {
        @Override
        public Object invoke(Integer error) {
          return implementations.getChannelErrorCallback().invoke(this,error);
        }
      };
    }

    @Override
    public Void invokeStaticMethod(TypeChannelMessenger messenger, String methodName, List<Object> arguments) {
      throw new UnsupportedOperationException();
    }

    @Override
    public Object invokeMethod(TypeChannelMessenger messenger, $ErrorCallback instance, String methodName, List<Object> arguments) throws Exception {
      return instance.invoke((Integer) arguments.get(0));
    }
  }
  
  public static class $AutoFocusCallbackHandler implements TypeChannelHandler<$AutoFocusCallback> {
    public final $LibraryImplementations implementations;

    public $AutoFocusCallbackHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    @Override
    public $AutoFocusCallback createInstance(TypeChannelMessenger messenger, List<Object> arguments) {
      return new $AutoFocusCallback() {
        @Override
        public Object invoke(Boolean success) {
          return implementations.getChannelAutoFocusCallback().invoke(this,success);
        }
      };
    }

    @Override
    public Void invokeStaticMethod(TypeChannelMessenger messenger, String methodName, List<Object> arguments) {
      throw new UnsupportedOperationException();
    }

    @Override
    public Object invokeMethod(TypeChannelMessenger messenger, $AutoFocusCallback instance, String methodName, List<Object> arguments) throws Exception {
      return instance.invoke((Boolean) arguments.get(0));
    }
  }
  
  public static class $ShutterCallbackHandler implements TypeChannelHandler<$ShutterCallback> {
    public final $LibraryImplementations implementations;

    public $ShutterCallbackHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    @Override
    public $ShutterCallback createInstance(TypeChannelMessenger messenger, List<Object> arguments) {
      return new $ShutterCallback() {
        @Override
        public Object invoke() {
          return implementations.getChannelShutterCallback().invoke(this);
        }
      };
    }

    @Override
    public Void invokeStaticMethod(TypeChannelMessenger messenger, String methodName, List<Object> arguments) {
      throw new UnsupportedOperationException();
    }

    @Override
    public Object invokeMethod(TypeChannelMessenger messenger, $ShutterCallback instance, String methodName, List<Object> arguments) throws Exception {
      return instance.invoke();
    }
  }
  
  public static class $DataCallbackHandler implements TypeChannelHandler<$DataCallback> {
    public final $LibraryImplementations implementations;

    public $DataCallbackHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    @Override
    public $DataCallback createInstance(TypeChannelMessenger messenger, List<Object> arguments) {
      return new $DataCallback() {
        @Override
        public Object invoke(byte[] data) {
          return implementations.getChannelDataCallback().invoke(this,data);
        }
      };
    }

    @Override
    public Void invokeStaticMethod(TypeChannelMessenger messenger, String methodName, List<Object> arguments) {
      throw new UnsupportedOperationException();
    }

    @Override
    public Object invokeMethod(TypeChannelMessenger messenger, $DataCallback instance, String methodName, List<Object> arguments) throws Exception {
      return instance.invoke((byte[]) arguments.get(0));
    }
  }
  
  public static class $OnZoomChangeListenerHandler implements TypeChannelHandler<$OnZoomChangeListener> {
    public final $LibraryImplementations implementations;

    public $OnZoomChangeListenerHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    @Override
    public $OnZoomChangeListener createInstance(TypeChannelMessenger messenger, List<Object> arguments) {
      return new $OnZoomChangeListener() {
        @Override
        public Object invoke(Integer zoomValue,Boolean stopped) {
          return implementations.getChannelOnZoomChangeListener().invoke(this,zoomValue,stopped);
        }
      };
    }

    @Override
    public Void invokeStaticMethod(TypeChannelMessenger messenger, String methodName, List<Object> arguments) {
      throw new UnsupportedOperationException();
    }

    @Override
    public Object invokeMethod(TypeChannelMessenger messenger, $OnZoomChangeListener instance, String methodName, List<Object> arguments) throws Exception {
      return instance.invoke((Integer) arguments.get(0),(Boolean) arguments.get(1));
    }
  }
  
  public static class $AutoFocusMoveCallbackHandler implements TypeChannelHandler<$AutoFocusMoveCallback> {
    public final $LibraryImplementations implementations;

    public $AutoFocusMoveCallbackHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    @Override
    public $AutoFocusMoveCallback createInstance(TypeChannelMessenger messenger, List<Object> arguments) {
      return new $AutoFocusMoveCallback() {
        @Override
        public Object invoke(Boolean start) {
          return implementations.getChannelAutoFocusMoveCallback().invoke(this,start);
        }
      };
    }

    @Override
    public Void invokeStaticMethod(TypeChannelMessenger messenger, String methodName, List<Object> arguments) {
      throw new UnsupportedOperationException();
    }

    @Override
    public Object invokeMethod(TypeChannelMessenger messenger, $AutoFocusMoveCallback instance, String methodName, List<Object> arguments) throws Exception {
      return instance.invoke((Boolean) arguments.get(0));
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
        public Object invoke(Integer what,Integer extra) {
          return implementations.getChannelOnErrorListener().invoke(this,what,extra);
        }
      };
    }

    @Override
    public Void invokeStaticMethod(TypeChannelMessenger messenger, String methodName, List<Object> arguments) {
      throw new UnsupportedOperationException();
    }

    @Override
    public Object invokeMethod(TypeChannelMessenger messenger, $OnErrorListener instance, String methodName, List<Object> arguments) throws Exception {
      return instance.invoke((Integer) arguments.get(0),(Integer) arguments.get(1));
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
        public Object invoke(Integer what,Integer extra) {
          return implementations.getChannelOnInfoListener().invoke(this,what,extra);
        }
      };
    }

    @Override
    public Void invokeStaticMethod(TypeChannelMessenger messenger, String methodName, List<Object> arguments) {
      throw new UnsupportedOperationException();
    }

    @Override
    public Object invokeMethod(TypeChannelMessenger messenger, $OnInfoListener instance, String methodName, List<Object> arguments) throws Exception {
      return instance.invoke((Integer) arguments.get(0),(Integer) arguments.get(1));
    }
  }
  

  
  public interface $PictureCallback {
    
  }
  
  public interface $PreviewCallback {
    
  }
  
  public interface $Camera {
    
    
    Object release() throws Exception;
    
    
    
    Object startPreview() throws Exception;
    
    
    
    Object stopPreview() throws Exception;
    
    
    
    Object attachPreviewTexture() throws Exception;
    
    
    
    Object releasePreviewTexture() throws Exception;
    
    
    
    Object unlock() throws Exception;
    
    
    
    Object setOneShotPreviewCallback($PreviewCallback callback) throws Exception;
    
    
    
    Object setPreviewCallback($PreviewCallback callback) throws Exception;
    
    
    
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
    
    
    
    Object setZoomChangeListener($OnZoomChangeListener listener) throws Exception;
    
    
    
    Object setAutoFocusMoveCallback($AutoFocusMoveCallback callback) throws Exception;
    
    
    
    Object lock() throws Exception;
    
    
    
    Object enableShutterSound(Boolean enabled) throws Exception;
    
    
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
    
    
    
    Object flatten() throws Exception;
    
    
    
    Object get(String key) throws Exception;
    
    
    
    Object getAntibanding() throws Exception;
    
    
    
    Object getAutoWhiteBalanceLock() throws Exception;
    
    
    
    Object getColorEffect() throws Exception;
    
    
    
    Object getFocalLength() throws Exception;
    
    
    
    Object getFocusMode() throws Exception;
    
    
    
    Object getHorizontalViewAngle() throws Exception;
    
    
    
    Object getInt(String key) throws Exception;
    
    
    
    Object getJpegQuality() throws Exception;
    
    
    
    Object getJpegThumbnailQuality() throws Exception;
    
    
    
    Object getJpegThumbnailSize() throws Exception;
    
    
    
    Object getMaxNumMeteringAreas() throws Exception;
    
    
    
    Object getMeteringAreas() throws Exception;
    
    
    
    Object getPictureFormat() throws Exception;
    
    
    
    Object getPreferredPreviewSizeForVideo() throws Exception;
    
    
    
    Object getPreviewFormat() throws Exception;
    
    
    
    Object getPreviewFpsRange() throws Exception;
    
    
    
    Object getSceneMode() throws Exception;
    
    
    
    Object getSupportedAntibanding() throws Exception;
    
    
    
    Object getSupportedColorEffects() throws Exception;
    
    
    
    Object getSupportedJpegThumbnailSizes() throws Exception;
    
    
    
    Object getSupportedPictureFormats() throws Exception;
    
    
    
    Object getSupportedPreviewFormats() throws Exception;
    
    
    
    Object getSupportedPreviewFpsRange() throws Exception;
    
    
    
    Object getSupportedSceneModes() throws Exception;
    
    
    
    Object getSupportedVideoSizes() throws Exception;
    
    
    
    Object getSupportedWhiteBalance() throws Exception;
    
    
    
    Object getVerticalViewAngle() throws Exception;
    
    
    
    Object getVideoStabilization() throws Exception;
    
    
    
    Object getWhiteBalance() throws Exception;
    
    
    
    Object getZoomRatios() throws Exception;
    
    
    
    Object isAutoWhiteBalanceLockSupported() throws Exception;
    
    
    
    Object isVideoSnapshotSupported() throws Exception;
    
    
    
    Object isVideoStabilizationSupported() throws Exception;
    
    
    
    Object remove(String key) throws Exception;
    
    
    
    Object removeGpsData() throws Exception;
    
    
    
    Object set(String key,Object value) throws Exception;
    
    
    
    Object setAntibanding(String antibanding) throws Exception;
    
    
    
    Object setAutoWhiteBalanceLock(Boolean toggle) throws Exception;
    
    
    
    Object setColorEffect(String effect) throws Exception;
    
    
    
    Object setGpsAltitude(Double meters) throws Exception;
    
    
    
    Object setGpsLatitude(Double latitude) throws Exception;
    
    
    
    Object setGpsLongitude(Double longitude) throws Exception;
    
    
    
    Object setGpsProcessingMethod(String processingMethod) throws Exception;
    
    
    
    Object setGpsTimestamp(Integer timestamp) throws Exception;
    
    
    
    Object setJpegQuality(Integer quality) throws Exception;
    
    
    
    Object setJpegThumbnailQuality(Integer quality) throws Exception;
    
    
    
    Object setJpegThumbnailSize(Integer width,Integer height) throws Exception;
    
    
    
    Object setMeteringAreas(List<$CameraArea> meteringAreas) throws Exception;
    
    
    
    Object setPictureFormat(Integer pixelFormat) throws Exception;
    
    
    
    Object setPreviewFormat(Integer pixelFormat) throws Exception;
    
    
    
    Object setPreviewFpsRange(Integer min,Integer max) throws Exception;
    
    
    
    Object setSceneMode(String mode) throws Exception;
    
    
    
    Object setVideoStabilization(Boolean toggle) throws Exception;
    
    
    
    Object setWhiteBalance(String value) throws Exception;
    
    
    
    Object unflatten(String flattened) throws Exception;
    
    
  }
  
  public interface $CameraArea {
    
  }
  
  public interface $CameraRect {
    
  }
  
  public interface $CameraSize {
    
  }
  
  public interface $CameraInfo {
    
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
    
    
    
    Object getMaxAmplitude() throws Exception;
    
    
    
    Object reset() throws Exception;
    
    
    
    Object setAudioChannels(Integer numChannels) throws Exception;
    
    
    
    Object setAudioEncodingBitRate(Integer bitRate) throws Exception;
    
    
    
    Object setAudioSamplingRate(Integer samplingRate) throws Exception;
    
    
    
    Object setCaptureRate(Double fps) throws Exception;
    
    
    
    Object setLocation(Double latitude,Double longitude) throws Exception;
    
    
    
    Object setMaxDuration(Integer maxDurationMs) throws Exception;
    
    
    
    Object setMaxFileSize(Integer maxFilesizeBytes) throws Exception;
    
    
    
    Object setOnErrorListener($OnErrorListener onError) throws Exception;
    
    
    
    Object setOnInfoListener($OnInfoListener onInfo) throws Exception;
    
    
    
    Object setOrientationHint(Integer degrees) throws Exception;
    
    
    
    Object setVideoEncodingBitRate(Integer bitRate) throws Exception;
    
    
    
    Object setVideoFrameRate(Integer rate) throws Exception;
    
    
    
    Object setVideoSize(Integer width,Integer height) throws Exception;
    
    
    
    Object setProfile($CamcorderProfile profile) throws Exception;
    
    
  }
  
  public interface $ImageFormat {
    
  }
  
  public interface $CamcorderProfile {
    
  }
  

  
  public static class $PictureCallbackChannel extends TypeChannel<$PictureCallback> {
    public $PictureCallbackChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/PictureCallback");
    }

    public Completable<PairedInstance> $$create($PictureCallback $instance, boolean $owner,$DataCallback onPictureTaken) {
      return createNewInstancePair($instance, Arrays.<Object>asList(onPictureTaken), $owner);
    }

    

    
  }
  
  public static class $PreviewCallbackChannel extends TypeChannel<$PreviewCallback> {
    public $PreviewCallbackChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/PreviewCallback");
    }

    public Completable<PairedInstance> $$create($PreviewCallback $instance, boolean $owner,$DataCallback onPreviewFrame) {
      return createNewInstancePair($instance, Arrays.<Object>asList(onPreviewFrame), $owner);
    }

    

    
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
  
  public static class $CameraInfoChannel extends TypeChannel<$CameraInfo> {
    public $CameraInfoChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/CameraInfo");
    }

    public Completable<PairedInstance> $$create($CameraInfo $instance, boolean $owner,Integer cameraId,Integer facing,Integer orientation,Boolean canDisableShutterSound) {
      return createNewInstancePair($instance, Arrays.<Object>asList(cameraId,facing,orientation,canDisableShutterSound), $owner);
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
  
  public static class $ImageFormatChannel extends TypeChannel<$ImageFormat> {
    public $ImageFormatChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/ImageFormat");
    }

    public Completable<PairedInstance> $$create($ImageFormat $instance, boolean $owner) {
      return createNewInstancePair($instance, Arrays.<Object>asList(), $owner);
    }

    
    
    

    
  }
  
  public static class $CamcorderProfileChannel extends TypeChannel<$CamcorderProfile> {
    public $CamcorderProfileChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_android_camera/camera/ImageFormat");
    }

    public Completable<PairedInstance> $$create($CamcorderProfile $instance, boolean $owner,Integer audioBitRate,Integer audioChannels,Integer audioCodec,Integer audioSampleRate,Integer duration,Integer fileFormat,Integer quality,Integer videoBitRate,Integer videoCodec,Integer videoFrameHeight,Integer videoFrameRate,Integer videoFrameWidth) {
      return createNewInstancePair($instance, Arrays.<Object>asList(audioBitRate,audioChannels,audioCodec,audioSampleRate,duration,fileFormat,quality,videoBitRate,videoCodec,videoFrameHeight,videoFrameRate,videoFrameWidth), $owner);
    }

    
    
    
    
    

    
  }
  

  
  public static class $PictureCallbackHandler implements TypeChannelHandler<$PictureCallback> {
    public $PictureCallback $$create(TypeChannelMessenger messenger,$DataCallback onPictureTaken)
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
      return $$create(messenger,($DataCallback) arguments.get(0));
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
  
  public static class $PreviewCallbackHandler implements TypeChannelHandler<$PreviewCallback> {
    public $PreviewCallback $$create(TypeChannelMessenger messenger,$DataCallback onPreviewFrame)
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
    public $PreviewCallback createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      return $$create(messenger,($DataCallback) arguments.get(0));
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        $PreviewCallback instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      switch(methodName) {
        
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
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
    
    
    
    public Object $setOneShotPreviewCallback($Camera $instance,$PreviewCallback callback) throws Exception {
      return $instance.setOneShotPreviewCallback( callback );
    }
    
    
    
    public Object $setPreviewCallback($Camera $instance,$PreviewCallback callback) throws Exception {
      return $instance.setPreviewCallback( callback );
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
    
    
    
    public Object $setZoomChangeListener($Camera $instance,$OnZoomChangeListener listener) throws Exception {
      return $instance.setZoomChangeListener( listener );
    }
    
    
    
    public Object $setAutoFocusMoveCallback($Camera $instance,$AutoFocusMoveCallback callback) throws Exception {
      return $instance.setAutoFocusMoveCallback( callback );
    }
    
    
    
    public Object $lock($Camera $instance) throws Exception {
      return $instance.lock();
    }
    
    
    
    public Object $enableShutterSound($Camera $instance,Boolean enabled) throws Exception {
      return $instance.enableShutterSound( enabled );
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
        
        
        
        case "setOneShotPreviewCallback":
          return $setOneShotPreviewCallback(instance,($PreviewCallback) arguments.get(0));
        
        
        
        case "setPreviewCallback":
          return $setPreviewCallback(instance,($PreviewCallback) arguments.get(0));
        
        
        
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
        
        
        
        case "setZoomChangeListener":
          return $setZoomChangeListener(instance,($OnZoomChangeListener) arguments.get(0));
        
        
        
        case "setAutoFocusMoveCallback":
          return $setAutoFocusMoveCallback(instance,($AutoFocusMoveCallback) arguments.get(0));
        
        
        
        case "lock":
          return $lock(instance);
        
        
        
        case "enableShutterSound":
          return $enableShutterSound(instance,(Boolean) arguments.get(0));
        
        
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
    
    
    
    public Object $flatten($CameraParameters $instance) throws Exception {
      return $instance.flatten();
    }
    
    
    
    public Object $get($CameraParameters $instance,String key) throws Exception {
      return $instance.get( key );
    }
    
    
    
    public Object $getAntibanding($CameraParameters $instance) throws Exception {
      return $instance.getAntibanding();
    }
    
    
    
    public Object $getAutoWhiteBalanceLock($CameraParameters $instance) throws Exception {
      return $instance.getAutoWhiteBalanceLock();
    }
    
    
    
    public Object $getColorEffect($CameraParameters $instance) throws Exception {
      return $instance.getColorEffect();
    }
    
    
    
    public Object $getFocalLength($CameraParameters $instance) throws Exception {
      return $instance.getFocalLength();
    }
    
    
    
    public Object $getFocusMode($CameraParameters $instance) throws Exception {
      return $instance.getFocusMode();
    }
    
    
    
    public Object $getHorizontalViewAngle($CameraParameters $instance) throws Exception {
      return $instance.getHorizontalViewAngle();
    }
    
    
    
    public Object $getInt($CameraParameters $instance,String key) throws Exception {
      return $instance.getInt( key );
    }
    
    
    
    public Object $getJpegQuality($CameraParameters $instance) throws Exception {
      return $instance.getJpegQuality();
    }
    
    
    
    public Object $getJpegThumbnailQuality($CameraParameters $instance) throws Exception {
      return $instance.getJpegThumbnailQuality();
    }
    
    
    
    public Object $getJpegThumbnailSize($CameraParameters $instance) throws Exception {
      return $instance.getJpegThumbnailSize();
    }
    
    
    
    public Object $getMaxNumMeteringAreas($CameraParameters $instance) throws Exception {
      return $instance.getMaxNumMeteringAreas();
    }
    
    
    
    public Object $getMeteringAreas($CameraParameters $instance) throws Exception {
      return $instance.getMeteringAreas();
    }
    
    
    
    public Object $getPictureFormat($CameraParameters $instance) throws Exception {
      return $instance.getPictureFormat();
    }
    
    
    
    public Object $getPreferredPreviewSizeForVideo($CameraParameters $instance) throws Exception {
      return $instance.getPreferredPreviewSizeForVideo();
    }
    
    
    
    public Object $getPreviewFormat($CameraParameters $instance) throws Exception {
      return $instance.getPreviewFormat();
    }
    
    
    
    public Object $getPreviewFpsRange($CameraParameters $instance) throws Exception {
      return $instance.getPreviewFpsRange();
    }
    
    
    
    public Object $getSceneMode($CameraParameters $instance) throws Exception {
      return $instance.getSceneMode();
    }
    
    
    
    public Object $getSupportedAntibanding($CameraParameters $instance) throws Exception {
      return $instance.getSupportedAntibanding();
    }
    
    
    
    public Object $getSupportedColorEffects($CameraParameters $instance) throws Exception {
      return $instance.getSupportedColorEffects();
    }
    
    
    
    public Object $getSupportedJpegThumbnailSizes($CameraParameters $instance) throws Exception {
      return $instance.getSupportedJpegThumbnailSizes();
    }
    
    
    
    public Object $getSupportedPictureFormats($CameraParameters $instance) throws Exception {
      return $instance.getSupportedPictureFormats();
    }
    
    
    
    public Object $getSupportedPreviewFormats($CameraParameters $instance) throws Exception {
      return $instance.getSupportedPreviewFormats();
    }
    
    
    
    public Object $getSupportedPreviewFpsRange($CameraParameters $instance) throws Exception {
      return $instance.getSupportedPreviewFpsRange();
    }
    
    
    
    public Object $getSupportedSceneModes($CameraParameters $instance) throws Exception {
      return $instance.getSupportedSceneModes();
    }
    
    
    
    public Object $getSupportedVideoSizes($CameraParameters $instance) throws Exception {
      return $instance.getSupportedVideoSizes();
    }
    
    
    
    public Object $getSupportedWhiteBalance($CameraParameters $instance) throws Exception {
      return $instance.getSupportedWhiteBalance();
    }
    
    
    
    public Object $getVerticalViewAngle($CameraParameters $instance) throws Exception {
      return $instance.getVerticalViewAngle();
    }
    
    
    
    public Object $getVideoStabilization($CameraParameters $instance) throws Exception {
      return $instance.getVideoStabilization();
    }
    
    
    
    public Object $getWhiteBalance($CameraParameters $instance) throws Exception {
      return $instance.getWhiteBalance();
    }
    
    
    
    public Object $getZoomRatios($CameraParameters $instance) throws Exception {
      return $instance.getZoomRatios();
    }
    
    
    
    public Object $isAutoWhiteBalanceLockSupported($CameraParameters $instance) throws Exception {
      return $instance.isAutoWhiteBalanceLockSupported();
    }
    
    
    
    public Object $isVideoSnapshotSupported($CameraParameters $instance) throws Exception {
      return $instance.isVideoSnapshotSupported();
    }
    
    
    
    public Object $isVideoStabilizationSupported($CameraParameters $instance) throws Exception {
      return $instance.isVideoStabilizationSupported();
    }
    
    
    
    public Object $remove($CameraParameters $instance,String key) throws Exception {
      return $instance.remove( key );
    }
    
    
    
    public Object $removeGpsData($CameraParameters $instance) throws Exception {
      return $instance.removeGpsData();
    }
    
    
    
    public Object $set($CameraParameters $instance,String key,Object value) throws Exception {
      return $instance.set( key , value );
    }
    
    
    
    public Object $setAntibanding($CameraParameters $instance,String antibanding) throws Exception {
      return $instance.setAntibanding( antibanding );
    }
    
    
    
    public Object $setAutoWhiteBalanceLock($CameraParameters $instance,Boolean toggle) throws Exception {
      return $instance.setAutoWhiteBalanceLock( toggle );
    }
    
    
    
    public Object $setColorEffect($CameraParameters $instance,String effect) throws Exception {
      return $instance.setColorEffect( effect );
    }
    
    
    
    public Object $setGpsAltitude($CameraParameters $instance,Double meters) throws Exception {
      return $instance.setGpsAltitude( meters );
    }
    
    
    
    public Object $setGpsLatitude($CameraParameters $instance,Double latitude) throws Exception {
      return $instance.setGpsLatitude( latitude );
    }
    
    
    
    public Object $setGpsLongitude($CameraParameters $instance,Double longitude) throws Exception {
      return $instance.setGpsLongitude( longitude );
    }
    
    
    
    public Object $setGpsProcessingMethod($CameraParameters $instance,String processingMethod) throws Exception {
      return $instance.setGpsProcessingMethod( processingMethod );
    }
    
    
    
    public Object $setGpsTimestamp($CameraParameters $instance,Integer timestamp) throws Exception {
      return $instance.setGpsTimestamp( timestamp );
    }
    
    
    
    public Object $setJpegQuality($CameraParameters $instance,Integer quality) throws Exception {
      return $instance.setJpegQuality( quality );
    }
    
    
    
    public Object $setJpegThumbnailQuality($CameraParameters $instance,Integer quality) throws Exception {
      return $instance.setJpegThumbnailQuality( quality );
    }
    
    
    
    public Object $setJpegThumbnailSize($CameraParameters $instance,Integer width,Integer height) throws Exception {
      return $instance.setJpegThumbnailSize( width , height );
    }
    
    
    
    public Object $setMeteringAreas($CameraParameters $instance,List<$CameraArea> meteringAreas) throws Exception {
      return $instance.setMeteringAreas( meteringAreas );
    }
    
    
    
    public Object $setPictureFormat($CameraParameters $instance,Integer pixelFormat) throws Exception {
      return $instance.setPictureFormat( pixelFormat );
    }
    
    
    
    public Object $setPreviewFormat($CameraParameters $instance,Integer pixelFormat) throws Exception {
      return $instance.setPreviewFormat( pixelFormat );
    }
    
    
    
    public Object $setPreviewFpsRange($CameraParameters $instance,Integer min,Integer max) throws Exception {
      return $instance.setPreviewFpsRange( min , max );
    }
    
    
    
    public Object $setSceneMode($CameraParameters $instance,String mode) throws Exception {
      return $instance.setSceneMode( mode );
    }
    
    
    
    public Object $setVideoStabilization($CameraParameters $instance,Boolean toggle) throws Exception {
      return $instance.setVideoStabilization( toggle );
    }
    
    
    
    public Object $setWhiteBalance($CameraParameters $instance,String value) throws Exception {
      return $instance.setWhiteBalance( value );
    }
    
    
    
    public Object $unflatten($CameraParameters $instance,String flattened) throws Exception {
      return $instance.unflatten( flattened );
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
        
        
        
        case "flatten":
          return $flatten(instance);
        
        
        
        case "get":
          return $get(instance,(String) arguments.get(0));
        
        
        
        case "getAntibanding":
          return $getAntibanding(instance);
        
        
        
        case "getAutoWhiteBalanceLock":
          return $getAutoWhiteBalanceLock(instance);
        
        
        
        case "getColorEffect":
          return $getColorEffect(instance);
        
        
        
        case "getFocalLength":
          return $getFocalLength(instance);
        
        
        
        case "getFocusMode":
          return $getFocusMode(instance);
        
        
        
        case "getHorizontalViewAngle":
          return $getHorizontalViewAngle(instance);
        
        
        
        case "getInt":
          return $getInt(instance,(String) arguments.get(0));
        
        
        
        case "getJpegQuality":
          return $getJpegQuality(instance);
        
        
        
        case "getJpegThumbnailQuality":
          return $getJpegThumbnailQuality(instance);
        
        
        
        case "getJpegThumbnailSize":
          return $getJpegThumbnailSize(instance);
        
        
        
        case "getMaxNumMeteringAreas":
          return $getMaxNumMeteringAreas(instance);
        
        
        
        case "getMeteringAreas":
          return $getMeteringAreas(instance);
        
        
        
        case "getPictureFormat":
          return $getPictureFormat(instance);
        
        
        
        case "getPreferredPreviewSizeForVideo":
          return $getPreferredPreviewSizeForVideo(instance);
        
        
        
        case "getPreviewFormat":
          return $getPreviewFormat(instance);
        
        
        
        case "getPreviewFpsRange":
          return $getPreviewFpsRange(instance);
        
        
        
        case "getSceneMode":
          return $getSceneMode(instance);
        
        
        
        case "getSupportedAntibanding":
          return $getSupportedAntibanding(instance);
        
        
        
        case "getSupportedColorEffects":
          return $getSupportedColorEffects(instance);
        
        
        
        case "getSupportedJpegThumbnailSizes":
          return $getSupportedJpegThumbnailSizes(instance);
        
        
        
        case "getSupportedPictureFormats":
          return $getSupportedPictureFormats(instance);
        
        
        
        case "getSupportedPreviewFormats":
          return $getSupportedPreviewFormats(instance);
        
        
        
        case "getSupportedPreviewFpsRange":
          return $getSupportedPreviewFpsRange(instance);
        
        
        
        case "getSupportedSceneModes":
          return $getSupportedSceneModes(instance);
        
        
        
        case "getSupportedVideoSizes":
          return $getSupportedVideoSizes(instance);
        
        
        
        case "getSupportedWhiteBalance":
          return $getSupportedWhiteBalance(instance);
        
        
        
        case "getVerticalViewAngle":
          return $getVerticalViewAngle(instance);
        
        
        
        case "getVideoStabilization":
          return $getVideoStabilization(instance);
        
        
        
        case "getWhiteBalance":
          return $getWhiteBalance(instance);
        
        
        
        case "getZoomRatios":
          return $getZoomRatios(instance);
        
        
        
        case "isAutoWhiteBalanceLockSupported":
          return $isAutoWhiteBalanceLockSupported(instance);
        
        
        
        case "isVideoSnapshotSupported":
          return $isVideoSnapshotSupported(instance);
        
        
        
        case "isVideoStabilizationSupported":
          return $isVideoStabilizationSupported(instance);
        
        
        
        case "remove":
          return $remove(instance,(String) arguments.get(0));
        
        
        
        case "removeGpsData":
          return $removeGpsData(instance);
        
        
        
        case "set":
          return $set(instance,(String) arguments.get(0),(Object) arguments.get(1));
        
        
        
        case "setAntibanding":
          return $setAntibanding(instance,(String) arguments.get(0));
        
        
        
        case "setAutoWhiteBalanceLock":
          return $setAutoWhiteBalanceLock(instance,(Boolean) arguments.get(0));
        
        
        
        case "setColorEffect":
          return $setColorEffect(instance,(String) arguments.get(0));
        
        
        
        case "setGpsAltitude":
          return $setGpsAltitude(instance,(Double) arguments.get(0));
        
        
        
        case "setGpsLatitude":
          return $setGpsLatitude(instance,(Double) arguments.get(0));
        
        
        
        case "setGpsLongitude":
          return $setGpsLongitude(instance,(Double) arguments.get(0));
        
        
        
        case "setGpsProcessingMethod":
          return $setGpsProcessingMethod(instance,(String) arguments.get(0));
        
        
        
        case "setGpsTimestamp":
          return $setGpsTimestamp(instance,(Integer) arguments.get(0));
        
        
        
        case "setJpegQuality":
          return $setJpegQuality(instance,(Integer) arguments.get(0));
        
        
        
        case "setJpegThumbnailQuality":
          return $setJpegThumbnailQuality(instance,(Integer) arguments.get(0));
        
        
        
        case "setJpegThumbnailSize":
          return $setJpegThumbnailSize(instance,(Integer) arguments.get(0),(Integer) arguments.get(1));
        
        
        
        case "setMeteringAreas":
          return $setMeteringAreas(instance,(List<$CameraArea>) arguments.get(0));
        
        
        
        case "setPictureFormat":
          return $setPictureFormat(instance,(Integer) arguments.get(0));
        
        
        
        case "setPreviewFormat":
          return $setPreviewFormat(instance,(Integer) arguments.get(0));
        
        
        
        case "setPreviewFpsRange":
          return $setPreviewFpsRange(instance,(Integer) arguments.get(0),(Integer) arguments.get(1));
        
        
        
        case "setSceneMode":
          return $setSceneMode(instance,(String) arguments.get(0));
        
        
        
        case "setVideoStabilization":
          return $setVideoStabilization(instance,(Boolean) arguments.get(0));
        
        
        
        case "setWhiteBalance":
          return $setWhiteBalance(instance,(String) arguments.get(0));
        
        
        
        case "unflatten":
          return $unflatten(instance,(String) arguments.get(0));
        
        
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
  
  public static class $CameraInfoHandler implements TypeChannelHandler<$CameraInfo> {
    public $CameraInfo $$create(TypeChannelMessenger messenger,Integer cameraId,Integer facing,Integer orientation,Boolean canDisableShutterSound)
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
      return $$create(messenger,(Integer) arguments.get(0),(Integer) arguments.get(1),(Integer) arguments.get(2),(Boolean) arguments.get(3));
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

    
    
    public Object $getAudioSourceMax(TypeChannelMessenger messenger)
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
    
    
    
    public Object $getMaxAmplitude($MediaRecorder $instance) throws Exception {
      return $instance.getMaxAmplitude();
    }
    
    
    
    public Object $reset($MediaRecorder $instance) throws Exception {
      return $instance.reset();
    }
    
    
    
    public Object $setAudioChannels($MediaRecorder $instance,Integer numChannels) throws Exception {
      return $instance.setAudioChannels( numChannels );
    }
    
    
    
    public Object $setAudioEncodingBitRate($MediaRecorder $instance,Integer bitRate) throws Exception {
      return $instance.setAudioEncodingBitRate( bitRate );
    }
    
    
    
    public Object $setAudioSamplingRate($MediaRecorder $instance,Integer samplingRate) throws Exception {
      return $instance.setAudioSamplingRate( samplingRate );
    }
    
    
    
    public Object $setCaptureRate($MediaRecorder $instance,Double fps) throws Exception {
      return $instance.setCaptureRate( fps );
    }
    
    
    
    public Object $setLocation($MediaRecorder $instance,Double latitude,Double longitude) throws Exception {
      return $instance.setLocation( latitude , longitude );
    }
    
    
    
    public Object $setMaxDuration($MediaRecorder $instance,Integer maxDurationMs) throws Exception {
      return $instance.setMaxDuration( maxDurationMs );
    }
    
    
    
    public Object $setMaxFileSize($MediaRecorder $instance,Integer maxFilesizeBytes) throws Exception {
      return $instance.setMaxFileSize( maxFilesizeBytes );
    }
    
    
    
    public Object $setOnErrorListener($MediaRecorder $instance,$OnErrorListener onError) throws Exception {
      return $instance.setOnErrorListener( onError );
    }
    
    
    
    public Object $setOnInfoListener($MediaRecorder $instance,$OnInfoListener onInfo) throws Exception {
      return $instance.setOnInfoListener( onInfo );
    }
    
    
    
    public Object $setOrientationHint($MediaRecorder $instance,Integer degrees) throws Exception {
      return $instance.setOrientationHint( degrees );
    }
    
    
    
    public Object $setVideoEncodingBitRate($MediaRecorder $instance,Integer bitRate) throws Exception {
      return $instance.setVideoEncodingBitRate( bitRate );
    }
    
    
    
    public Object $setVideoFrameRate($MediaRecorder $instance,Integer rate) throws Exception {
      return $instance.setVideoFrameRate( rate );
    }
    
    
    
    public Object $setVideoSize($MediaRecorder $instance,Integer width,Integer height) throws Exception {
      return $instance.setVideoSize( width , height );
    }
    
    
    
    public Object $setProfile($MediaRecorder $instance,$CamcorderProfile profile) throws Exception {
      return $instance.setProfile( profile );
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
        
        
        
        case "getMaxAmplitude":
          return $getMaxAmplitude(instance);
        
        
        
        case "reset":
          return $reset(instance);
        
        
        
        case "setAudioChannels":
          return $setAudioChannels(instance,(Integer) arguments.get(0));
        
        
        
        case "setAudioEncodingBitRate":
          return $setAudioEncodingBitRate(instance,(Integer) arguments.get(0));
        
        
        
        case "setAudioSamplingRate":
          return $setAudioSamplingRate(instance,(Integer) arguments.get(0));
        
        
        
        case "setCaptureRate":
          return $setCaptureRate(instance,(Double) arguments.get(0));
        
        
        
        case "setLocation":
          return $setLocation(instance,(Double) arguments.get(0),(Double) arguments.get(1));
        
        
        
        case "setMaxDuration":
          return $setMaxDuration(instance,(Integer) arguments.get(0));
        
        
        
        case "setMaxFileSize":
          return $setMaxFileSize(instance,(Integer) arguments.get(0));
        
        
        
        case "setOnErrorListener":
          return $setOnErrorListener(instance,($OnErrorListener) arguments.get(0));
        
        
        
        case "setOnInfoListener":
          return $setOnInfoListener(instance,($OnInfoListener) arguments.get(0));
        
        
        
        case "setOrientationHint":
          return $setOrientationHint(instance,(Integer) arguments.get(0));
        
        
        
        case "setVideoEncodingBitRate":
          return $setVideoEncodingBitRate(instance,(Integer) arguments.get(0));
        
        
        
        case "setVideoFrameRate":
          return $setVideoFrameRate(instance,(Integer) arguments.get(0));
        
        
        
        case "setVideoSize":
          return $setVideoSize(instance,(Integer) arguments.get(0),(Integer) arguments.get(1));
        
        
        
        case "setProfile":
          return $setProfile(instance,($CamcorderProfile) arguments.get(0));
        
        
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }
  
  public static class $ImageFormatHandler implements TypeChannelHandler<$ImageFormat> {
    public $ImageFormat $$create(TypeChannelMessenger messenger)
        throws Exception {
      throw new UnsupportedOperationException();
    }

    
    
    public Object $getBitsPerPixel(TypeChannelMessenger messenger,Integer format)
        throws Exception {
      throw new UnsupportedOperationException();
    }
    
    

    

    @Override
    public Object invokeStaticMethod(
        TypeChannelMessenger messenger, String methodName, List<Object> arguments)
        throws Exception {
      switch (methodName) {
        
        
        case "getBitsPerPixel":
          return $getBitsPerPixel(messenger,(Integer) arguments.get(0));
        
        
      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke static method %s", methodName));
    }

    @Override
    public $ImageFormat createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      return $$create(messenger);
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        $ImageFormat instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      switch(methodName) {
        
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }
  
  public static class $CamcorderProfileHandler implements TypeChannelHandler<$CamcorderProfile> {
    public $CamcorderProfile $$create(TypeChannelMessenger messenger,Integer audioBitRate,Integer audioChannels,Integer audioCodec,Integer audioSampleRate,Integer duration,Integer fileFormat,Integer quality,Integer videoBitRate,Integer videoCodec,Integer videoFrameHeight,Integer videoFrameRate,Integer videoFrameWidth)
        throws Exception {
      throw new UnsupportedOperationException();
    }

    
    
    public Object $get(TypeChannelMessenger messenger,Integer cameraId,Integer quality)
        throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public Object $hasProfile(TypeChannelMessenger messenger,Integer cameraId,Integer quality)
        throws Exception {
      throw new UnsupportedOperationException();
    }
    
    

    

    @Override
    public Object invokeStaticMethod(
        TypeChannelMessenger messenger, String methodName, List<Object> arguments)
        throws Exception {
      switch (methodName) {
        
        
        case "get":
          return $get(messenger,(Integer) arguments.get(0),(Integer) arguments.get(1));
        
        
        
        case "hasProfile":
          return $hasProfile(messenger,(Integer) arguments.get(0),(Integer) arguments.get(1));
        
        
      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke static method %s", methodName));
    }

    @Override
    public $CamcorderProfile createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      return $$create(messenger,(Integer) arguments.get(0),(Integer) arguments.get(1),(Integer) arguments.get(2),(Integer) arguments.get(3),(Integer) arguments.get(4),(Integer) arguments.get(5),(Integer) arguments.get(6),(Integer) arguments.get(7),(Integer) arguments.get(8),(Integer) arguments.get(9),(Integer) arguments.get(10),(Integer) arguments.get(11));
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        $CamcorderProfile instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      switch(methodName) {
        
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

    
    public $PictureCallbackChannel getChannelPictureCallback() {
      return new $PictureCallbackChannel(messenger);
    }

    public $PictureCallbackHandler getHandlerPictureCallback() {
      return new $PictureCallbackHandler();
    }
    
    public $PreviewCallbackChannel getChannelPreviewCallback() {
      return new $PreviewCallbackChannel(messenger);
    }

    public $PreviewCallbackHandler getHandlerPreviewCallback() {
      return new $PreviewCallbackHandler();
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
    
    public $ImageFormatChannel getChannelImageFormat() {
      return new $ImageFormatChannel(messenger);
    }

    public $ImageFormatHandler getHandlerImageFormat() {
      return new $ImageFormatHandler();
    }
    
    public $CamcorderProfileChannel getChannelCamcorderProfile() {
      return new $CamcorderProfileChannel(messenger);
    }

    public $CamcorderProfileHandler getHandlerCamcorderProfile() {
      return new $CamcorderProfileHandler();
    }
    

    
    public $ErrorCallbackChannel getChannelErrorCallback() {
      return new $ErrorCallbackChannel(messenger);
    }

    public $ErrorCallbackHandler getHandlerErrorCallback() {
      return new $ErrorCallbackHandler(this);
    }
    
    public $AutoFocusCallbackChannel getChannelAutoFocusCallback() {
      return new $AutoFocusCallbackChannel(messenger);
    }

    public $AutoFocusCallbackHandler getHandlerAutoFocusCallback() {
      return new $AutoFocusCallbackHandler(this);
    }
    
    public $ShutterCallbackChannel getChannelShutterCallback() {
      return new $ShutterCallbackChannel(messenger);
    }

    public $ShutterCallbackHandler getHandlerShutterCallback() {
      return new $ShutterCallbackHandler(this);
    }
    
    public $DataCallbackChannel getChannelDataCallback() {
      return new $DataCallbackChannel(messenger);
    }

    public $DataCallbackHandler getHandlerDataCallback() {
      return new $DataCallbackHandler(this);
    }
    
    public $OnZoomChangeListenerChannel getChannelOnZoomChangeListener() {
      return new $OnZoomChangeListenerChannel(messenger);
    }

    public $OnZoomChangeListenerHandler getHandlerOnZoomChangeListener() {
      return new $OnZoomChangeListenerHandler(this);
    }
    
    public $AutoFocusMoveCallbackChannel getChannelAutoFocusMoveCallback() {
      return new $AutoFocusMoveCallbackChannel(messenger);
    }

    public $AutoFocusMoveCallbackHandler getHandlerAutoFocusMoveCallback() {
      return new $AutoFocusMoveCallbackHandler(this);
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
      
      implementations.getChannelPictureCallback().setHandler(implementations.getHandlerPictureCallback());
      
      implementations.getChannelPreviewCallback().setHandler(implementations.getHandlerPreviewCallback());
      
      implementations.getChannelCamera().setHandler(implementations.getHandlerCamera());
      
      implementations.getChannelCameraParameters().setHandler(implementations.getHandlerCameraParameters());
      
      implementations.getChannelCameraArea().setHandler(implementations.getHandlerCameraArea());
      
      implementations.getChannelCameraRect().setHandler(implementations.getHandlerCameraRect());
      
      implementations.getChannelCameraSize().setHandler(implementations.getHandlerCameraSize());
      
      implementations.getChannelCameraInfo().setHandler(implementations.getHandlerCameraInfo());
      
      implementations.getChannelMediaRecorder().setHandler(implementations.getHandlerMediaRecorder());
      
      implementations.getChannelImageFormat().setHandler(implementations.getHandlerImageFormat());
      
      implementations.getChannelCamcorderProfile().setHandler(implementations.getHandlerCamcorderProfile());
      
      
      implementations.getChannelErrorCallback().setHandler(implementations.getHandlerErrorCallback());
      
      implementations.getChannelAutoFocusCallback().setHandler(implementations.getHandlerAutoFocusCallback());
      
      implementations.getChannelShutterCallback().setHandler(implementations.getHandlerShutterCallback());
      
      implementations.getChannelDataCallback().setHandler(implementations.getHandlerDataCallback());
      
      implementations.getChannelOnZoomChangeListener().setHandler(implementations.getHandlerOnZoomChangeListener());
      
      implementations.getChannelAutoFocusMoveCallback().setHandler(implementations.getHandlerAutoFocusMoveCallback());
      
      implementations.getChannelOnErrorListener().setHandler(implementations.getHandlerOnErrorListener());
      
      implementations.getChannelOnInfoListener().setHandler(implementations.getHandlerOnInfoListener());
      
    }

    public void unregisterHandlers() {
      
      implementations.getChannelPictureCallback().removeHandler();
      
      implementations.getChannelPreviewCallback().removeHandler();
      
      implementations.getChannelCamera().removeHandler();
      
      implementations.getChannelCameraParameters().removeHandler();
      
      implementations.getChannelCameraArea().removeHandler();
      
      implementations.getChannelCameraRect().removeHandler();
      
      implementations.getChannelCameraSize().removeHandler();
      
      implementations.getChannelCameraInfo().removeHandler();
      
      implementations.getChannelMediaRecorder().removeHandler();
      
      implementations.getChannelImageFormat().removeHandler();
      
      implementations.getChannelCamcorderProfile().removeHandler();
      
      
      implementations.getChannelErrorCallback().removeHandler();
      
      implementations.getChannelAutoFocusCallback().removeHandler();
      
      implementations.getChannelShutterCallback().removeHandler();
      
      implementations.getChannelDataCallback().removeHandler();
      
      implementations.getChannelOnZoomChangeListener().removeHandler();
      
      implementations.getChannelAutoFocusMoveCallback().removeHandler();
      
      implementations.getChannelOnErrorListener().removeHandler();
      
      implementations.getChannelOnInfoListener().removeHandler();
      
    }
  }
}
