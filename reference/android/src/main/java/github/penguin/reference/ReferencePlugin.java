package github.penguin.reference;

import androidx.annotation.NonNull;
import com.google.common.collect.ImmutableMap;
import github.penguin.reference.reference.ReferencePairManager;
import github.penguin.reference.templates.GeneratedReferencePairManager;
import github.penguin.reference.templates.GeneratedReferencePairManager.ClassTemplate;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import java.util.Collections;
import java.util.List;
import java.util.Map;

/** ReferencePlugin */
public class ReferencePlugin implements FlutterPlugin {
  public static void registerWith(Registrar registrar) {
    new ReferencePlugin().initialize(registrar.messenger());
  }

  private void initialize(final BinaryMessenger binaryMessenger) {
    new GeneratedReferencePairManager(
            binaryMessenger,
            "github.penguin/reference",
            new GeneratedReferencePairManager.GeneratedLocalReferenceCommunicationHandler() {
              @Override
              public ClassTemplate createClassTemplate(
                  ReferencePairManager referencePairManager,
                  int fieldTemplate,
                  ClassTemplate referenceFieldTemplate,
                  List<ClassTemplate> referenceListTemplate,
                  Map<String, ClassTemplate> referenceMapTemplate) {
                return new ClassTemplate() {
                  @Override
                  public Integer getFieldTemplate() {
                    return 0;
                  }

                  @Override
                  public ClassTemplate getReferenceFieldTemplate() {
                    return null;
                  }

                  @Override
                  public List<ClassTemplate> getReferenceListTemplate() {
                    return null;
                  }

                  @Override
                  public Map<String, ClassTemplate> getReferenceMapTemplate() {
                    return null;
                  }

                  @Override
                  public Object methodTemplate(
                      String parameterTemplate,
                      ClassTemplate referenceParameterTemplate,
                      List<ClassTemplate> referenceListTemplate,
                      Map<String, ClassTemplate> referenceMapTemplate) {
                    return "Reference";
                  }

                  @Override
                  public Object returnsReference() {
                    return new ClassTemplateImpl(
                        15,
                        new ClassTemplateImpl(16, null, null, null),
                        Collections.singletonList(
                            (ClassTemplate) new ClassTemplateImpl(17, null, null, null)),
                        ImmutableMap.of(
                            "tiny", (ClassTemplate) new ClassTemplateImpl(18, null, null, null)));
                  }
                };
              }
            })
        .initialize();
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
