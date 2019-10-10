package com.example.test_plugin.test_library;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TestClass1 {
  public int noParametersMethod() {
    return 72;
  }

  public String singleParameterMethod(String value) {
    return value + ", World!";
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
}
