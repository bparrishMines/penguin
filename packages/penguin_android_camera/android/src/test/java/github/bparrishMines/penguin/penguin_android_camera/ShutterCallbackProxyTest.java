package github.bparrishMines.penguin.penguin_android_camera;

import android.hardware.Camera;

import org.junit.Test;

import github.penguin.reference.reference.TypeChannelMessenger;

import static org.junit.Assert.assertTrue;
import static org.mockito.Mockito.mock;

public class ShutterCallbackProxyTest {
  @Test
  public void onShutter() {
    final Boolean[] onShutterCalled = {false};

    final ShutterCallbackProxy proxy = new ShutterCallbackProxy(mock(TypeChannelMessenger.class)) {
      @Override
      public Void onShutter() {
        onShutterCalled[0] = true;
        return null;
      }
    };

    proxy.getShutterCallback().onShutter();
    assertTrue(onShutterCalled[0]);
  }
}
