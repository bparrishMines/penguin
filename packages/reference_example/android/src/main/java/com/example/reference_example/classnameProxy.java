package com.example.reference_example;

import com.example.reference_example.fakelibrary.ClassTemplate;

public class classnameProxy implements LibraryTemplate.$__class_name__ {
  public final ClassTemplate classTemplate;

  public static Double staticMethodTemplate(String parameterTemplate) {
    return ClassTemplate.staticMethodTemplate(parameterTemplate);
  }

  public classnameProxy(Integer fieldTemplate) {
    this(new ClassTemplate(fieldTemplate));
  }

  public classnameProxy(ClassTemplate classTemplate) {
    this.classTemplate = classTemplate;
  }

  @Override
  public String __method_name__(String __parameter_name__) {
    return classTemplate.methodTemplate(__parameter_name__);
  }
}
