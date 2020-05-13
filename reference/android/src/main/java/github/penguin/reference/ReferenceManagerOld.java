package github.penguin.reference;

import github.penguin.reference.reference.RemoteReference;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

public class ReferenceManagerOld {
  final Map<String, RemoteReference> references = new HashMap<>();

  public static class ReferenceManagerOldNode extends ReferenceManagerOld {
    private final Set<ReferenceManagerOld> attachedManagers = new HashSet<>();

    @Override
    public boolean addReference(final RemoteReference remoteReference) {
      if (!canAddReference(remoteReference)) return false;

      for (final ReferenceManagerOld manager : attachedManagers) {
        manager.addReference(remoteReference);
      }
      references.put(remoteReference.referenceId, remoteReference);
      return true;
    }

    @Override
    public RemoteReference removeReference(final String referenceId) {
      for (final ReferenceManagerOld manager : attachedManagers) {
        manager.removeReference(referenceId);
      }
      return super.removeReference(referenceId);
    }

    @Override
    public RemoteReference getReference(final String referenceId) {
      for (final ReferenceManagerOld manager : attachedManagers) {
        final RemoteReference remoteReference = manager.getReference(referenceId);
        if (remoteReference != null) return remoteReference;
      }
      return super.getReference(referenceId);
    }

    @Override
    public boolean canAddReference(RemoteReference remoteReference) {
      for (final ReferenceManagerOld manager : attachedManagers) {
        if (!manager.canAddReference(remoteReference)) return false;
      }
      return super.canAddReference(remoteReference);
    }

    public boolean attachTo(ReferenceManagerOld manager) {
      for (final RemoteReference remoteReference : references.values()) {
        if (!manager.canAddReference(remoteReference)) return false;
      }

      for (final RemoteReference remoteReference : references.values()) {
        manager.addReference(remoteReference);
      }
      attachedManagers.add(manager);
      return true;
    }

    public void detachFrom(ReferenceManagerOld manager) {
      if (!attachedManagers.contains(manager)) return;

      for (final RemoteReference remoteReference : references.values()) {
        manager.removeReference(remoteReference.referenceId);
      }

      attachedManagers.remove(manager);
    }
  }

  public boolean addReference(final RemoteReference remoteReference) {
    if (!canAddReference(remoteReference)) return false;
    references.put(remoteReference.referenceId, remoteReference);
    return true;
  }

  public RemoteReference removeReference(final String referenceId) {
    return references.remove(referenceId);
  }

  public RemoteReference getReference(final String referenceId) {
    return references.get(referenceId);
  }

  public boolean canAddReference(final RemoteReference remoteReference) {
    final RemoteReference query = getReference(remoteReference.referenceId);
    return query == null || query == remoteReference;
  }
}
