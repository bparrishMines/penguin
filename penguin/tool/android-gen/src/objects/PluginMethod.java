package objects;

public class PluginMethod extends Plugin.ParameterHolder {
  public String name;
  public String returns = "void";
  public String type;
  public boolean is_static = false;
  public boolean allocator = false;
  public boolean disposer = false;
  public boolean force = false;
}
