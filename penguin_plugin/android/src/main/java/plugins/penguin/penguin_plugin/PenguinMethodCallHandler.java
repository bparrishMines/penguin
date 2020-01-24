package plugins.penguin.penguin_plugin;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public abstract class PenguinMethodCallHandler implements MethodCallHandler {
  @Override
  public void onMethodCall(MethodCall call, Result result) {
    final Object value;
    try {
      value = onMethodCall(call);
    } catch (Exception exception) {
      result.error(exception.getClass().getSimpleName(), exception.getMessage(), android.util.Log.getStackTraceString(exception));
      return;
    }

    if (value instanceof Wrapper) {
      result.success(((Wrapper) value).$uniqueId);
    } else {
      result.success(value);
    }
  }

  public abstract Object onMethodCall(MethodCall call) throws Exception;
}
