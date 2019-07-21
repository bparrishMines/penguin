package objects;

import java.util.ArrayList;
import java.util.List;

public class PluginClass {
  public String name;
  public String java_package;
  public List<PluginMethod> methods = new ArrayList<>();
  public List<PluginField> fields = new ArrayList<>();
}
