package dev.fruit.fruit_picker;

import android.util.SparseArray;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import java.lang.IllegalArgumentException;
import java.lang.Integer;
import java.lang.Override;
import java.lang.String;

public final class FruitPickerPlugin implements MethodCallHandler {
  private static final String CHANNEL_NAME = "dev.fruit/fruit_picker";

  private static final SparseArray<MethodCallHandler> handlers = new SparseArray<>();

  private static Registrar registrar;

  private static MethodChannel channel;

  public static void registerWith(Registrar registrar) {
    FruitPickerPlugin.registrar = registrar;
    channel = new MethodChannel(registrar.messenger(), CHANNEL_NAME);
    channel.setMethodCallHandler(new FruitPickerPlugin());
  }

  static void addHandler(final Integer handle, final MethodCallHandler handler) {
    if (handlers.get(handle) != null) {
      final String message = String.format("Object for handle already exists: %s", handle);
      throw new IllegalArgumentException(message);
    }
    handlers.put(handle, handler);
  }

  static void removeHandler(Integer handle) {
    handlers.remove(handle);
  }

  static MethodCallHandler getHandler(Integer handle) {
    return handlers.get(handle);
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    switch(call.method) {
      case "Basket#ripestBanana":
        FlutterBasket.onStaticMethodCall(call, result);
        break;
      case "Apple()":
        FlutterApple.onStaticMethodCall(call, result);
        break;
      case "Apple#areApplesGood":
        FlutterApple.onStaticMethodCall(call, result);
        break;
      case "Orange(double)":
        FlutterOrange.onStaticMethodCall(call, result);
        break;
      case "Strawberry#averageNumberOfSeeds":
        FlutterStrawberry.onStaticMethodCall(call, result);
        break;
      default:
        final Integer handle = call.argument("handle");
        if (handle == null) {
          result.notImplemented();
          return;
        }
        final MethodCallHandler handler = getHandler(handle);
        if (handler == null) {
          result.notImplemented();
          return;
        }
        handler.onMethodCall(call, result);
    }
  }
}
