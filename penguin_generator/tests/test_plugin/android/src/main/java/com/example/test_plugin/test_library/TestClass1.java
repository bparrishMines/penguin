package com.example.test_plugin.test_library;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TestClass1 {
  public final static List<Boolean> staticField = Arrays.asList(true, false, true);
  public final String stringField = "Macintosh";
  public final int intField = 43;
  public final double doubleField = 44.0;
  public final boolean boolField = true;
  public double mutableField = 56.5;

  public TestClass1() { }

  public TestClass1(String s, Long primitive, TestClass2 wrapper, NestedTestClass nested) {
    if (s == null || primitive == null || wrapper == null || nested == null) {
      throw new IllegalArgumentException();
    }
  }

  public static void staticMethod() {

  }

  public void returnVoid() {

  }

  public Object returnObject() {
    return "Hello";
  }

  public Object returnDynamic() {
    return 3;
  }

  public String returnString() {
    return "Amigo";
  }

  public int returnInt() {
    return 69;
  }

  public double returnDouble() {
    return 70.0;
  }

  public boolean returnBool() {
    return false;
  }

  public List returnList() {
    final ArrayList<Double> doubles = new ArrayList<>();
    doubles.add(1.0);
    doubles.add(2.0);
    return doubles;
  }

  public Map returnMap() {
    final HashMap<String, Integer> map = new HashMap<>();
    map.put("one", 1);
    map.put("two", 2);
    return map;
  }

  public void parameterMethod(String s, Long primitive, TestClass2 wrapper, NestedTestClass nested) {
    if (s == null || primitive == null || wrapper == null || nested == null) {
      throw new IllegalArgumentException();
    }
  }

  public static class NestedTestClass {

  }
//
//  public void callCallbackMethod() {
//    callbackMethod(new TestClass3(), "I love callbacks.");
//  }
//
//  public void callbackMethod(TestClass3 wrapper, String supported) {
//
//  }
//
//  public enum TestEnum {
//    ONE, TWO;
//
//    public int enumMethod() {
//      return 2;
//    }
//  }
}
