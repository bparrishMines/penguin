package plugins.penguin.penguin_plugin;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public abstract class PenguinMethodCallHandler implements MethodCallHandler {
  @Override
  public void onMethodCall(final MethodCall call, final Result result) {
    switch(call.method) {
      case "METHODCALL":
        final Object value;
        try {
          value = onMethodCall(call);
        } catch (Exception exception) {
          result.error(exception.getClass().getSimpleName(), exception.getMessage(), android.util.Log.getStackTraceString(exception));
          break;
        }
        result.success(value);
        break;
      case "DESTROY":
        handleDestroy(call);
        result.success(null);
        break;
      default:
        result.notImplemented();
    }
  }

  private Object onMethodCall(final MethodCall call) throws Exception {
    final List<Object> arguments = (List<Object>) call.arguments;

    final String referenceId = ((MethodChannelReferenceHolder) arguments.get(0)).referenceId;
    final ReferenceHolderManager manager = ReferenceHolderManager.getGlobalInstance();
    final Object caller = manager.getReferenceHolder(referenceId);

    final List<Object> methodArguments;
    if (arguments.size() > 2) {
      methodArguments = arguments.subList(2, arguments.size());
    } else {
      methodArguments = new ArrayList<>();
    }

    final String methodName = (String) arguments.get(1);
    final Method method = caller.getClass().getMethod(methodName, getClasses(methodArguments));
    return method.invoke(caller, methodArguments.toArray());
  }

  private void handleDestroy(final MethodCall call) {
    final List<Object> arguments = (List<Object>) call.arguments;
    final String referenceId = ((MethodChannelReferenceHolder) arguments.get(0)).referenceId;
    final ReferenceHolderManager manager = ReferenceHolderManager.getGlobalInstance();

    manager.removeReferenceHolder(referenceId);
  }

  private Class[] getClasses(final List<Object> arguments) {
    final Class[] classes = new Class[arguments.size()];
    for (int i = 0; i < arguments.size(); i++) {
      classes[i] = arguments.get(i).getClass();
    }
    return classes;
  }
}
