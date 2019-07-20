package objects;

import java.util.ArrayList;
import java.util.List;

public class Method {
  public String name;
  public String returns = "void";
  public String type;
  public List<Parameter> required_parameters = new ArrayList<>();
  public List<Parameter> optional_parameters = new ArrayList<>();
}
