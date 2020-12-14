package bparrishMines.penguin.penguin_camera.camerax;

import android.content.Context;

import com.google.common.util.concurrent.ListenableFuture;

import androidx.core.content.ContextCompat;
import androidx.lifecycle.LifecycleOwner;
import github.penguin.reference.reference.ReferenceChannelManager;

public class ProcessCameraProvider implements CameraXChannelLibrary.$ProcessCameraProvider {
  public static void setupChannel(ReferenceChannelManager manager, Context context, LifecycleOwner lifecycleOwner) {
    final CameraXChannelLibrary.$ProcessCameraProviderChannel channel =
        new CameraXChannelLibrary.$ProcessCameraProviderChannel(manager);
    channel.registerHandler(new CameraXChannelLibrary.$ProcessCameraProviderHandler() {
      private ProcessCameraProvider instance = new ProcessCameraProvider(manager, lifecycleOwner);

      @Override
      CameraXChannelLibrary.$ProcessCameraProvider onCreate(ReferenceChannelManager manager, CameraXChannelLibrary.$ProcessCameraProviderCreationArgs args) throws Exception {
        return instance;
      }

      @Override
      public Object $onInitialize(ReferenceChannelManager manager, CameraXChannelLibrary.$SuccessListener successListener) throws Exception {
        return initialize(context, instance, (SuccessListener) successListener);
      }
    });
  }

  private final ReferenceChannelManager manager;
  private final LifecycleOwner lifecycleOwner;
  private androidx.camera.lifecycle.ProcessCameraProvider provider;
  private Camera cameraReference;

  static Object initialize(Context context, ProcessCameraProvider instance, SuccessListener listener) {
    if (instance.provider != null) return instance;

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

  ProcessCameraProvider(ReferenceChannelManager manager, LifecycleOwner lifecycleOwner) {
    this.manager = manager;
    this.lifecycleOwner = lifecycleOwner;
  }

  @Override
  public Object bindToLifecycle(CameraXChannelLibrary.$CameraSelector selector, CameraXChannelLibrary.$UseCase useCase) {
    final CameraSelector cameraSelector = (CameraSelector) selector;
    final Preview preview = (Preview) useCase;
    final androidx.camera.core.Camera camera =
        provider.bindToLifecycle(lifecycleOwner, cameraSelector.getCameraSelector(), preview.getPreview());

    if (cameraReference == null) {
      cameraReference = new Camera(manager, camera);
      final CameraXChannelLibrary.$CameraChannel channel = new CameraXChannelLibrary.$CameraChannel(manager);
      channel.createNewPair(cameraReference);
    }
    return cameraReference;
  }

  @Override
  public Object unbindAll() {
    final CameraXChannelLibrary.$CameraChannel channel = new CameraXChannelLibrary.$CameraChannel(manager);
    channel.disposePair(cameraReference);
    cameraReference = null;
    provider.unbindAll();
    return null;
  }
}
