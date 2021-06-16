package github.penguin.reference.method_channel;

import androidx.annotation.NonNull;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.io.Writer;
import java.util.List;

import github.penguin.reference.reference.PairedInstance;
import github.penguin.reference.reference.TypeChannelMessageDispatcher;
import github.penguin.reference.reference.TypeChannelMessenger;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodCodec;
import io.flutter.plugin.common.StandardMethodCodec;

public class MethodChannelMessenger extends TypeChannelMessenger {
  static final String METHOD_CREATE = "REFERENCE_CREATE";
  static final String METHOD_STATIC_METHOD = "REFERENCE_STATIC_METHOD";
  static final String METHOD_METHOD = "REFERENCE_METHOD";
  static final String METHOD_DISPOSE = "REFERENCE_DISPOSE";

  public final BinaryMessenger binaryMessenger;
  public final String channelName;
  public final MethodCodec methodCodec;
  public final MethodChannel channel;

  public MethodChannelMessenger(
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
                case METHOD_CREATE: {
                  final List<Object> arguments = (List<Object>) call.arguments;
                  onReceiveCreateNewInstancePair(
                      (String) arguments.get(0),
                      (PairedInstance) arguments.get(1),
                      (List<Object>) arguments.get(2),
                      (Boolean) arguments.get(3));
                  callResult.success(null);
                  break;
                }
                case METHOD_STATIC_METHOD: {
                  final List<Object> arguments = (List<Object>) call.arguments;
                  final Object result =
                      onReceiveInvokeStaticMethod(
                          (String) arguments.get(0),
                          (String) arguments.get(1),
                          (List<Object>) arguments.get(2));
                  callResult.success(result);
                  break;
                }
                case METHOD_METHOD: {
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
                case METHOD_DISPOSE: {
                  final List<Object> arguments = (List<Object>) call.arguments;
                  onReceiveDisposeInstancePair((PairedInstance) arguments.get(0));
                  callResult.success(null);
                  break;
                }
                default:
                  callResult.notImplemented();
              }
            } catch (Exception exception) {
              callResult.error(
                  exception.getClass().getName(),
                  exception.getLocalizedMessage(),
                  getStackTrace(exception));
            }
          }

          private String getStackTrace(Exception exception) {
            Writer result = new StringWriter();
            exception.printStackTrace(new PrintWriter(result));
            return result.toString();
          }
        });
  }

  @Override
  public TypeChannelMessageDispatcher getMessageDispatcher() {
    return new MethodChannelMessageDispatcher(binaryMessenger, channel);
  }
}
