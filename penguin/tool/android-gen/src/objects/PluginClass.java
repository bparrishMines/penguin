package objects;

import creator.ClassDetails;

import java.util.ArrayList;
import java.util.List;

public class PluginClass {
  public String name;
  public String java_package;
  public List<PluginMethod> methods = new ArrayList<>();
  public List<PluginField> fields = new ArrayList<>();
  public List<PluginConstructor> constructors = new ArrayList<>();
  public ClassDetails details;

  public List<Object> getFieldsAndMethods() {
    final List<Object> fieldsAndMethods = new ArrayList<>();
    fieldsAndMethods.addAll(fields);
    fieldsAndMethods.addAll(methods);

    return fieldsAndMethods;
  }
}
