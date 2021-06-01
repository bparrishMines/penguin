package github.penguin.reference;

import androidx.annotation.NonNull;
import java.util.HashMap;
import java.util.Map;

import github.penguin.reference.method_channel.MethodChannelMessenger;
import github.penguin.reference.reference.TypeChannelMessenger;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;

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

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
    final TypeChannelMessenger messenger = getMessengerInstance(binding.getBinaryMessenger());
    binding.getPlatformViewRegistry().registerViewFactory(
        "github.penguin.reference/AndroidReferenceWidget",
        new ReferenceViewFactory(messenger.getInstanceManager()));
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    messengers.remove(binding.getBinaryMessenger());
  }
}
