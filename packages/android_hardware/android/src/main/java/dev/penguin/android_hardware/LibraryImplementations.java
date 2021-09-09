package dev.penguin.android_hardware;

import github.penguin.reference.reference.TypeChannelMessenger;
import io.flutter.view.TextureRegistry;

public class LibraryImplementations extends CameraChannelLibrary.$LibraryImplementations {
  public final TextureRegistry textureRegistry;

  public LibraryImplementations(TypeChannelMessenger messenger, TextureRegistry textureRegistry) {
    super(messenger);
    this.textureRegistry = textureRegistry;
    this.channelArea = new AreaChannel(this);
    this.handlerArea = new AreaHandler(this);
    this.handlerAutoFocusCallback = new AutoFocusCallbackHandler(this);
    this.handlerAutoFocusMoveCallback = new AutoFocusMoveCallbackHandler(this);
    this.handlerCameraInfoProxy = new CameraInfoProxyHandler(this);
    this.handlerCameraProxy = new CameraProxyHandler(this);
    this.handlerErrorCallback = new ErrorCallbackHandler(this);
    this.handlerImageFormat = new ImageFormatHandler(this);
    this.handlerOnZoomChangeListener = new OnZoomChangeListenerHandler(this);
    this.handlerParameters = new ParametersHandler(this);
    this.handlerPictureCallback = new PictureCallbackHandler(this);
    this.handlerPreviewCallback = new PreviewCallbackHandler(this);
    this.handlerRect = new RectHandler(this);
    this.handlerShutterCallback = new ShutterCallbackHandler(this);
  }
}
