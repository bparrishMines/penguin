package com.example.reference_example;

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** ReferenceExamplePlugin */
public class ReferenceExamplePlugin implements FlutterPlugin {
  public static void registerWith(Registrar registrar) {
    new ReferenceExamplePlugin().initialize(registrar.messenger());
  }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    initialize(flutterPluginBinding.getBinaryMessenger());
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    // Do nothing.
  }

  private void initialize(final BinaryMessenger binaryMessenger) {
    new MyReferencePairManager(binaryMessenger).initialize();
  }
}
