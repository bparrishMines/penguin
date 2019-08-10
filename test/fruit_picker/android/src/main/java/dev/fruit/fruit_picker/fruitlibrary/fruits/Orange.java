package dev.fruit.fruit_picker.fruitlibrary.fruits;

public class Orange {
  public Orange(Double juiciness) {
    if (juiciness == null) throw new IllegalArgumentException();
  }

  public void squeeze(Double pressure) {
    if (pressure == null) throw new IllegalArgumentException();
  }
}
