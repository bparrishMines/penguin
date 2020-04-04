package com.example.reference;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

public class ReferenceManager {
  final Map<String, Reference> references = new HashMap<>();

  public static class ReferenceManagerNode extends ReferenceManager {
    private final Set<ReferenceManager> attachedManagers = new HashSet<>();

    @Override
    public boolean addReference(final Reference reference) {
      if (!canAddReference(reference)) return false;

      for (final ReferenceManager manager: attachedManagers) {
        manager.addReference(reference);
      }
      references.put(reference.referenceId, reference);
      return true;
    }

    @Override
    public Reference removeReference(final String referenceId) {
      for (final ReferenceManager manager: attachedManagers) {
        manager.removeReference(referenceId);
      }
      return super.removeReference(referenceId);
    }

    @Override
    public Reference getReference(final String referenceId) {
      for (final ReferenceManager manager: attachedManagers) {
        final Reference reference = manager.getReference(referenceId);
        if (reference != null) return reference;
      }
      return super.getReference(referenceId);
    }

    @Override
    public boolean canAddReference(Reference reference) {
      for (final ReferenceManager manager: attachedManagers) {
        if (!manager.canAddReference(reference)) return false;
      }
      return super.canAddReference(reference);
    }

    public boolean attachTo(ReferenceManager manager) {
      for (final Reference reference : references.values()) {
        if (!manager.canAddReference(reference)) return false;
      }

      for (final Reference reference : references.values()) {
        manager.addReference(reference);
      }
      attachedManagers.add(manager);
      return true;
    }

    public void detachFrom(ReferenceManager manager) {
      if (!attachedManagers.contains(manager)) return;

      for (final Reference reference : references.values()) {
        manager.removeReference(reference.referenceId);
      }

      attachedManagers.remove(manager);
    }
  }

  public boolean addReference(final Reference reference) {
    if (!canAddReference(reference)) return false;
    references.put(reference.referenceId, reference);
    return true;
  }

  public Reference removeReference(final String referenceId) {
    return references.remove(referenceId);
  }

  public Reference getReference(final String referenceId) {
    return references.get(referenceId);
  }

  public boolean canAddReference(final Reference reference) {
    final Reference query = getReference(reference.referenceId);
    return query == null || query == reference;
  }
}
