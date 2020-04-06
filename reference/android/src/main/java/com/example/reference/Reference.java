package com.example.reference;

import java.util.UUID;

public abstract class Reference {
  public final String referenceId;

  public Reference(final String referenceId) {
    this.referenceId = referenceId;
  }

  public Reference() {
    this.referenceId = UUID.randomUUID().toString();
  }
}
