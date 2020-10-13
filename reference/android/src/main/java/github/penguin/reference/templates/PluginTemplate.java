package github.penguin.reference.templates;

import androidx.annotation.NonNull;
import github.penguin.reference.reference.ReferencePairManager;
import github.penguin.reference.templates.LibraryTemplate.$ClassTemplateCreationArgs;
import github.penguin.reference.templates.LibraryTemplate.$LocalHandler;
import github.penguin.reference.templates.LibraryTemplate.$ReferencePairManager;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.PluginRegistry.Registrar;

public class PluginTemplate implements FlutterPlugin {
  private static class ReferencePairManagerTemplate extends $ReferencePairManager {
    public ReferencePairManagerTemplate(BinaryMessenger binaryMessenger) {
      super(binaryMessenger, "github.penguin/reference/template");
    }

    @Override
    public $LocalHandler getLocalHandler() {
      return new $LocalHandler() {
        @Override
        public LibraryTemplate.$ClassTemplate createClassTemplate(
            ReferencePairManager referencePairManager, $ClassTemplateCreationArgs args) {
          return new ClassTemplate(args.fieldTemplate);
        }

        @Override
        public Object classTemplate$staticMethodTemplate(
            ReferencePairManager referencePairManager, String parameterTemplate) {
          return ClassTemplate.staticMethodTemplate(parameterTemplate);
        }
      };
    }
  }

  @SuppressWarnings("unused")
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
