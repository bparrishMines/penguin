package github.penguin.reference.method_channel;

import androidx.annotation.Nullable;
import github.penguin.reference.reference.Completable;
import github.penguin.reference.reference.Completer;
import github.penguin.reference.reference.ReferencePairManager.RemoteReferenceCommunicationHandler;
import github.penguin.reference.reference.RemoteReference;
import github.penguin.reference.reference.UnpairedReference;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.StandardMethodCodec;
import java.util.ArrayList;
import java.util.List;

public abstract class MethodChannelRemoteHandler implements RemoteReferenceCommunicationHandler {
  public final MethodChannel channel;
  public final BinaryMessenger binaryMessenger;

  private static class RemoteHandlerResult<T> implements Result {
    private final Completer<T> completer;

    private RemoteHandlerResult(Completer<T> completer) {
      this.completer = completer;
    }

    @Override
    public void success(@Nullable Object result) {
      completer.complete((T) result);
    }

    @Override
    public void error(
        String errorCode,
        @Nullable String errorMessage,
        @Nullable Object errorDetails) {
      completer.completeWithError(
          new Throwable(String.format("%s: %s", errorCode, errorMessage)));
    }

    @Override
    public void notImplemented() {
      final String message =
          String.format(
              "Method `%s` returned as not implemented.",
              MethodChannelReferencePairManager.METHOD_CREATE);
      completer.completeWithError(new Throwable(message));
    }
  }

  @SuppressWarnings("unused")
  public MethodChannelRemoteHandler(BinaryMessenger binaryMessenger, String channelName) {
    this(binaryMessenger, channelName, new ReferenceMessageCodec());
  }

  public MethodChannelRemoteHandler(BinaryMessenger binaryMessenger,
                                    String channelName,
                                    ReferenceMessageCodec messageCodec) {
    this.binaryMessenger = binaryMessenger;
    this.channel = new MethodChannel(binaryMessenger, channelName, new StandardMethodCodec(messageCodec));
  }

  @Override
  public Completable<Void> create(
      final RemoteReference remoteReference,
      final int classId,
      final List<Object> arguments) {
    final Completer<Void> completer = new Completer<>();

    final List<Object> methodCallArgs = new ArrayList<>();
    methodCallArgs.add(remoteReference);
    methodCallArgs.add(classId);
    methodCallArgs.add(arguments);
    channel.invokeMethod(
        MethodChannelReferencePairManager.METHOD_CREATE,
        methodCallArgs,
        new RemoteHandlerResult<>(completer));

    return completer.completable;
  }

  @Override
  public Completable<Object> invokeMethod(
      final RemoteReference remoteReference,
      final String methodName,
      final List<Object> arguments) {
    final Completer<Object> completer = new Completer<>();

    final List<Object> methodCallArgs = new ArrayList<>();
    methodCallArgs.add(remoteReference);
    methodCallArgs.add(methodName);
    methodCallArgs.add(arguments);
    channel.invokeMethod(
        MethodChannelReferencePairManager.METHOD_METHOD,
        methodCallArgs,
        new RemoteHandlerResult<>(completer));

    return completer.completable;
  }

  @Override
  public Completable<Object> invokeMethodOnUnpairedReference(final UnpairedReference unpairedReference,
                                                             final String methodName,
                                                             final List<Object> arguments) {
    final Completer<Object> completer = new Completer<>();

    final List<Object> methodCallArgs = new ArrayList<>();
    methodCallArgs.add(unpairedReference);
    methodCallArgs.add(methodName);
    methodCallArgs.add(arguments);
    channel.invokeMethod(
        MethodChannelReferencePairManager.METHOD_METHOD,
        methodCallArgs,
        new RemoteHandlerResult<>(completer));

    return completer.completable;
  }

  @Override
  public Completable<Void> dispose(final RemoteReference remoteReference) {
    final Completer<Void> completer = new Completer<>();

    channel.invokeMethod(
        MethodChannelReferencePairManager.METHOD_DISPOSE,
        remoteReference,
        new RemoteHandlerResult<>(completer));

    return completer.completable;
  }
}
