package bparrishMines.penguin.penguin_camera.camerax;

import android.content.Context;

import com.google.common.util.concurrent.ListenableFuture;

import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnit;
import org.mockito.junit.MockitoRule;
import org.powermock.api.mockito.PowerMockito;
import org.powermock.core.classloader.annotations.PrepareForTest;
import org.powermock.modules.junit4.PowerMockRunner;

import androidx.camera.lifecycle.ProcessCameraProvider;
import androidx.lifecycle.LifecycleOwner;
import github.penguin.reference.async.Completer;
import github.penguin.reference.reference.PairedInstance;
import github.penguin.reference.reference.TypeChannelMessageDispatcher;
import github.penguin.reference.reference.TypeChannelMessenger;

import static org.mockito.Matchers.any;
import static org.mockito.Matchers.anyList;
import static org.mockito.Matchers.anyString;
import static org.mockito.Matchers.eq;
import static org.mockito.Matchers.isNotNull;
import static org.mockito.Mockito.verify;
import static org.powermock.api.mockito.PowerMockito.mock;
import static org.powermock.api.mockito.PowerMockito.spy;
import static org.powermock.api.mockito.PowerMockito.verifyStatic;
import static org.powermock.api.mockito.PowerMockito.when;

@RunWith(PowerMockRunner.class)
@PrepareForTest( {ProcessCameraProvider.class, androidx.camera.core.CameraSelector.class})
public class ProcessCameraProviderTest {
  @Rule
  public MockitoRule mockitoRule = MockitoJUnit.rule();

  @Mock
  Context mockContext;

  @Mock
  ProcessCameraProvider mockProvider;

  @Mock
  LifecycleOwner mockLifecycleOwner;

  TypeChannelMessenger testManager;

  @Before
  public void setUp() {
    final TypeChannelMessageDispatcher mockMessenger = mock(TypeChannelMessageDispatcher.class);
    when(mockMessenger.sendCreateNewInstancePair(anyString(), any(PairedInstance.class), anyList())).thenReturn(new Completer<Void>().complete(null).completable);
    testManager = new TypeChannelMessenger() {
      @Override
      public TypeChannelMessageDispatcher getMessageDispatcher() {
        return mockMessenger;
      }
    };
    final CameraXChannelLibrary.$CameraChannel testChannel = new CameraXChannelLibrary.$CameraChannel(testManager);
    testChannel.setHandler(new CameraXChannelLibrary.$CameraHandler());
  }

  @Test
  public void initialize() {
    PowerMockito.mockStatic(ProcessCameraProvider.class);

    when(ProcessCameraProvider.getInstance(mockContext)).thenReturn(mock(ListenableFuture.class));

    final bparrishMines.penguin.penguin_camera.camerax.ProcessCameraProvider mockProvider = mock(bparrishMines.penguin.penguin_camera.camerax.ProcessCameraProvider.class);
    bparrishMines.penguin.penguin_camera.camerax.ProcessCameraProvider.initialize(mockContext,
        mockProvider,
        null);

    verifyStatic();
    ProcessCameraProvider.getInstance(mockContext);
  }

  @Test
  public void bindToLifecycle() {
    final bparrishMines.penguin.penguin_camera.camerax.ProcessCameraProvider provider =
        new bparrishMines.penguin.penguin_camera.camerax.ProcessCameraProvider(testManager, mockLifecycleOwner);

    final bparrishMines.penguin.penguin_camera.camerax.ProcessCameraProvider spyProvider = spy(provider);

    final CameraSelector mockCameraSelector = mock(CameraSelector.class);
    when(mockCameraSelector.getCameraSelector()).thenReturn(mock(androidx.camera.core.CameraSelector.class));

    final UseCase mockUseCase = mock(UseCase.class);
    when(mockUseCase.getUseCase()).thenReturn(mock(androidx.camera.core.UseCase.class));

    when(spyProvider.getProvider()).thenReturn(mockProvider);
    spyProvider.bindToLifecycle(mockCameraSelector, mockUseCase);

    verify(mockProvider).bindToLifecycle(eq(mockLifecycleOwner), isNotNull(androidx.camera.core.CameraSelector.class), isNotNull(androidx.camera.core.UseCase.class));
  }

  @Test
  public void unbindAll() {
    final bparrishMines.penguin.penguin_camera.camerax.ProcessCameraProvider provider =
        new bparrishMines.penguin.penguin_camera.camerax.ProcessCameraProvider(testManager, mockLifecycleOwner);

    final bparrishMines.penguin.penguin_camera.camerax.ProcessCameraProvider spyProvider = spy(provider);
    when(spyProvider.getProvider()).thenReturn(mockProvider);
    spyProvider.unbindAll();

    verify(mockProvider).unbindAll();
  }
}
