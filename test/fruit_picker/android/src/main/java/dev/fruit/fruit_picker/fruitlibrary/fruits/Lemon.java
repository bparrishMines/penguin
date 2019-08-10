package dev.fruit.fruit_picker.fruitlibrary.fruits;

public class Lemon {
  public Lemon(String color, Double sourness) {
    if (color == null) throw new IllegalArgumentException();
    if (sourness == null) throw new IllegalArgumentException();
  }

  public void makeLemonade(Boolean addSugar, Boolean addIce) {
    if (addSugar == null) throw new IllegalArgumentException();
    if (addIce == null) throw new IllegalArgumentException();
  }

  public Boolean isBigger(Orange anOrange) {
    if (anOrange == null) throw new IllegalArgumentException();
    return false;
  }
}
