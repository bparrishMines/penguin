// GENERATED CODE - DO NOT MODIFY BY HAND


package dev.penguin.android_hardware;



import dev.penguin.android_hardware.PictureCallbackProxy;

import dev.penguin.android_hardware.PreviewCallbackProxy;

import dev.penguin.android_hardware.CameraProxy;

import dev.penguin.android_hardware.CameraParametersProxy;

import dev.penguin.android_hardware.CameraInfoProxy;

import dev.penguin.android_hardware.CameraAreaProxy;

import dev.penguin.android_hardware.CameraSizeProxy;

import dev.penguin.android_hardware.CameraRectProxy;

import dev.penguin.android_hardware.ImageFormatProxy;


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
  
  public interface $ErrorCallback {
    Completable<Void> invoke(Integer error);
  }
  
  public interface $AutoFocusCallback {
    Completable<Void> invoke(Boolean success);
  }
  
  public interface $ShutterCallback {
    Completable<Void> invoke();
  }
  
  public interface $DataCallback {
    Completable<Void> invoke(byte[] data);
  }
  
  public interface $OnZoomChangeListener {
    Completable<Void> invoke(Integer zoomValue,Boolean stopped);
  }
  
  public interface $AutoFocusMoveCallback {
    Completable<Void> invoke(Boolean start);
  }
  

  
  public static class $ErrorCallbackChannel extends TypeChannel<$ErrorCallback> {
    public $ErrorCallbackChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "android_hardware/camera/ErrorCallback");
    }

    public Completable<PairedInstance> $create($ErrorCallback $instance, boolean $owner) {
      return createNewInstancePair($instance, Collections.emptyList(), $owner);
    }

    private Completable<Void> invoke($ErrorCallback $instance
        , Integer error) {
      return invokeMethod($instance, "", Arrays.<Object>asList(error));
    }
  }
  
  public static class $AutoFocusCallbackChannel extends TypeChannel<$AutoFocusCallback> {
    public $AutoFocusCallbackChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "android_hardware/camera/AutoFocusCallback");
    }

    public Completable<PairedInstance> $create($AutoFocusCallback $instance, boolean $owner) {
      return createNewInstancePair($instance, Collections.emptyList(), $owner);
    }

    private Completable<Void> invoke($AutoFocusCallback $instance
        , Boolean success) {
      return invokeMethod($instance, "", Arrays.<Object>asList(success));
    }
  }
  
  public static class $ShutterCallbackChannel extends TypeChannel<$ShutterCallback> {
    public $ShutterCallbackChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "android_hardware/camera/ShutterCallback");
    }

    public Completable<PairedInstance> $create($ShutterCallback $instance, boolean $owner) {
      return createNewInstancePair($instance, Collections.emptyList(), $owner);
    }

    private Completable<Void> invoke($ShutterCallback $instance
        ) {
      return invokeMethod($instance, "", Arrays.<Object>asList());
    }
  }
  
  public static class $DataCallbackChannel extends TypeChannel<$DataCallback> {
    public $DataCallbackChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "android_hardware/camera/DataCallback");
    }

    public Completable<PairedInstance> $create($DataCallback $instance, boolean $owner) {
      return createNewInstancePair($instance, Collections.emptyList(), $owner);
    }

    private Completable<Void> invoke($DataCallback $instance
        , byte[] data) {
      return invokeMethod($instance, "", Arrays.<Object>asList(data));
    }
  }
  
  public static class $OnZoomChangeListenerChannel extends TypeChannel<$OnZoomChangeListener> {
    public $OnZoomChangeListenerChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "android_hardware/camera/OnZoomChangeListener");
    }

    public Completable<PairedInstance> $create($OnZoomChangeListener $instance, boolean $owner) {
      return createNewInstancePair($instance, Collections.emptyList(), $owner);
    }

    private Completable<Void> invoke($OnZoomChangeListener $instance
        , Integer zoomValue, Boolean stopped) {
      return invokeMethod($instance, "", Arrays.<Object>asList(zoomValue,stopped));
    }
  }
  
  public static class $AutoFocusMoveCallbackChannel extends TypeChannel<$AutoFocusMoveCallback> {
    public $AutoFocusMoveCallbackChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "android_hardware/camera/AutoFocusMoveCallback");
    }

    public Completable<PairedInstance> $create($AutoFocusMoveCallback $instance, boolean $owner) {
      return createNewInstancePair($instance, Collections.emptyList(), $owner);
    }

    private Completable<Void> invoke($AutoFocusMoveCallback $instance
        , Boolean start) {
      return invokeMethod($instance, "", Arrays.<Object>asList(start));
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
        public Completable<Void> invoke(byte[] data) {
          return implementations.channelDataCallback.invoke(this,data);
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
    public Object invokeMethod(TypeChannelMessenger messenger, $AutoFocusMoveCallback instance, String methodName, List<Object> arguments) throws Exception {
      return instance.invoke((Boolean) arguments.get(0));
    }
  }
  

  
  public static class $PictureCallbackProxyChannel extends TypeChannel<PictureCallbackProxy> {
    public $PictureCallbackProxyChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "android_hardware/camera/PictureCallback");
    }

    
    public Completable<PairedInstance> $create$(PictureCallbackProxy $instance, boolean $owner,DataCallback onPictureTaken) {
      return createNewInstancePair($instance, Arrays.<Object>asList("", onPictureTaken), $owner);
    }
    

    

    
  }
  
  public static class $PreviewCallbackProxyChannel extends TypeChannel<PreviewCallbackProxy> {
    public $PreviewCallbackProxyChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "android_hardware/camera/PreviewCallback");
    }

    
    public Completable<PairedInstance> $create$(PreviewCallbackProxy $instance, boolean $owner,DataCallback onPreviewFrame) {
      return createNewInstancePair($instance, Arrays.<Object>asList("", onPreviewFrame), $owner);
    }
    

    

    
  }
  
  public static class $CameraProxyChannel extends TypeChannel<CameraProxy> {
    public $CameraProxyChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "android_hardware/camera/Camera");
    }

    
    public Completable<PairedInstance> $create$(CameraProxy $instance, boolean $owner) {
      return createNewInstancePair($instance, Arrays.<Object>asList(""), $owner);
    }
    

    
    
    
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  }
  
  public static class $CameraParametersProxyChannel extends TypeChannel<CameraParametersProxy> {
    public $CameraParametersProxyChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "android_hardware/camera/CameraParameters");
    }

    

    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  }
  
  public static class $CameraAreaProxyChannel extends TypeChannel<CameraAreaProxy> {
    public $CameraAreaProxyChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "android_hardware/camera/CameraArea");
    }

    
    public Completable<PairedInstance> $create$(CameraAreaProxy $instance, boolean $owner,CameraRectProxy rect,Integer weight) {
      return createNewInstancePair($instance, Arrays.<Object>asList("", rect, weight), $owner);
    }
    

    

    
  }
  
  public static class $CameraRectProxyChannel extends TypeChannel<CameraRectProxy> {
    public $CameraRectProxyChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "android_hardware/camera/CameraRect");
    }

    
    public Completable<PairedInstance> $create$(CameraRectProxy $instance, boolean $owner,Integer top,Integer bottom,Integer right,Integer left) {
      return createNewInstancePair($instance, Arrays.<Object>asList("", top, bottom, right, left), $owner);
    }
    

    

    
  }
  
  public static class $CameraSizeProxyChannel extends TypeChannel<CameraSizeProxy> {
    public $CameraSizeProxyChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "android_hardware/camera/CameraSize");
    }

    
    public Completable<PairedInstance> $create$(CameraSizeProxy $instance, boolean $owner,Integer width,Integer height) {
      return createNewInstancePair($instance, Arrays.<Object>asList("", width, height), $owner);
    }
    

    

    
  }
  
  public static class $CameraInfoProxyChannel extends TypeChannel<CameraInfoProxy> {
    public $CameraInfoProxyChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "android_hardware/camera/CameraInfo");
    }

    
    public Completable<PairedInstance> $create$(CameraInfoProxy $instance, boolean $owner,Integer cameraId,Integer facing,Integer orientation,Boolean canDisableShutterSound) {
      return createNewInstancePair($instance, Arrays.<Object>asList("", cameraId, facing, orientation, canDisableShutterSound), $owner);
    }
    

    

    
  }
  
  public static class $ImageFormatProxyChannel extends TypeChannel<ImageFormatProxy> {
    public $ImageFormatProxyChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "android_hardware/camera/ImageFormat");
    }

    

    
    
    

    
  }
  

  
  public static class $PictureCallbackProxyHandler implements TypeChannelHandler<PictureCallbackProxy> {
    public final $LibraryImplementations implementations;

    public $PictureCallbackProxyHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    
    public PictureCallbackProxy $create$(DataCallback onPictureTaken)
        throws Exception {
      return new PictureCallbackProxy(implementations, false, onPictureTaken);
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
    public PictureCallbackProxy createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      final String constructorName = (String) arguments.get(0);
      switch(constructorName) {
        
        case "":
          return $create$((DataCallback) arguments.get(1));
        
      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke constructor of %s", constructorName));
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        PictureCallbackProxy instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      switch(methodName) {
        
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }
  
  public static class $PreviewCallbackProxyHandler implements TypeChannelHandler<PreviewCallbackProxy> {
    public final $LibraryImplementations implementations;

    public $PreviewCallbackProxyHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    
    public PreviewCallbackProxy $create$(DataCallback onPreviewFrame)
        throws Exception {
      return new PreviewCallbackProxy(implementations, false, onPreviewFrame);
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
    public PreviewCallbackProxy createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      final String constructorName = (String) arguments.get(0);
      switch(constructorName) {
        
        case "":
          return $create$((DataCallback) arguments.get(1));
        
      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke constructor of %s", constructorName));
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        PreviewCallbackProxy instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      switch(methodName) {
        
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }
  
  public static class $CameraProxyHandler implements TypeChannelHandler<CameraProxy> {
    public final $LibraryImplementations implementations;

    public $CameraProxyHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    
    public CameraProxy $create$()
        throws Exception {
      return new CameraProxy(implementations, false);
    }
    

    
    
    public List<CameraInfoProxy> $getAllCameraInfo()
        throws Exception {
      return CameraProxy.staticMethodTemplate(implementations, __parameter_name__);
    }
    
    
    
    public CameraProxy $open(Integer cameraId)
        throws Exception {
      return CameraProxy.staticMethodTemplate(implementations, __parameter_name__);
    }

    public void $release(CameraProxy $instance) throws Exception {
       $instance.release();
    }
    
    
    
    public void $startPreview(CameraProxy $instance) throws Exception {
       $instance.startPreview();
    }
    
    
    
    public void $stopPreview(CameraProxy $instance) throws Exception {
       $instance.stopPreview();
    }
    
    
    
    public Integer $attachPreviewTexture(CameraProxy $instance) throws Exception {
      return $instance.attachPreviewTexture();
    }
    
    
    
    public void $releasePreviewTexture(CameraProxy $instance) throws Exception {
       $instance.releasePreviewTexture();
    }
    
    
    
    public void $unlock(CameraProxy $instance) throws Exception {
       $instance.unlock();
    }
    
    
    
    public void $setOneShotPreviewCallback(CameraProxy $instance,PreviewCallbackProxy callback) throws Exception {
       $instance.setOneShotPreviewCallback( callback );
    }
    
    
    
    public void $setPreviewCallback(CameraProxy $instance,PreviewCallbackProxy callback) throws Exception {
       $instance.setPreviewCallback( callback );
    }
    
    
    
    public void $reconnect(CameraProxy $instance) throws Exception {
       $instance.reconnect();
    }
    
    
    
    public void $takePicture(CameraProxy $instance,ShutterCallback shutter,PictureCallbackProxy raw,PictureCallbackProxy postView,PictureCallbackProxy jpeg) throws Exception {
       $instance.takePicture( shutter , raw , postView , jpeg );
    }
    
    
    
    public void $autoFocus(CameraProxy $instance,AutoFocusCallback callback) throws Exception {
       $instance.autoFocus( callback );
    }
    
    
    
    public void $cancelAutoFocus(CameraProxy $instance) throws Exception {
       $instance.cancelAutoFocus();
    }
    
    
    
    public void $setDisplayOrientation(CameraProxy $instance,Integer degrees) throws Exception {
       $instance.setDisplayOrientation( degrees );
    }
    
    
    
    public void $setErrorCallback(CameraProxy $instance,ErrorCallback callback) throws Exception {
       $instance.setErrorCallback( callback );
    }
    
    
    
    public void $startSmoothZoom(CameraProxy $instance,Integer value) throws Exception {
       $instance.startSmoothZoom( value );
    }
    
    
    
    public void $stopSmoothZoom(CameraProxy $instance) throws Exception {
       $instance.stopSmoothZoom();
    }
    
    
    
    public CameraParametersProxy $getParameters(CameraProxy $instance) throws Exception {
      return $instance.getParameters();
    }
    
    
    
    public void $setParameters(CameraProxy $instance,CameraParametersProxy parameters) throws Exception {
       $instance.setParameters( parameters );
    }
    
    
    
    public void $setZoomChangeListener(CameraProxy $instance,OnZoomChangeListener listener) throws Exception {
       $instance.setZoomChangeListener( listener );
    }
    
    
    
    public void $setAutoFocusMoveCallback(CameraProxy $instance,AutoFocusMoveCallback callback) throws Exception {
       $instance.setAutoFocusMoveCallback( callback );
    }
    
    
    
    public void $lock(CameraProxy $instance) throws Exception {
       $instance.lock();
    }
    
    
    
    public Boolean $enableShutterSound(CameraProxy $instance,Boolean enabled) throws Exception {
      return $instance.enableShutterSound( enabled );
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
           $setOneShotPreviewCallback(instance,(PreviewCallbackProxy) arguments.get(0));
          
          return null;
          
        
        
        
        case "setPreviewCallback":
           $setPreviewCallback(instance,(PreviewCallbackProxy) arguments.get(0));
          
          return null;
          
        
        
        
        case "reconnect":
           $reconnect(instance);
          
          return null;
          
        
        
        
        case "takePicture":
           $takePicture(instance,(ShutterCallback) arguments.get(0),(PictureCallbackProxy) arguments.get(1),(PictureCallbackProxy) arguments.get(2),(PictureCallbackProxy) arguments.get(3));
          
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
           $setParameters(instance,(CameraParametersProxy) arguments.get(0));
          
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
  
  public static class $CameraParametersProxyHandler implements TypeChannelHandler<CameraParametersProxy> {
    public final $LibraryImplementations implementations;

    public $CameraParametersProxyHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    

    

    
    
    public Boolean $getAutoExposureLock(CameraParametersProxy $instance) throws Exception {
      return $instance.getAutoExposureLock();
    }
    
    
    
    public List<CameraAreaProxy> $getFocusAreas(CameraParametersProxy $instance) throws Exception {
      return $instance.getFocusAreas();
    }
    
    
    
    public List<Double> $getFocusDistances(CameraParametersProxy $instance) throws Exception {
      return $instance.getFocusDistances();
    }
    
    
    
    public Integer $getMaxExposureCompensation(CameraParametersProxy $instance) throws Exception {
      return $instance.getMaxExposureCompensation();
    }
    
    
    
    public Integer $getMaxNumFocusAreas(CameraParametersProxy $instance) throws Exception {
      return $instance.getMaxNumFocusAreas();
    }
    
    
    
    public Integer $getMinExposureCompensation(CameraParametersProxy $instance) throws Exception {
      return $instance.getMinExposureCompensation();
    }
    
    
    
    public List<String> $getSupportedFocusModes(CameraParametersProxy $instance) throws Exception {
      return $instance.getSupportedFocusModes();
    }
    
    
    
    public Boolean $isAutoExposureLockSupported(CameraParametersProxy $instance) throws Exception {
      return $instance.isAutoExposureLockSupported();
    }
    
    
    
    public Boolean $isZoomSupported(CameraParametersProxy $instance) throws Exception {
      return $instance.isZoomSupported();
    }
    
    
    
    public void $setAutoExposureLock(CameraParametersProxy $instance,Boolean toggle) throws Exception {
       $instance.setAutoExposureLock( toggle );
    }
    
    
    
    public void $setExposureCompensation(CameraParametersProxy $instance,Integer value) throws Exception {
       $instance.setExposureCompensation( value );
    }
    
    
    
    public void $setFocusAreas(CameraParametersProxy $instance,List<CameraAreaProxy> focusAreas) throws Exception {
       $instance.setFocusAreas( focusAreas );
    }
    
    
    
    public void $setFocusMode(CameraParametersProxy $instance,String value) throws Exception {
       $instance.setFocusMode( value );
    }
    
    
    
    public String $getFlashMode(CameraParametersProxy $instance) throws Exception {
      return $instance.getFlashMode();
    }
    
    
    
    public Integer $getMaxZoom(CameraParametersProxy $instance) throws Exception {
      return $instance.getMaxZoom();
    }
    
    
    
    public CameraSizeProxy $getPictureSize(CameraParametersProxy $instance) throws Exception {
      return $instance.getPictureSize();
    }
    
    
    
    public CameraSizeProxy $getPreviewSize(CameraParametersProxy $instance) throws Exception {
      return $instance.getPreviewSize();
    }
    
    
    
    public List<CameraSizeProxy> $getSupportedPreviewSizes(CameraParametersProxy $instance) throws Exception {
      return $instance.getSupportedPreviewSizes();
    }
    
    
    
    public List<CameraSizeProxy> $getSupportedPictureSizes(CameraParametersProxy $instance) throws Exception {
      return $instance.getSupportedPictureSizes();
    }
    
    
    
    public List<String> $getSupportedFlashModes(CameraParametersProxy $instance) throws Exception {
      return $instance.getSupportedFlashModes();
    }
    
    
    
    public Integer $getZoom(CameraParametersProxy $instance) throws Exception {
      return $instance.getZoom();
    }
    
    
    
    public Boolean $isSmoothZoomSupported(CameraParametersProxy $instance) throws Exception {
      return $instance.isSmoothZoomSupported();
    }
    
    
    
    public void $setFlashMode(CameraParametersProxy $instance,String mode) throws Exception {
       $instance.setFlashMode( mode );
    }
    
    
    
    public void $setPictureSize(CameraParametersProxy $instance,Integer width,Integer height) throws Exception {
       $instance.setPictureSize( width , height );
    }
    
    
    
    public void $setRecordingHint(CameraParametersProxy $instance,Boolean hint) throws Exception {
       $instance.setRecordingHint( hint );
    }
    
    
    
    public void $setRotation(CameraParametersProxy $instance,Integer rotation) throws Exception {
       $instance.setRotation( rotation );
    }
    
    
    
    public void $setZoom(CameraParametersProxy $instance,Integer value) throws Exception {
       $instance.setZoom( value );
    }
    
    
    
    public void $setPreviewSize(CameraParametersProxy $instance,Integer width,Integer height) throws Exception {
       $instance.setPreviewSize( width , height );
    }
    
    
    
    public Integer $getExposureCompensation(CameraParametersProxy $instance) throws Exception {
      return $instance.getExposureCompensation();
    }
    
    
    
    public Double $getExposureCompensationStep(CameraParametersProxy $instance) throws Exception {
      return $instance.getExposureCompensationStep();
    }
    
    
    
    public String $flatten(CameraParametersProxy $instance) throws Exception {
      return $instance.flatten();
    }
    
    
    
    public String $get(CameraParametersProxy $instance,String key) throws Exception {
      return $instance.get( key );
    }
    
    
    
    public String $getAntibanding(CameraParametersProxy $instance) throws Exception {
      return $instance.getAntibanding();
    }
    
    
    
    public Boolean $getAutoWhiteBalanceLock(CameraParametersProxy $instance) throws Exception {
      return $instance.getAutoWhiteBalanceLock();
    }
    
    
    
    public String $getColorEffect(CameraParametersProxy $instance) throws Exception {
      return $instance.getColorEffect();
    }
    
    
    
    public Double $getFocalLength(CameraParametersProxy $instance) throws Exception {
      return $instance.getFocalLength();
    }
    
    
    
    public String $getFocusMode(CameraParametersProxy $instance) throws Exception {
      return $instance.getFocusMode();
    }
    
    
    
    public Double $getHorizontalViewAngle(CameraParametersProxy $instance) throws Exception {
      return $instance.getHorizontalViewAngle();
    }
    
    
    
    public Integer $getInt(CameraParametersProxy $instance,String key) throws Exception {
      return $instance.getInt( key );
    }
    
    
    
    public Integer $getJpegQuality(CameraParametersProxy $instance) throws Exception {
      return $instance.getJpegQuality();
    }
    
    
    
    public Integer $getJpegThumbnailQuality(CameraParametersProxy $instance) throws Exception {
      return $instance.getJpegThumbnailQuality();
    }
    
    
    
    public CameraSizeProxy $getJpegThumbnailSize(CameraParametersProxy $instance) throws Exception {
      return $instance.getJpegThumbnailSize();
    }
    
    
    
    public Integer $getMaxNumMeteringAreas(CameraParametersProxy $instance) throws Exception {
      return $instance.getMaxNumMeteringAreas();
    }
    
    
    
    public List<CameraAreaProxy> $getMeteringAreas(CameraParametersProxy $instance) throws Exception {
      return $instance.getMeteringAreas();
    }
    
    
    
    public Integer $getPictureFormat(CameraParametersProxy $instance) throws Exception {
      return $instance.getPictureFormat();
    }
    
    
    
    public CameraSizeProxy $getPreferredPreviewSizeForVideo(CameraParametersProxy $instance) throws Exception {
      return $instance.getPreferredPreviewSizeForVideo();
    }
    
    
    
    public Integer $getPreviewFormat(CameraParametersProxy $instance) throws Exception {
      return $instance.getPreviewFormat();
    }
    
    
    
    public List<Integer> $getPreviewFpsRange(CameraParametersProxy $instance) throws Exception {
      return $instance.getPreviewFpsRange();
    }
    
    
    
    public String $getSceneMode(CameraParametersProxy $instance) throws Exception {
      return $instance.getSceneMode();
    }
    
    
    
    public List<String> $getSupportedAntibanding(CameraParametersProxy $instance) throws Exception {
      return $instance.getSupportedAntibanding();
    }
    
    
    
    public List<String> $getSupportedColorEffects(CameraParametersProxy $instance) throws Exception {
      return $instance.getSupportedColorEffects();
    }
    
    
    
    public CameraSizeProxy $getSupportedJpegThumbnailSizes(CameraParametersProxy $instance) throws Exception {
      return $instance.getSupportedJpegThumbnailSizes();
    }
    
    
    
    public List<Integer> $getSupportedPictureFormats(CameraParametersProxy $instance) throws Exception {
      return $instance.getSupportedPictureFormats();
    }
    
    
    
    public List<Integer> $getSupportedPreviewFormats(CameraParametersProxy $instance) throws Exception {
      return $instance.getSupportedPreviewFormats();
    }
    
    
    
    public List<List<Integer>> $getSupportedPreviewFpsRange(CameraParametersProxy $instance) throws Exception {
      return $instance.getSupportedPreviewFpsRange();
    }
    
    
    
    public List<String> $getSupportedSceneModes(CameraParametersProxy $instance) throws Exception {
      return $instance.getSupportedSceneModes();
    }
    
    
    
    public List<CameraSizeProxy> $getSupportedVideoSizes(CameraParametersProxy $instance) throws Exception {
      return $instance.getSupportedVideoSizes();
    }
    
    
    
    public List<String> $getSupportedWhiteBalance(CameraParametersProxy $instance) throws Exception {
      return $instance.getSupportedWhiteBalance();
    }
    
    
    
    public Double $getVerticalViewAngle(CameraParametersProxy $instance) throws Exception {
      return $instance.getVerticalViewAngle();
    }
    
    
    
    public Boolean $getVideoStabilization(CameraParametersProxy $instance) throws Exception {
      return $instance.getVideoStabilization();
    }
    
    
    
    public String $getWhiteBalance(CameraParametersProxy $instance) throws Exception {
      return $instance.getWhiteBalance();
    }
    
    
    
    public List<Integer> $getZoomRatios(CameraParametersProxy $instance) throws Exception {
      return $instance.getZoomRatios();
    }
    
    
    
    public Boolean $isAutoWhiteBalanceLockSupported(CameraParametersProxy $instance) throws Exception {
      return $instance.isAutoWhiteBalanceLockSupported();
    }
    
    
    
    public Boolean $isVideoSnapshotSupported(CameraParametersProxy $instance) throws Exception {
      return $instance.isVideoSnapshotSupported();
    }
    
    
    
    public Boolean $isVideoStabilizationSupported(CameraParametersProxy $instance) throws Exception {
      return $instance.isVideoStabilizationSupported();
    }
    
    
    
    public void $remove(CameraParametersProxy $instance,String key) throws Exception {
       $instance.remove( key );
    }
    
    
    
    public void $removeGpsData(CameraParametersProxy $instance) throws Exception {
       $instance.removeGpsData();
    }
    
    
    
    public void $set(CameraParametersProxy $instance,String key,Object value) throws Exception {
       $instance.set( key , value );
    }
    
    
    
    public void $setAntibanding(CameraParametersProxy $instance,String antibanding) throws Exception {
       $instance.setAntibanding( antibanding );
    }
    
    
    
    public void $setAutoWhiteBalanceLock(CameraParametersProxy $instance,Boolean toggle) throws Exception {
       $instance.setAutoWhiteBalanceLock( toggle );
    }
    
    
    
    public void $setColorEffect(CameraParametersProxy $instance,String effect) throws Exception {
       $instance.setColorEffect( effect );
    }
    
    
    
    public void $setGpsAltitude(CameraParametersProxy $instance,Double meters) throws Exception {
       $instance.setGpsAltitude( meters );
    }
    
    
    
    public void $setGpsLatitude(CameraParametersProxy $instance,Double latitude) throws Exception {
       $instance.setGpsLatitude( latitude );
    }
    
    
    
    public void $setGpsLongitude(CameraParametersProxy $instance,Double longitude) throws Exception {
       $instance.setGpsLongitude( longitude );
    }
    
    
    
    public void $setGpsProcessingMethod(CameraParametersProxy $instance,String processingMethod) throws Exception {
       $instance.setGpsProcessingMethod( processingMethod );
    }
    
    
    
    public void $setGpsTimestamp(CameraParametersProxy $instance,Integer timestamp) throws Exception {
       $instance.setGpsTimestamp( timestamp );
    }
    
    
    
    public void $setJpegQuality(CameraParametersProxy $instance,Integer quality) throws Exception {
       $instance.setJpegQuality( quality );
    }
    
    
    
    public void $setJpegThumbnailQuality(CameraParametersProxy $instance,Integer quality) throws Exception {
       $instance.setJpegThumbnailQuality( quality );
    }
    
    
    
    public void $setJpegThumbnailSize(CameraParametersProxy $instance,Integer width,Integer height) throws Exception {
       $instance.setJpegThumbnailSize( width , height );
    }
    
    
    
    public void $setMeteringAreas(CameraParametersProxy $instance,List<CameraAreaProxy> meteringAreas) throws Exception {
       $instance.setMeteringAreas( meteringAreas );
    }
    
    
    
    public void $setPictureFormat(CameraParametersProxy $instance,Integer pixelFormat) throws Exception {
       $instance.setPictureFormat( pixelFormat );
    }
    
    
    
    public void $setPreviewFormat(CameraParametersProxy $instance,Integer pixelFormat) throws Exception {
       $instance.setPreviewFormat( pixelFormat );
    }
    
    
    
    public void $setPreviewFpsRange(CameraParametersProxy $instance,Integer min,Integer max) throws Exception {
       $instance.setPreviewFpsRange( min , max );
    }
    
    
    
    public void $setSceneMode(CameraParametersProxy $instance,String mode) throws Exception {
       $instance.setSceneMode( mode );
    }
    
    
    
    public void $setVideoStabilization(CameraParametersProxy $instance,Boolean toggle) throws Exception {
       $instance.setVideoStabilization( toggle );
    }
    
    
    
    public void $setWhiteBalance(CameraParametersProxy $instance,String value) throws Exception {
       $instance.setWhiteBalance( value );
    }
    
    
    
    public void $unflatten(CameraParametersProxy $instance,String flattened) throws Exception {
       $instance.unflatten( flattened );
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
    public CameraParametersProxy createInstance(TypeChannelMessenger messenger, List<Object> arguments)
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
        CameraParametersProxy instance,
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
           $setFocusAreas(instance,(List<CameraAreaProxy>) arguments.get(0));
          
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
           $setMeteringAreas(instance,(List<CameraAreaProxy>) arguments.get(0));
          
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
  
  public static class $CameraAreaProxyHandler implements TypeChannelHandler<CameraAreaProxy> {
    public final $LibraryImplementations implementations;

    public $CameraAreaProxyHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    
    public CameraAreaProxy $create$(CameraRectProxy rect,Integer weight)
        throws Exception {
      return new CameraAreaProxy(implementations, false, rect, weight);
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
    public CameraAreaProxy createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      final String constructorName = (String) arguments.get(0);
      switch(constructorName) {
        
        case "":
          return $create$((CameraRectProxy) arguments.get(1),(Integer) arguments.get(2));
        
      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke constructor of %s", constructorName));
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        CameraAreaProxy instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      switch(methodName) {
        
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }
  
  public static class $CameraRectProxyHandler implements TypeChannelHandler<CameraRectProxy> {
    public final $LibraryImplementations implementations;

    public $CameraRectProxyHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    
    public CameraRectProxy $create$(Integer top,Integer bottom,Integer right,Integer left)
        throws Exception {
      return new CameraRectProxy(implementations, false, top, bottom, right, left);
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
    public CameraRectProxy createInstance(TypeChannelMessenger messenger, List<Object> arguments)
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
        CameraRectProxy instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      switch(methodName) {
        
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }
  
  public static class $CameraSizeProxyHandler implements TypeChannelHandler<CameraSizeProxy> {
    public final $LibraryImplementations implementations;

    public $CameraSizeProxyHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    
    public CameraSizeProxy $create$(Integer width,Integer height)
        throws Exception {
      return new CameraSizeProxy(implementations, false, width, height);
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
    public CameraSizeProxy createInstance(TypeChannelMessenger messenger, List<Object> arguments)
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
        CameraSizeProxy instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      switch(methodName) {
        
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }
  
  public static class $CameraInfoProxyHandler implements TypeChannelHandler<CameraInfoProxy> {
    public final $LibraryImplementations implementations;

    public $CameraInfoProxyHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    
    public CameraInfoProxy $create$(Integer cameraId,Integer facing,Integer orientation,Boolean canDisableShutterSound)
        throws Exception {
      return new CameraInfoProxy(implementations, false, cameraId, facing, orientation, canDisableShutterSound);
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
    public CameraInfoProxy createInstance(TypeChannelMessenger messenger, List<Object> arguments)
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
        CameraInfoProxy instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      switch(methodName) {
        
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }
  
  public static class $ImageFormatProxyHandler implements TypeChannelHandler<ImageFormatProxy> {
    public final $LibraryImplementations implementations;

    public $ImageFormatProxyHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    

    
    
    public Integer $getBitsPerPixel(Integer format)
        throws Exception {
      return ImageFormatProxy.staticMethodTemplate(implementations, __parameter_name__);
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
    public ImageFormatProxy createInstance(TypeChannelMessenger messenger, List<Object> arguments)
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
        ImageFormatProxy instance,
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

    
    public $PictureCallbackProxyChannel channelPictureCallbackProxy;
    public $PictureCallbackProxyHandler handlerPictureCallbackProxy;
    
    public $PreviewCallbackProxyChannel channelPreviewCallbackProxy;
    public $PreviewCallbackProxyHandler handlerPreviewCallbackProxy;
    
    public $CameraProxyChannel channelCameraProxy;
    public $CameraProxyHandler handlerCameraProxy;
    
    public $CameraParametersProxyChannel channelCameraParametersProxy;
    public $CameraParametersProxyHandler handlerCameraParametersProxy;
    
    public $CameraAreaProxyChannel channelCameraAreaProxy;
    public $CameraAreaProxyHandler handlerCameraAreaProxy;
    
    public $CameraRectProxyChannel channelCameraRectProxy;
    public $CameraRectProxyHandler handlerCameraRectProxy;
    
    public $CameraSizeProxyChannel channelCameraSizeProxy;
    public $CameraSizeProxyHandler handlerCameraSizeProxy;
    
    public $CameraInfoProxyChannel channelCameraInfoProxy;
    public $CameraInfoProxyHandler handlerCameraInfoProxy;
    
    public $ImageFormatProxyChannel channelImageFormatProxy;
    public $ImageFormatProxyHandler handlerImageFormatProxy;
    

    
    public $ErrorCallbackChannel channelErrorCallback;
    public $ErrorCallbackHandler handlerErrorCallback;
    
    public $AutoFocusCallbackChannel channelAutoFocusCallback;
    public $AutoFocusCallbackHandler handlerAutoFocusCallback;
    
    public $ShutterCallbackChannel channelShutterCallback;
    public $ShutterCallbackHandler handlerShutterCallback;
    
    public $DataCallbackChannel channelDataCallback;
    public $DataCallbackHandler handlerDataCallback;
    
    public $OnZoomChangeListenerChannel channelOnZoomChangeListener;
    public $OnZoomChangeListenerHandler handlerOnZoomChangeListener;
    
    public $AutoFocusMoveCallbackChannel channelAutoFocusMoveCallback;
    public $AutoFocusMoveCallbackHandler handlerAutoFocusMoveCallback;
    

    public $LibraryImplementations(TypeChannelMessenger messenger) {
      this.messenger = messenger;
      
      this.channelPictureCallbackProxy = new $PictureCallbackProxyChannel(messenger);
      this.handlerPictureCallbackProxy = new $PictureCallbackProxyHandler(this);
      
      this.channelPreviewCallbackProxy = new $PreviewCallbackProxyChannel(messenger);
      this.handlerPreviewCallbackProxy = new $PreviewCallbackProxyHandler(this);
      
      this.channelCameraProxy = new $CameraProxyChannel(messenger);
      this.handlerCameraProxy = new $CameraProxyHandler(this);
      
      this.channelCameraParametersProxy = new $CameraParametersProxyChannel(messenger);
      this.handlerCameraParametersProxy = new $CameraParametersProxyHandler(this);
      
      this.channelCameraAreaProxy = new $CameraAreaProxyChannel(messenger);
      this.handlerCameraAreaProxy = new $CameraAreaProxyHandler(this);
      
      this.channelCameraRectProxy = new $CameraRectProxyChannel(messenger);
      this.handlerCameraRectProxy = new $CameraRectProxyHandler(this);
      
      this.channelCameraSizeProxy = new $CameraSizeProxyChannel(messenger);
      this.handlerCameraSizeProxy = new $CameraSizeProxyHandler(this);
      
      this.channelCameraInfoProxy = new $CameraInfoProxyChannel(messenger);
      this.handlerCameraInfoProxy = new $CameraInfoProxyHandler(this);
      
      this.channelImageFormatProxy = new $ImageFormatProxyChannel(messenger);
      this.handlerImageFormatProxy = new $ImageFormatProxyHandler(this);
      
      
      this.channelErrorCallback = new $ErrorCallbackChannel(messenger);
      this.handlerErrorCallback = new $ErrorCallbackHandler(this);
      
      this.channelAutoFocusCallback = new $AutoFocusCallbackChannel(messenger);
      this.handlerAutoFocusCallback = new $AutoFocusCallbackHandler(this);
      
      this.channelShutterCallback = new $ShutterCallbackChannel(messenger);
      this.handlerShutterCallback = new $ShutterCallbackHandler(this);
      
      this.channelDataCallback = new $DataCallbackChannel(messenger);
      this.handlerDataCallback = new $DataCallbackHandler(this);
      
      this.channelOnZoomChangeListener = new $OnZoomChangeListenerChannel(messenger);
      this.handlerOnZoomChangeListener = new $OnZoomChangeListenerHandler(this);
      
      this.channelAutoFocusMoveCallback = new $AutoFocusMoveCallbackChannel(messenger);
      this.handlerAutoFocusMoveCallback = new $AutoFocusMoveCallbackHandler(this);
      
    }
  }

  public static class $ChannelRegistrar {
    public final $LibraryImplementations implementations;

    public $ChannelRegistrar($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    public void registerHandlers() {
      
      implementations.channelPictureCallbackProxy.setHandler(implementations.handlerPictureCallbackProxy);
      
      implementations.channelPreviewCallbackProxy.setHandler(implementations.handlerPreviewCallbackProxy);
      
      implementations.channelCameraProxy.setHandler(implementations.handlerCameraProxy);
      
      implementations.channelCameraParametersProxy.setHandler(implementations.handlerCameraParametersProxy);
      
      implementations.channelCameraAreaProxy.setHandler(implementations.handlerCameraAreaProxy);
      
      implementations.channelCameraRectProxy.setHandler(implementations.handlerCameraRectProxy);
      
      implementations.channelCameraSizeProxy.setHandler(implementations.handlerCameraSizeProxy);
      
      implementations.channelCameraInfoProxy.setHandler(implementations.handlerCameraInfoProxy);
      
      implementations.channelImageFormatProxy.setHandler(implementations.handlerImageFormatProxy);
      
      
      implementations.channelErrorCallback.setHandler(implementations.handlerErrorCallback);
      
      implementations.channelAutoFocusCallback.setHandler(implementations.handlerAutoFocusCallback);
      
      implementations.channelShutterCallback.setHandler(implementations.handlerShutterCallback);
      
      implementations.channelDataCallback.setHandler(implementations.handlerDataCallback);
      
      implementations.channelOnZoomChangeListener.setHandler(implementations.handlerOnZoomChangeListener);
      
      implementations.channelAutoFocusMoveCallback.setHandler(implementations.handlerAutoFocusMoveCallback);
      
    }

    public void unregisterHandlers() {
      
      implementations.channelPictureCallbackProxy.removeHandler();
      
      implementations.channelPreviewCallbackProxy.removeHandler();
      
      implementations.channelCameraProxy.removeHandler();
      
      implementations.channelCameraParametersProxy.removeHandler();
      
      implementations.channelCameraAreaProxy.removeHandler();
      
      implementations.channelCameraRectProxy.removeHandler();
      
      implementations.channelCameraSizeProxy.removeHandler();
      
      implementations.channelCameraInfoProxy.removeHandler();
      
      implementations.channelImageFormatProxy.removeHandler();
      
      
      implementations.channelErrorCallback.removeHandler();
      
      implementations.channelAutoFocusCallback.removeHandler();
      
      implementations.channelShutterCallback.removeHandler();
      
      implementations.channelDataCallback.removeHandler();
      
      implementations.channelOnZoomChangeListener.removeHandler();
      
      implementations.channelAutoFocusMoveCallback.removeHandler();
      
    }
  }
}
