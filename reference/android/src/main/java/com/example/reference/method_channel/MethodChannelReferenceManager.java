package com.example.reference.method_channel;

import android.os.Handler;
import android.os.Looper;
import androidx.annotation.NonNull;
import com.example.reference.reference.CompletableRunnable;
import com.example.reference.reference.Reference;
import com.example.reference.reference.ReferenceManager;
import java.util.ArrayList;
import static java.util.Arrays.asList;
import java.util.List;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.StandardMethodCodec;

public abstract class MethodChannelReferenceManager extends ReferenceManager implements
    ReferenceManager.LocalReferenceHandler {
  private static final String METHOD_CREATE = "REFERENCE_CREATE";
  private static final String METHOD_METHOD = "REFERENCE_METHOD";
  private static final String METHOD_DISPOSE = "REFERENCE_DISPOSE";

  private final MethodChannel channel;
  protected final Handler uiHandler = new Handler(Looper.getMainLooper());

  private static class MethodChannelRemoteReferenceHandler implements RemoteReferenceHandler {
    private final Handler handler;
    private final MethodChannel channel;

    private MethodChannelRemoteReferenceHandler(final MethodChannel channel, final Handler handler) {
      this.channel = channel;
      this.handler = handler;
    }

    @Override
    public void createRemoteReference(String referenceId, ReferenceHolder holder) {
      final List<Object> args = new ArrayList<>();
      args.add(referenceId);
      args.add(holder);
      channel.invokeMethod(METHOD_CREATE, args);
    }

    @Override
    public void disposeRemoteReference(String referenceId, ReferenceHolder holder) {
      channel.invokeMethod(METHOD_DISPOSE, new Reference(referenceId));
    }

    @Override
    public <T> CompletableRunnable<T> sendRemoteMethodCall(final Reference reference, final String methodName, final Object[] arguments) {
      final List<Object> argsForMethodCall = new ArrayList<>(arguments.length + 2);
      argsForMethodCall.add(reference);
      argsForMethodCall.add(methodName);
      argsForMethodCall.add(asList(arguments));

      final CompletableRunnable<T> completer = new CompletableRunnable<T>() {
        @Override
        public void run() {
          channel.invokeMethod(METHOD_METHOD, argsForMethodCall, new MethodChannel.Result() {
            @Override
            public void success(Object result) {
              complete((T) result);
            }

            @Override
            public void error(String errorCode, String errorMessage, Object errorDetails) {
              completeWithError(new Exception(String.format("%s: %s", errorCode, errorMessage)));
            }

            @Override
            public void notImplemented() {
              final String message = String.format("Method `%s` returned as not implemented.", methodName);
              completeWithError(new Exception(message));
            }
          });
        }
      };

      handler.post(completer);
      return completer;
    }
  }

  public MethodChannelReferenceManager(final BinaryMessenger binaryMessenger,
                                       final String channelName,
                                       final ReferenceMessageCodec messageCodec) {
    this.channel = new MethodChannel(binaryMessenger,
        channelName,
        new StandardMethodCodec(messageCodec));
  }

  @Override
  public LocalReferenceHandler getLocalReferenceHandler() {
    return this;
  }

  @Override
  public RemoteReferenceHandler getRemoteReferenceHandler() {
    return new MethodChannelRemoteReferenceHandler(channel, uiHandler);
  }

  @Override
  public void initialize() {
    channel.setMethodCallHandler(new MethodChannel.MethodCallHandler() {
      @Override
      public void onMethodCall(@NonNull MethodCall call, @NonNull final MethodChannel.Result channelResult) {
        switch(call.method) {
          case METHOD_CREATE: {
            final List<Object> arguments = (List<Object>) call.arguments;
            createAndAddLocalReference((String) arguments.get(0), arguments.get(1));
            channelResult.success(null);
            break;
          }
          case METHOD_METHOD:
            final List<Object> arguments = (List<Object>) call.arguments;
            receiveMethodCall((Reference) arguments.get(0),
                (String) arguments.get(1),
                ((List<Object>) arguments.get(2)).toArray())
                .setOnCompleteListener(new CompletableRunnable.OnCompleteListener() {
              @Override
              public void onComplete(Object result) {
                channelResult.success(result);
              }

              @Override
              public void onError(Throwable throwable) {
                channelResult.error(throwable.getClass().getSimpleName(), throwable.getLocalizedMessage(), null);
              }
            });
            break;
          case METHOD_DISPOSE:
            disposeLocalReference(((Reference) call.arguments).referenceId);
            channelResult.success(null);
            break;
        }
      }
    });
  }
}
