package dev.fruit.fruit_picker;

import dev.fruit.fruits.Banana;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import java.lang.Integer;
import java.lang.Override;

final class FlutterBanana implements MethodCallHandler {
  private final Integer handle;

  private final Banana banana;

  FlutterBanana(Integer handle, Banana banana) {
    this.handle = handle;
    this.banana = banana;
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    switch(call.method) {
      case "Banana#length":
        length(result);
        break;
      default:
        result.notImplemented();
    }
  }

  private void length(final Result result) {
    final Double value = banana.length;
    result.success(value);
  }
}
