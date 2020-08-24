package com.example.reference_example;

import github.penguin.reference.reference.LocalReference;

public class MyClass implements LocalReference {
  private final MyApiClass myApiClass = new MyApiClass();
  public final String stringField;

  public static class MyApiClass {
    public String myMethod(double value, String className) {
      return String.format("myMethod(%f, %s)", value, className);
    }
  }

  public MyClass(String stringField) {
    this.stringField = stringField;
  }

  public String myMethod(double value, MyOtherClass myOtherClass) {
    return getMyApiClass().myMethod(value, myOtherClass.getClass().getSimpleName());
  }

  // The unique `Class` used to represent this class in a `ReferencePairManager`.
  @Override
  public Class<? extends LocalReference> getReferenceClass() {
    return MyClass.class;
  }

  public MyApiClass getMyApiClass() {
    return myApiClass;
  }
}
