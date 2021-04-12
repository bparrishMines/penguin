package github.penguin.reference.method_channel;

import androidx.annotation.Nullable;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import github.penguin.reference.async.Completable;
import github.penguin.reference.async.Completer;
import github.penguin.reference.reference.PairedInstance;
import github.penguin.reference.reference.TypeChannelMessageDispatcher;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.Result;

public class MethodChannelMessageDispatcher implements TypeChannelMessageDispatcher {
  public final BinaryMessenger binaryMessenger;
  public final MethodChannel channel;

  public MethodChannelMessageDispatcher(
      BinaryMessenger binaryMessenger, MethodChannel channel) {
    this.binaryMessenger = binaryMessenger;
    this.channel = channel;
  }

  @Override
  public Completable<Void> sendCreateNewInstancePair(
      String channelName, PairedInstance pairedInstance, List<Object> arguments, boolean owner) {
    final Completer<Void> completer = new Completer<>();
    final String method = MethodChannelMessenger.METHOD_CREATE;

    channel.invokeMethod(
        method,
        Arrays.asList(channelName, pairedInstance, arguments, owner),
        new MethodChannelMessengerResult<>(completer, method));

    return completer.completable;
  }

  @Override
  public Completable<Object> sendInvokeStaticMethod(
      String channelName, String methodName, List<Object> arguments) {
    final Completer<Object> completer = new Completer<>();
    final String method = MethodChannelMessenger.METHOD_STATIC_METHOD;

    channel.invokeMethod(
        method,
        Arrays.asList(channelName, methodName, arguments),
        new MethodChannelMessengerResult<>(completer, method));

    return completer.completable;
  }

  @Override
  public Completable<Object> sendInvokeMethod(
      String channelName,
      PairedInstance pairedInstance,
      String methodName,
      List<Object> arguments) {
    final Completer<Object> completer = new Completer<>();
    final String method = MethodChannelMessenger.METHOD_METHOD;

    channel.invokeMethod(
        method,
        Arrays.asList(channelName, pairedInstance, methodName, arguments),
        new MethodChannelMessengerResult<>(completer, method));

    return completer.completable;
  }

  @Override
  public Completable<Void> sendDisposeInstancePair(PairedInstance pairedInstance) {
    final Completer<Void> completer = new Completer<>();
    final String method = MethodChannelMessenger.METHOD_DISPOSE;

    channel.invokeMethod(
        method,
        Collections.singletonList(pairedInstance),
        new MethodChannelMessengerResult<>(completer, method));

    return completer.completable;
  }

  private static class MethodChannelMessengerResult<T> implements Result {
    private final Completer<T> completer;
    private final String method;

    private MethodChannelMessengerResult(Completer<T> completer, String method) {
      this.completer = completer;
      this.method = method;
    }

    @SuppressWarnings("unchecked")
    @Override
    public void success(@Nullable Object result) {
      completer.complete((T) result);
    }

    @Override
    public void error(
        String errorCode, @Nullable String errorMessage, @Nullable Object errorDetails) {
      completer.completeWithError(new Throwable(String.format("%s: %s", errorCode, errorMessage)));
    }

    @Override
    public void notImplemented() {
      final String message = String.format("Method `%s` returned as not implemented.", method);
      completer.completeWithError(new Throwable(message));
    }
  }
}
