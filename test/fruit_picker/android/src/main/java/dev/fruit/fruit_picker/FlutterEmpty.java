package dev.fruit.fruit_picker;

import dev.fruit.nada.Empty;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import java.lang.Integer;
import java.lang.Override;

final class FlutterEmpty implements MethodCallHandler {
  private final Integer handle;

  private final Empty empty;

  private FlutterEmpty(final Integer handle) {
    this.handle = handle;
    this.empty = new Empty();
  }

  static void onStaticMethodCall(MethodCall call, Result result) {
    switch(call.method) {
      case "Empty()":
        final Integer handle = call.argument("emptyHandle");
        ;
        final FlutterEmpty handler = new FlutterEmpty(handle, );
        FruitPickerPlugin.addHandler(handle, handler);
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
}
