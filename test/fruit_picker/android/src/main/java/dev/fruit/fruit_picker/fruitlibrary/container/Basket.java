package dev.fruit.fruit_picker.fruitlibrary.container;

import java.util.ArrayList;
import java.util.List;

import dev.fruit.fruit_picker.fruitlibrary.fruits.Apple;
import dev.fruit.fruit_picker.fruitlibrary.fruits.Apricot;
import dev.fruit.fruit_picker.fruitlibrary.fruits.Banana;
import dev.fruit.fruit_picker.fruitlibrary.fruits.Cherry;
import dev.fruit.fruit_picker.fruitlibrary.fruits.Grape;
import dev.fruit.fruit_picker.fruitlibrary.fruits.Orange;
import dev.fruit.fruit_picker.fruitlibrary.fruits.Peach;
import dev.fruit.fruit_picker.fruitlibrary.fruits.Pear;
import dev.fruit.fruit_picker.fruitlibrary.fruits.Seed;

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
    if (firstBanana == null) throw new IllegalArgumentException();
    if (secondBanana == null) throw new IllegalArgumentException();
    return new Basket();
  }

  public static void destroyBasket(Basket apricotBasket) {
    if (apricotBasket == null) throw new IllegalArgumentException();
  }

  public Apple takeApple() {
    return new Apple();
  }

  public Orange takeOrange() {
    return new Orange(32.0);
  }

  public void addApple(Apple apple) {
    if (apple == null) throw new IllegalArgumentException();
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
    if (aGoodApple == null) throw new IllegalArgumentException();
    if (aDecentApricot == null) throw new IllegalArgumentException();
    if (anotherGoodApple == null) throw new IllegalArgumentException();

    final Grape grape = new Grape();
    grape.hasSeed = false;
    grape.color = "orange";

    return grape;
  }

  public Cherry getCherry() {
    return new Cherry(new Seed());
  }

  public void saveSeed(Seed seed) {
    if (seed == null) throw new IllegalArgumentException();
  }

  public List<String> namesOfAllMyBananas() {
    final List<String> bananas = new ArrayList<>();
    bananas.add("charlie");
    bananas.add("wanda");
    return bananas;
  }
}
