package objects;

import java.util.ArrayList;
import java.util.List;

public class Class {
  public String name;
  public String java_package;
  public List<Method> methods = new ArrayList<>();
  public List<Field> fields = new ArrayList<>();
}
