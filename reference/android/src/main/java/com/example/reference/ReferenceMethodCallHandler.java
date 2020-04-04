package com.example.reference;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class ReferenceMethodCallHandler implements MethodCallHandler {
  public static final String METHOD_RETAIN = "REFERENCE_RETAIN";
  public static final String METHOD_METHODCALL = "REFERENCE_METHODCALL";
  public static final String METHOD_RELEASE = "REFERENCE_RELEASE";

  public final ReferenceManager referenceManager;
  public final ReferenceFactory referenceFactory;

  public ReferenceMethodCallHandler(final ReferenceManager referenceManager,
                                    final ReferenceFactory referenceFactory) {
    this.referenceManager = referenceManager;
    this.referenceFactory = referenceFactory;
  }

  @Override
  public void onMethodCall(final MethodCall call, final Result result) {
    try {
      switch (call.method) {
        case METHOD_RETAIN:
          handleRetain(call);
          result.success(null);
          break;
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
  
  private void handleRetain(final MethodCall call) {
    final Reference reference = referenceFactory.createReference(call.arguments);
    if (!referenceManager.addReference(reference)) {
      final String message = String.format("%s with the following referenceId already exists: %s",
          reference.getClass().getSimpleName(),
          reference.referenceId);
      throw new IllegalArgumentException(message);
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

    for (int i = 0; i < methodArguments.size(); i++) {
      final Object object = methodArguments.get(i);
      if (!(object instanceof Reference)) continue;

      final Reference reference = referenceManager.getReference(((Reference) object).referenceId);
      if (reference != null) methodArguments.set(i, reference);
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
