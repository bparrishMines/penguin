package github.penguin.reference;

import androidx.annotation.NonNull;
import github.penguin.reference.method_channel.MethodChannelReferenceChannelManager;
import github.penguin.reference.reference.ReferenceChannelManager;
import github.penguin.reference.templates.PluginTemplate;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import java.util.HashMap;
import java.util.Map;

/** ReferencePlugin */
public class ReferencePlugin implements FlutterPlugin {
  private static final Map<BinaryMessenger, ReferenceChannelManager> managers = new HashMap<>();

  public static ReferenceChannelManager getInstance(BinaryMessenger messenger) {
    ReferenceChannelManager manager = managers.get(messenger);
    if (manager == null) {
      manager = new MethodChannelReferenceChannelManager(messenger, "github.penguin/reference");
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
