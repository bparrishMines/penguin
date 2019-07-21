import objects.Plugin;
import objects.PluginClass;
import objects.PluginField;
import objects.PluginMethod;

public enum ClassStructure {
  UNSPECIFIED_PUBLIC,
  UNSPECIFIED_PRIVATE;

  public static ClassStructure tryGetClassStructure(Plugin plugin, String className) {
    final PluginClass aClass = classFromString(plugin, className);

    if (aClass != null) {
      return structureFromClass(plugin, aClass);
    }

    return null;
  }

  public static PluginClass classFromString(Plugin plugin, String className) {
    for (PluginClass theClass : plugin.classes) {
      if (theClass.name.equals(className)) {
        return theClass;
      }
    }

    return null;
  }

  public static ClassStructure structureFromClass(Plugin plugin, PluginClass theClass) {
    for (PluginClass dClass : plugin.classes) {
      for (PluginMethod method : dClass.methods) {
        if (method.returns.equals(theClass.name)) {
          return ClassStructure.UNSPECIFIED_PRIVATE;
        }
      }

      for (PluginField field : dClass.fields) {
        if (field.type.equals(theClass.name)) {
          return ClassStructure.UNSPECIFIED_PRIVATE;
        }
      }
    }

    return ClassStructure.UNSPECIFIED_PUBLIC;
  }
}
