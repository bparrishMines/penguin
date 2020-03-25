package com.example.reference;

import java.util.HashMap;

public class ReferenceManager {
  private static final ReferenceManager GLOBAL_INSTANCE = new ReferenceManager();

  private final HashMap<String, Reference> references = new HashMap<>();

  public static ReferenceManager getGlobalInstance() {
    return GLOBAL_INSTANCE;
  }

  public void addReference(final Reference reference) {
    if (references.containsKey(reference.referenceId)) {
      final String message = String.format("%s with the following referenceId already exists: %s",
          reference.getClass().getSimpleName(),
          reference.referenceId);
      throw new IllegalArgumentException(message);
    }

    references.put(reference.referenceId, reference);
  }

  public Reference removeReference(final String referenceId) {
    return references.remove(referenceId);
  }

  public Reference getReference(final String referenceId) throws ReferenceNotFoundException {
    if (references.containsKey(referenceId)) return references.get(referenceId);
    throw new ReferenceNotFoundException(referenceId);
  }
}
