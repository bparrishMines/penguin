package objects;

import java.util.ArrayList;
import java.util.List;

public class Plugin {
  public String name;
  public String organization = "com.example";
  public List<PluginClass> classes = new ArrayList<>();

  static public Boolean isStatic(Object fieldOrMethod) {
    assert fieldOrMethod instanceof PluginField || fieldOrMethod instanceof PluginMethod;

    if (fieldOrMethod instanceof PluginField) {
      return ((PluginField) fieldOrMethod).is_static;
    }

    return ((PluginMethod) fieldOrMethod).is_static;
  }

  static public String returnType(Object fieldOrMethod) {
    assert fieldOrMethod instanceof PluginField || fieldOrMethod instanceof PluginMethod;

    if (fieldOrMethod instanceof PluginField) {
      return ((PluginField) fieldOrMethod).type;
    }

    return ((PluginMethod) fieldOrMethod).returns;
  }

  static public String name(Object fieldOrMethod) {
    assert fieldOrMethod instanceof PluginField || fieldOrMethod instanceof PluginMethod;

    if (fieldOrMethod instanceof PluginField) {
      return ((PluginField) fieldOrMethod).name;
    }

    return ((PluginMethod) fieldOrMethod).name;
  }

  static public boolean mutable(Object fieldOrMethod) {
    assert fieldOrMethod instanceof PluginField || fieldOrMethod instanceof PluginMethod;

    if (fieldOrMethod instanceof PluginField) {
      return ((PluginField) fieldOrMethod).mutable;
    }

    return false;
  }

  static public boolean initialized(Object fieldOrMethod) {
    assert fieldOrMethod instanceof PluginField || fieldOrMethod instanceof PluginMethod;

    if (fieldOrMethod instanceof PluginField) {
      return ((PluginField) fieldOrMethod).initialized;
    }

    return false;
  }

  static public PluginMethod method(Object method) {
    assert method instanceof PluginMethod;
    return (PluginMethod) method;
  }

  static public List<PluginParameter> parameters(Object fieldOrParameterHolder) {
    assert fieldOrParameterHolder instanceof PluginField || fieldOrParameterHolder instanceof ParameterHolder;

    if (fieldOrParameterHolder instanceof ParameterHolder) {
      return ((ParameterHolder) fieldOrParameterHolder).allParameters;
    }

    return new ArrayList<>();
  }

  public static abstract class ParameterHolder {
    public List<PluginParameter> required_parameters = new ArrayList<>();
    public List<PluginParameter> optional_parameters = new ArrayList<>();

    private List<PluginParameter> allParameters;

    public List<PluginParameter> getAllParameters() {
      if (allParameters == null) {
        final List<PluginParameter> parameterList = new ArrayList<>();
        parameterList.addAll(required_parameters);
        parameterList.addAll(optional_parameters);

        allParameters = parameterList;
      }

      return allParameters;
    }

    public List<String> getAllParameterTypes() {
      final List<String> allParameterTypes = new ArrayList<>();
      for (PluginParameter parameter : getAllParameters()) {
        allParameterTypes.add(parameter.type);
      }

      return  allParameterTypes;
    }

    public List<String> getAllParameterNames() {
      final List<String> allParameterNames = new ArrayList<>();
      for (PluginParameter parameter : getAllParameters()) {
        allParameterNames.add(parameter.name);
      }

      return  allParameterNames;
    }
  }
}
