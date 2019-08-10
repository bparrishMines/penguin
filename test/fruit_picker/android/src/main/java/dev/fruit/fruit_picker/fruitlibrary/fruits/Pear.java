package dev.fruit.fruit_picker.fruitlibrary.fruits;

public class Pear {
  public Apple closestApple = new Apple();

  public static Pear aPearForAnApple(Apple apple) {
    assert apple != null;
    return new Pear();
  }
}
