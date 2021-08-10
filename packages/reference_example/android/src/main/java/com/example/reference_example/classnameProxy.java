package com.example.reference_example;

import com.example.reference_example.fakelibrary.ClassTemplate;

public class classnameProxy extends LibraryTemplate.$__class_name__ {
  public final ClassTemplate classTemplate;

  public static classnameProxy noCreate(LibraryTemplate.$LibraryImplementations implementations,
                                        Integer __parameter_name__) {
    return classnameProxy(__parameter_name__);
  }

  public static Double staticMethodTemplate(String parameterTemplate) {
    return ClassTemplate.staticMethodTemplate(parameterTemplate);
  }

  public classnameProxy(LibraryTemplate.$LibraryImplementations implementations, Integer fieldTemplate) {
    this(new ClassTemplate(fieldTemplate));
  }

  public classnameProxy(ClassTemplate classTemplate) {
    this.classTemplate = classTemplate;
  }

  private classnameProxy(Integer __parameter_name__) {

  }

  @Override
  public String __method_name__(String __parameter_name__) {
    return classTemplate.methodTemplate(__parameter_name__);
  }
}
