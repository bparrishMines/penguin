package com.example.test_plugin.test_library;

public class GenericClass<T> {
  private T object;

  void add(T object) {
    if (object == null) throw new IllegalArgumentException();
    this.object = object;
  }

  T get(String id) {
    return object;
  }
}
