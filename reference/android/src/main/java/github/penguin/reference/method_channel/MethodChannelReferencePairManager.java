package github.penguin.reference.method_channel;

import androidx.annotation.NonNull;
import github.penguin.reference.reference.LocalReference;
import github.penguin.reference.reference.PoolableReferencePairManager;
import github.penguin.reference.reference.RemoteReference;
import github.penguin.reference.reference.UnpairedReference;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodCodec;
import io.flutter.plugin.common.StandardMethodCodec;
import java.util.List;

public abstract class MethodChannelReferencePairManager extends PoolableReferencePairManager
    implements MethodChannel.MethodCallHandler {
  static final String METHOD_CREATE = "REFERENCE_CREATE";
  static final String METHOD_METHOD = "REFERENCE_METHOD";
  static final String METHOD_DISPOSE = "REFERENCE_DISPOSE";

  public final MethodChannel channel;

  public final MethodCodec methodCodec;

  public final BinaryMessenger binaryMessenger;

  @SuppressWarnings("unused")
  public MethodChannelReferencePairManager(
      final List<Class<? extends LocalReference>> supportedClasses,
      final BinaryMessenger binaryMessenger,
      final String channelName) {
    this(supportedClasses, binaryMessenger, channelName, channelName, new ReferenceMessageCodec());
  }

  // TODO: problem with if null add my choice
  public MethodChannelReferencePairManager(
      final List<Class<? extends LocalReference>> supportedClasses,
      final BinaryMessenger binaryMessenger,
      final String channelName,
      final String poolId,
      final ReferenceMessageCodec messageCodec) {
    super(supportedClasses, poolId != null ? poolId : channelName);
    this.binaryMessenger = binaryMessenger;
    methodCodec = new StandardMethodCodec(messageCodec);
    this.channel = new MethodChannel(binaryMessenger, channelName, methodCodec);
  }

  @Override
  public abstract MethodChannelRemoteHandler getRemoteHandler();

  @Override
  public void initialize() {
    super.initialize();
    channel.setMethodCallHandler(this);
  }

  @SuppressWarnings("unchecked")
  @Override
  public void onMethodCall(
      @NonNull MethodCall call, @NonNull final MethodChannel.Result channelResult) {
    try {
      switch (call.method) {
        case METHOD_CREATE:
          {
            final List<Object> arguments = (List<Object>) call.arguments;
            pairWithNewLocalReference(
                (RemoteReference) arguments.get(0),
                (Integer) arguments.get(1),
                (List<Object>) arguments.get(2));
            channelResult.success(null);
            break;
          }
        case METHOD_METHOD:
          {
            final List<Object> arguments = (List<Object>) call.arguments;
            final Object result;
            if (arguments.get(0) instanceof UnpairedReference) {
              result = invokeLocalMethodOnUnpairedReference((UnpairedReference) arguments.get(0),
                  (String) arguments.get(1),
                  (List<Object>) arguments.get(2));
            } else if (arguments.get(0) instanceof RemoteReference) {
              result =
                  invokeLocalMethod(
                      getPairedLocalReference((RemoteReference) arguments.get(0)),
                      (String) arguments.get(1),
                      (List<Object>) arguments.get(2));
            } else {
              throw new IllegalArgumentException(arguments.toString());
            }
            channelResult.success(result);
            break;
          }
        case METHOD_DISPOSE:
          disposePairWithRemoteReference((RemoteReference) call.arguments);
          channelResult.success(null);
          break;
        default:
          channelResult.notImplemented();
      }
    } catch (Exception exception) {
      channelResult.error(
          exception.getClass().getName(),
          exception.getLocalizedMessage(),
          android.util.Log.getStackTraceString(exception));
    }
  }
}
