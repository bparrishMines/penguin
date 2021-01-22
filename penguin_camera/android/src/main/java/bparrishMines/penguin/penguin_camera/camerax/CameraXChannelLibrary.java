// GENERATED CODE - DO NOT MODIFY BY HAND

package bparrishMines.penguin.penguin_camera.camerax;

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

class CameraXChannelLibrary {
  interface $UseCase {
    

    
  }
interface $Preview {
    

    Object attachToTexture() throws Exception;
Object releaseTexture() throws Exception;
  }
interface $SuccessListener {
    

    Object onSuccess() throws Exception;
Object onError(String code,String message) throws Exception;
  }
interface $ProcessCameraProvider {
    

    Object bindToLifecycle($CameraSelector selector,$UseCase useCase) throws Exception;
Object unbindAll() throws Exception;
  }
interface $Camera {
    

    
  }
interface $CameraSelector {
    Integer getLensFacing();

    
  }

  static class $UseCaseCreationArgs {
    
  }

static class $PreviewCreationArgs {
    
  }

static class $SuccessListenerCreationArgs {
    
  }

static class $ProcessCameraProviderCreationArgs {
    
  }

static class $CameraCreationArgs {
    
  }

static class $CameraSelectorCreationArgs {
    Integer lensFacing;
  }

  static class $UseCaseChannel extends TypeChannel<$UseCase> {
    $UseCaseChannel(@NonNull TypeChannelManager manager) {
      super(manager, "penguin_camera/android/camerax/UseCase");
    }

    

    
  }

static class $PreviewChannel extends TypeChannel<$Preview> {
    $PreviewChannel(@NonNull TypeChannelManager manager) {
      super(manager, "penguin_camera/android/camerax/Preview");
    }

    

    Completable<Object> $invokeAttachToTexture($Preview instance) {
      return invokeMethod(instance, "attachToTexture", Arrays.<Object>asList());
    }

Completable<Object> $invokeReleaseTexture($Preview instance) {
      return invokeMethod(instance, "releaseTexture", Arrays.<Object>asList());
    }
  }

static class $SuccessListenerChannel extends TypeChannel<$SuccessListener> {
    $SuccessListenerChannel(@NonNull TypeChannelManager manager) {
      super(manager, "penguin_camera/android/camerax/SuccessListener");
    }

    

    Completable<Object> $invokeOnSuccess($SuccessListener instance) {
      return invokeMethod(instance, "onSuccess", Arrays.<Object>asList());
    }

Completable<Object> $invokeOnError($SuccessListener instance, String code , String message) {
      return invokeMethod(instance, "onError", Arrays.<Object>asList(code, message));
    }
  }

static class $ProcessCameraProviderChannel extends TypeChannel<$ProcessCameraProvider> {
    $ProcessCameraProviderChannel(@NonNull TypeChannelManager manager) {
      super(manager, "penguin_camera/android/camerax/ProcessCameraProvider");
    }

    Completable<Object> $invokeInitialize($SuccessListener successListener) {
      return invokeStaticMethod("initialize", Arrays.<Object>asList(successListener));
    }

    Completable<Object> $invokeBindToLifecycle($ProcessCameraProvider instance, $CameraSelector selector , $UseCase useCase) {
      return invokeMethod(instance, "bindToLifecycle", Arrays.<Object>asList(selector, useCase));
    }

Completable<Object> $invokeUnbindAll($ProcessCameraProvider instance) {
      return invokeMethod(instance, "unbindAll", Arrays.<Object>asList());
    }
  }

static class $CameraChannel extends TypeChannel<$Camera> {
    $CameraChannel(@NonNull TypeChannelManager manager) {
      super(manager, "penguin_camera/android/camerax/Camera");
    }

    

    
  }

static class $CameraSelectorChannel extends TypeChannel<$CameraSelector> {
    $CameraSelectorChannel(@NonNull TypeChannelManager manager) {
      super(manager, "penguin_camera/android/camerax/CameraSelector");
    }

    

    
  }

  static class $UseCaseHandler implements TypeChannelHandler<$UseCase> {
    $UseCase onCreate(TypeChannelManager manager, $UseCaseCreationArgs args)
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
        TypeChannelManager manager, $UseCase instance) {
      return Arrays.<Object>asList();
    }

    @Override
    public $UseCase createInstance(TypeChannelManager manager, List<Object> arguments)
        throws Exception {
      final $UseCaseCreationArgs args = new $UseCaseCreationArgs();
      
      return onCreate(manager, args);
    }

    @Override
    public Object invokeMethod(
        TypeChannelManager manager,
        $UseCase instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      for (Method method : $UseCase.class.getMethods()) {
        if (method.getName().equals(methodName)) {
          return method.invoke(instance, arguments.toArray());
        }
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }

    @Override
    public void onInstanceDisposed(TypeChannelManager manager, $UseCase instance)
        throws Exception {}
  }
static class $PreviewHandler implements TypeChannelHandler<$Preview> {
    $Preview onCreate(TypeChannelManager manager, $PreviewCreationArgs args)
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
        TypeChannelManager manager, $Preview instance) {
      return Arrays.<Object>asList();
    }

    @Override
    public $Preview createInstance(TypeChannelManager manager, List<Object> arguments)
        throws Exception {
      final $PreviewCreationArgs args = new $PreviewCreationArgs();
      
      return onCreate(manager, args);
    }

    @Override
    public Object invokeMethod(
        TypeChannelManager manager,
        $Preview instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      for (Method method : $Preview.class.getMethods()) {
        if (method.getName().equals(methodName)) {
          return method.invoke(instance, arguments.toArray());
        }
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }

    @Override
    public void onInstanceDisposed(TypeChannelManager manager, $Preview instance)
        throws Exception {}
  }
static class $SuccessListenerHandler implements TypeChannelHandler<$SuccessListener> {
    $SuccessListener onCreate(TypeChannelManager manager, $SuccessListenerCreationArgs args)
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
        TypeChannelManager manager, $SuccessListener instance) {
      return Arrays.<Object>asList();
    }

    @Override
    public $SuccessListener createInstance(TypeChannelManager manager, List<Object> arguments)
        throws Exception {
      final $SuccessListenerCreationArgs args = new $SuccessListenerCreationArgs();
      
      return onCreate(manager, args);
    }

    @Override
    public Object invokeMethod(
        TypeChannelManager manager,
        $SuccessListener instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      for (Method method : $SuccessListener.class.getMethods()) {
        if (method.getName().equals(methodName)) {
          return method.invoke(instance, arguments.toArray());
        }
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }

    @Override
    public void onInstanceDisposed(TypeChannelManager manager, $SuccessListener instance)
        throws Exception {}
  }
static class $ProcessCameraProviderHandler implements TypeChannelHandler<$ProcessCameraProvider> {
    $ProcessCameraProvider onCreate(TypeChannelManager manager, $ProcessCameraProviderCreationArgs args)
        throws Exception {
      return null;
    }

    public Object $onInitialize(TypeChannelManager manager, $SuccessListener successListener)
        throws Exception {
      return null;
    }

    @Override
    public Object invokeStaticMethod(
        TypeChannelManager manager, String methodName, List<Object> arguments)
        throws Exception {
      switch (methodName) {
        case "initialize":
          return $onInitialize(manager, ($SuccessListener) arguments.get(0));
      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke static method %s", methodName));
    }

    @Override
    public List<Object> getCreationArguments(
        TypeChannelManager manager, $ProcessCameraProvider instance) {
      return Arrays.<Object>asList();
    }

    @Override
    public $ProcessCameraProvider createInstance(TypeChannelManager manager, List<Object> arguments)
        throws Exception {
      final $ProcessCameraProviderCreationArgs args = new $ProcessCameraProviderCreationArgs();
      
      return onCreate(manager, args);
    }

    @Override
    public Object invokeMethod(
        TypeChannelManager manager,
        $ProcessCameraProvider instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      for (Method method : $ProcessCameraProvider.class.getMethods()) {
        if (method.getName().equals(methodName)) {
          return method.invoke(instance, arguments.toArray());
        }
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }

    @Override
    public void onInstanceDisposed(TypeChannelManager manager, $ProcessCameraProvider instance)
        throws Exception {}
  }
static class $CameraHandler implements TypeChannelHandler<$Camera> {
    $Camera onCreate(TypeChannelManager manager, $CameraCreationArgs args)
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
static class $CameraSelectorHandler implements TypeChannelHandler<$CameraSelector> {
    $CameraSelector onCreate(TypeChannelManager manager, $CameraSelectorCreationArgs args)
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
        TypeChannelManager manager, $CameraSelector instance) {
      return Arrays.<Object>asList(instance.getLensFacing());
    }

    @Override
    public $CameraSelector createInstance(TypeChannelManager manager, List<Object> arguments)
        throws Exception {
      final $CameraSelectorCreationArgs args = new $CameraSelectorCreationArgs();
      args.lensFacing = (Integer) arguments.get(0);
      return onCreate(manager, args);
    }

    @Override
    public Object invokeMethod(
        TypeChannelManager manager,
        $CameraSelector instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      for (Method method : $CameraSelector.class.getMethods()) {
        if (method.getName().equals(methodName)) {
          return method.invoke(instance, arguments.toArray());
        }
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }

    @Override
    public void onInstanceDisposed(TypeChannelManager manager, $CameraSelector instance)
        throws Exception {}
  }
}
