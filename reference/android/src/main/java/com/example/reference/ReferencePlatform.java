package com.example.reference;

public abstract class ReferencePlatform {
  public final ReferenceManager referenceManager;

  public ReferencePlatform(ReferenceManager referenceManager) {
    this.referenceManager = referenceManager;
  }

  public abstract void initialize();
}
