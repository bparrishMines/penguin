package dev.fruit.fruit_picker.fruitlibrary.container;

import dev.fruit.fruit_picker.fruitlibrary.fruits.Apple;
import dev.fruit.fruit_picker.fruitlibrary.fruits.Apricot;
import dev.fruit.fruit_picker.fruitlibrary.fruits.Banana;
import dev.fruit.fruit_picker.fruitlibrary.fruits.Grape;
import dev.fruit.fruit_picker.fruitlibrary.fruits.Orange;
import dev.fruit.fruit_picker.fruitlibrary.fruits.Peach;
import dev.fruit.fruit_picker.fruitlibrary.fruits.Pear;

public class Basket {
  public static Banana ripestBanana = new Banana();
  public static Peach favoritePeach;
  public static Grape aGreenGrape;
  public Grape aRedGrape = new Grape();
  public Pear sweetestPear = new Pear();

  public Basket() { }

  public Basket(Apple apple) {
    assert apple != null;
  }

  public static Basket basketWithBananas(Banana firstBanana, Banana secondBanana) {
    return new Basket();
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

  public Apricot takeApricot() {
    final Apricot apricot = new Apricot();
    apricot.shape = "square";
    return apricot;
  }

  public Grape addAndTakeSomeFruit(Apple aGoodApple, Apricot aDecentApricot, Apple anotherGoodApple) {
    assert aGoodApple != null;
    assert aDecentApricot != null;
    assert anotherGoodApple != null;

    final Grape grape = new Grape();
    grape.hasSeed = false;
    grape.color = "orange";

    return grape;
  }
}
