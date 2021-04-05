package github.bparrishMines.penguin.penguin_android_camera;

import org.junit.Test;

import static org.junit.Assert.assertTrue;
import static org.mockito.Mockito.mock;

public class ShutterCallbackProxyTest {
  @Test
  public void onShutter() {
    final Boolean[] onShutterCalled = {false};

    final ShutterCallbackProxy proxy = new ShutterCallbackProxy(mock(ChannelRegistrar.LibraryImplementations.class)) {
      @Override
      public Void onShutter() {
        onShutterCalled[0] = true;
        return null;
      }
    };

    proxy.shutterCallback.onShutter();
    assertTrue(onShutterCalled[0]);
  }
}
