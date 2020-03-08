package plugins.penguin.penguin_plugin;

class ReferenceHolderNotFoundException extends Exception {
  ReferenceHolderNotFoundException(String referenceId) {
    super(String.format("Could not find %s with referenceId %s.",
        MethodChannelReferenceHolder.class.getSimpleName(),
        referenceId));
  }
}
