package bparrishMines.penguin.penguin_camera.camerax;

import android.graphics.SurfaceTexture;

import androidx.camera.core.Preview;

import org.junit.Rule;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnit;
import org.mockito.junit.MockitoRule;
import org.powermock.core.classloader.annotations.SuppressStaticInitializationFor;
import org.powermock.modules.junit4.PowerMockRunner;

import io.flutter.view.TextureRegistry;

import static org.junit.Assert.assertEquals;
import static org.mockito.Matchers.any;
import static org.mockito.Mockito.verify;
import static org.powermock.api.mockito.PowerMockito.mock;
import static org.powermock.api.mockito.PowerMockito.when;

@RunWith(PowerMockRunner.class)
@SuppressStaticInitializationFor("androidx.camera.core.Preview")
public class PreviewTest {
  @Rule
  public MockitoRule mockitoRule = MockitoJUnit.rule();

  @Mock
  TextureRegistry mockTextureRegistry;

  @Mock
  Preview mockPreview;

  @Test
  public void attachToTexture() {
    final bparrishMines.penguin.penguin_camera.camerax.Preview preview = mock(bparrishMines.penguin.penguin_camera.camerax.Preview.class);
    when(preview.getPreview()).thenReturn(mockPreview);
    when(preview.getTextureRegistry()).thenReturn(mockTextureRegistry);
    when(preview.attachToTexture()).thenCallRealMethod();

    final TextureRegistry.SurfaceTextureEntry mockEntry = mock(TextureRegistry.SurfaceTextureEntry.class);
    final SurfaceTexture mockTexture = mock(SurfaceTexture.class);
    when(mockTextureRegistry.createSurfaceTexture()).thenReturn(mockEntry);
    when(mockEntry.id()).thenReturn(0L);
    when(mockEntry.surfaceTexture()).thenReturn(mockTexture);

    assertEquals(preview.attachToTexture(), (Long) 0L);
    assertEquals(preview.attachToTexture(), (Long) 0L);
    verify(mockPreview).setSurfaceProvider(any(Preview.SurfaceProvider.class));
  }

  @Test
  public void releaseTexture() {
    final Preview mockPreview = mock(Preview.class);

    final bparrishMines.penguin.penguin_camera.camerax.Preview preview = mock(bparrishMines.penguin.penguin_camera.camerax.Preview.class);
    when(preview.getPreview()).thenReturn(mockPreview);
    when(preview.getTextureRegistry()).thenReturn(mockTextureRegistry);
    when(preview.attachToTexture()).thenCallRealMethod();
    when(preview.releaseTexture()).thenCallRealMethod();

    final TextureRegistry.SurfaceTextureEntry mockEntry = mock(TextureRegistry.SurfaceTextureEntry.class);
    final SurfaceTexture mockTexture = mock(SurfaceTexture.class);
    when(mockTextureRegistry.createSurfaceTexture()).thenReturn(mockEntry);
    when(mockEntry.id()).thenReturn(0L);
    when(mockEntry.surfaceTexture()).thenReturn(mockTexture);

    preview.attachToTexture();
    preview.releaseTexture();
    verify(mockPreview).setSurfaceProvider(null);
  }
}
