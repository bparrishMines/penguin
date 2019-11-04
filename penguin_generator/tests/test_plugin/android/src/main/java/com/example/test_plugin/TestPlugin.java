package com.example.test_plugin;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** TestPlugin */
public class TestPlugin {
  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "test_plugin");
    final ChannelGenerated channelGenerated = new ChannelGenerated();
    final ChannelGenerated.ActivityWrapper wrapper = new ChannelGenerated.ActivityWrapper(
        channelGenerated,
        "activity",
        registrar.activity());
    channelGenerated.addAllocatedWrapper("activity", wrapper);
    channel.setMethodCallHandler(channelGenerated);
  }
}
