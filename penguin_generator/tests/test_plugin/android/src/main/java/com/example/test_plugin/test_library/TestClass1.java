package com.example.test_plugin.test_library;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TestClass1 {
//  public static int staticField = 12;
//  public Object objectField = "32";
//  public Object dynamicField = 42;
//  public String stringField = "Macintosh";
//  public int intField = 43;
//  public final double doubleField = 44.0;
//  public Number numField = 0;
//  public boolean boolField = true;
//  public List<Boolean> listField = Arrays.asList(true, false, true);
//  public Map<String, Double> mapField;
//  public String constructorValue;

  public TestClass1() {
//    final HashMap<String, Double> map = new HashMap<>(2);
//    map.put("true", 1.0);
//    map.put("false", 0.0);
//    mapField = map;
  }

//  public TestClass1(String constructorValue) {
//    this.constructorValue = constructorValue;
//  }
//
//  public static int staticMethod() {
//    return 13;
//  }
//

  public void returnVoid() {

  }
//
//  public Object returnObject() {
//    return "Hello";
//  }
//
//  public Object returnDynamic() {
//    return 3;
//  }
//
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
//
//  public static class NestedTestClass {
//    public int nestedClassField = 4;
//    public int nestedClassMethod() {
//      return 5;
//    }
//  }
//
//  public void callCallbackMethod() {
//    callbackMethod(new TestClass3(), "I love callbacks.");
//  }
//
//  public void callbackMethod(TestClass3 wrapper, String supported) {
//
//  }
//
//  public void passParameters(int primitive, TestClass3 wrapper, NestedTestClass nested, AbstractTestClass abstractClass) {
//    // Do nothing
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
