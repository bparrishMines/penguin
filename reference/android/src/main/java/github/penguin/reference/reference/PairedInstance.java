package github.penguin.reference.reference;

import androidx.annotation.NonNull;

public class PairedInstance {
  public final String referenceId;

  public PairedInstance(final String referenceId) {
    this.referenceId = referenceId;
  }

  @Override
  public boolean equals(Object obj) {
    return obj instanceof PairedInstance
        && referenceId.equals(((PairedInstance) obj).referenceId);
  }

  @Override
  public int hashCode() {
    return referenceId.hashCode() & super.hashCode();
  }

  @NonNull
  @Override
  public String toString() {
    return String.format("%s(%s)", "PairedInstance", referenceId);
  }
}
