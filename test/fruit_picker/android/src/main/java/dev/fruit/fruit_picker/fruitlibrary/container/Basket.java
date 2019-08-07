package dev.fruit.fruit_picker.fruitlibrary.container;

import dev.fruit.fruit_picker.fruitlibrary.fruits.Apple;
import dev.fruit.fruit_picker.fruitlibrary.fruits.Banana;
import dev.fruit.fruit_picker.fruitlibrary.fruits.Grape;
import dev.fruit.fruit_picker.fruitlibrary.fruits.Orange;
import dev.fruit.fruit_picker.fruitlibrary.fruits.Peach;

public class Basket {
  public static Banana ripestBanana = new Banana();
  public static Peach favoritePeach;
  public static Grape aGreenGrape;
  public Grape aRedGrape = new Grape();

  public Basket() {}

  public Basket(Apple apple) {
    assert apple != null;
  }

  public Apple takeApple() {
    return new Apple();
  }

  public Orange takeOrange() {
    return new Orange(32.0);
  }

  public void addApple(Apple apple) {
    assert apple != null;
  }

  public Grape takeGrape() {
    final Grape grape = new Grape();
    grape.color = "yellow";
    grape.hasSeed = true;
    return grape;
  }
}
