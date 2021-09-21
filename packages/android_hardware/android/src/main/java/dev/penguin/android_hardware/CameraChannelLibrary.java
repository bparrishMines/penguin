// GENERATED CODE - DO NOT MODIFY BY HAND


package dev.penguin.android_hardware;



import android.hardware.Camera.ErrorCallback;


import dev.penguin.android_hardware.OnErrorCallback;


import android.hardware.Camera;


import android.hardware.Camera.AutoFocusCallback;


import dev.penguin.android_hardware.OnAutoFocusCallback;


import android.hardware.Camera.ShutterCallback;


import dev.penguin.android_hardware.OnShutterCallback;


import android.hardware.Camera.OnZoomChangeListener;


import dev.penguin.android_hardware.OnZoomChangeCallback;


import android.hardware.Camera.AutoFocusMoveCallback;


import dev.penguin.android_hardware.OnAutoFocusMovingCallback;


import android.hardware.Camera.PictureCallback;


import dev.penguin.android_hardware.OnPictureTakenCallback;


import android.hardware.Camera.PreviewCallback;


import dev.penguin.android_hardware.OnPreviewFrameCallback;


import android.hardware.Camera.Parameters;


import dev.penguin.android_hardware.CameraInfoProxy;


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
  
  public static class $OnErrorCallbackChannel extends TypeChannel<OnErrorCallback> {
    public final $LibraryImplementations implementations;

    public $OnErrorCallbackChannel(@NonNull $LibraryImplementations implementations) {
      super(implementations.messenger, "dev.penguin.android_hardware.OnErrorCallback");
      this.implementations = implementations;
    }

    public Completable<PairedInstance> $create$(OnErrorCallback $instance, boolean $owner) {
      return createNewInstancePair($instance, Collections.emptyList(), $owner);
    }

    public Completable<Void> $invoke(OnErrorCallback $instance
        , int error, Camera camera) {
      
      
      
      
      implementations.channelCamera.$create$(camera, false);
      
      
      return invokeMethod($instance, "", Arrays.<Object>asList(error,camera));
    }
  }
  
  public static class $OnAutoFocusCallbackChannel extends TypeChannel<OnAutoFocusCallback> {
    public final $LibraryImplementations implementations;

    public $OnAutoFocusCallbackChannel(@NonNull $LibraryImplementations implementations) {
      super(implementations.messenger, "dev.penguin.android_hardware.OnAutoFocusCallback");
      this.implementations = implementations;
    }

    public Completable<PairedInstance> $create$(OnAutoFocusCallback $instance, boolean $owner) {
      return createNewInstancePair($instance, Collections.emptyList(), $owner);
    }

    public Completable<Void> $invoke(OnAutoFocusCallback $instance
        , boolean success, Camera camera) {
      
      
      
      
      implementations.channelCamera.$create$(camera, false);
      
      
      return invokeMethod($instance, "", Arrays.<Object>asList(success,camera));
    }
  }
  
  public static class $OnShutterCallbackChannel extends TypeChannel<OnShutterCallback> {
    public final $LibraryImplementations implementations;

    public $OnShutterCallbackChannel(@NonNull $LibraryImplementations implementations) {
      super(implementations.messenger, "dev.penguin.android_hardware.OnShutterCallback");
      this.implementations = implementations;
    }

    public Completable<PairedInstance> $create$(OnShutterCallback $instance, boolean $owner) {
      return createNewInstancePair($instance, Collections.emptyList(), $owner);
    }

    public Completable<Void> $invoke(OnShutterCallback $instance
        ) {
      
      return invokeMethod($instance, "", Arrays.<Object>asList());
    }
  }
  
  public static class $OnZoomChangeCallbackChannel extends TypeChannel<OnZoomChangeCallback> {
    public final $LibraryImplementations implementations;

    public $OnZoomChangeCallbackChannel(@NonNull $LibraryImplementations implementations) {
      super(implementations.messenger, "dev.penguin.android_hardware.OnZoomChangeCallback");
      this.implementations = implementations;
    }

    public Completable<PairedInstance> $create$(OnZoomChangeCallback $instance, boolean $owner) {
      return createNewInstancePair($instance, Collections.emptyList(), $owner);
    }

    public Completable<Void> $invoke(OnZoomChangeCallback $instance
        , int zoomValue, boolean stopped, Camera camera) {
      
      
      
      
      
      
      implementations.channelCamera.$create$(camera, false);
      
      
      return invokeMethod($instance, "", Arrays.<Object>asList(zoomValue,stopped,camera));
    }
  }
  
  public static class $OnAutoFocusMovingCallbackChannel extends TypeChannel<OnAutoFocusMovingCallback> {
    public final $LibraryImplementations implementations;

    public $OnAutoFocusMovingCallbackChannel(@NonNull $LibraryImplementations implementations) {
      super(implementations.messenger, "dev.penguin.android_hardware.OnAutoFocusMovingCallback");
      this.implementations = implementations;
    }

    public Completable<PairedInstance> $create$(OnAutoFocusMovingCallback $instance, boolean $owner) {
      return createNewInstancePair($instance, Collections.emptyList(), $owner);
    }

    public Completable<Void> $invoke(OnAutoFocusMovingCallback $instance
        , boolean start, Camera camera) {
      
      
      
      
      implementations.channelCamera.$create$(camera, false);
      
      
      return invokeMethod($instance, "", Arrays.<Object>asList(start,camera));
    }
  }
  
  public static class $OnPictureTakenCallbackChannel extends TypeChannel<OnPictureTakenCallback> {
    public final $LibraryImplementations implementations;

    public $OnPictureTakenCallbackChannel(@NonNull $LibraryImplementations implementations) {
      super(implementations.messenger, "dev.penguin.android_hardware.OnPictureTakenCallback");
      this.implementations = implementations;
    }

    public Completable<PairedInstance> $create$(OnPictureTakenCallback $instance, boolean $owner) {
      return createNewInstancePair($instance, Collections.emptyList(), $owner);
    }

    public Completable<Void> $invoke(OnPictureTakenCallback $instance
        , byte[] data, Camera camera) {
      
      
      
      
      implementations.channelCamera.$create$(camera, false);
      
      
      return invokeMethod($instance, "", Arrays.<Object>asList(data,camera));
    }
  }
  
  public static class $OnPreviewFrameCallbackChannel extends TypeChannel<OnPreviewFrameCallback> {
    public final $LibraryImplementations implementations;

    public $OnPreviewFrameCallbackChannel(@NonNull $LibraryImplementations implementations) {
      super(implementations.messenger, "dev.penguin.android_hardware.OnPreviewFrameCallback");
      this.implementations = implementations;
    }

    public Completable<PairedInstance> $create$(OnPreviewFrameCallback $instance, boolean $owner) {
      return createNewInstancePair($instance, Collections.emptyList(), $owner);
    }

    public Completable<Void> $invoke(OnPreviewFrameCallback $instance
        , byte[] data, Camera camera) {
      
      
      
      
      implementations.channelCamera.$create$(camera, false);
      
      
      return invokeMethod($instance, "", Arrays.<Object>asList(data,camera));
    }
  }
  

  
  public static class $OnErrorCallbackHandler implements TypeChannelHandler<OnErrorCallback> {
    public final $LibraryImplementations implementations;

    public $OnErrorCallbackHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    public void $invoke(OnErrorCallback $instance, int error, Camera camera) {
      $instance.invoke(error,camera);
    }

    @Override
    public OnErrorCallback createInstance(TypeChannelMessenger messenger, List<Object> arguments) {
      return new OnErrorCallback() {
        @Override
        public Completable<Void> invoke(int error,Camera camera) {
          return implementations.channelOnErrorCallback.$invoke(this,error,camera);
        }
      };
    }

    @Override
    public Object invokeStaticMethod(TypeChannelMessenger messenger, String methodName, List<Object> arguments) {
      throw new UnsupportedOperationException();
    }

    @Override
    public Void invokeMethod(TypeChannelMessenger messenger, OnErrorCallback instance, String methodName, List<Object> arguments) throws Exception {
      $invoke(instance,(int) arguments.get(0),(Camera) arguments.get(1));
      return null;
    }
  }
  
  public static class $OnAutoFocusCallbackHandler implements TypeChannelHandler<OnAutoFocusCallback> {
    public final $LibraryImplementations implementations;

    public $OnAutoFocusCallbackHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    public void $invoke(OnAutoFocusCallback $instance, boolean success, Camera camera) {
      $instance.invoke(success,camera);
    }

    @Override
    public OnAutoFocusCallback createInstance(TypeChannelMessenger messenger, List<Object> arguments) {
      return new OnAutoFocusCallback() {
        @Override
        public Completable<Void> invoke(boolean success,Camera camera) {
          return implementations.channelOnAutoFocusCallback.$invoke(this,success,camera);
        }
      };
    }

    @Override
    public Object invokeStaticMethod(TypeChannelMessenger messenger, String methodName, List<Object> arguments) {
      throw new UnsupportedOperationException();
    }

    @Override
    public Void invokeMethod(TypeChannelMessenger messenger, OnAutoFocusCallback instance, String methodName, List<Object> arguments) throws Exception {
      $invoke(instance,(boolean) arguments.get(0),(Camera) arguments.get(1));
      return null;
    }
  }
  
  public static class $OnShutterCallbackHandler implements TypeChannelHandler<OnShutterCallback> {
    public final $LibraryImplementations implementations;

    public $OnShutterCallbackHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    public void $invoke(OnShutterCallback $instance) {
      $instance.invoke();
    }

    @Override
    public OnShutterCallback createInstance(TypeChannelMessenger messenger, List<Object> arguments) {
      return new OnShutterCallback() {
        @Override
        public Completable<Void> invoke() {
          return implementations.channelOnShutterCallback.$invoke(this);
        }
      };
    }

    @Override
    public Object invokeStaticMethod(TypeChannelMessenger messenger, String methodName, List<Object> arguments) {
      throw new UnsupportedOperationException();
    }

    @Override
    public Void invokeMethod(TypeChannelMessenger messenger, OnShutterCallback instance, String methodName, List<Object> arguments) throws Exception {
      $invoke(instance);
      return null;
    }
  }
  
  public static class $OnZoomChangeCallbackHandler implements TypeChannelHandler<OnZoomChangeCallback> {
    public final $LibraryImplementations implementations;

    public $OnZoomChangeCallbackHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    public void $invoke(OnZoomChangeCallback $instance, int zoomValue, boolean stopped, Camera camera) {
      $instance.invoke(zoomValue,stopped,camera);
    }

    @Override
    public OnZoomChangeCallback createInstance(TypeChannelMessenger messenger, List<Object> arguments) {
      return new OnZoomChangeCallback() {
        @Override
        public Completable<Void> invoke(int zoomValue,boolean stopped,Camera camera) {
          return implementations.channelOnZoomChangeCallback.$invoke(this,zoomValue,stopped,camera);
        }
      };
    }

    @Override
    public Object invokeStaticMethod(TypeChannelMessenger messenger, String methodName, List<Object> arguments) {
      throw new UnsupportedOperationException();
    }

    @Override
    public Void invokeMethod(TypeChannelMessenger messenger, OnZoomChangeCallback instance, String methodName, List<Object> arguments) throws Exception {
      $invoke(instance,(int) arguments.get(0),(boolean) arguments.get(1),(Camera) arguments.get(2));
      return null;
    }
  }
  
  public static class $OnAutoFocusMovingCallbackHandler implements TypeChannelHandler<OnAutoFocusMovingCallback> {
    public final $LibraryImplementations implementations;

    public $OnAutoFocusMovingCallbackHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    public void $invoke(OnAutoFocusMovingCallback $instance, boolean start, Camera camera) {
      $instance.invoke(start,camera);
    }

    @Override
    public OnAutoFocusMovingCallback createInstance(TypeChannelMessenger messenger, List<Object> arguments) {
      return new OnAutoFocusMovingCallback() {
        @Override
        public Completable<Void> invoke(boolean start,Camera camera) {
          return implementations.channelOnAutoFocusMovingCallback.$invoke(this,start,camera);
        }
      };
    }

    @Override
    public Object invokeStaticMethod(TypeChannelMessenger messenger, String methodName, List<Object> arguments) {
      throw new UnsupportedOperationException();
    }

    @Override
    public Void invokeMethod(TypeChannelMessenger messenger, OnAutoFocusMovingCallback instance, String methodName, List<Object> arguments) throws Exception {
      $invoke(instance,(boolean) arguments.get(0),(Camera) arguments.get(1));
      return null;
    }
  }
  
  public static class $OnPictureTakenCallbackHandler implements TypeChannelHandler<OnPictureTakenCallback> {
    public final $LibraryImplementations implementations;

    public $OnPictureTakenCallbackHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    public void $invoke(OnPictureTakenCallback $instance, byte[] data, Camera camera) {
      $instance.invoke(data,camera);
    }

    @Override
    public OnPictureTakenCallback createInstance(TypeChannelMessenger messenger, List<Object> arguments) {
      return new OnPictureTakenCallback() {
        @Override
        public Completable<Void> invoke(byte[] data,Camera camera) {
          return implementations.channelOnPictureTakenCallback.$invoke(this,data,camera);
        }
      };
    }

    @Override
    public Object invokeStaticMethod(TypeChannelMessenger messenger, String methodName, List<Object> arguments) {
      throw new UnsupportedOperationException();
    }

    @Override
    public Void invokeMethod(TypeChannelMessenger messenger, OnPictureTakenCallback instance, String methodName, List<Object> arguments) throws Exception {
      $invoke(instance,(byte[]) arguments.get(0),(Camera) arguments.get(1));
      return null;
    }
  }
  
  public static class $OnPreviewFrameCallbackHandler implements TypeChannelHandler<OnPreviewFrameCallback> {
    public final $LibraryImplementations implementations;

    public $OnPreviewFrameCallbackHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    public void $invoke(OnPreviewFrameCallback $instance, byte[] data, Camera camera) {
      $instance.invoke(data,camera);
    }

    @Override
    public OnPreviewFrameCallback createInstance(TypeChannelMessenger messenger, List<Object> arguments) {
      return new OnPreviewFrameCallback() {
        @Override
        public Completable<Void> invoke(byte[] data,Camera camera) {
          return implementations.channelOnPreviewFrameCallback.$invoke(this,data,camera);
        }
      };
    }

    @Override
    public Object invokeStaticMethod(TypeChannelMessenger messenger, String methodName, List<Object> arguments) {
      throw new UnsupportedOperationException();
    }

    @Override
    public Void invokeMethod(TypeChannelMessenger messenger, OnPreviewFrameCallback instance, String methodName, List<Object> arguments) throws Exception {
      $invoke(instance,(byte[]) arguments.get(0),(Camera) arguments.get(1));
      return null;
    }
  }
  

  
  public static class $ErrorCallbackChannel extends TypeChannel<ErrorCallback> {
    public final $LibraryImplementations implementations;

    public $ErrorCallbackChannel(@NonNull $LibraryImplementations implementations) {
      super(implementations.messenger, "android.hardware.Camera.ErrorCallback");
      this.implementations = implementations;
    }

    
    public Completable<PairedInstance> $create$(ErrorCallback $instance, boolean $owner) {
      
      
      return createNewInstancePair($instance, Arrays.<Object>asList(""), $owner);
      
      
    }
    

    

    
  }
  
  public static class $AutoFocusCallbackChannel extends TypeChannel<AutoFocusCallback> {
    public final $LibraryImplementations implementations;

    public $AutoFocusCallbackChannel(@NonNull $LibraryImplementations implementations) {
      super(implementations.messenger, "android.hardware.Camera.AutoFocusCallback");
      this.implementations = implementations;
    }

    
    public Completable<PairedInstance> $create$(AutoFocusCallback $instance, boolean $owner) {
      
      
      return createNewInstancePair($instance, Arrays.<Object>asList(""), $owner);
      
      
    }
    

    

    
  }
  
  public static class $ShutterCallbackChannel extends TypeChannel<ShutterCallback> {
    public final $LibraryImplementations implementations;

    public $ShutterCallbackChannel(@NonNull $LibraryImplementations implementations) {
      super(implementations.messenger, "android.hardware.Camera.ShutterCallback");
      this.implementations = implementations;
    }

    
    public Completable<PairedInstance> $create$(ShutterCallback $instance, boolean $owner) {
      
      
      return createNewInstancePair($instance, Arrays.<Object>asList(""), $owner);
      
      
    }
    

    

    
  }
  
  public static class $OnZoomChangeListenerChannel extends TypeChannel<OnZoomChangeListener> {
    public final $LibraryImplementations implementations;

    public $OnZoomChangeListenerChannel(@NonNull $LibraryImplementations implementations) {
      super(implementations.messenger, "android.hardware.Camera.OnZoomChangeListener");
      this.implementations = implementations;
    }

    
    public Completable<PairedInstance> $create$(OnZoomChangeListener $instance, boolean $owner) {
      
      
      return createNewInstancePair($instance, Arrays.<Object>asList(""), $owner);
      
      
    }
    

    

    
  }
  
  public static class $AutoFocusMoveCallbackChannel extends TypeChannel<AutoFocusMoveCallback> {
    public final $LibraryImplementations implementations;

    public $AutoFocusMoveCallbackChannel(@NonNull $LibraryImplementations implementations) {
      super(implementations.messenger, "android.hardware.Camera.AutoFocusMoveCallback");
      this.implementations = implementations;
    }

    
    public Completable<PairedInstance> $create$(AutoFocusMoveCallback $instance, boolean $owner) {
      
      
      return createNewInstancePair($instance, Arrays.<Object>asList(""), $owner);
      
      
    }
    

    

    
  }
  
  public static class $PictureCallbackChannel extends TypeChannel<PictureCallback> {
    public final $LibraryImplementations implementations;

    public $PictureCallbackChannel(@NonNull $LibraryImplementations implementations) {
      super(implementations.messenger, "android.hardware.Camera.PictureCallback");
      this.implementations = implementations;
    }

    
    public Completable<PairedInstance> $create$(PictureCallback $instance, boolean $owner) {
      
      
      return createNewInstancePair($instance, Arrays.<Object>asList(""), $owner);
      
      
    }
    

    

    
  }
  
  public static class $PreviewCallbackChannel extends TypeChannel<PreviewCallback> {
    public final $LibraryImplementations implementations;

    public $PreviewCallbackChannel(@NonNull $LibraryImplementations implementations) {
      super(implementations.messenger, "android.hardware.Camera.PreviewCallback");
      this.implementations = implementations;
    }

    
    public Completable<PairedInstance> $create$(PreviewCallback $instance, boolean $owner) {
      
      
      return createNewInstancePair($instance, Arrays.<Object>asList(""), $owner);
      
      
    }
    

    

    
  }
  
  public static class $CameraChannel extends TypeChannel<Camera> {
    public final $LibraryImplementations implementations;

    public $CameraChannel(@NonNull $LibraryImplementations implementations) {
      super(implementations.messenger, "android.hardware.Camera");
      this.implementations = implementations;
    }

    
    public Completable<PairedInstance> $create$(Camera $instance, boolean $owner) {
      
      
      return createNewInstancePair($instance, Arrays.<Object>asList(""), $owner);
      
      
    }
    

    
    
    
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  }
  
  public static class $ParametersChannel extends TypeChannel<Parameters> {
    public final $LibraryImplementations implementations;

    public $ParametersChannel(@NonNull $LibraryImplementations implementations) {
      super(implementations.messenger, "android.hardware.Camera.Parameters");
      this.implementations = implementations;
    }

    
    public Completable<PairedInstance> $create$(Parameters $instance, boolean $owner) {
      
      
      return createNewInstancePair($instance, Arrays.<Object>asList(""), $owner);
      
      
    }
    

    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  }
  
  public static class $AreaChannel extends TypeChannel<Area> {
    public final $LibraryImplementations implementations;

    public $AreaChannel(@NonNull $LibraryImplementations implementations) {
      super(implementations.messenger, "android.hardware.Camera.Area");
      this.implementations = implementations;
    }

    
    public Completable<PairedInstance> $create$(Area $instance, boolean $owner) {
      
      
      
      implementations.channelRect.$create$($instance.rect, false);
      
      
      
      
      return createNewInstancePair($instance, Arrays.<Object>asList("", $instance.rect, $instance.weight), $owner);
      
      
    }
    

    

    
  }
  
  public static class $RectChannel extends TypeChannel<Rect> {
    public final $LibraryImplementations implementations;

    public $RectChannel(@NonNull $LibraryImplementations implementations) {
      super(implementations.messenger, "android.graphics.Rect");
      this.implementations = implementations;
    }

    
    public Completable<PairedInstance> $create$(Rect $instance, boolean $owner) {
      
      
      
      
      
      
      
      
      
      
      return createNewInstancePair($instance, Arrays.<Object>asList("", $instance.top, $instance.bottom, $instance.right, $instance.left), $owner);
      
      
    }
    

    

    
  }
  
  public static class $SizeChannel extends TypeChannel<Size> {
    public final $LibraryImplementations implementations;

    public $SizeChannel(@NonNull $LibraryImplementations implementations) {
      super(implementations.messenger, "android.hardware.Camera.Size");
      this.implementations = implementations;
    }

    
    public Completable<PairedInstance> $create$(Size $instance, boolean $owner) {
      
      
      
      
      
      
      return createNewInstancePair($instance, Arrays.<Object>asList("", $instance.width, $instance.height), $owner);
      
      
    }
    

    

    
  }
  
  public static class $CameraInfoProxyChannel extends TypeChannel<CameraInfoProxy> {
    public final $LibraryImplementations implementations;

    public $CameraInfoProxyChannel(@NonNull $LibraryImplementations implementations) {
      super(implementations.messenger, "dev.penguin.android_hardware.CameraInfoHandler.CameraInfoProxy");
      this.implementations = implementations;
    }

    
    public Completable<PairedInstance> $create$(CameraInfoProxy $instance, boolean $owner) {
      
      throw new UnsupportedOperationException();
    }
    

    

    
  }
  
  public static class $ImageFormatChannel extends TypeChannel<ImageFormat> {
    public final $LibraryImplementations implementations;

    public $ImageFormatChannel(@NonNull $LibraryImplementations implementations) {
      super(implementations.messenger, "android.graphics.ImageFormat");
      this.implementations = implementations;
    }

    

    
    
    

    
  }
  

  
  public static class $ErrorCallbackHandler implements TypeChannelHandler<ErrorCallback> {
    public final $LibraryImplementations implementations;

    public $ErrorCallbackHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    
    public ErrorCallback $create$(OnErrorCallback onError)
        throws Exception {
      
      return new ErrorCallback()
        
      {
        
        @Override
        public void onError(int error,Camera camera) {
          
          onError.invoke(error,camera);
        }
        
      }
      ;
      
      
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
    public ErrorCallback createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      final String constructorName = (String) arguments.get(0);
      switch(constructorName) {
        
        case "":
          return $create$((OnErrorCallback) arguments.get(1));
        
      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke constructor of %s", constructorName));
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        ErrorCallback instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      switch(methodName) {
        
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }
  
  public static class $AutoFocusCallbackHandler implements TypeChannelHandler<AutoFocusCallback> {
    public final $LibraryImplementations implementations;

    public $AutoFocusCallbackHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    
    public AutoFocusCallback $create$(OnAutoFocusCallback onAutoFocus)
        throws Exception {
      
      return new AutoFocusCallback()
        
      {
        
        @Override
        public void onAutoFocus(boolean success,Camera camera) {
          
          onAutoFocus.invoke(success,camera);
        }
        
      }
      ;
      
      
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
    public AutoFocusCallback createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      final String constructorName = (String) arguments.get(0);
      switch(constructorName) {
        
        case "":
          return $create$((OnAutoFocusCallback) arguments.get(1));
        
      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke constructor of %s", constructorName));
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        AutoFocusCallback instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      switch(methodName) {
        
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }
  
  public static class $ShutterCallbackHandler implements TypeChannelHandler<ShutterCallback> {
    public final $LibraryImplementations implementations;

    public $ShutterCallbackHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    
    public ShutterCallback $create$(OnShutterCallback onShutter)
        throws Exception {
      
      return new ShutterCallback()
        
      {
        
        @Override
        public void onShutter() {
          
          onShutter.invoke();
        }
        
      }
      ;
      
      
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
    public ShutterCallback createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      final String constructorName = (String) arguments.get(0);
      switch(constructorName) {
        
        case "":
          return $create$((OnShutterCallback) arguments.get(1));
        
      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke constructor of %s", constructorName));
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        ShutterCallback instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      switch(methodName) {
        
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }
  
  public static class $OnZoomChangeListenerHandler implements TypeChannelHandler<OnZoomChangeListener> {
    public final $LibraryImplementations implementations;

    public $OnZoomChangeListenerHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    
    public OnZoomChangeListener $create$(OnZoomChangeCallback onZoomChange)
        throws Exception {
      
      return new OnZoomChangeListener()
        
      {
        
        @Override
        public void onZoomChange(int zoomValue,boolean stopped,Camera camera) {
          
          onZoomChange.invoke(zoomValue,stopped,camera);
        }
        
      }
      ;
      
      
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
    public OnZoomChangeListener createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      final String constructorName = (String) arguments.get(0);
      switch(constructorName) {
        
        case "":
          return $create$((OnZoomChangeCallback) arguments.get(1));
        
      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke constructor of %s", constructorName));
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        OnZoomChangeListener instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      switch(methodName) {
        
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }
  
  public static class $AutoFocusMoveCallbackHandler implements TypeChannelHandler<AutoFocusMoveCallback> {
    public final $LibraryImplementations implementations;

    public $AutoFocusMoveCallbackHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    
    public AutoFocusMoveCallback $create$(OnAutoFocusMovingCallback onAutoFocusMoving)
        throws Exception {
      
      return new AutoFocusMoveCallback()
        
      {
        
        @Override
        public void onAutoFocusMoving(boolean start,Camera camera) {
          
          onAutoFocusMoving.invoke(start,camera);
        }
        
      }
      ;
      
      
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
    public AutoFocusMoveCallback createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      final String constructorName = (String) arguments.get(0);
      switch(constructorName) {
        
        case "":
          return $create$((OnAutoFocusMovingCallback) arguments.get(1));
        
      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke constructor of %s", constructorName));
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        AutoFocusMoveCallback instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      switch(methodName) {
        
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }
  
  public static class $PictureCallbackHandler implements TypeChannelHandler<PictureCallback> {
    public final $LibraryImplementations implementations;

    public $PictureCallbackHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    
    public PictureCallback $create$(OnPictureTakenCallback onPictureTaken)
        throws Exception {
      
      return new PictureCallback()
        
      {
        
        @Override
        public void onPictureTaken(byte[] data,Camera camera) {
          
          onPictureTaken.invoke(data,camera);
        }
        
      }
      ;
      
      
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
    public PictureCallback createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      final String constructorName = (String) arguments.get(0);
      switch(constructorName) {
        
        case "":
          return $create$((OnPictureTakenCallback) arguments.get(1));
        
      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke constructor of %s", constructorName));
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        PictureCallback instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      switch(methodName) {
        
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }
  
  public static class $PreviewCallbackHandler implements TypeChannelHandler<PreviewCallback> {
    public final $LibraryImplementations implementations;

    public $PreviewCallbackHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    
    public PreviewCallback $create$(OnPreviewFrameCallback onPreviewFrame)
        throws Exception {
      
      return new PreviewCallback()
        
      {
        
        @Override
        public void onPreviewFrame(byte[] data,Camera camera) {
          
          onPreviewFrame.invoke(data,camera);
        }
        
      }
      ;
      
      
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
    public PreviewCallback createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      final String constructorName = (String) arguments.get(0);
      switch(constructorName) {
        
        case "":
          return $create$((OnPreviewFrameCallback) arguments.get(1));
        
      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke constructor of %s", constructorName));
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        PreviewCallback instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      switch(methodName) {
        
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }
  
  public static class $CameraHandler implements TypeChannelHandler<Camera> {
    public final $LibraryImplementations implementations;

    public $CameraHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    
    public Camera $create$()
        throws Exception {
      
      throw new UnsupportedOperationException();
    }
    

    
    
    public List<CameraInfoProxy> $getAllCameraInfo() throws Exception {
      
      throw new UnsupportedOperationException();
    }
    
    
    
    public Camera $open(int cameraId) throws Exception {
      
      throw new UnsupportedOperationException();
    }
    
    

    
    
    public void $release(Camera $instance) throws Exception {
      
      $instance.release();
      
      
    }
    
    
    
    public void $startPreview(Camera $instance) throws Exception {
      
      $instance.startPreview();
      
      
    }
    
    
    
    public void $stopPreview(Camera $instance) throws Exception {
      
      $instance.stopPreview();
      
      
    }
    
    
    
    public Long $attachPreviewTexture(Camera $instance) throws Exception {
      
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $releasePreviewTexture(Camera $instance) throws Exception {
      
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $unlock(Camera $instance) throws Exception {
      
      $instance.unlock();
      
      
    }
    
    
    
    public void $setOneShotPreviewCallback(Camera $instance,PreviewCallback callback) throws Exception {
      
      $instance.setOneShotPreviewCallback(callback);
      
      
    }
    
    
    
    public void $setPreviewCallback(Camera $instance,PreviewCallback callback) throws Exception {
      
      $instance.setPreviewCallback(callback);
      
      
    }
    
    
    
    public void $reconnect(Camera $instance) throws Exception {
      
      $instance.reconnect();
      
      
    }
    
    
    
    public void $takePicture(Camera $instance,ShutterCallback shutter,PictureCallback raw,PictureCallback postView,PictureCallback jpeg) throws Exception {
      
      $instance.takePicture(shutter,raw,postView,jpeg);
      
      
    }
    
    
    
    public void $autoFocus(Camera $instance,AutoFocusCallback callback) throws Exception {
      
      $instance.autoFocus(callback);
      
      
    }
    
    
    
    public void $cancelAutoFocus(Camera $instance) throws Exception {
      
      $instance.cancelAutoFocus();
      
      
    }
    
    
    
    public void $setDisplayOrientation(Camera $instance,int degrees) throws Exception {
      
      $instance.setDisplayOrientation(degrees);
      
      
    }
    
    
    
    public void $setErrorCallback(Camera $instance,ErrorCallback callback) throws Exception {
      
      $instance.setErrorCallback(callback);
      
      
    }
    
    
    
    public void $startSmoothZoom(Camera $instance,int value) throws Exception {
      
      $instance.startSmoothZoom(value);
      
      
    }
    
    
    
    public void $stopSmoothZoom(Camera $instance) throws Exception {
      
      $instance.stopSmoothZoom();
      
      
    }
    
    
    
    public Parameters $getParameters(Camera $instance) throws Exception {
      
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $setParameters(Camera $instance,Parameters parameters) throws Exception {
      
      $instance.setParameters(parameters);
      
      
    }
    
    
    
    public void $setZoomChangeListener(Camera $instance,OnZoomChangeListener listener) throws Exception {
      
      $instance.setZoomChangeListener(listener);
      
      
    }
    
    
    
    public void $setAutoFocusMoveCallback(Camera $instance,AutoFocusMoveCallback callback) throws Exception {
      
      $instance.setAutoFocusMoveCallback(callback);
      
      
    }
    
    
    
    public void $lock(Camera $instance) throws Exception {
      
      $instance.lock();
      
      
    }
    
    
    
    public Boolean $enableShutterSound(Camera $instance,Boolean enabled) throws Exception {
      
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
          
          return $open((int) arguments.get(0));
          
        
        
      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke static method %s", methodName));
    }

    @Override
    public Camera createInstance(TypeChannelMessenger messenger, List<Object> arguments)
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
        Camera instance,
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
           $setDisplayOrientation(instance,(int) arguments.get(0));
          
          return null;
          
        
        
        
        case "setErrorCallback":
           $setErrorCallback(instance,(ErrorCallback) arguments.get(0));
          
          return null;
          
        
        
        
        case "startSmoothZoom":
           $startSmoothZoom(instance,(int) arguments.get(0));
          
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
      
      
      return $instance.getAutoExposureLock();
      
      
    }
    
    
    
    public List<Area> $getFocusAreas(Parameters $instance) throws Exception {
      
      throw new UnsupportedOperationException();
    }
    
    
    
    public List<Double> $getFocusDistances(Parameters $instance) throws Exception {
      
      throw new UnsupportedOperationException();
    }
    
    
    
    public int $getMaxExposureCompensation(Parameters $instance) throws Exception {
      
      
      return $instance.getMaxExposureCompensation();
      
      
    }
    
    
    
    public int $getMaxNumFocusAreas(Parameters $instance) throws Exception {
      
      
      return $instance.getMaxNumFocusAreas();
      
      
    }
    
    
    
    public int $getMinExposureCompensation(Parameters $instance) throws Exception {
      
      
      return $instance.getMinExposureCompensation();
      
      
    }
    
    
    
    public List<String> $getSupportedFocusModes(Parameters $instance) throws Exception {
      
      
      return $instance.getSupportedFocusModes();
      
      
    }
    
    
    
    public Boolean $isAutoExposureLockSupported(Parameters $instance) throws Exception {
      
      
      return $instance.isAutoExposureLockSupported();
      
      
    }
    
    
    
    public Boolean $isZoomSupported(Parameters $instance) throws Exception {
      
      
      return $instance.isZoomSupported();
      
      
    }
    
    
    
    public void $setAutoExposureLock(Parameters $instance,Boolean toggle) throws Exception {
      
      $instance.setAutoExposureLock(toggle);
      
      
    }
    
    
    
    public void $setExposureCompensation(Parameters $instance,int value) throws Exception {
      
      $instance.setExposureCompensation(value);
      
      
    }
    
    
    
    public void $setFocusAreas(Parameters $instance,List<Area> focusAreas) throws Exception {
      
      $instance.setFocusAreas(focusAreas);
      
      
    }
    
    
    
    public void $setFocusMode(Parameters $instance,String value) throws Exception {
      
      $instance.setFocusMode(value);
      
      
    }
    
    
    
    public String $getFlashMode(Parameters $instance) throws Exception {
      
      
      return $instance.getFlashMode();
      
      
    }
    
    
    
    public int $getMaxZoom(Parameters $instance) throws Exception {
      
      
      return $instance.getMaxZoom();
      
      
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
      
      
      return $instance.getSupportedFlashModes();
      
      
    }
    
    
    
    public int $getZoom(Parameters $instance) throws Exception {
      
      
      return $instance.getZoom();
      
      
    }
    
    
    
    public Boolean $isSmoothZoomSupported(Parameters $instance) throws Exception {
      
      
      return $instance.isSmoothZoomSupported();
      
      
    }
    
    
    
    public void $setFlashMode(Parameters $instance,String mode) throws Exception {
      
      $instance.setFlashMode(mode);
      
      
    }
    
    
    
    public void $setPictureSize(Parameters $instance,int width,int height) throws Exception {
      
      $instance.setPictureSize(width,height);
      
      
    }
    
    
    
    public void $setRecordingHint(Parameters $instance,Boolean hint) throws Exception {
      
      $instance.setRecordingHint(hint);
      
      
    }
    
    
    
    public void $setRotation(Parameters $instance,int rotation) throws Exception {
      
      $instance.setRotation(rotation);
      
      
    }
    
    
    
    public void $setZoom(Parameters $instance,int value) throws Exception {
      
      $instance.setZoom(value);
      
      
    }
    
    
    
    public void $setPreviewSize(Parameters $instance,int width,int height) throws Exception {
      
      $instance.setPreviewSize(width,height);
      
      
    }
    
    
    
    public int $getExposureCompensation(Parameters $instance) throws Exception {
      
      
      return $instance.getExposureCompensation();
      
      
    }
    
    
    
    public double $getExposureCompensationStep(Parameters $instance) throws Exception {
      
      
      return $instance.getExposureCompensationStep();
      
      
    }
    
    
    
    public String $flatten(Parameters $instance) throws Exception {
      
      
      return $instance.flatten();
      
      
    }
    
    
    
    public String $get(Parameters $instance,String key) throws Exception {
      
      
      return $instance.get(key);
      
      
    }
    
    
    
    public String $getAntibanding(Parameters $instance) throws Exception {
      
      
      return $instance.getAntibanding();
      
      
    }
    
    
    
    public Boolean $getAutoWhiteBalanceLock(Parameters $instance) throws Exception {
      
      
      return $instance.getAutoWhiteBalanceLock();
      
      
    }
    
    
    
    public String $getColorEffect(Parameters $instance) throws Exception {
      
      
      return $instance.getColorEffect();
      
      
    }
    
    
    
    public double $getFocalLength(Parameters $instance) throws Exception {
      
      
      return $instance.getFocalLength();
      
      
    }
    
    
    
    public String $getFocusMode(Parameters $instance) throws Exception {
      
      
      return $instance.getFocusMode();
      
      
    }
    
    
    
    public double $getHorizontalViewAngle(Parameters $instance) throws Exception {
      
      
      return $instance.getHorizontalViewAngle();
      
      
    }
    
    
    
    public int $getInt(Parameters $instance,String key) throws Exception {
      
      
      return $instance.getInt(key);
      
      
    }
    
    
    
    public int $getJpegQuality(Parameters $instance) throws Exception {
      
      
      return $instance.getJpegQuality();
      
      
    }
    
    
    
    public int $getJpegThumbnailQuality(Parameters $instance) throws Exception {
      
      
      return $instance.getJpegThumbnailQuality();
      
      
    }
    
    
    
    public Size $getJpegThumbnailSize(Parameters $instance) throws Exception {
      
      throw new UnsupportedOperationException();
    }
    
    
    
    public int $getMaxNumMeteringAreas(Parameters $instance) throws Exception {
      
      
      return $instance.getMaxNumMeteringAreas();
      
      
    }
    
    
    
    public List<Area> $getMeteringAreas(Parameters $instance) throws Exception {
      
      throw new UnsupportedOperationException();
    }
    
    
    
    public int $getPictureFormat(Parameters $instance) throws Exception {
      
      
      return $instance.getPictureFormat();
      
      
    }
    
    
    
    public Size $getPreferredPreviewSizeForVideo(Parameters $instance) throws Exception {
      
      throw new UnsupportedOperationException();
    }
    
    
    
    public int $getPreviewFormat(Parameters $instance) throws Exception {
      
      
      return $instance.getPreviewFormat();
      
      
    }
    
    
    
    public List<Integer> $getPreviewFpsRange(Parameters $instance) throws Exception {
      
      throw new UnsupportedOperationException();
    }
    
    
    
    public String $getSceneMode(Parameters $instance) throws Exception {
      
      
      return $instance.getSceneMode();
      
      
    }
    
    
    
    public List<String> $getSupportedAntibanding(Parameters $instance) throws Exception {
      
      
      return $instance.getSupportedAntibanding();
      
      
    }
    
    
    
    public List<String> $getSupportedColorEffects(Parameters $instance) throws Exception {
      
      
      return $instance.getSupportedColorEffects();
      
      
    }
    
    
    
    public List<Size> $getSupportedJpegThumbnailSizes(Parameters $instance) throws Exception {
      
      throw new UnsupportedOperationException();
    }
    
    
    
    public List<Integer> $getSupportedPictureFormats(Parameters $instance) throws Exception {
      
      
      return $instance.getSupportedPictureFormats();
      
      
    }
    
    
    
    public List<Integer> $getSupportedPreviewFormats(Parameters $instance) throws Exception {
      
      
      return $instance.getSupportedPreviewFormats();
      
      
    }
    
    
    
    public List<List<Integer>> $getSupportedPreviewFpsRange(Parameters $instance) throws Exception {
      
      throw new UnsupportedOperationException();
    }
    
    
    
    public List<String> $getSupportedSceneModes(Parameters $instance) throws Exception {
      
      
      return $instance.getSupportedSceneModes();
      
      
    }
    
    
    
    public List<Size> $getSupportedVideoSizes(Parameters $instance) throws Exception {
      
      throw new UnsupportedOperationException();
    }
    
    
    
    public List<String> $getSupportedWhiteBalance(Parameters $instance) throws Exception {
      
      
      return $instance.getSupportedWhiteBalance();
      
      
    }
    
    
    
    public double $getVerticalViewAngle(Parameters $instance) throws Exception {
      
      
      return $instance.getVerticalViewAngle();
      
      
    }
    
    
    
    public Boolean $getVideoStabilization(Parameters $instance) throws Exception {
      
      
      return $instance.getVideoStabilization();
      
      
    }
    
    
    
    public String $getWhiteBalance(Parameters $instance) throws Exception {
      
      
      return $instance.getWhiteBalance();
      
      
    }
    
    
    
    public List<Integer> $getZoomRatios(Parameters $instance) throws Exception {
      
      
      return $instance.getZoomRatios();
      
      
    }
    
    
    
    public Boolean $isAutoWhiteBalanceLockSupported(Parameters $instance) throws Exception {
      
      
      return $instance.isAutoWhiteBalanceLockSupported();
      
      
    }
    
    
    
    public Boolean $isVideoSnapshotSupported(Parameters $instance) throws Exception {
      
      
      return $instance.isVideoSnapshotSupported();
      
      
    }
    
    
    
    public Boolean $isVideoStabilizationSupported(Parameters $instance) throws Exception {
      
      
      return $instance.isVideoStabilizationSupported();
      
      
    }
    
    
    
    public void $remove(Parameters $instance,String key) throws Exception {
      
      $instance.remove(key);
      
      
    }
    
    
    
    public void $removeGpsData(Parameters $instance) throws Exception {
      
      $instance.removeGpsData();
      
      
    }
    
    
    
    public void $set(Parameters $instance,String key,Object value) throws Exception {
      
      throw new UnsupportedOperationException();
    }
    
    
    
    public void $setAntibanding(Parameters $instance,String antibanding) throws Exception {
      
      $instance.setAntibanding(antibanding);
      
      
    }
    
    
    
    public void $setAutoWhiteBalanceLock(Parameters $instance,Boolean toggle) throws Exception {
      
      $instance.setAutoWhiteBalanceLock(toggle);
      
      
    }
    
    
    
    public void $setColorEffect(Parameters $instance,String effect) throws Exception {
      
      $instance.setColorEffect(effect);
      
      
    }
    
    
    
    public void $setGpsAltitude(Parameters $instance,double meters) throws Exception {
      
      $instance.setGpsAltitude(meters);
      
      
    }
    
    
    
    public void $setGpsLatitude(Parameters $instance,double latitude) throws Exception {
      
      $instance.setGpsLatitude(latitude);
      
      
    }
    
    
    
    public void $setGpsLongitude(Parameters $instance,double longitude) throws Exception {
      
      $instance.setGpsLongitude(longitude);
      
      
    }
    
    
    
    public void $setGpsProcessingMethod(Parameters $instance,String processingMethod) throws Exception {
      
      $instance.setGpsProcessingMethod(processingMethod);
      
      
    }
    
    
    
    public void $setGpsTimestamp(Parameters $instance,int timestamp) throws Exception {
      
      $instance.setGpsTimestamp(timestamp);
      
      
    }
    
    
    
    public void $setJpegQuality(Parameters $instance,int quality) throws Exception {
      
      $instance.setJpegQuality(quality);
      
      
    }
    
    
    
    public void $setJpegThumbnailQuality(Parameters $instance,int quality) throws Exception {
      
      $instance.setJpegThumbnailQuality(quality);
      
      
    }
    
    
    
    public void $setJpegThumbnailSize(Parameters $instance,int width,int height) throws Exception {
      
      $instance.setJpegThumbnailSize(width,height);
      
      
    }
    
    
    
    public void $setMeteringAreas(Parameters $instance,List<Area> meteringAreas) throws Exception {
      
      $instance.setMeteringAreas(meteringAreas);
      
      
    }
    
    
    
    public void $setPictureFormat(Parameters $instance,int pixelFormat) throws Exception {
      
      $instance.setPictureFormat(pixelFormat);
      
      
    }
    
    
    
    public void $setPreviewFormat(Parameters $instance,int pixelFormat) throws Exception {
      
      $instance.setPreviewFormat(pixelFormat);
      
      
    }
    
    
    
    public void $setPreviewFpsRange(Parameters $instance,int min,int max) throws Exception {
      
      $instance.setPreviewFpsRange(min,max);
      
      
    }
    
    
    
    public void $setSceneMode(Parameters $instance,String mode) throws Exception {
      
      $instance.setSceneMode(mode);
      
      
    }
    
    
    
    public void $setVideoStabilization(Parameters $instance,Boolean toggle) throws Exception {
      
      $instance.setVideoStabilization(toggle);
      
      
    }
    
    
    
    public void $setWhiteBalance(Parameters $instance,String value) throws Exception {
      
      $instance.setWhiteBalance(value);
      
      
    }
    
    
    
    public void $unflatten(Parameters $instance,String flattened) throws Exception {
      
      $instance.unflatten(flattened);
      
      
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
           $setExposureCompensation(instance,(int) arguments.get(0));
          
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
           $setPictureSize(instance,(int) arguments.get(0),(int) arguments.get(1));
          
          return null;
          
        
        
        
        case "setRecordingHint":
           $setRecordingHint(instance,(Boolean) arguments.get(0));
          
          return null;
          
        
        
        
        case "setRotation":
           $setRotation(instance,(int) arguments.get(0));
          
          return null;
          
        
        
        
        case "setZoom":
           $setZoom(instance,(int) arguments.get(0));
          
          return null;
          
        
        
        
        case "setPreviewSize":
           $setPreviewSize(instance,(int) arguments.get(0),(int) arguments.get(1));
          
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
           $setGpsAltitude(instance,(double) arguments.get(0));
          
          return null;
          
        
        
        
        case "setGpsLatitude":
           $setGpsLatitude(instance,(double) arguments.get(0));
          
          return null;
          
        
        
        
        case "setGpsLongitude":
           $setGpsLongitude(instance,(double) arguments.get(0));
          
          return null;
          
        
        
        
        case "setGpsProcessingMethod":
           $setGpsProcessingMethod(instance,(String) arguments.get(0));
          
          return null;
          
        
        
        
        case "setGpsTimestamp":
           $setGpsTimestamp(instance,(int) arguments.get(0));
          
          return null;
          
        
        
        
        case "setJpegQuality":
           $setJpegQuality(instance,(int) arguments.get(0));
          
          return null;
          
        
        
        
        case "setJpegThumbnailQuality":
           $setJpegThumbnailQuality(instance,(int) arguments.get(0));
          
          return null;
          
        
        
        
        case "setJpegThumbnailSize":
           $setJpegThumbnailSize(instance,(int) arguments.get(0),(int) arguments.get(1));
          
          return null;
          
        
        
        
        case "setMeteringAreas":
           $setMeteringAreas(instance,(List<Area>) arguments.get(0));
          
          return null;
          
        
        
        
        case "setPictureFormat":
           $setPictureFormat(instance,(int) arguments.get(0));
          
          return null;
          
        
        
        
        case "setPreviewFormat":
           $setPreviewFormat(instance,(int) arguments.get(0));
          
          return null;
          
        
        
        
        case "setPreviewFpsRange":
           $setPreviewFpsRange(instance,(int) arguments.get(0),(int) arguments.get(1));
          
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

    
    public Area $create$(Rect rect,int weight)
        throws Exception {
      
      return new Area(rect,weight)
        ;
      
      
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
          return $create$((Rect) arguments.get(1),(int) arguments.get(2));
        
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

    
    public Rect $create$(int top,int bottom,int right,int left)
        throws Exception {
      
      return new Rect(top,bottom,right,left)
        ;
      
      
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
          return $create$((int) arguments.get(1),(int) arguments.get(2),(int) arguments.get(3),(int) arguments.get(4));
        
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

    
    public Size $create$(int width,int height)
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
          return $create$((int) arguments.get(1),(int) arguments.get(2));
        
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
  
  public static class $CameraInfoProxyHandler implements TypeChannelHandler<CameraInfoProxy> {
    public final $LibraryImplementations implementations;

    public $CameraInfoProxyHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    
    public CameraInfoProxy $create$(int cameraId,int facing,int orientation,Boolean canDisableShutterSound)
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
    public CameraInfoProxy createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      final String constructorName = (String) arguments.get(0);
      switch(constructorName) {
        
        case "":
          return $create$((int) arguments.get(1),(int) arguments.get(2),(int) arguments.get(3),(Boolean) arguments.get(4));
        
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
  
  public static class $ImageFormatHandler implements TypeChannelHandler<ImageFormat> {
    public final $LibraryImplementations implementations;

    public $ImageFormatHandler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    

    
    
    public int $getBitsPerPixel(int format) throws Exception {
      
      
      return ImageFormat.getBitsPerPixel(format);
      
      
    }
    
    

    

    @Override
    public Object invokeStaticMethod(
        TypeChannelMessenger messenger, String methodName, List<Object> arguments)
        throws Exception {
      switch (methodName) {
        
        
        case "getBitsPerPixel":
          
          return $getBitsPerPixel((int) arguments.get(0));
          
        
        
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
    
    public $CameraChannel channelCamera;
    public $CameraHandler handlerCamera;
    
    public $ParametersChannel channelParameters;
    public $ParametersHandler handlerParameters;
    
    public $AreaChannel channelArea;
    public $AreaHandler handlerArea;
    
    public $RectChannel channelRect;
    public $RectHandler handlerRect;
    
    public $SizeChannel channelSize;
    public $SizeHandler handlerSize;
    
    public $CameraInfoProxyChannel channelCameraInfoProxy;
    public $CameraInfoProxyHandler handlerCameraInfoProxy;
    
    public $ImageFormatChannel channelImageFormat;
    public $ImageFormatHandler handlerImageFormat;
    

    
    public $OnErrorCallbackChannel channelOnErrorCallback;
    public $OnErrorCallbackHandler handlerOnErrorCallback;
    
    public $OnAutoFocusCallbackChannel channelOnAutoFocusCallback;
    public $OnAutoFocusCallbackHandler handlerOnAutoFocusCallback;
    
    public $OnShutterCallbackChannel channelOnShutterCallback;
    public $OnShutterCallbackHandler handlerOnShutterCallback;
    
    public $OnZoomChangeCallbackChannel channelOnZoomChangeCallback;
    public $OnZoomChangeCallbackHandler handlerOnZoomChangeCallback;
    
    public $OnAutoFocusMovingCallbackChannel channelOnAutoFocusMovingCallback;
    public $OnAutoFocusMovingCallbackHandler handlerOnAutoFocusMovingCallback;
    
    public $OnPictureTakenCallbackChannel channelOnPictureTakenCallback;
    public $OnPictureTakenCallbackHandler handlerOnPictureTakenCallback;
    
    public $OnPreviewFrameCallbackChannel channelOnPreviewFrameCallback;
    public $OnPreviewFrameCallbackHandler handlerOnPreviewFrameCallback;
    

    public $LibraryImplementations(TypeChannelMessenger messenger) {
      this.messenger = messenger;
      
      this.channelErrorCallback = new $ErrorCallbackChannel(this);
      this.handlerErrorCallback = new $ErrorCallbackHandler(this);
      
      this.channelAutoFocusCallback = new $AutoFocusCallbackChannel(this);
      this.handlerAutoFocusCallback = new $AutoFocusCallbackHandler(this);
      
      this.channelShutterCallback = new $ShutterCallbackChannel(this);
      this.handlerShutterCallback = new $ShutterCallbackHandler(this);
      
      this.channelOnZoomChangeListener = new $OnZoomChangeListenerChannel(this);
      this.handlerOnZoomChangeListener = new $OnZoomChangeListenerHandler(this);
      
      this.channelAutoFocusMoveCallback = new $AutoFocusMoveCallbackChannel(this);
      this.handlerAutoFocusMoveCallback = new $AutoFocusMoveCallbackHandler(this);
      
      this.channelPictureCallback = new $PictureCallbackChannel(this);
      this.handlerPictureCallback = new $PictureCallbackHandler(this);
      
      this.channelPreviewCallback = new $PreviewCallbackChannel(this);
      this.handlerPreviewCallback = new $PreviewCallbackHandler(this);
      
      this.channelCamera = new $CameraChannel(this);
      this.handlerCamera = new $CameraHandler(this);
      
      this.channelParameters = new $ParametersChannel(this);
      this.handlerParameters = new $ParametersHandler(this);
      
      this.channelArea = new $AreaChannel(this);
      this.handlerArea = new $AreaHandler(this);
      
      this.channelRect = new $RectChannel(this);
      this.handlerRect = new $RectHandler(this);
      
      this.channelSize = new $SizeChannel(this);
      this.handlerSize = new $SizeHandler(this);
      
      this.channelCameraInfoProxy = new $CameraInfoProxyChannel(this);
      this.handlerCameraInfoProxy = new $CameraInfoProxyHandler(this);
      
      this.channelImageFormat = new $ImageFormatChannel(this);
      this.handlerImageFormat = new $ImageFormatHandler(this);
      
      
      this.channelOnErrorCallback = new $OnErrorCallbackChannel(this);
      this.handlerOnErrorCallback = new $OnErrorCallbackHandler(this);
      
      this.channelOnAutoFocusCallback = new $OnAutoFocusCallbackChannel(this);
      this.handlerOnAutoFocusCallback = new $OnAutoFocusCallbackHandler(this);
      
      this.channelOnShutterCallback = new $OnShutterCallbackChannel(this);
      this.handlerOnShutterCallback = new $OnShutterCallbackHandler(this);
      
      this.channelOnZoomChangeCallback = new $OnZoomChangeCallbackChannel(this);
      this.handlerOnZoomChangeCallback = new $OnZoomChangeCallbackHandler(this);
      
      this.channelOnAutoFocusMovingCallback = new $OnAutoFocusMovingCallbackChannel(this);
      this.handlerOnAutoFocusMovingCallback = new $OnAutoFocusMovingCallbackHandler(this);
      
      this.channelOnPictureTakenCallback = new $OnPictureTakenCallbackChannel(this);
      this.handlerOnPictureTakenCallback = new $OnPictureTakenCallbackHandler(this);
      
      this.channelOnPreviewFrameCallback = new $OnPreviewFrameCallbackChannel(this);
      this.handlerOnPreviewFrameCallback = new $OnPreviewFrameCallbackHandler(this);
      
    }
  }

  public static class $ChannelRegistrar {
    public final $LibraryImplementations implementations;

    public $ChannelRegistrar($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    public void registerHandlers() {
      
      implementations.channelErrorCallback.setHandler(implementations.handlerErrorCallback);
      
      implementations.channelAutoFocusCallback.setHandler(implementations.handlerAutoFocusCallback);
      
      implementations.channelShutterCallback.setHandler(implementations.handlerShutterCallback);
      
      implementations.channelOnZoomChangeListener.setHandler(implementations.handlerOnZoomChangeListener);
      
      implementations.channelAutoFocusMoveCallback.setHandler(implementations.handlerAutoFocusMoveCallback);
      
      implementations.channelPictureCallback.setHandler(implementations.handlerPictureCallback);
      
      implementations.channelPreviewCallback.setHandler(implementations.handlerPreviewCallback);
      
      implementations.channelCamera.setHandler(implementations.handlerCamera);
      
      implementations.channelParameters.setHandler(implementations.handlerParameters);
      
      implementations.channelArea.setHandler(implementations.handlerArea);
      
      implementations.channelRect.setHandler(implementations.handlerRect);
      
      implementations.channelSize.setHandler(implementations.handlerSize);
      
      implementations.channelCameraInfoProxy.setHandler(implementations.handlerCameraInfoProxy);
      
      implementations.channelImageFormat.setHandler(implementations.handlerImageFormat);
      
      
      implementations.channelOnErrorCallback.setHandler(implementations.handlerOnErrorCallback);
      
      implementations.channelOnAutoFocusCallback.setHandler(implementations.handlerOnAutoFocusCallback);
      
      implementations.channelOnShutterCallback.setHandler(implementations.handlerOnShutterCallback);
      
      implementations.channelOnZoomChangeCallback.setHandler(implementations.handlerOnZoomChangeCallback);
      
      implementations.channelOnAutoFocusMovingCallback.setHandler(implementations.handlerOnAutoFocusMovingCallback);
      
      implementations.channelOnPictureTakenCallback.setHandler(implementations.handlerOnPictureTakenCallback);
      
      implementations.channelOnPreviewFrameCallback.setHandler(implementations.handlerOnPreviewFrameCallback);
      
    }

    public void unregisterHandlers() {
      
      implementations.channelErrorCallback.removeHandler();
      
      implementations.channelAutoFocusCallback.removeHandler();
      
      implementations.channelShutterCallback.removeHandler();
      
      implementations.channelOnZoomChangeListener.removeHandler();
      
      implementations.channelAutoFocusMoveCallback.removeHandler();
      
      implementations.channelPictureCallback.removeHandler();
      
      implementations.channelPreviewCallback.removeHandler();
      
      implementations.channelCamera.removeHandler();
      
      implementations.channelParameters.removeHandler();
      
      implementations.channelArea.removeHandler();
      
      implementations.channelRect.removeHandler();
      
      implementations.channelSize.removeHandler();
      
      implementations.channelCameraInfoProxy.removeHandler();
      
      implementations.channelImageFormat.removeHandler();
      
      
      implementations.channelOnErrorCallback.removeHandler();
      
      implementations.channelOnAutoFocusCallback.removeHandler();
      
      implementations.channelOnShutterCallback.removeHandler();
      
      implementations.channelOnZoomChangeCallback.removeHandler();
      
      implementations.channelOnAutoFocusMovingCallback.removeHandler();
      
      implementations.channelOnPictureTakenCallback.removeHandler();
      
      implementations.channelOnPreviewFrameCallback.removeHandler();
      
    }
  }
}
