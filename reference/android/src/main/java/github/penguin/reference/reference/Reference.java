package github.penguin.reference.reference;

public class Reference {
  public final String referenceId;

  public Reference(final String referenceId) {
    this.referenceId = referenceId;
  }

  @Override
  public boolean equals(Object obj) {
    return obj instanceof Reference && referenceId.equals(((Reference) obj).referenceId);
  }

  @Override
  public int hashCode() {
    return referenceId.hashCode();
  }
}
