package dev.fruit.fruit_picker;

import dev.fruit.fruits.Orange;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import java.lang.Integer;
import java.lang.Override;

final class FlutterOrange implements MethodCallHandler {
  private final Integer handle;

  private final Orange orange;

  private FlutterOrange(final Integer handle, final Double juiciness) {
    this.handle = handle;
    this.orange = new Orange(juiciness);
  }

  static void onStaticMethodCall(MethodCall call, Result result) {
    switch(call.method) {
      case "Orange(double)":
        final Integer handle = call.argument("orangeHandle");
        final Double juiciness = call.argument("juiciness");
        final FlutterOrange handler = new FlutterOrange(handle, juiciness);
        FruitPickerPlugin.addHandler(handle, handler);
        break;
      default:
        result.notImplemented();
    }
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    switch(call.method) {
      case "Orange#squeeze":
        squeeze(call, result);
        break;
      default:
        result.notImplemented();
    }
  }

  private void squeeze(final MethodCall call, final Result result) {
    orange.squeeze(pressure);
    result.success(null);
  }
}
