package plugins.penguin.penguin_plugin;

public class WrapperNotFoundException extends Exception {
  public WrapperNotFoundException(String uniqueId) {
    super(String.format("Could not find Wrapper with uniqueId %s.", uniqueId));
  }
}
