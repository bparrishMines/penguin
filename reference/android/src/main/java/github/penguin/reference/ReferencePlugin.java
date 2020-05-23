package github.penguin.reference;

import androidx.annotation.NonNull;
import github.penguin.reference.reference.ReferencePairManager;
import github.penguin.reference.templates.$ReferencePairManager;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import java.util.List;
import java.util.Map;

/** ReferencePlugin */
public class ReferencePlugin implements FlutterPlugin {
  static class ReferencePairManagerTemplate extends $ReferencePairManager {
    ReferencePairManagerTemplate(BinaryMessenger binaryMessenger) {
      super(binaryMessenger, "github.penguin/reference", new $LocalReferenceCommunicationHandler() {
        @Override
        public ClassTemplate createClassTemplate(ReferencePairManager referencePairManager, int fieldTemplate, ClassTemplate referenceFieldTemplate, List<ClassTemplate> referenceListTemplate, Map<String, ClassTemplate> referenceMapTemplate) {
          return new ClassTemplateImpl(fieldTemplate, referenceFieldTemplate, referenceListTemplate, referenceMapTemplate).setReferencePairManager(referencePairManager);
        }
      });
    }
  }

  public static void registerWith(Registrar registrar) {
    new ReferencePlugin().initialize(registrar.messenger());
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

  //  public static boolean attachToGlobalReferenceManager(final PluginRegistry registry, MethodChannelReferencePlatform platform) {
  //    final ReferenceManagerOld globalManager = registry.valuePublishedByPlugin(ReferencePlugin.class.getName());
  //    return attachToGlobalReferenceManager(globalManager, platform);
  //  }
  //
  //  public static boolean attachToGlobalReferenceManager(final FlutterEngine engine, MethodChannelReferencePlatform platform) {
  //    final ReferencePlugin plugin = (ReferencePlugin) engine.getPlugins().get(ReferencePlugin.class);
  //    return attachToGlobalReferenceManager(plugin.globalReferenceManagerOld, platform);
  //  }
  //
  //  private static boolean attachToGlobalReferenceManager(ReferenceManagerOld globalReferenceManagerOld, MethodChannelReferencePlatform platform) {
  //    final ReferenceManagerOld referenceManagerOld = platform.referenceManagerOld;
  //    if (referenceManagerOld instanceof ReferenceManagerOld.ReferenceManagerOldNode) {
  //      return ((ReferenceManagerOld.ReferenceManagerOldNode) referenceManagerOld).attachTo(globalReferenceManagerOld);
  //    }
  //    return false;
  //  }
}
