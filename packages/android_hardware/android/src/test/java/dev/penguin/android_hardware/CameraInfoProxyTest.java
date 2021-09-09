package dev.penguin.android_hardware;

import android.hardware.Camera;
import org.junit.Test;
import static org.junit.Assert.assertEquals;

public class CameraInfoProxyTest {
  @Test
  public void facing() {
    assertEquals(Camera.CameraInfo.CAMERA_FACING_BACK, 0);
    assertEquals(Camera.CameraInfo.CAMERA_FACING_FRONT, 1);
  }
}
