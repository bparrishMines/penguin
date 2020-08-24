package com.example.reference_example_example;

import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import com.example.reference_example.ReferenceExamplePlugin;

import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.TestRule;
import org.junit.runner.Description;
import org.junit.runner.RunWith;
import org.junit.runner.Runner;
import org.junit.runner.notification.Failure;
import org.junit.runner.notification.RunNotifier;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeUnit;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.test.rule.ActivityTestRule;
import dev.flutter.plugins.e2e.E2EPlugin;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MyRunner extends Runner {
//  final Class<?> testClass;
//  ActivityTestRule rule = null;
//
//  public MyRunner(Class<?> testClass) {
//    super();
//    this.testClass = testClass;
//
//    // Look for an `ActivityTestRule` annotated `@Rule` and invoke `launchActivity()`
//    Field[] fields = testClass.getDeclaredFields();
//    System.out.println("SOMEFIELD?");
//    for (Field field : fields) {
//      System.out.println("AFIELD");
//      if (field.isAnnotationPresent(Rule.class)) {
//        try {
//          Object instance = testClass.newInstance();
//          if (field.get(instance) instanceof ActivityTestRule) {
//            rule = (ActivityTestRule) field.get(instance);
//            break;
//          }
//        } catch (InstantiationException | IllegalAccessException e) {
//          // This might occur if the developer did not make the rule public.
//          // We could call field.setAccessible(true) but it seems better to throw.
//          throw new RuntimeException("Unable to access activity rule", e);
//        }
//      }
//    }
//  }
//
//  @Override
//  public Description getDescription() {
//    return Description.createTestDescription(testClass, "Flutter Tests");
//  }
//
//  @Override
//  public void run(RunNotifier notifier) {
//    if (rule == null) {
//      throw new RuntimeException("EFOWJIE" + testClass.getName());
//    }
//    rule.launchActivity(null);
//
//    final MainActivity activity = (MainActivity) rule.getActivity();
//
//    System.out.println("running the tests from MyRunner: " + testClass);
//    try {
//      Looper.prepare();
//      Object testObject = testClass.newInstance();
//      for (Method method : testClass.getMethods()) {
//        if (method.isAnnotationPresent(Test.class)) {
//          notifier.fireTestStarted(Description
//              .createTestDescription(testClass, method.getName()));
//          method.invoke(testObject);
//          notifier.fireTestFinished(Description
//              .createTestDescription(testClass, method.getName()));
//        }
//      }
//    } catch (Exception e) {
//      throw new RuntimeException(e);
//    }
//
//    try {
//      TimeUnit.SECONDS.sleep(10);
//    } catch (InterruptedException e) {
//      throw new RuntimeException(e);
//    }
//
//    if (true) throw new RuntimeException(ReferenceExamplePlugin.testValue);
//
//    rule.finishActivity();
//  }
private static final String TAG = "MYRUNNER";
  final Class<?> testClass;
  ActivityTestRule<?> rule = null;
  Object testObjectInstance;

  public MyRunner(Class<?> testClass) {
    super();
    this.testClass = testClass;

    // Look for an `ActivityTestRule` annotated `@Rule` and invoke `launchActivity()`
    Field[] fields = testClass.getDeclaredFields();
    for (Field field : fields) {
      if (field.isAnnotationPresent(Rule.class)) {
        try {
          testObjectInstance = testClass.newInstance();
          if (field.get(testObjectInstance) instanceof ActivityTestRule) {
            rule = (ActivityTestRule<?>) field.get(testObjectInstance);
            break;
          }
        } catch (InstantiationException | IllegalAccessException e) {
          // This might occur if the developer did not make the rule public.
          // We could call field.setAccessible(true) but it seems better to throw.
          throw new RuntimeException("Unable to access activity rule", e);
        }
      }
    }
  }

  @Override
  public Description getDescription() {
    return Description.createTestDescription(testClass, "Flutter Tests");
  }

  @Override
  public void run(RunNotifier notifier) {
    if (rule == null) {
      throw new RuntimeException("Unable to run tests due to missing activity rule");
    }
    try {
      rule.launchActivity(null);
    } catch (RuntimeException e) {
      Log.v(TAG, "launchActivity failed, possibly because the activity was already running. " + e);
      Log.v(
          TAG,
          "Try disabling auto-launch of the activity, e.g. ActivityTestRule<>(MainActivity.class, true, false);");
    }

    final MainActivity activity = (MainActivity) rule.getActivity();

    final BinaryMessenger messenger = activity.getBinaryMessenger();
    ((MainActivityTest) testObjectInstance).init(messenger);
    final MethodChannel testChannel = new MethodChannel(messenger, "test_channel");
    testChannel.setMethodCallHandler(new MethodChannel.MethodCallHandler() {
      @Override
      public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        if (!call.method.equals("verify")) {
          result.notImplemented();
          return;
        }

        final Method method;
        try {
          method = testClass.getMethod((String) call.arguments);
        } catch (NoSuchMethodException e) {
          result.notImplemented();
          return;
        }

        try {
          method.invoke(testObjectInstance);
        } catch (Exception e) {
          result.error(e.getClass().getSimpleName(), e.getMessage(), null);
          return;
        }

        result.success(null);
      }
    });

    Map<String, String> results = null;
    try {
      results = E2EPlugin.testResults.get();
    } catch (ExecutionException | InterruptedException e) {
      throw new IllegalThreadStateException("Unable to get test results");
    }

    for (String name : results.keySet()) {
      Description d = Description.createTestDescription(testClass, name);
      notifier.fireTestStarted(d);
      String outcome = results.get(name);
      if (outcome.equals("failed")) {
        Exception dummyException = new Exception(outcome);
        notifier.fireTestFailure(new Failure(d, dummyException));
      }
      notifier.fireTestFinished(d);
    }
  }
}
