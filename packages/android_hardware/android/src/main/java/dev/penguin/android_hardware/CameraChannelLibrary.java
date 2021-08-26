// GENERATED CODE - DO NOT MODIFY BY HAND


package dev.penguin.android_hardware;



import android.hardware.Camera;

import android.hardware.Camera.PreviewCallback;

import android.hardware.Camera.ShutterCallback;

import android.hardware.Camera.PictureCallback;

import android.hardware.Camera.AutoFocusCallback;

import android.hardware.Camera.ErrorCallback;

import android.hardware.Camera.Parameters;

import android.hardware.Camera.OnZoomChangeListener;

import android.hardware.Camera.AutoFocusMoveCallback;

import android.hardware.Camera.CameraInfo;

import android.hardware.Camera.Area;

import android.hardware.Camera.Size;

import android.graphics.Rect;

import android.graphics.ImageFormat;


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
  
  public static class $ErrorCallbackChannel extends TypeChannel<ErrorCallback> {
    public $ErrorCallbackChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "android.hardware.Camera.ErrorCallback");
    }

    public Completable<PairedInstance> $create(ErrorCallback $instance, boolean $owner) {
      return createNewInstancePair($instance, Collections.emptyList(), $owner);
    }

    private Completable<Void> invoke(ErrorCallback $instance
        , Integer error) {
      return invokeMethod($instance, "", Arrays.<Object>asList(error));
    }
  }
  
  public static class $AutoFocusCallbackChannel extends TypeChannel<AutoFocusCallback> {
    public $AutoFocusCallbackChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "android.hardware.Camera.AutoFocusCallback");
    }

    public Completable<PairedInstance> $create(AutoFocusCallback $instance, boolean $owner) {
      return createNewInstancePair($instance, Collections.emptyList(), $owner);
    }

    private Completable<Void> invoke(AutoFocusCallback $instance
        , Boolean success) {
      return invokeMethod($instance, "", Arrays.<Object>asList(success));
    }
  }
  
  public static class $ShutterCallbackChannel extends TypeChannel<ShutterCallback> {
    public $ShutterCallbackChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "android.hardware.Camera.ShutterCallback");
    }

    public Completable<PairedInstance> $create(ShutterCallback $instance, boolean $owner) {
      return createNewInstancePair($instance, Collections.emptyList(), $owner);
    }

    private Completable<Void> invoke(ShutterCallback $instance
        ) {
      return invokeMethod($instance, "", Arrays.<Object>asList());
    }
  }
  
  public static class $OnZoomChangeListenerChannel extends TypeChannel<OnZoomChangeListener> {
    public $OnZoomChangeListenerChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "android.hardware.Camera.OnZoomChangeListener");
    }

    public Completable<PairedInstance> $create(OnZoomChangeListener $instance, boolean $owner) {
      return createNewInstancePair($instance, Collections.emptyList(), $owner);
    }

    private Completable<Void> invoke(OnZoomChangeListener $instance
        , Integer zoomValue, Boolean stopped) {
      return invokeMethod($instance, "", Arrays.<Object>asList(zoomValue,stopped));
    }
  }
  
  public static class $AutoFocusMoveCallbackChannel extends TypeChannel<AutoFocusMoveCallback> {
    public $AutoFocusMoveCallbackChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "android.hardware.Camera.AutoFocusMoveCallback");
    }

    public Completable<PairedInstance> $create(AutoFocusMoveCallback $instance, boolean $owner) {
      return createNewInstancePair($instance, Collections.emptyList(), $owner);
    }

    private Completable<Void> invoke(AutoFocusMoveCallback $instance
        , Boolean start) {
      return invokeMethod($instance, "", Arrays.<Object>asList(start));
    }
  }
  
  public static class $PictureCallbackChannel extends TypeChannel<PictureCallback> {
    public $PictureCallbackChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "android.hardware.Camera.PictureCallback");
    }

    public Completable<PairedInstance> $create(PictureCallback $instance, boolean $owner) {
      return createNewInstancePair($instance, Collections.emptyList(), $owner);
    }

    private Completable<Void> invoke(PictureCallback $instance
        , byte[] data) {
      return invokeMethod($instance, "", Arrays.<Object>asList(data));
    }
  }
  
  public static class $PreviewCallbackChannel extends TypeChannel<PreviewCallback> {
    public $PreviewCallbackChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "android.hardware.Camera.PreviewCallback");
    }

    public Completable<PairedInstance> $create(PreviewCallback $instance, boolean $owner) {
      return createNewInstancePair($instance, Collections.emptyList(), $owner);
    }

    private Completable<Void> invoke(PreviewCallback $instance
        , byte[] data) {
      return invokeMethod($instance, "", Arrays.<Object>asList(data));
    }
  }
  

  
  public static class $ErrorCallbackHandler implements TypeChannelHandler<ErrorCallback> {
    public final $LibraryImplementations implementations;

    public $ErrorCallbackHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    @Override
    public ErrorCallback createInstance(TypeChannelMessenger messenger, List<Object> arguments) {
      return new ErrorCallback() {
        @Override
        public Completable<Void> invoke(Integer error) {
          return implementations.channelErrorCallback.invoke(this,error);
        }
      };
    }

    @Override
    public Void invokeStaticMethod(TypeChannelMessenger messenger, String methodName, List<Object> arguments) {
      throw new UnsupportedOperationException();
    }

    @Override
    public Object invokeMethod(TypeChannelMessenger messenger, ErrorCallback instance, String methodName, List<Object> arguments) throws Exception {
      return instance.invoke((Integer) arguments.get(0));
    }
  }
  
  public static class $AutoFocusCallbackHandler implements TypeChannelHandler<AutoFocusCallback> {
    public final $LibraryImplementations implementations;

    public $AutoFocusCallbackHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    @Override
    public AutoFocusCallback createInstance(TypeChannelMessenger messenger, List<Object> arguments) {
      return new AutoFocusCallback() {
        @Override
        public Completable<Void> invoke(Boolean success) {
          return implementations.channelAutoFocusCallback.invoke(this,success);
        }
      };
    }

    @Override
    public Void invokeStaticMethod(TypeChannelMessenger messenger, String methodName, List<Object> arguments) {
      throw new UnsupportedOperationException();
    }

    @Override
    public Object invokeMethod(TypeChannelMessenger messenger, AutoFocusCallback instance, String methodName, List<Object> arguments) throws Exception {
      return instance.invoke((Boolean) arguments.get(0));
    }
  }
  
  public static class $ShutterCallbackHandler implements TypeChannelHandler<ShutterCallback> {
    public final $LibraryImplementations implementations;

    public $ShutterCallbackHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    @Override
    public ShutterCallback createInstance(TypeChannelMessenger messenger, List<Object> arguments) {
      return new ShutterCallback() {
        @Override
        public Completable<Void> invoke() {
          return implementations.channelShutterCallback.invoke(this);
        }
      };
    }

    @Override
    public Void invokeStaticMethod(TypeChannelMessenger messenger, String methodName, List<Object> arguments) {
      throw new UnsupportedOperationException();
    }

    @Override
    public Object invokeMethod(TypeChannelMessenger messenger, ShutterCallback instance, String methodName, List<Object> arguments) throws Exception {
      return instance.invoke();
    }
  }
  
  public static class $OnZoomChangeListenerHandler implements TypeChannelHandler<OnZoomChangeListener> {
    public final $LibraryImplementations implementations;

    public $OnZoomChangeListenerHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    @Override
    public OnZoomChangeListener createInstance(TypeChannelMessenger messenger, List<Object> arguments) {
      return new OnZoomChangeListener() {
        @Override
        public Completable<Void> invoke(Integer zoomValue,Boolean stopped) {
          return implementations.channelOnZoomChangeListener.invoke(this,zoomValue,stopped);
        }
      };
    }

    @Override
    public Void invokeStaticMethod(TypeChannelMessenger messenger, String methodName, List<Object> arguments) {
      throw new UnsupportedOperationException();
    }

    @Override
    public Object invokeMethod(TypeChannelMessenger messenger, OnZoomChangeListener instance, String methodName, List<Object> arguments) throws Exception {
      return instance.invoke((Integer) arguments.get(0),(Boolean) arguments.get(1));
    }
  }
  
  public static class $AutoFocusMoveCallbackHandler implements TypeChannelHandler<AutoFocusMoveCallback> {
    public final $LibraryImplementations implementations;

    public $AutoFocusMoveCallbackHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    @Override
    public AutoFocusMoveCallback createInstance(TypeChannelMessenger messenger, List<Object> arguments) {
      return new AutoFocusMoveCallback() {
        @Override
        public Completable<Void> invoke(Boolean start) {
          return implementations.channelAutoFocusMoveCallback.invoke(this,start);
        }
      };
    }

    @Override
    public Void invokeStaticMethod(TypeChannelMessenger messenger, String methodName, List<Object> arguments) {
      throw new UnsupportedOperationException();
    }

    @Override
    public Object invokeMethod(TypeChannelMessenger messenger, AutoFocusMoveCallback instance, String methodName, List<Object> arguments) throws Exception {
      return instance.invoke((Boolean) arguments.get(0));
    }
  }
  
  public static class $PictureCallbackHandler implements TypeChannelHandler<PictureCallback> {
    public final $LibraryImplementations implementations;

    public $PictureCallbackHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    @Override
    public PictureCallback createInstance(TypeChannelMessenger messenger, List<Object> arguments) {
      return new PictureCallback() {
        @Override
        public Completable<Void> invoke(byte[] data) {
          return implementations.channelPictureCallback.invoke(this,data);
        }
      };
    }

    @Override
    public Void invokeStaticMethod(TypeChannelMessenger messenger, String methodName, List<Object> arguments) {
      throw new UnsupportedOperationException();
    }

    @Override
    public Object invokeMethod(TypeChannelMessenger messenger, PictureCallback instance, String methodName, List<Object> arguments) throws Exception {
      return instance.invoke((byte[]) arguments.get(0));
    }
  }
  
  public static class $PreviewCallbackHandler implements TypeChannelHandler<PreviewCallback> {
    public final $LibraryImplementations implementations;

    public $PreviewCallbackHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    @Override
    public PreviewCallback createInstance(TypeChannelMessenger messenger, List<Object> arguments) {
      return new PreviewCallback() {
        @Override
        public Completable<Void> invoke(byte[] data) {
          return implementations.channelPreviewCallback.invoke(this,data);
        }
      };
    }

    @Override
    public Void invokeStaticMethod(TypeChannelMessenger messenger, String methodName, List<Object> arguments) {
      throw new UnsupportedOperationException();
    }

    @Override
    public Object invokeMethod(TypeChannelMessenger messenger, PreviewCallback instance, String methodName, List<Object> arguments) throws Exception {
      return instance.invoke((byte[]) arguments.get(0));
    }
  }
  

  
  public static class $CameraProxyChannel extends TypeChannel<CameraProxy> {
    public $CameraProxyChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "android.hardware.Camera");
    }

    
    public Completable<PairedInstance> $create$(CameraProxy $instance, boolean $owner) {
      return createNewInstancePair($instance, Arrays.<Object>asList(""), $owner);
    }
    

    
    
    
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  }
  
  public static class $ParametersChannel extends TypeChannel<Parameters> {
    public $ParametersChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "android.hardware.Camera.Parameters");
    }

    
    public Completable<PairedInstance> $create$(Parameters $instance, boolean $owner) {
      return createNewInstancePair($instance, Arrays.<Object>asList(""), $owner);
    }
    

    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  }
  
  public static class $AreaChannel extends TypeChannel<Area> {
    public $AreaChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "android.hardware.Camera.Area");
    }

    
    public Completable<PairedInstance> $create$(Area $instance, boolean $owner,Rect rect,Integer weight) {
      return createNewInstancePair($instance, Arrays.<Object>asList("", rect, weight), $owner);
    }
    

    

    
  }
  
  public static class $RectChannel extends TypeChannel<Rect> {
    public $RectChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "android.graphics.Rect");
    }

    
    public Completable<PairedInstance> $create$(Rect $instance, boolean $owner,Integer top,Integer bottom,Integer right,Integer left) {
      return createNewInstancePair($instance, Arrays.<Object>asList("", top, bottom, right, left), $owner);
    }
    

    

    
  }
  
  public static class $SizeChannel extends TypeChannel<Size> {
    public $SizeChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "android.hardware.Camera.Size");
    }

    
    public Completable<PairedInstance> $create$(Size $instance, boolean $owner,Integer width,Integer height) {
      return createNewInstancePair($instance, Arrays.<Object>asList("", width, height), $owner);
    }
    

    

    
  }
  
  public static class $CameraInfoChannel extends TypeChannel<CameraInfo> {
    public $CameraInfoChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "android.hardware.Camera.CameraInfo");
    }

    
    public Completable<PairedInstance> $create$(CameraInfo $instance, boolean $owner,Integer cameraId,Integer facing,Integer orientation,Boolean canDisableShutterSound) {
      return createNewInstancePair($instance, Arrays.<Object>asList("", cameraId, facing, orientation, canDisableShutterSound), $owner);
    }
    

    

    
  }
  
  public static class $ImageFormatChannel extends TypeChannel<ImageFormat> {
    public $ImageFormatChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "android.graphics.ImageFormat");
    }

    

    
    
    

    
  }
  

  
  public static class $CameraProxyHandler implements TypeChannelHandler<CameraProxy> {
    public final $LibraryImplementations implementations;

    public $CameraProxyHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    
    public CameraProxy $create$()
        throws Exception {
      throw new UnsupportedOperationException();
    }
    

    
    
    public List<CameraInfo> $getAllCameraInfo() throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public CameraProxy $open(Integer cameraId) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    

    
    
    public void $release(CameraProxy $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $startPreview(CameraProxy $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $stopPreview(CameraProxy $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public Long $attachPreviewTexture(CameraProxy $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $releasePreviewTexture(CameraProxy $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $unlock(CameraProxy $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $setOneShotPreviewCallback(CameraProxy $instance,PreviewCallback callback) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $setPreviewCallback(CameraProxy $instance,PreviewCallback callback) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $reconnect(CameraProxy $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $takePicture(CameraProxy $instance,ShutterCallback shutter,PictureCallback raw,PictureCallback postView,PictureCallback jpeg) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $autoFocus(CameraProxy $instance,AutoFocusCallback callback) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $cancelAutoFocus(CameraProxy $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $setDisplayOrientation(CameraProxy $instance,Integer degrees) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $setErrorCallback(CameraProxy $instance,ErrorCallback callback) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $startSmoothZoom(CameraProxy $instance,Integer value) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $stopSmoothZoom(CameraProxy $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public Parameters $getParameters(CameraProxy $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $setParameters(CameraProxy $instance,Parameters parameters) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $setZoomChangeListener(CameraProxy $instance,OnZoomChangeListener listener) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $setAutoFocusMoveCallback(CameraProxy $instance,AutoFocusMoveCallback callback) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $lock(CameraProxy $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public Boolean $enableShutterSound(CameraProxy $instance,Boolean enabled) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    

    @Override
    public Object invokeStaticMethod(
        TypeChannelMessenger messenger, String methodName, List<Object> arguments)
        throws Exception {
      switch (methodName) {
        
        
        case "getAllCameraInfo":
          
          return $getAllCameraInfo();
          
        
        
        
        case "open":
          
          return $open((Integer) arguments.get(0));
          
        
        
      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke static method %s", methodName));
    }

    @Override
    public CameraProxy createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      final String constructorName = (String) arguments.get(0);
      switch(constructorName) {
        
        case "":
          return $create$();
        
      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke constructor of %s", constructorName));
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        CameraProxy instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      switch(methodName) {
        
        
        case "release":
           $release(instance);
          
          return null;
          
        
        
        
        case "startPreview":
           $startPreview(instance);
          
          return null;
          
        
        
        
        case "stopPreview":
           $stopPreview(instance);
          
          return null;
          
        
        
        
        case "attachPreviewTexture":
          
          return  $attachPreviewTexture(instance);
          
        
        
        
        case "releasePreviewTexture":
           $releasePreviewTexture(instance);
          
          return null;
          
        
        
        
        case "unlock":
           $unlock(instance);
          
          return null;
          
        
        
        
        case "setOneShotPreviewCallback":
           $setOneShotPreviewCallback(instance,(PreviewCallback) arguments.get(0));
          
          return null;
          
        
        
        
        case "setPreviewCallback":
           $setPreviewCallback(instance,(PreviewCallback) arguments.get(0));
          
          return null;
          
        
        
        
        case "reconnect":
           $reconnect(instance);
          
          return null;
          
        
        
        
        case "takePicture":
           $takePicture(instance,(ShutterCallback) arguments.get(0),(PictureCallback) arguments.get(1),(PictureCallback) arguments.get(2),(PictureCallback) arguments.get(3));
          
          return null;
          
        
        
        
        case "autoFocus":
           $autoFocus(instance,(AutoFocusCallback) arguments.get(0));
          
          return null;
          
        
        
        
        case "cancelAutoFocus":
           $cancelAutoFocus(instance);
          
          return null;
          
        
        
        
        case "setDisplayOrientation":
           $setDisplayOrientation(instance,(Integer) arguments.get(0));
          
          return null;
          
        
        
        
        case "setErrorCallback":
           $setErrorCallback(instance,(ErrorCallback) arguments.get(0));
          
          return null;
          
        
        
        
        case "startSmoothZoom":
           $startSmoothZoom(instance,(Integer) arguments.get(0));
          
          return null;
          
        
        
        
        case "stopSmoothZoom":
           $stopSmoothZoom(instance);
          
          return null;
          
        
        
        
        case "getParameters":
          
          return  $getParameters(instance);
          
        
        
        
        case "setParameters":
           $setParameters(instance,(Parameters) arguments.get(0));
          
          return null;
          
        
        
        
        case "setZoomChangeListener":
           $setZoomChangeListener(instance,(OnZoomChangeListener) arguments.get(0));
          
          return null;
          
        
        
        
        case "setAutoFocusMoveCallback":
           $setAutoFocusMoveCallback(instance,(AutoFocusMoveCallback) arguments.get(0));
          
          return null;
          
        
        
        
        case "lock":
           $lock(instance);
          
          return null;
          
        
        
        
        case "enableShutterSound":
          
          return  $enableShutterSound(instance,(Boolean) arguments.get(0));
          
        
        
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }
  
  public static class $ParametersHandler implements TypeChannelHandler<Parameters> {
    public final $LibraryImplementations implementations;

    public $ParametersHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    
    public Parameters $create$()
        throws Exception {
      throw new UnsupportedOperationException();
    }
    

    

    
    
    public Boolean $getAutoExposureLock(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public List<Area> $getFocusAreas(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public List<Double> $getFocusDistances(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public Integer $getMaxExposureCompensation(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public Integer $getMaxNumFocusAreas(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public Integer $getMinExposureCompensation(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public List<String> $getSupportedFocusModes(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public Boolean $isAutoExposureLockSupported(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public Boolean $isZoomSupported(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $setAutoExposureLock(Parameters $instance,Boolean toggle) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $setExposureCompensation(Parameters $instance,Integer value) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $setFocusAreas(Parameters $instance,List<Area> focusAreas) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $setFocusMode(Parameters $instance,String value) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public String $getFlashMode(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public Integer $getMaxZoom(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public Size $getPictureSize(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public Size $getPreviewSize(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public List<Size> $getSupportedPreviewSizes(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public List<Size> $getSupportedPictureSizes(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public List<String> $getSupportedFlashModes(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public Integer $getZoom(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public Boolean $isSmoothZoomSupported(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $setFlashMode(Parameters $instance,String mode) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $setPictureSize(Parameters $instance,Integer width,Integer height) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $setRecordingHint(Parameters $instance,Boolean hint) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $setRotation(Parameters $instance,Integer rotation) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $setZoom(Parameters $instance,Integer value) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $setPreviewSize(Parameters $instance,Integer width,Integer height) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public Integer $getExposureCompensation(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public Double $getExposureCompensationStep(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public String $flatten(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public String $get(Parameters $instance,String key) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public String $getAntibanding(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public Boolean $getAutoWhiteBalanceLock(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public String $getColorEffect(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public Double $getFocalLength(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public String $getFocusMode(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public Double $getHorizontalViewAngle(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public Integer $getInt(Parameters $instance,String key) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public Integer $getJpegQuality(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public Integer $getJpegThumbnailQuality(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public Size $getJpegThumbnailSize(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public Integer $getMaxNumMeteringAreas(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public List<Area> $getMeteringAreas(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public Integer $getPictureFormat(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public Size $getPreferredPreviewSizeForVideo(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public Integer $getPreviewFormat(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public List<Integer> $getPreviewFpsRange(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public String $getSceneMode(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public List<String> $getSupportedAntibanding(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public List<String> $getSupportedColorEffects(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public List<Size> $getSupportedJpegThumbnailSizes(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public List<Integer> $getSupportedPictureFormats(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public List<Integer> $getSupportedPreviewFormats(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public List<List<Integer>> $getSupportedPreviewFpsRange(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public List<String> $getSupportedSceneModes(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public List<Size> $getSupportedVideoSizes(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public List<String> $getSupportedWhiteBalance(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public Double $getVerticalViewAngle(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public Boolean $getVideoStabilization(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public String $getWhiteBalance(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public List<Integer> $getZoomRatios(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public Boolean $isAutoWhiteBalanceLockSupported(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public Boolean $isVideoSnapshotSupported(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public Boolean $isVideoStabilizationSupported(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $remove(Parameters $instance,String key) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $removeGpsData(Parameters $instance) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $set(Parameters $instance,String key,Object value) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $setAntibanding(Parameters $instance,String antibanding) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $setAutoWhiteBalanceLock(Parameters $instance,Boolean toggle) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $setColorEffect(Parameters $instance,String effect) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $setGpsAltitude(Parameters $instance,Double meters) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $setGpsLatitude(Parameters $instance,Double latitude) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $setGpsLongitude(Parameters $instance,Double longitude) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $setGpsProcessingMethod(Parameters $instance,String processingMethod) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $setGpsTimestamp(Parameters $instance,Integer timestamp) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $setJpegQuality(Parameters $instance,Integer quality) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $setJpegThumbnailQuality(Parameters $instance,Integer quality) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $setJpegThumbnailSize(Parameters $instance,Integer width,Integer height) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $setMeteringAreas(Parameters $instance,List<Area> meteringAreas) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $setPictureFormat(Parameters $instance,Integer pixelFormat) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $setPreviewFormat(Parameters $instance,Integer pixelFormat) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $setPreviewFpsRange(Parameters $instance,Integer min,Integer max) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $setSceneMode(Parameters $instance,String mode) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $setVideoStabilization(Parameters $instance,Boolean toggle) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $setWhiteBalance(Parameters $instance,String value) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $unflatten(Parameters $instance,String flattened) throws Exception {
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
    public Parameters createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      final String constructorName = (String) arguments.get(0);
      switch(constructorName) {
        
        case "":
          return $create$();
        
      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke constructor of %s", constructorName));
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        Parameters instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      switch(methodName) {
        
        
        case "getAutoExposureLock":
          
          return  $getAutoExposureLock(instance);
          
        
        
        
        case "getFocusAreas":
          
          return  $getFocusAreas(instance);
          
        
        
        
        case "getFocusDistances":
          
          return  $getFocusDistances(instance);
          
        
        
        
        case "getMaxExposureCompensation":
          
          return  $getMaxExposureCompensation(instance);
          
        
        
        
        case "getMaxNumFocusAreas":
          
          return  $getMaxNumFocusAreas(instance);
          
        
        
        
        case "getMinExposureCompensation":
          
          return  $getMinExposureCompensation(instance);
          
        
        
        
        case "getSupportedFocusModes":
          
          return  $getSupportedFocusModes(instance);
          
        
        
        
        case "isAutoExposureLockSupported":
          
          return  $isAutoExposureLockSupported(instance);
          
        
        
        
        case "isZoomSupported":
          
          return  $isZoomSupported(instance);
          
        
        
        
        case "setAutoExposureLock":
           $setAutoExposureLock(instance,(Boolean) arguments.get(0));
          
          return null;
          
        
        
        
        case "setExposureCompensation":
           $setExposureCompensation(instance,(Integer) arguments.get(0));
          
          return null;
          
        
        
        
        case "setFocusAreas":
           $setFocusAreas(instance,(List<Area>) arguments.get(0));
          
          return null;
          
        
        
        
        case "setFocusMode":
           $setFocusMode(instance,(String) arguments.get(0));
          
          return null;
          
        
        
        
        case "getFlashMode":
          
          return  $getFlashMode(instance);
          
        
        
        
        case "getMaxZoom":
          
          return  $getMaxZoom(instance);
          
        
        
        
        case "getPictureSize":
          
          return  $getPictureSize(instance);
          
        
        
        
        case "getPreviewSize":
          
          return  $getPreviewSize(instance);
          
        
        
        
        case "getSupportedPreviewSizes":
          
          return  $getSupportedPreviewSizes(instance);
          
        
        
        
        case "getSupportedPictureSizes":
          
          return  $getSupportedPictureSizes(instance);
          
        
        
        
        case "getSupportedFlashModes":
          
          return  $getSupportedFlashModes(instance);
          
        
        
        
        case "getZoom":
          
          return  $getZoom(instance);
          
        
        
        
        case "isSmoothZoomSupported":
          
          return  $isSmoothZoomSupported(instance);
          
        
        
        
        case "setFlashMode":
           $setFlashMode(instance,(String) arguments.get(0));
          
          return null;
          
        
        
        
        case "setPictureSize":
           $setPictureSize(instance,(Integer) arguments.get(0),(Integer) arguments.get(1));
          
          return null;
          
        
        
        
        case "setRecordingHint":
           $setRecordingHint(instance,(Boolean) arguments.get(0));
          
          return null;
          
        
        
        
        case "setRotation":
           $setRotation(instance,(Integer) arguments.get(0));
          
          return null;
          
        
        
        
        case "setZoom":
           $setZoom(instance,(Integer) arguments.get(0));
          
          return null;
          
        
        
        
        case "setPreviewSize":
           $setPreviewSize(instance,(Integer) arguments.get(0),(Integer) arguments.get(1));
          
          return null;
          
        
        
        
        case "getExposureCompensation":
          
          return  $getExposureCompensation(instance);
          
        
        
        
        case "getExposureCompensationStep":
          
          return  $getExposureCompensationStep(instance);
          
        
        
        
        case "flatten":
          
          return  $flatten(instance);
          
        
        
        
        case "get":
          
          return  $get(instance,(String) arguments.get(0));
          
        
        
        
        case "getAntibanding":
          
          return  $getAntibanding(instance);
          
        
        
        
        case "getAutoWhiteBalanceLock":
          
          return  $getAutoWhiteBalanceLock(instance);
          
        
        
        
        case "getColorEffect":
          
          return  $getColorEffect(instance);
          
        
        
        
        case "getFocalLength":
          
          return  $getFocalLength(instance);
          
        
        
        
        case "getFocusMode":
          
          return  $getFocusMode(instance);
          
        
        
        
        case "getHorizontalViewAngle":
          
          return  $getHorizontalViewAngle(instance);
          
        
        
        
        case "getInt":
          
          return  $getInt(instance,(String) arguments.get(0));
          
        
        
        
        case "getJpegQuality":
          
          return  $getJpegQuality(instance);
          
        
        
        
        case "getJpegThumbnailQuality":
          
          return  $getJpegThumbnailQuality(instance);
          
        
        
        
        case "getJpegThumbnailSize":
          
          return  $getJpegThumbnailSize(instance);
          
        
        
        
        case "getMaxNumMeteringAreas":
          
          return  $getMaxNumMeteringAreas(instance);
          
        
        
        
        case "getMeteringAreas":
          
          return  $getMeteringAreas(instance);
          
        
        
        
        case "getPictureFormat":
          
          return  $getPictureFormat(instance);
          
        
        
        
        case "getPreferredPreviewSizeForVideo":
          
          return  $getPreferredPreviewSizeForVideo(instance);
          
        
        
        
        case "getPreviewFormat":
          
          return  $getPreviewFormat(instance);
          
        
        
        
        case "getPreviewFpsRange":
          
          return  $getPreviewFpsRange(instance);
          
        
        
        
        case "getSceneMode":
          
          return  $getSceneMode(instance);
          
        
        
        
        case "getSupportedAntibanding":
          
          return  $getSupportedAntibanding(instance);
          
        
        
        
        case "getSupportedColorEffects":
          
          return  $getSupportedColorEffects(instance);
          
        
        
        
        case "getSupportedJpegThumbnailSizes":
          
          return  $getSupportedJpegThumbnailSizes(instance);
          
        
        
        
        case "getSupportedPictureFormats":
          
          return  $getSupportedPictureFormats(instance);
          
        
        
        
        case "getSupportedPreviewFormats":
          
          return  $getSupportedPreviewFormats(instance);
          
        
        
        
        case "getSupportedPreviewFpsRange":
          
          return  $getSupportedPreviewFpsRange(instance);
          
        
        
        
        case "getSupportedSceneModes":
          
          return  $getSupportedSceneModes(instance);
          
        
        
        
        case "getSupportedVideoSizes":
          
          return  $getSupportedVideoSizes(instance);
          
        
        
        
        case "getSupportedWhiteBalance":
          
          return  $getSupportedWhiteBalance(instance);
          
        
        
        
        case "getVerticalViewAngle":
          
          return  $getVerticalViewAngle(instance);
          
        
        
        
        case "getVideoStabilization":
          
          return  $getVideoStabilization(instance);
          
        
        
        
        case "getWhiteBalance":
          
          return  $getWhiteBalance(instance);
          
        
        
        
        case "getZoomRatios":
          
          return  $getZoomRatios(instance);
          
        
        
        
        case "isAutoWhiteBalanceLockSupported":
          
          return  $isAutoWhiteBalanceLockSupported(instance);
          
        
        
        
        case "isVideoSnapshotSupported":
          
          return  $isVideoSnapshotSupported(instance);
          
        
        
        
        case "isVideoStabilizationSupported":
          
          return  $isVideoStabilizationSupported(instance);
          
        
        
        
        case "remove":
           $remove(instance,(String) arguments.get(0));
          
          return null;
          
        
        
        
        case "removeGpsData":
           $removeGpsData(instance);
          
          return null;
          
        
        
        
        case "set":
           $set(instance,(String) arguments.get(0),(Object) arguments.get(1));
          
          return null;
          
        
        
        
        case "setAntibanding":
           $setAntibanding(instance,(String) arguments.get(0));
          
          return null;
          
        
        
        
        case "setAutoWhiteBalanceLock":
           $setAutoWhiteBalanceLock(instance,(Boolean) arguments.get(0));
          
          return null;
          
        
        
        
        case "setColorEffect":
           $setColorEffect(instance,(String) arguments.get(0));
          
          return null;
          
        
        
        
        case "setGpsAltitude":
           $setGpsAltitude(instance,(Double) arguments.get(0));
          
          return null;
          
        
        
        
        case "setGpsLatitude":
           $setGpsLatitude(instance,(Double) arguments.get(0));
          
          return null;
          
        
        
        
        case "setGpsLongitude":
           $setGpsLongitude(instance,(Double) arguments.get(0));
          
          return null;
          
        
        
        
        case "setGpsProcessingMethod":
           $setGpsProcessingMethod(instance,(String) arguments.get(0));
          
          return null;
          
        
        
        
        case "setGpsTimestamp":
           $setGpsTimestamp(instance,(Integer) arguments.get(0));
          
          return null;
          
        
        
        
        case "setJpegQuality":
           $setJpegQuality(instance,(Integer) arguments.get(0));
          
          return null;
          
        
        
        
        case "setJpegThumbnailQuality":
           $setJpegThumbnailQuality(instance,(Integer) arguments.get(0));
          
          return null;
          
        
        
        
        case "setJpegThumbnailSize":
           $setJpegThumbnailSize(instance,(Integer) arguments.get(0),(Integer) arguments.get(1));
          
          return null;
          
        
        
        
        case "setMeteringAreas":
           $setMeteringAreas(instance,(List<Area>) arguments.get(0));
          
          return null;
          
        
        
        
        case "setPictureFormat":
           $setPictureFormat(instance,(Integer) arguments.get(0));
          
          return null;
          
        
        
        
        case "setPreviewFormat":
           $setPreviewFormat(instance,(Integer) arguments.get(0));
          
          return null;
          
        
        
        
        case "setPreviewFpsRange":
           $setPreviewFpsRange(instance,(Integer) arguments.get(0),(Integer) arguments.get(1));
          
          return null;
          
        
        
        
        case "setSceneMode":
           $setSceneMode(instance,(String) arguments.get(0));
          
          return null;
          
        
        
        
        case "setVideoStabilization":
           $setVideoStabilization(instance,(Boolean) arguments.get(0));
          
          return null;
          
        
        
        
        case "setWhiteBalance":
           $setWhiteBalance(instance,(String) arguments.get(0));
          
          return null;
          
        
        
        
        case "unflatten":
           $unflatten(instance,(String) arguments.get(0));
          
          return null;
          
        
        
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }
  
  public static class $AreaHandler implements TypeChannelHandler<Area> {
    public final $LibraryImplementations implementations;

    public $AreaHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    
    public Area $create$(Rect rect,Integer weight)
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
    public Area createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      final String constructorName = (String) arguments.get(0);
      switch(constructorName) {
        
        case "":
          return $create$((Rect) arguments.get(1),(Integer) arguments.get(2));
        
      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke constructor of %s", constructorName));
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        Area instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      switch(methodName) {
        
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }
  
  public static class $RectHandler implements TypeChannelHandler<Rect> {
    public final $LibraryImplementations implementations;

    public $RectHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    
    public Rect $create$(Integer top,Integer bottom,Integer right,Integer left)
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
    public Rect createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      final String constructorName = (String) arguments.get(0);
      switch(constructorName) {
        
        case "":
          return $create$((Integer) arguments.get(1),(Integer) arguments.get(2),(Integer) arguments.get(3),(Integer) arguments.get(4));
        
      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke constructor of %s", constructorName));
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        Rect instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      switch(methodName) {
        
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }
  
  public static class $SizeHandler implements TypeChannelHandler<Size> {
    public final $LibraryImplementations implementations;

    public $SizeHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    
    public Size $create$(Integer width,Integer height)
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
    public Size createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      final String constructorName = (String) arguments.get(0);
      switch(constructorName) {
        
        case "":
          return $create$((Integer) arguments.get(1),(Integer) arguments.get(2));
        
      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke constructor of %s", constructorName));
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        Size instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      switch(methodName) {
        
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }
  
  public static class $CameraInfoHandler implements TypeChannelHandler<CameraInfo> {
    public final $LibraryImplementations implementations;

    public $CameraInfoHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    
    public CameraInfo $create$(Integer cameraId,Integer facing,Integer orientation,Boolean canDisableShutterSound)
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
    public CameraInfo createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      final String constructorName = (String) arguments.get(0);
      switch(constructorName) {
        
        case "":
          return $create$((Integer) arguments.get(1),(Integer) arguments.get(2),(Integer) arguments.get(3),(Boolean) arguments.get(4));
        
      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke constructor of %s", constructorName));
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        CameraInfo instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      switch(methodName) {
        
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }
  
  public static class $ImageFormatHandler implements TypeChannelHandler<ImageFormat> {
    public final $LibraryImplementations implementations;

    public $ImageFormatHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    

    
    
    public Integer $getBitsPerPixel(Integer format) throws Exception {
      throw new UnsupportedOperationException();
    }
    
    

    

    @Override
    public Object invokeStaticMethod(
        TypeChannelMessenger messenger, String methodName, List<Object> arguments)
        throws Exception {
      switch (methodName) {
        
        
        case "getBitsPerPixel":
          
          return $getBitsPerPixel((Integer) arguments.get(0));
          
        
        
      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke static method %s", methodName));
    }

    @Override
    public ImageFormat createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      final String constructorName = (String) arguments.get(0);
      switch(constructorName) {
        
      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke constructor of %s", constructorName));
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        ImageFormat instance,
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

    
    public $CameraProxyChannel channelCameraProxy;
    public $CameraProxyHandler handlerCameraProxy;
    
    public $ParametersChannel channelParameters;
    public $ParametersHandler handlerParameters;
    
    public $AreaChannel channelArea;
    public $AreaHandler handlerArea;
    
    public $RectChannel channelRect;
    public $RectHandler handlerRect;
    
    public $SizeChannel channelSize;
    public $SizeHandler handlerSize;
    
    public $CameraInfoChannel channelCameraInfo;
    public $CameraInfoHandler handlerCameraInfo;
    
    public $ImageFormatChannel channelImageFormat;
    public $ImageFormatHandler handlerImageFormat;
    

    
    public $ErrorCallbackChannel channelErrorCallback;
    public $ErrorCallbackHandler handlerErrorCallback;
    
    public $AutoFocusCallbackChannel channelAutoFocusCallback;
    public $AutoFocusCallbackHandler handlerAutoFocusCallback;
    
    public $ShutterCallbackChannel channelShutterCallback;
    public $ShutterCallbackHandler handlerShutterCallback;
    
    public $OnZoomChangeListenerChannel channelOnZoomChangeListener;
    public $OnZoomChangeListenerHandler handlerOnZoomChangeListener;
    
    public $AutoFocusMoveCallbackChannel channelAutoFocusMoveCallback;
    public $AutoFocusMoveCallbackHandler handlerAutoFocusMoveCallback;
    
    public $PictureCallbackChannel channelPictureCallback;
    public $PictureCallbackHandler handlerPictureCallback;
    
    public $PreviewCallbackChannel channelPreviewCallback;
    public $PreviewCallbackHandler handlerPreviewCallback;
    

    public $LibraryImplementations(TypeChannelMessenger messenger) {
      this.messenger = messenger;
      
      this.channelCameraProxy = new $CameraProxyChannel(messenger);
      this.handlerCameraProxy = new $CameraProxyHandler(this);
      
      this.channelParameters = new $ParametersChannel(messenger);
      this.handlerParameters = new $ParametersHandler(this);
      
      this.channelArea = new $AreaChannel(messenger);
      this.handlerArea = new $AreaHandler(this);
      
      this.channelRect = new $RectChannel(messenger);
      this.handlerRect = new $RectHandler(this);
      
      this.channelSize = new $SizeChannel(messenger);
      this.handlerSize = new $SizeHandler(this);
      
      this.channelCameraInfo = new $CameraInfoChannel(messenger);
      this.handlerCameraInfo = new $CameraInfoHandler(this);
      
      this.channelImageFormat = new $ImageFormatChannel(messenger);
      this.handlerImageFormat = new $ImageFormatHandler(this);
      
      
      this.channelErrorCallback = new $ErrorCallbackChannel(messenger);
      this.handlerErrorCallback = new $ErrorCallbackHandler(this);
      
      this.channelAutoFocusCallback = new $AutoFocusCallbackChannel(messenger);
      this.handlerAutoFocusCallback = new $AutoFocusCallbackHandler(this);
      
      this.channelShutterCallback = new $ShutterCallbackChannel(messenger);
      this.handlerShutterCallback = new $ShutterCallbackHandler(this);
      
      this.channelOnZoomChangeListener = new $OnZoomChangeListenerChannel(messenger);
      this.handlerOnZoomChangeListener = new $OnZoomChangeListenerHandler(this);
      
      this.channelAutoFocusMoveCallback = new $AutoFocusMoveCallbackChannel(messenger);
      this.handlerAutoFocusMoveCallback = new $AutoFocusMoveCallbackHandler(this);
      
      this.channelPictureCallback = new $PictureCallbackChannel(messenger);
      this.handlerPictureCallback = new $PictureCallbackHandler(this);
      
      this.channelPreviewCallback = new $PreviewCallbackChannel(messenger);
      this.handlerPreviewCallback = new $PreviewCallbackHandler(this);
      
    }
  }

  public static class $ChannelRegistrar {
    public final $LibraryImplementations implementations;

    public $ChannelRegistrar($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    public void registerHandlers() {
      
      implementations.channelCameraProxy.setHandler(implementations.handlerCameraProxy);
      
      implementations.channelParameters.setHandler(implementations.handlerParameters);
      
      implementations.channelArea.setHandler(implementations.handlerArea);
      
      implementations.channelRect.setHandler(implementations.handlerRect);
      
      implementations.channelSize.setHandler(implementations.handlerSize);
      
      implementations.channelCameraInfo.setHandler(implementations.handlerCameraInfo);
      
      implementations.channelImageFormat.setHandler(implementations.handlerImageFormat);
      
      
      implementations.channelErrorCallback.setHandler(implementations.handlerErrorCallback);
      
      implementations.channelAutoFocusCallback.setHandler(implementations.handlerAutoFocusCallback);
      
      implementations.channelShutterCallback.setHandler(implementations.handlerShutterCallback);
      
      implementations.channelOnZoomChangeListener.setHandler(implementations.handlerOnZoomChangeListener);
      
      implementations.channelAutoFocusMoveCallback.setHandler(implementations.handlerAutoFocusMoveCallback);
      
      implementations.channelPictureCallback.setHandler(implementations.handlerPictureCallback);
      
      implementations.channelPreviewCallback.setHandler(implementations.handlerPreviewCallback);
      
    }

    public void unregisterHandlers() {
      
      implementations.channelCameraProxy.removeHandler();
      
      implementations.channelParameters.removeHandler();
      
      implementations.channelArea.removeHandler();
      
      implementations.channelRect.removeHandler();
      
      implementations.channelSize.removeHandler();
      
      implementations.channelCameraInfo.removeHandler();
      
      implementations.channelImageFormat.removeHandler();
      
      
      implementations.channelErrorCallback.removeHandler();
      
      implementations.channelAutoFocusCallback.removeHandler();
      
      implementations.channelShutterCallback.removeHandler();
      
      implementations.channelOnZoomChangeListener.removeHandler();
      
      implementations.channelAutoFocusMoveCallback.removeHandler();
      
      implementations.channelPictureCallback.removeHandler();
      
      implementations.channelPreviewCallback.removeHandler();
      
    }
  }
}
