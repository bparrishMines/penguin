package com.example.reference;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public abstract class ReferenceMethodCallHandler implements MethodCallHandler {
  public static final String METHOD_RETAIN = "REFERENCE_RETAIN";
  public static final String METHOD_METHODCALL = "REFERENCE_METHODCALL";
  public static final String METHOD_RELEASE = "REFERENCE_RELEASE";

  public final ReferenceManager referenceManager;

  public ReferenceMethodCallHandler(ReferenceManager referenceManager) {
    this.referenceManager = referenceManager;
  }

  @Override
  public void onMethodCall(final MethodCall call, final Result result) {
    try {
      switch (call.method) {
        case METHOD_METHODCALL:
          result.success(handleMethodCall(call));
          break;
        case METHOD_RELEASE:
          handleRelease(call);
          result.success(null);
          break;
        default:
          result.notImplemented();
      }
    } catch (Exception exception) {
      result.error(exception.getClass().getSimpleName(), exception.getMessage(), android.util.Log.getStackTraceString(exception));
    }
  }

  private Object handleMethodCall(final MethodCall call) throws Exception {
    final List<Object> arguments = (List<Object>) call.arguments;

    final String referenceId = (String) arguments.get(0);
    final Object caller = referenceManager.getReference(referenceId);
    if (caller == null) throw new ReferenceNotFoundException(referenceId);

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

  private void handleRelease(final MethodCall call) {
    referenceManager.removeReference((String) call.arguments);
  }

  private Class[] getClasses(final List<Object> arguments) {
    final Class[] classes = new Class[arguments.size()];
    for (int i = 0; i < arguments.size(); i++) {
      classes[i] = arguments.get(i).getClass();
    }
    return classes;
  }
}
