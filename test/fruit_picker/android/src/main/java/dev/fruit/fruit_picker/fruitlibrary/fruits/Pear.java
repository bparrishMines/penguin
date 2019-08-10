package dev.fruit.fruit_picker.fruitlibrary.fruits;

public class Pear {
  public Apple closestApple = new Apple();

  public static Pear aPearForAnApple(Apple apple) {
    if (apple == null) throw new IllegalArgumentException();
    return new Pear();
  }
}
