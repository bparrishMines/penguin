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

public class Preview implements CameraXChannelLibrary.$Preview, CameraXChannelLibrary.$UseCase {
  private static final String TAG = "Preview";

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

  private final Context context;
  private final TextureRegistry textureRegistry;
  final androidx.camera.core.Preview preview;

  private TextureRegistry.SurfaceTextureEntry currentTextureEntry;

  Preview(Context context, TextureRegistry textureRegistry) {
    this.textureRegistry = textureRegistry;
    this.context = context;
    this.preview = new androidx.camera.core.Preview.Builder().build();
  }

  @Override
  public Object attachToTexture() {
    if (currentTextureEntry != null) return currentTextureEntry.id();

    currentTextureEntry = textureRegistry.createSurfaceTexture();
    preview.setSurfaceProvider(new androidx.camera.core.Preview.SurfaceProvider() {
      @Override
      public void onSurfaceRequested(@NonNull SurfaceRequest request) {
        request.provideSurface(new Surface(currentTextureEntry.surfaceTexture()),
            ContextCompat.getMainExecutor(context),
            new Consumer<SurfaceRequest.Result>() {
              @Override
              public void accept(SurfaceRequest.Result result) {
                Log.d(TAG, "" + result.getResultCode());
              }
            }
        );
      }
    });
    return currentTextureEntry.id();
  }

  @Override
  public Object releaseTexture() {
    if (currentTextureEntry == null) return null;

    preview.setSurfaceProvider(null);
    currentTextureEntry.release();
    currentTextureEntry = null;
    return null;
  }
}
