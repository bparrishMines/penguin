package bparrishMines.penguin.penguin_camera.camerax;

import android.content.Context;

import com.google.common.util.concurrent.ListenableFuture;

import androidx.annotation.Nullable;
import androidx.core.content.ContextCompat;
import androidx.lifecycle.LifecycleOwner;
import github.penguin.reference.reference.TypeChannelMessenger;

public class ProcessCameraProvider implements CameraXChannelLibrary.$ProcessCameraProvider {
  private final CameraXChannelLibrary.$ProcessCameraProviderChannel channel;
  private final LifecycleOwner lifecycleOwner;
  @Nullable
  private androidx.camera.lifecycle.ProcessCameraProvider provider;
  @Nullable
  private Camera cameraInstance;

  public static void setupChannel(TypeChannelMessenger messenger, Context context, LifecycleOwner lifecycleOwner) {
    final CameraXChannelLibrary.$ProcessCameraProviderChannel channel =
        new CameraXChannelLibrary.$ProcessCameraProviderChannel(messenger);
    channel.setHandler(new CameraXChannelLibrary.$ProcessCameraProviderHandler() {
      private final ProcessCameraProvider instance = new ProcessCameraProvider(messenger, lifecycleOwner);

      @Override
      CameraXChannelLibrary.$ProcessCameraProvider onCreate(TypeChannelMessenger messenger, CameraXChannelLibrary.$ProcessCameraProviderCreationArgs args) {
        return instance;
      }

      @Override
      public Object $onInitialize(TypeChannelMessenger messenger, CameraXChannelLibrary.$SuccessListener successListener) {
        return initialize(context, instance, (SuccessListener) successListener);
      }
    });
  }

  public static ProcessCameraProvider initialize(Context context, ProcessCameraProvider instance, SuccessListener listener) {
    if (instance.getProvider() != null) return instance;

    final ListenableFuture<androidx.camera.lifecycle.ProcessCameraProvider> future =
        androidx.camera.lifecycle.ProcessCameraProvider.getInstance(context);
    future.addListener(new Runnable() {
      @Override
      public void run() {
        try {
          instance.provider = future.get();
          listener.onSuccess();
        } catch(Exception exception) {
          listener.onError(exception.getClass().getSimpleName(), exception.getMessage());
        }
      }
    }, ContextCompat.getMainExecutor(context));

    return instance;
  }

  public ProcessCameraProvider(TypeChannelMessenger messenger, LifecycleOwner lifecycleOwner) {
    this.channel = new CameraXChannelLibrary.$ProcessCameraProviderChannel(messenger);
    this.lifecycleOwner = lifecycleOwner;
  }

  @Nullable
  public androidx.camera.lifecycle.ProcessCameraProvider getProvider() {
    return provider;
  }

  @Override
  public Camera bindToLifecycle(CameraXChannelLibrary.$CameraSelector selector, CameraXChannelLibrary.$UseCase useCase) {
    final CameraSelector cameraSelector = (CameraSelector) selector;
    final UseCase useCaseImpl = (UseCase) useCase;
    final androidx.camera.core.Camera camera =
        getProvider().bindToLifecycle(lifecycleOwner, cameraSelector.getCameraSelector(), useCaseImpl.getUseCase());

    if (cameraInstance == null) {
      cameraInstance = new Camera(channel.messenger, camera);
      cameraInstance.getTypeChannel().createNewInstancePair(cameraInstance);
    }
    return cameraInstance;
  }

  @Override
  public Void unbindAll() {
    if (cameraInstance != null) {
      cameraInstance.getTypeChannel().disposeInstancePair(cameraInstance);
      cameraInstance = null;
    }
    getProvider().unbindAll();
    return null;
  }
}
