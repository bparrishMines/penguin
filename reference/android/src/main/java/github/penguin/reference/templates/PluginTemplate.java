package github.penguin.reference.templates;

import java.util.List;
import java.util.Map;
import androidx.annotation.NonNull;
import androidx.annotation.VisibleForTesting;
import github.penguin.reference.reference.ReferencePairManager;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.PluginRegistry.Registrar;

public class PluginTemplate implements FlutterPlugin {
  @VisibleForTesting
  public static class ReferencePairManagerTemplate extends $ReferencePairManager {
    public ReferencePairManagerTemplate(BinaryMessenger binaryMessenger) {
      super(binaryMessenger, "github.penguin/reference", new $LocalReferenceCommunicationHandler() {
        @Override
        public ClassTemplate createClassTemplate(ReferencePairManager referencePairManager, int fieldTemplate, ClassTemplate referenceFieldTemplate, List<ClassTemplate> referenceListTemplate, Map<String, ClassTemplate> referenceMapTemplate) {
          return new ClassTemplateImpl(fieldTemplate, referenceFieldTemplate, referenceListTemplate, referenceMapTemplate).setReferencePairManager(referencePairManager);
        }
      });
    }
  }

  public static void registerWith(Registrar registrar) {
    new PluginTemplate().initialize(registrar.messenger());
  }

  private void initialize(final BinaryMessenger binaryMessenger) {
    new ReferencePairManagerTemplate(binaryMessenger).initialize();
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
