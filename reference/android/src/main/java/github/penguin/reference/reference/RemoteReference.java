package github.penguin.reference.reference;

public class RemoteReference {
  public final String referenceId;

  public RemoteReference(final String referenceId) {
    this.referenceId = referenceId;
  }

  @Override
  public boolean equals(Object obj) {
    return obj instanceof RemoteReference && referenceId.equals(((RemoteReference) obj).referenceId);
  }

  @Override
  public int hashCode() {
    return referenceId.hashCode();
  }
}
