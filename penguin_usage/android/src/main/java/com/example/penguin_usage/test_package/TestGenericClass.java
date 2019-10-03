package com.example.penguin_usage.test_package;

public class TestGenericClass<T> {
  T value;

  public void setValue(T value) {
    this.value = value;
  }

  public T get() {
    return value;
  }
}
