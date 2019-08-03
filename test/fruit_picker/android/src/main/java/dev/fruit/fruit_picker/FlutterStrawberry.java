package dev.fruit.fruit_picker;

import dev.fruit.fruits.Strawberry;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import java.lang.Integer;
import java.lang.Override;

final class FlutterStrawberry implements MethodCallHandler {
  private final Integer handle;

  private final Strawberry strawberry;

  void onStaticMethodCall(MethodCall call, Result result) {
    switch(call.method) {
      case "Strawberry#averageNumberOfSeeds":
        averageNumberOfSeeds(result);
        break;
      default:
        result.notImplemented();
    }
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    switch(call.method) {
      default:
        result.notImplemented();
    }
  }

  private static void averageNumberOfSeeds(final Result result) {
    final Integer value = Strawberry.averageNumberOfSeeds;
    result.success(value);
  }
}
