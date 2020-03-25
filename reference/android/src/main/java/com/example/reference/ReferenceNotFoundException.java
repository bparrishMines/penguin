package com.example.reference;

public class ReferenceNotFoundException extends Exception {
  public ReferenceNotFoundException(String referenceId) {
    super(String.format("Could not find %s with referenceId %s.",
        Reference.class.getSimpleName(),
        referenceId));
  }
}
