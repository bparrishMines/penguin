package com.example.reference_example;

import androidx.annotation.NonNull;

import github.penguin.reference.ReferencePlugin;
import github.penguin.reference.reference.TypeChannelMessenger;
import io.flutter.embedding.engine.plugins.FlutterPlugin;

/**
 * ReferenceExamplePlugin
 */
public class ReferenceExamplePlugin implements FlutterPlugin {
  ChannelRegistrar channelRegistrar;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    final TypeChannelMessenger messenger = ReferencePlugin.getMessengerInstance(flutterPluginBinding.getBinaryMessenger());
    channelRegistrar = new ChannelRegistrar(new ChannelRegistrar.LibraryImplementations(messenger));
    channelRegistrar.registerHandlers();
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channelRegistrar.unregisterHandlers();
  }
}
