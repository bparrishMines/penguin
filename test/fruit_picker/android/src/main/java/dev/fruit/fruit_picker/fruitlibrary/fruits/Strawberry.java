package dev.fruit.fruit_picker.fruitlibrary.fruits;

import java.util.HashMap;
import java.util.Map;

public class Strawberry {
  public static Integer averageNumberOfSeeds = 50;

  public Strawberry() {}

  public Strawberry(Map<Boolean, Double> aMap) {
    if (aMap.get(true) != 0 || aMap.get(false) != 1.0) throw new IllegalArgumentException();
  }

  public Map<String, Integer> namingSucksSoHereIsAMap() {
    final Map<String, Integer> map = new HashMap<>();
    map.put("one", 1);
    map.put("two", 2);
    return map;
  }
}
