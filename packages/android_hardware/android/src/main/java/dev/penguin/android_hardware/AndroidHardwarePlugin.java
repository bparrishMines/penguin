package dev.penguin.android_hardware;

import androidx.annotation.NonNull;

import github.penguin.reference.ReferencePlugin;
import github.penguin.reference.reference.TypeChannelMessenger;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.view.TextureRegistry;
import dev.penguin.android_hardware.CameraChannelLibrary.$ChannelRegistrar;

/** AndroidHardwarePlugin */
public class AndroidHardwarePlugin implements FlutterPlugin {
  private $ChannelRegistrar channelRegistrar;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    final BinaryMessenger binaryMessenger = flutterPluginBinding.getBinaryMessenger();
    final TypeChannelMessenger messenger = ReferencePlugin.getMessengerInstance(binaryMessenger);

    final TextureRegistry textureRegistry = flutterPluginBinding.getTextureRegistry();
    final LibraryImplementations implementations = new LibraryImplementations(messenger, textureRegistry);
    channelRegistrar = new $ChannelRegistrar(implementations);
    channelRegistrar.implementations.channelArea = new AreaChannel(implementations);
    channelRegistrar.implementations.handlerArea = new AreaHandler(implementations);
    channelRegistrar.implementations.handlerAutoFocusCallback = new AutoFocusCallbackHandler(implementations);
    channelRegistrar.implementations.handlerAutoFocusMoveCallback = new AutoFocusMoveCallbackHandler(implementations);
    channelRegistrar.implementations.handlerCameraInfoProxy = new CameraInfoProxyHandler(implementations);
    channelRegistrar.implementations.handlerCameraProxy = new CameraProxyHandler(implementations);
    channelRegistrar.implementations.handlerErrorCallback = new ErrorCallbackHandler(implementations);
    channelRegistrar.implementations.handlerImageFormat = new ImageFormatHandler(implementations);
    channelRegistrar.implementations.handlerOnZoomChangeListener = new OnZoomChangeListenerHandler(implementations);
    channelRegistrar.implementations.handlerParameters = new ParametersHandler(implementations);
    channelRegistrar.implementations.handlerPictureCallback = new PictureCallbackHandler(implementations);
    channelRegistrar.implementations.handlerPreviewCallback = new PreviewCallbackHandler(implementations);
    channelRegistrar.implementations.handlerRect = new RectHandler(implementations);
    channelRegistrar.implementations.handlerShutterCallback = new ShutterCallbackHandler(implementations);

    channelRegistrar.registerHandlers();
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channelRegistrar.unregisterHandlers();
    channelRegistrar = null;
  }

  public $ChannelRegistrar getChannelRegistrar() {
    return channelRegistrar;
  }
}
