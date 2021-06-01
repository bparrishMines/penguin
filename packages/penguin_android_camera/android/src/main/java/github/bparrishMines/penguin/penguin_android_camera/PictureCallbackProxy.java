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

  public void onPictureTaken(byte[] data) {
    libraryImplementations.getChannelPictureCallback().$onPictureTaken(this, data);
  }

  @Override
  protected void finalize() throws Throwable {
    libraryImplementations.getChannelPictureCallback().disposeInstancePair(this);
    super.finalize();
  }
}
