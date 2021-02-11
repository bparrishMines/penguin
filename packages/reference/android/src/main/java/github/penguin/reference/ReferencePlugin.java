package github.penguin.reference;

import androidx.annotation.NonNull;

import java.util.HashMap;
import java.util.Map;

import github.penguin.reference.method_channel.MethodChannelMessenger;
import github.penguin.reference.reference.TypeChannelMessenger;
import github.penguin.reference.templates.PluginTemplate;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * ReferencePlugin
 */
public class ReferencePlugin implements FlutterPlugin {
  private static final Map<BinaryMessenger, TypeChannelMessenger> messengers = new HashMap<>();

  public static TypeChannelMessenger getMessengerInstance(BinaryMessenger messenger) {
    TypeChannelMessenger typeChannelMessenger = messengers.get(messenger);
    if (typeChannelMessenger == null) {
      typeChannelMessenger = new MethodChannelMessenger(messenger, "github.penguin/reference");
      messengers.put(messenger, typeChannelMessenger);
    }
    return typeChannelMessenger;
  }

  @SuppressWarnings({"unused", "deprecation"})
  public static void registerWith(Registrar registrar) {
    PluginTemplate.registerWith(registrar);
  }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
    new PluginTemplate().onAttachedToEngine(binding);
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    new PluginTemplate().onDetachedFromEngine(binding);
    messengers.remove(binding.getBinaryMessenger());
  }
}