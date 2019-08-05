package dev.fruit.fruit_picker.fruitlibrary.fruits;

public class Lemon {
  public Lemon(String color, Double sourness) {
    assert color != null;
    assert sourness != null;
  }

  public void makeLemonade(Boolean addSugar, Boolean addIce) {
    assert addSugar != null;
    assert addIce != null;
  }

  public Boolean isBigger(Orange anOrange) {
    return false;
  }
}
