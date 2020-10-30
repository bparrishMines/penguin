package github.penguin.reference.method_channel;

import androidx.annotation.Nullable;
import github.penguin.reference.async.Completable;
import github.penguin.reference.async.Completer;
import github.penguin.reference.reference.ReferenceChannelMessenger;
import github.penguin.reference.reference.RemoteReference;
import github.penguin.reference.reference.UnpairedReference;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.Result;
import java.util.Arrays;
import java.util.List;

public class MethodChannelReferenceChannelMessenger implements ReferenceChannelMessenger {
  public final BinaryMessenger binaryMessenger;
  public final MethodChannel channel;

  private static class RemoteHandlerResult<T> implements Result {
    private final Completer<T> completer;
    private final String method;

    private RemoteHandlerResult(Completer<T> completer, String method) {
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

  @SuppressWarnings("unused")
  public MethodChannelReferenceChannelMessenger(
      BinaryMessenger binaryMessenger, MethodChannel channel) {
    this.binaryMessenger = binaryMessenger;
    this.channel = channel;
  }

  @Override
  public Completable<Void> sendCreateNewPair(
      String handlerChannel, RemoteReference remoteReference, List<Object> arguments) {
    final Completer<Void> completer = new Completer<>();
    final String method = MethodChannelReferenceChannelManager.METHOD_CREATE;

    channel.invokeMethod(
        method,
        Arrays.asList(handlerChannel, remoteReference, arguments),
        new RemoteHandlerResult<>(completer, method));

    return completer.completable;
  }

  @Override
  public Completable<Object> sendInvokeStaticMethod(
      String handlerChannel, String methodName, List<Object> arguments) {
    final Completer<Object> completer = new Completer<>();
    final String method = MethodChannelReferenceChannelManager.METHOD_STATIC_METHOD;

    channel.invokeMethod(
        method,
        Arrays.asList(handlerChannel, methodName, arguments),
        new RemoteHandlerResult<>(completer, method));

    return completer.completable;
  }

  @Override
  public Completable<Object> sendInvokeMethod(
      String handlerChannel,
      RemoteReference remoteReference,
      String methodName,
      List<Object> arguments) {
    final Completer<Object> completer = new Completer<>();
    final String method = MethodChannelReferenceChannelManager.METHOD_METHOD;

    channel.invokeMethod(
        method,
        Arrays.asList(handlerChannel, remoteReference, methodName, arguments),
        new RemoteHandlerResult<>(completer, method));

    return completer.completable;
  }

  @Override
  public Completable<Object> sendInvokeMethodOnUnpairedReference(
      UnpairedReference unpairedReference, String methodName, List<Object> arguments) {
    final Completer<Object> completer = new Completer<>();
    final String method = MethodChannelReferenceChannelManager.METHOD_UNPAIRED_METHOD;

    channel.invokeMethod(
        method,
        Arrays.asList(unpairedReference, methodName, arguments),
        new RemoteHandlerResult<>(completer, method));

    return completer.completable;
  }

  @Override
  public Completable<Void> sendDisposePair(String handlerChannel, RemoteReference remoteReference) {
    final Completer<Void> completer = new Completer<>();
    final String method = MethodChannelReferenceChannelManager.METHOD_DISPOSE;

    channel.invokeMethod(
        method,
        Arrays.asList(handlerChannel, remoteReference),
        new RemoteHandlerResult<>(completer, method));

    return completer.completable;
  }
}
