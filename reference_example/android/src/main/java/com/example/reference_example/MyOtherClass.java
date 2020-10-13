package com.example.reference_example;

import github.penguin.reference.reference.LocalReference;

class MyOtherClass implements LocalReference {
  public final int intField;

  static Integer myStaticMethod() {
    return 324;
  }

  public MyOtherClass(int intField) {
    this.intField = intField;
  }

  // The unique `Class` used to represent this class in a `ReferencePairManager`.
  @Override
  public Class<? extends LocalReference> getReferenceClass() {
    return MyOtherClass.class;
  }
}
