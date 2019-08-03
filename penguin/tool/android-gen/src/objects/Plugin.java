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
    } else  {
      return ((PluginMethod) fieldOrMethod).is_static;
    }
  }

  static public String returnType(Object fieldOrMethod) {
    assert fieldOrMethod instanceof PluginField || fieldOrMethod instanceof PluginMethod;

    if (fieldOrMethod instanceof PluginField) {
      return ((PluginField) fieldOrMethod).type;
    } else  {
      return ((PluginMethod) fieldOrMethod).returns;
    }
  }

  static public String name(Object fieldOrMethod) {
    assert fieldOrMethod instanceof PluginField || fieldOrMethod instanceof PluginMethod;

    if (fieldOrMethod instanceof PluginField) {
      return ((PluginField) fieldOrMethod).name;
    } else  {
      return ((PluginMethod) fieldOrMethod).name;
    }
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
