package dev.fruit.fruit_picker.fruitlibrary.fruits;

public class Cherry {
  public Seed seed;

  public Cherry(Seed seed) {
    if (seed == null) throw new IllegalArgumentException();
    seed.length = 14.0;
    this.seed = seed;
  }
}
