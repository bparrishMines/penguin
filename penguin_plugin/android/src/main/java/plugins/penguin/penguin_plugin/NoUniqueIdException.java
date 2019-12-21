package plugins.penguin.penguin_plugin;

public class NoUniqueIdException extends Exception {
  public NoUniqueIdException(String method) {
    super(String.format("MethodCall was made without a unique handle for %s.", method));
  }
}
