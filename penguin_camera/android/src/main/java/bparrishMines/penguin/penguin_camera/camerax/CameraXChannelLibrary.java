// GENERATED CODE - DO NOT MODIFY BY HAND

package bparrishMines.penguin.penguin_camera.camerax;

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

  static class $UseCaseChannel extends ReferenceChannel<$UseCase> {
    $UseCaseChannel(@NonNull ReferenceChannelManager manager) {
      super(manager, "penguin_camera/usecase");
    }

    

    
  }

static class $PreviewChannel extends ReferenceChannel<$Preview> {
    $PreviewChannel(@NonNull ReferenceChannelManager manager) {
      super(manager, "penguin_camera/preview");
    }

    

    Completable<Object> $invokeAttachToTexture($Preview instance) {
      final String $methodName = "attachToTexture";
      final List<Object> $arguments = Arrays.<Object>asList();

      if (manager.isPaired(instance)) return invokeMethod(instance, $methodName, $arguments);
      return invokeMethodOnUnpairedReference(instance, $methodName, $arguments);
    }

Completable<Object> $invokeReleaseTexture($Preview instance) {
      final String $methodName = "releaseTexture";
      final List<Object> $arguments = Arrays.<Object>asList();

      if (manager.isPaired(instance)) return invokeMethod(instance, $methodName, $arguments);
      return invokeMethodOnUnpairedReference(instance, $methodName, $arguments);
    }
  }

static class $SuccessListenerChannel extends ReferenceChannel<$SuccessListener> {
    $SuccessListenerChannel(@NonNull ReferenceChannelManager manager) {
      super(manager, "penguin_camera/successlistener");
    }

    

    Completable<Object> $invokeOnSuccess($SuccessListener instance) {
      final String $methodName = "onSuccess";
      final List<Object> $arguments = Arrays.<Object>asList();

      if (manager.isPaired(instance)) return invokeMethod(instance, $methodName, $arguments);
      return invokeMethodOnUnpairedReference(instance, $methodName, $arguments);
    }

Completable<Object> $invokeOnError($SuccessListener instance, String code , String message) {
      final String $methodName = "onError";
      final List<Object> $arguments = Arrays.<Object>asList(code, message);

      if (manager.isPaired(instance)) return invokeMethod(instance, $methodName, $arguments);
      return invokeMethodOnUnpairedReference(instance, $methodName, $arguments);
    }
  }

static class $ProcessCameraProviderChannel extends ReferenceChannel<$ProcessCameraProvider> {
    $ProcessCameraProviderChannel(@NonNull ReferenceChannelManager manager) {
      super(manager, "penguin_camera/processcameraprovider");
    }

    Completable<Object> $invokeInitialize($SuccessListener successListener) {
      return invokeStaticMethod("initialize", Arrays.<Object>asList(successListener));
    }

    Completable<Object> $invokeBindToLifecycle($ProcessCameraProvider instance, $CameraSelector selector , $UseCase useCase) {
      final String $methodName = "bindToLifecycle";
      final List<Object> $arguments = Arrays.<Object>asList(selector, useCase);

      if (manager.isPaired(instance)) return invokeMethod(instance, $methodName, $arguments);
      return invokeMethodOnUnpairedReference(instance, $methodName, $arguments);
    }

Completable<Object> $invokeUnbindAll($ProcessCameraProvider instance) {
      final String $methodName = "unbindAll";
      final List<Object> $arguments = Arrays.<Object>asList();

      if (manager.isPaired(instance)) return invokeMethod(instance, $methodName, $arguments);
      return invokeMethodOnUnpairedReference(instance, $methodName, $arguments);
    }
  }

static class $CameraChannel extends ReferenceChannel<$Camera> {
    $CameraChannel(@NonNull ReferenceChannelManager manager) {
      super(manager, "penguin_camera/camera");
    }

    

    
  }

static class $CameraSelectorChannel extends ReferenceChannel<$CameraSelector> {
    $CameraSelectorChannel(@NonNull ReferenceChannelManager manager) {
      super(manager, "penguin_camera/cameraselector");
    }

    

    
  }

  static class $UseCaseHandler implements ReferenceChannelHandler<$UseCase> {
    $UseCase onCreate(ReferenceChannelManager manager, $UseCaseCreationArgs args)
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
        ReferenceChannelManager manager, $UseCase instance) {
      return Arrays.<Object>asList();
    }

    @Override
    public $UseCase createInstance(ReferenceChannelManager manager, List<Object> arguments)
        throws Exception {
      final $UseCaseCreationArgs args = new $UseCaseCreationArgs();
      
      return onCreate(manager, args);
    }

    @Override
    public Object invokeMethod(
        ReferenceChannelManager manager,
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
    public void onInstanceDisposed(ReferenceChannelManager manager, $UseCase instance)
        throws Exception {}
  }
static class $PreviewHandler implements ReferenceChannelHandler<$Preview> {
    $Preview onCreate(ReferenceChannelManager manager, $PreviewCreationArgs args)
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
        ReferenceChannelManager manager, $Preview instance) {
      return Arrays.<Object>asList();
    }

    @Override
    public $Preview createInstance(ReferenceChannelManager manager, List<Object> arguments)
        throws Exception {
      final $PreviewCreationArgs args = new $PreviewCreationArgs();
      
      return onCreate(manager, args);
    }

    @Override
    public Object invokeMethod(
        ReferenceChannelManager manager,
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
    public void onInstanceDisposed(ReferenceChannelManager manager, $Preview instance)
        throws Exception {}
  }
static class $SuccessListenerHandler implements ReferenceChannelHandler<$SuccessListener> {
    $SuccessListener onCreate(ReferenceChannelManager manager, $SuccessListenerCreationArgs args)
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
        ReferenceChannelManager manager, $SuccessListener instance) {
      return Arrays.<Object>asList();
    }

    @Override
    public $SuccessListener createInstance(ReferenceChannelManager manager, List<Object> arguments)
        throws Exception {
      final $SuccessListenerCreationArgs args = new $SuccessListenerCreationArgs();
      
      return onCreate(manager, args);
    }

    @Override
    public Object invokeMethod(
        ReferenceChannelManager manager,
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
    public void onInstanceDisposed(ReferenceChannelManager manager, $SuccessListener instance)
        throws Exception {}
  }
static class $ProcessCameraProviderHandler implements ReferenceChannelHandler<$ProcessCameraProvider> {
    $ProcessCameraProvider onCreate(ReferenceChannelManager manager, $ProcessCameraProviderCreationArgs args)
        throws Exception {
      return null;
    }

    public Object $onInitialize(ReferenceChannelManager manager, $SuccessListener successListener)
        throws Exception {
      return null;
    }

    @Override
    public Object invokeStaticMethod(
        ReferenceChannelManager manager, String methodName, List<Object> arguments)
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
        ReferenceChannelManager manager, $ProcessCameraProvider instance) {
      return Arrays.<Object>asList();
    }

    @Override
    public $ProcessCameraProvider createInstance(ReferenceChannelManager manager, List<Object> arguments)
        throws Exception {
      final $ProcessCameraProviderCreationArgs args = new $ProcessCameraProviderCreationArgs();
      
      return onCreate(manager, args);
    }

    @Override
    public Object invokeMethod(
        ReferenceChannelManager manager,
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
    public void onInstanceDisposed(ReferenceChannelManager manager, $ProcessCameraProvider instance)
        throws Exception {}
  }
static class $CameraHandler implements ReferenceChannelHandler<$Camera> {
    $Camera onCreate(ReferenceChannelManager manager, $CameraCreationArgs args)
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
static class $CameraSelectorHandler implements ReferenceChannelHandler<$CameraSelector> {
    $CameraSelector onCreate(ReferenceChannelManager manager, $CameraSelectorCreationArgs args)
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
        ReferenceChannelManager manager, $CameraSelector instance) {
      return Arrays.<Object>asList(instance.getLensFacing());
    }

    @Override
    public $CameraSelector createInstance(ReferenceChannelManager manager, List<Object> arguments)
        throws Exception {
      final $CameraSelectorCreationArgs args = new $CameraSelectorCreationArgs();
      args.lensFacing = (Integer) arguments.get(0);
      return onCreate(manager, args);
    }

    @Override
    public Object invokeMethod(
        ReferenceChannelManager manager,
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
    public void onInstanceDisposed(ReferenceChannelManager manager, $CameraSelector instance)
        throws Exception {}
  }
}
