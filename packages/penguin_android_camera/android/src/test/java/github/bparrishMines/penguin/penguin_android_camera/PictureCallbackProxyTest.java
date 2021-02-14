package github.bparrishMines.penguin.penguin_android_camera;

import org.junit.Test;

import github.penguin.reference.reference.TypeChannelMessenger;

import static org.junit.Assert.assertArrayEquals;
import static org.mockito.Mockito.mock;

public class PictureCallbackProxyTest {
  @Test
  public void onPictureTaken() {
    final byte[][] bytes = new byte[1][1];

    final PictureCallbackProxy proxy = new PictureCallbackProxy(mock(TypeChannelMessenger.class)) {
      @Override
      public Void onPictureTaken(byte[] data) {
        bytes[0] = new byte[]{1, 2, 3};
        return null;
      }
    };

    proxy.getPictureCallback().onPictureTaken(bytes[0], null);
    assertArrayEquals(bytes[0], new byte[]{1, 2, 3});
  }
}
