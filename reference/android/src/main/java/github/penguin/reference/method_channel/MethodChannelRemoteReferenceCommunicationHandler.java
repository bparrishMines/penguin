package github.penguin.reference.method_channel;

import androidx.annotation.Nullable;
import github.penguin.reference.reference.CompletableRunnable;
import github.penguin.reference.reference.ReferencePairManager;
import github.penguin.reference.reference.RemoteReference;
import github.penguin.reference.reference.TypeReference;
import io.flutter.plugin.common.MethodChannel;
import java.util.ArrayList;
import java.util.List;

public abstract class MethodChannelRemoteReferenceCommunicationHandler
    implements ReferencePairManager.RemoteReferenceCommunicationHandler {
  // Null until MethodChannelReferencePairManager.initialize is called.
  MethodChannel channel;

  @Override
  public CompletableRunnable<Void> createRemoteReference(
      final RemoteReference remoteReference,
      final TypeReference typeReference,
      final List<Object> arguments) {
    final CompletableRunnable<Void> completer =
        new CompletableRunnable<Void>() {
          @Override
          public void run() {
            final List<Object> methodCallArgs = new ArrayList<>();
            methodCallArgs.add(remoteReference);
            methodCallArgs.add(typeReference);
            methodCallArgs.add(arguments);
            channel.invokeMethod(
                MethodChannelReferencePairManager.METHOD_CREATE,
                methodCallArgs,
                new MethodChannel.Result() {
                  @Override
                  public void success(@Nullable Object result) {
                    complete(null);
                  }

                  @Override
                  public void error(
                      String errorCode,
                      @Nullable String errorMessage,
                      @Nullable Object errorDetails) {
                    completeWithError(
                        new Throwable(String.format("%s: %s", errorCode, errorMessage)));
                  }

                  @Override
                  public void notImplemented() {
                    final String message =
                        String.format(
                            "Method `%s` returned as not implemented.",
                            MethodChannelReferencePairManager.METHOD_CREATE);
                    completeWithError(new Throwable(message));
                  }
                });
          }
        };

    completer.run();
    return completer;
  }

  @Override
  public CompletableRunnable<Object> executeRemoteMethod(
      final RemoteReference remoteReference,
      final String methodName,
      final List<Object> arguments) {
    final CompletableRunnable<Object> completer =
        new CompletableRunnable<Object>() {
          @Override
          public void run() {
            final List<Object> methodCallArgs = new ArrayList<>();
            methodCallArgs.add(remoteReference);
            methodCallArgs.add(methodName);
            methodCallArgs.add(arguments);
            channel.invokeMethod(
                MethodChannelReferencePairManager.METHOD_METHOD,
                methodCallArgs,
                new MethodChannel.Result() {
                  @Override
                  public void success(@Nullable Object result) {
                    complete(result);
                  }

                  @Override
                  public void error(
                      String errorCode,
                      @Nullable String errorMessage,
                      @Nullable Object errorDetails) {
                    completeWithError(
                        new Throwable(String.format("%s: %s", errorCode, errorMessage)));
                  }

                  @Override
                  public void notImplemented() {
                    final String message =
                        String.format("Method `%s` returned as not implemented.", methodName);
                    completeWithError(new Throwable(message));
                  }
                });
          }
        };

    completer.run();
    return completer;
  }

  @Override
  public CompletableRunnable<Void> disposeRemoteReference(final RemoteReference remoteReference) {
    final CompletableRunnable<Void> completer =
        new CompletableRunnable<Void>() {
          @Override
          public void run() {
            channel.invokeMethod(
                MethodChannelReferencePairManager.METHOD_DISPOSE,
                remoteReference,
                new MethodChannel.Result() {
                  @Override
                  public void success(@Nullable Object result) {
                    complete(null);
                  }

                  @Override
                  public void error(
                      String errorCode,
                      @Nullable String errorMessage,
                      @Nullable Object errorDetails) {
                    completeWithError(
                        new Throwable(String.format("%s: %s", errorCode, errorMessage)));
                  }

                  @Override
                  public void notImplemented() {
                    final String message =
                        String.format(
                            "Method `%s` returned as not implemented.",
                            MethodChannelReferencePairManager.METHOD_DISPOSE);
                    completeWithError(new Throwable(message));
                  }
                });
          }
        };

    completer.run();
    return completer;
  }
}
