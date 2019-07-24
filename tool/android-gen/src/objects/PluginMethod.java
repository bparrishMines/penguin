package objects;

import java.util.ArrayList;
import java.util.List;

public class PluginMethod {
  public String name;
  public String returns = "void";
  public String type;
  public boolean is_static = false;
  public List<PluginParameter> required_parameters = new ArrayList<>();
  public List<PluginParameter> optional_parameters = new ArrayList<>();
}
