package github.penguin.reference.method_channel;

import androidx.annotation.NonNull;
import github.penguin.reference.reference.PairedInstance;
import github.penguin.reference.reference.TypeChannelManager;
import github.penguin.reference.reference.TypeChannelMessenger;
import github.penguin.reference.reference.NewUnpairedInstance;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodCodec;
import io.flutter.plugin.common.StandardMethodCodec;
import java.util.List;

public class MethodChannelManager extends TypeChannelManager {
  static final String METHOD_CREATE = "REFERENCE_CREATE";
  static final String METHOD_STATIC_METHOD = "REFERENCE_STATIC_METHOD";
  static final String METHOD_METHOD = "REFERENCE_METHOD";
  static final String METHOD_UNPAIRED_METHOD = "REFERENCE_UNPAIRED_METHOD";
  static final String METHOD_DISPOSE = "REFERENCE_DISPOSE";

  public final BinaryMessenger binaryMessenger;
  public final String channelName;
  public final MethodCodec methodCodec;
  public final MethodChannel channel;

  public MethodChannelManager(
      final BinaryMessenger binaryMessenger, final String channelName) {
    this.binaryMessenger = binaryMessenger;
    this.channelName = channelName;
    methodCodec = new StandardMethodCodec(new ReferenceMessageCodec());
    channel = new MethodChannel(binaryMessenger, channelName, methodCodec);
    channel.setMethodCallHandler(
        new MethodChannel.MethodCallHandler() {
          @Override
          public void onMethodCall(
              @NonNull MethodCall call, @NonNull MethodChannel.Result callResult) {
            try {
              switch (call.method) {
                case METHOD_CREATE:
                  {
                    final List<Object> arguments = (List<Object>) call.arguments;
                    onReceiveCreateNewInstancePair(
                        (String) arguments.get(0),
                        (PairedInstance) arguments.get(1),
                        (List<Object>) arguments.get(2));
                    callResult.success(null);
                    break;
                  }
                case METHOD_STATIC_METHOD:
                  {
                    final List<Object> arguments = (List<Object>) call.arguments;
                    final Object result =
                        onReceiveInvokeStaticMethod(
                            (String) arguments.get(0),
                            (String) arguments.get(1),
                            (List<Object>) arguments.get(2));
                    callResult.success(result);
                    break;
                  }
                case METHOD_METHOD:
                  {
                    final List<Object> arguments = (List<Object>) call.arguments;
                    final Object result =
                        onReceiveInvokeMethod(
                            (String) arguments.get(0),
                            (PairedInstance) arguments.get(1),
                            (String) arguments.get(2),
                            (List<Object>) arguments.get(3));
                    callResult.success(result);
                    break;
                  }
                case METHOD_UNPAIRED_METHOD:
                  {
                    final List<Object> arguments = (List<Object>) call.arguments;
                    final Object result =
                        onReceiveInvokeMethodOnUnpairedReference(
                            (NewUnpairedInstance) arguments.get(0),
                            (String) arguments.get(1),
                            (List<Object>) arguments.get(2));
                    callResult.success(result);
                    break;
                  }
                case METHOD_DISPOSE:
                  final List<Object> arguments = (List<Object>) call.arguments;
                  onReceiveDisposePair(
                      (String) arguments.get(0), (PairedInstance) arguments.get(1));
                  callResult.success(null);
                  break;
                default:
                  callResult.notImplemented();
              }
            } catch (Exception exception) {
              callResult.error(
                  exception.getClass().getName(),
                  exception.getLocalizedMessage(),
                  android.util.Log.getStackTraceString(exception));
            }
          }
        });
  }

  @Override
  public TypeChannelMessenger getMessenger() {
    return new MethodChannelMessenger(binaryMessenger, channel);
  }
}
