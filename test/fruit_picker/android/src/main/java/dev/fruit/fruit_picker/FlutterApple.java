package dev.fruit.fruit_picker;

import dev.fruit.fruit_picker.fruitlibrary.fruits.Apple;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import java.lang.Integer;
import java.lang.Override;

final class FlutterApple implements MethodCallHandler {
  private final Integer handle;

  private final Apple apple;

  FlutterApple(Integer handle, Apple apple) {
    this.handle = handle;
    this.apple = apple;
  }

  static void onStaticMethodCall(MethodCall call, Result result) {
    switch(call.method) {
      case "Apple#areApplesGood":
        areApplesGood(result);
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

  private static void areApplesGood(final Result result) {
    final Boolean value = Apple.areApplesGood();
    result.success(value);
  }
}
