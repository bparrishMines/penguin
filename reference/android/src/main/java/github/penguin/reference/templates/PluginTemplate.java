package github.penguin.reference.templates;

import androidx.annotation.NonNull;
import androidx.annotation.VisibleForTesting;
import github.penguin.reference.reference.ReferencePairManager;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.PluginRegistry.Registrar;

public class PluginTemplate implements FlutterPlugin {
  @VisibleForTesting
  public static class TemplateReferencePairManagerTemplate extends $TemplateReferencePairManager {
    public TemplateReferencePairManagerTemplate(BinaryMessenger binaryMessenger) {
      super(binaryMessenger, "github.penguin/reference", new $LocalReferenceCommunicationHandler() {
        @Override
        public ClassTemplate createClassTemplate(ReferencePairManager referencePairManager, int fieldTemplate) {
          return new ClassTemplateImpl(fieldTemplate).setReferencePairManager(referencePairManager);
        }
      });
    }
  }

  @SuppressWarnings("unused")
  public static void registerWith(Registrar registrar) {
    new PluginTemplate().initialize(registrar.messenger());
  }

  private void initialize(final BinaryMessenger binaryMessenger) {
    new TemplateReferencePairManagerTemplate(binaryMessenger).initialize();
  }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    initialize(flutterPluginBinding.getBinaryMessenger());
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    // Do nothing.
  }
}
