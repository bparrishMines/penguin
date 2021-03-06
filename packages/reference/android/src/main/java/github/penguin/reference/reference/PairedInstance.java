package github.penguin.reference.reference;

import androidx.annotation.NonNull;

public class PairedInstance {
  public final String instanceId;

  public PairedInstance(final String instanceId) {
    this.instanceId = instanceId;
  }

  @Override
  public boolean equals(Object obj) {
    return obj instanceof PairedInstance
        && instanceId.equals(((PairedInstance) obj).instanceId);
  }

  @Override
  public int hashCode() {
    int hash = 0x1fffffff & (17 + instanceId.hashCode());
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  @NonNull
  @Override
  public String toString() {
    return String.format("%s(%s)", "PairedInstance", instanceId);
  }
}
