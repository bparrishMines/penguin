package plugins.penguin.penguin_plugin;

import java.util.Locale;

public class NotImplementedException extends Exception {
  public NotImplementedException(String method) {
    super(String.format(Locale.getDefault(),"No implementation for %s.", method));
  }
}