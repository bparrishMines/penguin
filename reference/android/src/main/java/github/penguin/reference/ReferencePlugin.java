package github.penguin.reference;

import androidx.annotation.NonNull;
import github.penguin.reference.method_channel.MethodChannelManager;
import github.penguin.reference.reference.TypeChannelManager;
import github.penguin.reference.templates.PluginTemplate;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import java.util.HashMap;
import java.util.Map;

/** ReferencePlugin */
public class ReferencePlugin implements FlutterPlugin {
  private static final Map<BinaryMessenger, TypeChannelManager> managers = new HashMap<>();

  public static TypeChannelManager getManagerInstance(BinaryMessenger messenger) {
    TypeChannelManager manager = managers.get(messenger);
    if (manager == null) {
      manager = new MethodChannelManager(messenger, "github.penguin/reference");
      managers.put(messenger, manager);
    }
    return manager;
  }

  @SuppressWarnings("unused")
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
    managers.remove(binding.getBinaryMessenger());
  }
}
