package dev.fruit.fruit_picker.fruitlibrary.fruits;

public class Apple {
  public static boolean areApplesGood() {
    return true;
  }

  public static Boolean areApplesBetterThanThis(Apricot apricot) {
    if (apricot == null) throw new IllegalArgumentException();
    return true;
  }
}
