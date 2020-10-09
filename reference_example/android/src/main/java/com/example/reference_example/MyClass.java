package com.example.reference_example;

import github.penguin.reference.reference.LocalReference;

public class MyClass implements LocalReference {
  public MyClass(String stringField) {
    this.stringField = stringField;
  }

  public final String stringField;

  public String myMethod(double value, MyOtherClass myOtherClass) {
    return String.format("myMethod(%f, %s)", value, myOtherClass.toString());
  }

  // The unique `Class` used to represent this class in a `ReferencePairManager`.
  @Override
  public Class<? extends LocalReference> getReferenceClass() {
    return MyClass.class;
  }
}
