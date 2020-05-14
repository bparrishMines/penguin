package github.penguin.reference.reference;

import androidx.annotation.NonNull;

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

  @NonNull
  @Override
  public String toString() {
    return String.format("%s(%s)", RemoteReference.class.getName(), referenceId);
  }
}
