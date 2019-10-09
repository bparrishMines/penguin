package com.example.penguin_usage;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** PenguinUsagePlugin */
public class PenguinUsagePlugin implements MethodCallHandler {
  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "penguin_usage");
    channel.setMethodCallHandler(new ChannelGenerated());
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    // Do nothing
  }
}