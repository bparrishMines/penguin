package bparrishMines.penguin.penguin_camera.camerax;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.powermock.api.mockito.PowerMockito;
import org.powermock.core.classloader.annotations.PrepareForTest;
import org.powermock.modules.junit4.PowerMockRunner;

import androidx.camera.core.CameraSelector;

import static org.mockito.Matchers.anyInt;
import static org.mockito.Mockito.verify;
import static org.powermock.api.mockito.PowerMockito.mock;
import static org.powermock.api.mockito.PowerMockito.when;

@RunWith(PowerMockRunner.class)
@PrepareForTest( { bparrishMines.penguin.penguin_camera.camerax.CameraSelector.class, CameraSelector.class })
public class CameraSelectorTest {
  @Test
  public void constructor() throws Exception {
    final CameraSelector.Builder mockBuilder = mock(CameraSelector.Builder.class);
    when(mockBuilder.requireLensFacing(anyInt())).thenReturn(mockBuilder);

    PowerMockito.whenNew(CameraSelector.Builder.class).withNoArguments().thenReturn(mockBuilder);

    new bparrishMines.penguin.penguin_camera.camerax.CameraSelector(8);

    verify(mockBuilder).requireLensFacing(8);
  }
}
