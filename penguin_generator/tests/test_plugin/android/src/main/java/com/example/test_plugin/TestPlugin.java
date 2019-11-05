package com.example.test_plugin;

import android.widget.TextView;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** TestPlugin */
public class TestPlugin {
  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "test_plugin");
    final ChannelGenerated channelGenerated = new ChannelGenerated();

    final ChannelGenerated.ActivityWrapper activityWrapper = new ChannelGenerated.ActivityWrapper(
        channelGenerated,
        "activity",
        registrar.activity());
    final ChannelGenerated.TextViewWrapper textViewWrapper = new ChannelGenerated.TextViewWrapper(
        channelGenerated,
        "textView",
        new TextView(registrar.activity()));

    channelGenerated.addAllocatedWrapper("activity", activityWrapper);
    channelGenerated.addAllocatedWrapper("textView", textViewWrapper);

    channel.setMethodCallHandler(channelGenerated);

    registrar
        .platformViewRegistry()
        .registerViewFactory(
            "test_plugin/view",
            channelGenerated.getPlatformViewFactory());
  }
}
