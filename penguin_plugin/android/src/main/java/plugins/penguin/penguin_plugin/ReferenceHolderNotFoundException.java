package plugins.penguin.penguin_plugin;

public class ReferenceHolderNotFoundException extends Exception {
  public ReferenceHolderNotFoundException(String referenceId) {
    super(String.format("Could not find %s with referenceId %s.",
        MethodChannelReferenceHolder.class.getSimpleName(),
        referenceId));
  }
}
