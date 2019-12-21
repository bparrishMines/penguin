package plugins.penguin.penguin_plugin;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public abstract class PenguinMethodCallHandler implements MethodChannel.MethodCallHandler {
  public final WrapperManager wrapperManager;

  public PenguinMethodCallHandler(WrapperManager wrapperManager) {
    this.wrapperManager = wrapperManager;
  }

  @Override
  public void onMethodCall(MethodCall call, MethodChannel.Result result) {
    try {
      final Object value = onMethodCall(call);
      result.success(value);
    } catch (Exception exception) {
      result.error(exception.getClass().getSimpleName(), exception.getMessage(), android.util.Log.getStackTraceString(exception));
    } finally {
      wrapperManager.clearTemporaryWrappers();
    }
  }

  public abstract Object onMethodCall(MethodCall call) throws Exception;
}
