package github.penguin.reference.method_channel;

import androidx.annotation.NonNull;
import github.penguin.reference.reference.RemoteReference;
import github.penguin.reference.reference.ReferencePairManager;
import github.penguin.reference.reference.TypeReference;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodCodec;
import io.flutter.plugin.common.StandardMethodCodec;
import java.util.List;

public abstract class MethodChannelReferencePairManager extends ReferencePairManager implements MethodChannel.MethodCallHandler {
  static final String METHOD_CREATE = "REFERENCE_CREATE";
  static final String METHOD_METHOD = "REFERENCE_METHOD";
  static final String METHOD_DISPOSE = "REFERENCE_DISPOSE";

  public final BinaryMessenger binaryMessenger;
  public final String channelName;
  public final MethodCodec methodCodec;

  private final MethodChannelRemoteReferenceCommunicationHandler remoteHandler;
  private final LocalReferenceCommunicationHandler localHandler;

  public MethodChannelReferencePairManager(
      final BinaryMessenger binaryMessenger,
      final String channelName,
      final LocalReferenceCommunicationHandler localHandler,
      final MethodChannelRemoteReferenceCommunicationHandler remoteHandler) {
    this(binaryMessenger, channelName, localHandler, remoteHandler, new ReferenceMessageCodec());
  }

  public MethodChannelReferencePairManager(
      final BinaryMessenger binaryMessenger,
      final String channelName,
      final LocalReferenceCommunicationHandler localHandler,
      final MethodChannelRemoteReferenceCommunicationHandler remoteHandler,
      final ReferenceMessageCodec messageCodec) {
    this.binaryMessenger = binaryMessenger;
    this.channelName = channelName;
    this.remoteHandler = remoteHandler;
    this.localHandler = localHandler;
    this.methodCodec = new StandardMethodCodec(messageCodec);
  }

  @Override
  public void initialize() {
    super.initialize();
    getRemoteHandler().channel = new MethodChannel(binaryMessenger, channelName, methodCodec);
    getRemoteHandler().channel.setMethodCallHandler(this);
  }

  @SuppressWarnings("unchecked")
  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull final MethodChannel.Result channelResult) {
    try {
      switch (call.method) {
        case METHOD_CREATE: {
          final List<Object> arguments = (List<Object>) call.arguments;
          createLocalReferenceFor((RemoteReference) arguments.get(0),
              (TypeReference) arguments.get(1),
              (List<Object>) arguments.get(2)
          );
          channelResult.success(null);
          break;
        }
        case METHOD_METHOD: {
          final List<Object> arguments = (List<Object>) call.arguments;
          final Object result = executeLocalMethodFor(
              (RemoteReference) arguments.get(0),
              (String) arguments.get(1),
              (List<Object>) arguments.get(2));
          channelResult.success(result);
          break;
        }
        case METHOD_DISPOSE:
          disposeLocalReferenceFor((RemoteReference) call.arguments);
          channelResult.success(null);
          break;
        default:
          channelResult.notImplemented();
      }
    } catch (Exception exception) {
      channelResult.error(exception.getClass().getName(),
          exception.getLocalizedMessage(),
          android.util.Log.getStackTraceString(exception));
    }
  }

  public MethodChannel getChannel() {
    return getRemoteHandler().channel;
  }

  @Override
  public MethodChannelRemoteReferenceCommunicationHandler getRemoteHandler() {
    return remoteHandler;
  }

  @Override
  public LocalReferenceCommunicationHandler getLocalHandler() {
    return localHandler;
  }
}

