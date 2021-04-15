package github.bparrishMines.penguin.penguin_android_camera;

import android.hardware.Camera;

public class PictureCallbackProxy implements CameraChannelLibrary.$PictureCallback {
  public final Camera.PictureCallback pictureCallback;
  private final ChannelRegistrar.LibraryImplementations libraryImplementations;

  public PictureCallbackProxy(ChannelRegistrar.LibraryImplementations libraryImplementations) {
    this.libraryImplementations = libraryImplementations;
    this.pictureCallback = (data, camera) -> PictureCallbackProxy.this.onPictureTaken(data);
  }

  public PictureCallbackProxy(Camera.PictureCallback pictureCallback, ChannelRegistrar.LibraryImplementations libraryImplementations) {
    this.pictureCallback = pictureCallback;
    this.libraryImplementations = libraryImplementations;
  }

  @Override
  public Void onPictureTaken(byte[] data) {
    libraryImplementations.getPictureCallbackChannel().$invokeOnPictureTaken(this, data);
    return null;
  }

  @Override
  protected void finalize() throws Throwable {
    libraryImplementations.getPictureCallbackChannel().disposeInstancePair(this);
    super.finalize();
  }
}
