// GENERATED CODE - DO NOT MODIFY BY HAND

package bparrishMines.penguin.penguin_camera.camerax;

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

class CameraXChannelLibrary {
  interface $UseCase {}

  interface $Preview {
    Object attachToTexture() throws Exception;

    Object releaseTexture() throws Exception;
  }

  interface $SuccessListener {
    Object onSuccess() throws Exception;

    Object onError(String code, String message) throws Exception;
  }

  interface $ProcessCameraProvider {
    Object bindToLifecycle($CameraSelector selector, $UseCase useCase) throws Exception;

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
    $UseCaseChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_camera/android/camerax/UseCase");
    }


  }

  static class $PreviewChannel extends TypeChannel<$Preview> {
    $PreviewChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_camera/android/camerax/Preview");
    }


    Completable<Object> $invokeAttachToTexture($Preview instance) {
      return invokeMethod(instance, "attachToTexture", Arrays.asList());
    }

    Completable<Object> $invokeReleaseTexture($Preview instance) {
      return invokeMethod(instance, "releaseTexture", Arrays.asList());
    }
  }

  static class $SuccessListenerChannel extends TypeChannel<$SuccessListener> {
    $SuccessListenerChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_camera/android/camerax/SuccessListener");
    }


    Completable<Object> $invokeOnSuccess($SuccessListener instance) {
      return invokeMethod(instance, "onSuccess", Arrays.asList());
    }

    Completable<Object> $invokeOnError($SuccessListener instance, String code, String message) {
      return invokeMethod(instance, "onError", Arrays.asList(code, message));
    }
  }

  static class $ProcessCameraProviderChannel extends TypeChannel<$ProcessCameraProvider> {
    $ProcessCameraProviderChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_camera/android/camerax/ProcessCameraProvider");
    }

    Completable<Object> $invokeInitialize($SuccessListener successListener) {
      return invokeStaticMethod("initialize", Arrays.asList(successListener));
    }

    Completable<Object> $invokeBindToLifecycle($ProcessCameraProvider instance, $CameraSelector selector, $UseCase useCase) {
      return invokeMethod(instance, "bindToLifecycle", Arrays.asList(selector, useCase));
    }

    Completable<Object> $invokeUnbindAll($ProcessCameraProvider instance) {
      return invokeMethod(instance, "unbindAll", Arrays.asList());
    }
  }

  static class $CameraChannel extends TypeChannel<$Camera> {
    $CameraChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_camera/android/camerax/Camera");
    }


  }

  static class $CameraSelectorChannel extends TypeChannel<$CameraSelector> {
    $CameraSelectorChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "penguin_camera/android/camerax/CameraSelector");
    }


  }

  static class $UseCaseHandler implements TypeChannelHandler<$UseCase> {
    $UseCase onCreate(TypeChannelMessenger messenger, $UseCaseCreationArgs args)
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
        TypeChannelMessenger messenger, $UseCase instance) {
      return Arrays.asList();
    }

    @Override
    public $UseCase createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      final $UseCaseCreationArgs args = new $UseCaseCreationArgs();

      return onCreate(messenger, args);
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
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
    public void onInstanceAdded(TypeChannelMessenger messenger, $UseCase instance)
        throws Exception {
    }

    @Override
    public void onInstanceRemoved(TypeChannelMessenger messenger, $UseCase instance)
        throws Exception {
    }
  }

  static class $PreviewHandler implements TypeChannelHandler<$Preview> {
    $Preview onCreate(TypeChannelMessenger messenger, $PreviewCreationArgs args)
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
        TypeChannelMessenger messenger, $Preview instance) {
      return Arrays.asList();
    }

    @Override
    public $Preview createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      final $PreviewCreationArgs args = new $PreviewCreationArgs();

      return onCreate(messenger, args);
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
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
    public void onInstanceAdded(TypeChannelMessenger messenger, $Preview instance)
        throws Exception {
    }

    @Override
    public void onInstanceRemoved(TypeChannelMessenger messenger, $Preview instance)
        throws Exception {
    }
  }

  static class $SuccessListenerHandler implements TypeChannelHandler<$SuccessListener> {
    $SuccessListener onCreate(TypeChannelMessenger messenger, $SuccessListenerCreationArgs args)
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
        TypeChannelMessenger messenger, $SuccessListener instance) {
      return Arrays.asList();
    }

    @Override
    public $SuccessListener createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      final $SuccessListenerCreationArgs args = new $SuccessListenerCreationArgs();

      return onCreate(messenger, args);
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
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
    public void onInstanceAdded(TypeChannelMessenger messenger, $SuccessListener instance)
        throws Exception {
    }

    @Override
    public void onInstanceRemoved(TypeChannelMessenger messenger, $SuccessListener instance)
        throws Exception {
    }
  }

  static class $ProcessCameraProviderHandler implements TypeChannelHandler<$ProcessCameraProvider> {
    $ProcessCameraProvider onCreate(TypeChannelMessenger messenger, $ProcessCameraProviderCreationArgs args)
        throws Exception {
      return null;
    }

    public Object $onInitialize(TypeChannelMessenger messenger, $SuccessListener successListener)
        throws Exception {
      return null;
    }

    @Override
    public Object invokeStaticMethod(
        TypeChannelMessenger messenger, String methodName, List<Object> arguments)
        throws Exception {
      switch (methodName) {
        case "initialize":
          return $onInitialize(messenger, ($SuccessListener) arguments.get(0));
      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke static method %s", methodName));
    }

    @Override
    public List<Object> getCreationArguments(
        TypeChannelMessenger messenger, $ProcessCameraProvider instance) {
      return Arrays.asList();
    }

    @Override
    public $ProcessCameraProvider createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      final $ProcessCameraProviderCreationArgs args = new $ProcessCameraProviderCreationArgs();

      return onCreate(messenger, args);
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
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
    public void onInstanceAdded(TypeChannelMessenger messenger, $ProcessCameraProvider instance)
        throws Exception {
    }

    @Override
    public void onInstanceRemoved(TypeChannelMessenger messenger, $ProcessCameraProvider instance)
        throws Exception {
    }
  }

  static class $CameraHandler implements TypeChannelHandler<$Camera> {
    $Camera onCreate(TypeChannelMessenger messenger, $CameraCreationArgs args)
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
        TypeChannelMessenger messenger, $Camera instance) {
      return Arrays.asList();
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

  static class $CameraSelectorHandler implements TypeChannelHandler<$CameraSelector> {
    $CameraSelector onCreate(TypeChannelMessenger messenger, $CameraSelectorCreationArgs args)
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
        TypeChannelMessenger messenger, $CameraSelector instance) {
      return Arrays.asList(instance.getLensFacing());
    }

    @Override
    public $CameraSelector createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      final $CameraSelectorCreationArgs args = new $CameraSelectorCreationArgs();
      args.lensFacing = (Integer) arguments.get(0);
      return onCreate(messenger, args);
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
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
    public void onInstanceAdded(TypeChannelMessenger messenger, $CameraSelector instance)
        throws Exception {
    }

    @Override
    public void onInstanceRemoved(TypeChannelMessenger messenger, $CameraSelector instance)
        throws Exception {
    }
  }
}
