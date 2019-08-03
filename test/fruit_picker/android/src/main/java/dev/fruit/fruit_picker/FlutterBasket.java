package dev.fruit.fruit_picker;

import dev.fruit.fruit_picker.fruitlibrary.container.Basket;
import dev.fruit.fruit_picker.fruitlibrary.fruits.Apple;
import dev.fruit.fruit_picker.fruitlibrary.fruits.Banana;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import java.lang.Integer;
import java.lang.Override;

final class FlutterBasket implements MethodCallHandler {
  private final Integer handle;

  private final Basket basket;

  private FlutterBasket(final Integer handle) {
    this.handle = handle;
    this.basket = new Basket();
  }

  static void onStaticMethodCall(MethodCall call, Result result) {
    switch(call.method) {
      case "Basket()":
        final Integer handle = call.argument("basketHandle");
        final FlutterBasket handler = new FlutterBasket(handle);
        FruitPickerPlugin.addHandler(handle, handler);
        break;
      case "Basket#ripestBanana":
        ripestBanana(call, result);
        break;
      default:
        result.notImplemented();
    }
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    switch(call.method) {
      case "Basket#takeApple":
        takeApple(call, result);
        break;
      default:
        result.notImplemented();
    }
  }

  private static void ripestBanana(final MethodCall call, final Result result) {
    final Integer handle = call.argument("bananaHandle");
    final Banana value = Basket.ripestBanana;
    final FlutterBanana handler = new FlutterBanana(handle, value);
    FruitPickerPlugin.addHandler(handle, handler);
    result.success(null);
  }

  private void takeApple(final MethodCall call, final Result result) {
    final Integer handle = call.argument("appleHandle");
    final Apple value = basket.takeApple();
    final FlutterApple handler = new FlutterApple(handle, value);
    FruitPickerPlugin.addHandler(handle, handler);
    result.success(null);
  }
}
