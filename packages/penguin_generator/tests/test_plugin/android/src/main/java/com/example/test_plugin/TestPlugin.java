package com.example.test_plugin;

import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** TestPlugin */
public class TestPlugin {
  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "test_plugin");
    final ChannelGenerated channelGenerated = new ChannelGenerated(channel);
    channel.setMethodCallHandler(channelGenerated.methodCallHandler);

    registrar
        .platformViewRegistry()
        .registerViewFactory("test_plugin/view", channelGenerated.viewFactory);
  }
}