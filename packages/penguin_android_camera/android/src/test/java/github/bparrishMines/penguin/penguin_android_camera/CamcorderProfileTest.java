package github.bparrishMines.penguin.penguin_android_camera;

import android.media.CamcorderProfile;

import org.junit.Rule;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnit;
import org.mockito.junit.MockitoRule;
import org.powermock.api.mockito.PowerMockito;
import org.powermock.core.classloader.annotations.PowerMockIgnore;
import org.powermock.core.classloader.annotations.PrepareForTest;
import org.powermock.modules.junit4.PowerMockRunner;

import github.penguin.reference.reference.TypeChannelMessenger;
import io.flutter.view.TextureRegistry;

import static org.junit.Assert.assertEquals;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.powermock.api.mockito.PowerMockito.verifyStatic;
import static org.powermock.api.mockito.PowerMockito.when;

@RunWith(PowerMockRunner.class)
@PowerMockIgnore("jdk.internal.reflect.*")
@PrepareForTest({CamcorderProfile.class})
public class CamcorderProfileTest {
  @Rule
  public MockitoRule mockitoRule = MockitoJUnit.rule();

  @Mock
  TypeChannelMessenger mockTypeChannelMessenger;

  @Mock
  TextureRegistry mockTextureRegistry;

  @Mock
  ChannelRegistrar.LibraryImplementations mockImplementations;

  @Mock
  CameraChannelLibrary.$CamcorderProfileChannel mockCamcorderProfileChannel;

  @Test
  public void quality() {
    assertEquals(CamcorderProfile.QUALITY_1080P, 0x00000006);
    assertEquals(CamcorderProfile.QUALITY_2160P, 0x00000008);
    assertEquals(CamcorderProfile.QUALITY_480P, 0x00000004);
    assertEquals(CamcorderProfile.QUALITY_720P, 0x00000005);
    assertEquals(CamcorderProfile.QUALITY_CIF, 0x00000003);
    assertEquals(CamcorderProfile.QUALITY_HIGH, 0x00000001);
    assertEquals(CamcorderProfile.QUALITY_HIGH_SPEED_1080P, 0x000007d4);
    assertEquals(CamcorderProfile.QUALITY_HIGH_SPEED_2160P, 0x000007d5);
    assertEquals(CamcorderProfile.QUALITY_HIGH_SPEED_480P, 0x000007d2);
    assertEquals(CamcorderProfile.QUALITY_HIGH_SPEED_720P, 0x000007d3);
    assertEquals(CamcorderProfile.QUALITY_HIGH_SPEED_HIGH, 0x000007d1);
    assertEquals(CamcorderProfile.QUALITY_HIGH_SPEED_LOW, 0x000007d0);
    assertEquals(CamcorderProfile.QUALITY_HIGH_SPEED_VGA, 0x000007d7);
    assertEquals(CamcorderProfile.QUALITY_LOW, 0x00000000);
    assertEquals(CamcorderProfile.QUALITY_QVGA, 0x00000007);
    assertEquals(CamcorderProfile.QUALITY_TIME_LAPSE_1080P, 0x000003ee);
    assertEquals(CamcorderProfile.QUALITY_TIME_LAPSE_2160P, 0x000003f0);
    assertEquals(CamcorderProfile.QUALITY_TIME_LAPSE_480P, 0x000003ec);
    assertEquals(CamcorderProfile.QUALITY_TIME_LAPSE_720P, 0x000003ed);
    assertEquals(CamcorderProfile.QUALITY_TIME_LAPSE_CIF, 0x000003eb);
    assertEquals(CamcorderProfile.QUALITY_TIME_LAPSE_HIGH, 0x000003e9);
    assertEquals(CamcorderProfile.QUALITY_TIME_LAPSE_LOW, 0x000003e8);
    assertEquals(CamcorderProfile.QUALITY_TIME_LAPSE_QCIF, 0x000003ea);
    assertEquals(CamcorderProfile.QUALITY_TIME_LAPSE_QVGA, 0x000003ef);
  }

  @Test
  public void createCamcorderProfile() {
    final CamcorderProfile mockCamcorderProfile = mock(CamcorderProfile.class);
    mockCamcorderProfile.audioBitRate = 1;
    mockCamcorderProfile.audioChannels = 2;
    mockCamcorderProfile.audioCodec = 3;
    mockCamcorderProfile.audioSampleRate = 4;
    mockCamcorderProfile.duration = 5;
    mockCamcorderProfile.fileFormat = 6;
    mockCamcorderProfile.quality = 7;
    mockCamcorderProfile.videoBitRate = 8;
    mockCamcorderProfile.videoCodec = 9;
    mockCamcorderProfile.videoFrameHeight = 10;
    mockCamcorderProfile.videoFrameRate = 11;
    mockCamcorderProfile.videoFrameWidth = 12;

    when(mockImplementations.getChannelCamcorderProfile()).thenReturn(mockCamcorderProfileChannel);
    final CamcorderProfileProxy camcorderProfileProxy = new CamcorderProfileProxy(mockCamcorderProfile,
        mockImplementations);

    verify(mockCamcorderProfileChannel).$$create(camcorderProfileProxy, false,
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12
        );
  }

  @Test
  public void get() {
    PowerMockito.mockStatic(CamcorderProfile.class);
    when(CamcorderProfile.get(23, 15)).thenReturn(mock(CamcorderProfile.class));

    final ChannelRegistrar.LibraryImplementations libraryImplementations =
        new ChannelRegistrar.LibraryImplementations(mockTypeChannelMessenger, mockTextureRegistry);
    libraryImplementations.getHandlerCamcorderProfile().$get(mockTypeChannelMessenger, 23, 15);

    verifyStatic();
    CamcorderProfile.get(23, 15);
  }

  @Test
  public void hasProfile() {
    PowerMockito.mockStatic(CamcorderProfile.class);

    final ChannelRegistrar.LibraryImplementations libraryImplementations =
        new ChannelRegistrar.LibraryImplementations(mockTypeChannelMessenger, mockTextureRegistry);
    libraryImplementations.getHandlerCamcorderProfile().$hasProfile(mockTypeChannelMessenger, 23, 15);

    verifyStatic();
    CamcorderProfile.hasProfile(23, 15);
  }
}
