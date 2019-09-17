package com.example.penguin_usage.test_package;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TestClass {
  public void aMethod() {

  }

  public String getStringMethod() {
    return "Hello, World.";
  }

  public int addTwo(int value) {
    return value += 2;
  }

  public double divide(int one, int two) {
    return one / two;
  }

  public List<String> getList(HashMap<Integer, Integer> integerIntegerHashMap) {
    final List<String> values = new ArrayList<>();
    for (Map.Entry<Integer, Integer> entry : integerIntegerHashMap.entrySet()) {
      values.add("" + (entry.getKey() + entry.getValue()));
    }
    return values;
  }

  public TestClassTwo getUsage2() {
    return new TestClassTwo();
  }

  public String giveUsage2(TestClassTwo usage2) {
    return "Thank you for a: " + usage2.getClass().getSimpleName();
  }
}
