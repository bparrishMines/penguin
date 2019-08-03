package dev.fruit.fruit_picker.fruitlibrary.container;

import dev.fruit.fruit_picker.fruitlibrary.fruits.Apple;
import dev.fruit.fruit_picker.fruitlibrary.fruits.Banana;

public class Basket {
  public static Banana ripestBanana = new Banana();

  public Basket() {}

  public Basket(Apple apple) {}

  public Apple takeApple() {
    return new Apple();
  }

  public void addApple(Apple apple) {}
}
