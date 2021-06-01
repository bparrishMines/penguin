package github.bparrishMines.penguin.penguin_android_camera;

import android.hardware.Camera;

import org.junit.Test;

import github.penguin.reference.async.Completable;

import static org.junit.Assert.assertTrue;
import static org.mockito.Mockito.mock;

public class AutoFocusCallbackTest {
  @Test
  public void onAutoFocus() {
    final Boolean[] onAutoFocusCalled = {null};

    final AutoFocusCallbackProxy proxy = new AutoFocusCallbackProxy(mock(ChannelRegistrar.LibraryImplementations.class)) {
      @Override
      public Completable<Object> onAutoFocus(Boolean success) {
        onAutoFocusCalled[0] = success;
        return null;
      }
    };

    proxy.onAutoFocus(true, mock(Camera.class));
    assertTrue(onAutoFocusCalled[0]);
  }
}
