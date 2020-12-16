package bparrishMines.penguin.penguin_camera.camerax;

import android.content.Context;
import android.util.Log;
import android.view.Surface;
import androidx.annotation.NonNull;
import androidx.camera.core.SurfaceRequest;
import androidx.core.content.ContextCompat;
import androidx.core.util.Consumer;
import github.penguin.reference.reference.ReferenceChannelManager;
import io.flutter.view.TextureRegistry;

import static androidx.camera.core.SurfaceRequest.Result.RESULT_INVALID_SURFACE;
import static androidx.camera.core.SurfaceRequest.Result.RESULT_REQUEST_CANCELLED;
import static androidx.camera.core.SurfaceRequest.Result.RESULT_SURFACE_ALREADY_PROVIDED;
import static androidx.camera.core.SurfaceRequest.Result.RESULT_SURFACE_USED_SUCCESSFULLY;
import static androidx.camera.core.SurfaceRequest.Result.RESULT_WILL_NOT_PROVIDE_SURFACE;

public class Preview implements CameraXChannelLibrary.$Preview, CameraXChannelLibrary.$UseCase {
  private static final String TAG = "Preview";
  private final Context context;
  private final TextureRegistry textureRegistry;
  private final androidx.camera.core.Preview preview;

  public static void setupChannel(ReferenceChannelManager manager, Context context, TextureRegistry textureRegistry) {
    final CameraXChannelLibrary.$PreviewChannel channel =
        new CameraXChannelLibrary.$PreviewChannel(manager);
    channel.registerHandler(new CameraXChannelLibrary.$PreviewHandler() {
      @Override
      CameraXChannelLibrary.$Preview onCreate(ReferenceChannelManager manager, CameraXChannelLibrary.$PreviewCreationArgs args) throws Exception {
        return new Preview(context, textureRegistry);
      }
    });
  }

  private TextureRegistry.SurfaceTextureEntry currentTextureEntry;

  public Preview(Context context, TextureRegistry textureRegistry) {
    this.context = context;
    this.textureRegistry = textureRegistry;
    this.preview = new androidx.camera.core.Preview.Builder().build();
  }

  public androidx.camera.core.Preview getPreview() {
    return preview;
  }

  public TextureRegistry getTextureRegistry() {
    return textureRegistry;
  }

  @Override
  public Long attachToTexture() {
    if (currentTextureEntry != null) return currentTextureEntry.id();

    currentTextureEntry = getTextureRegistry().createSurfaceTexture();
    getPreview().setSurfaceProvider(new androidx.camera.core.Preview.SurfaceProvider() {
      @Override
      public void onSurfaceRequested(@NonNull SurfaceRequest request) {
        request.provideSurface(new Surface(currentTextureEntry.surfaceTexture()),
            ContextCompat.getMainExecutor(context),
            new Consumer<SurfaceRequest.Result>() {
              @Override
              public void accept(SurfaceRequest.Result result) {
                final String message;
                switch(result.getResultCode()) {
                  case RESULT_SURFACE_USED_SUCCESSFULLY:
                    message = "Result surface used successfully.";
                    break;
                  case RESULT_REQUEST_CANCELLED:
                    message = "Result request cancelled.";
                    break;
                  case RESULT_INVALID_SURFACE:
                    message = "Result invalid surface.";
                    break;
                  case RESULT_SURFACE_ALREADY_PROVIDED:
                    message = "Result surface already provided.";
                    break;
                  case RESULT_WILL_NOT_PROVIDE_SURFACE:
                    message = "Result will not provide surface";
                    break;
                  default:
                    message = "Unknown error code.";
                }
                Log.d(TAG, String.format("%d: %s", result.getResultCode(), message));
              }
            }
        );
      }
    });
    return currentTextureEntry.id();
  }

  @Override
  public Void releaseTexture() {
    if (currentTextureEntry == null) return null;

    getPreview().setSurfaceProvider(null);
    currentTextureEntry.release();
    currentTextureEntry = null;
    return null;
  }
}
