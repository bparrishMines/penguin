package com.example.reference_example;

import com.example.reference_example.fakelibrary.ClassTemplate;

public class __class_name__Proxy {
  public final LibraryTemplate.$LibraryImplementations implementations;
  public final ClassTemplate classTemplate;

  public static Double staticMethodTemplate(LibraryTemplate.$LibraryImplementations implementations, String parameterTemplate) {
    return ClassTemplate.staticMethodTemplate(parameterTemplate);
  }

  public __class_name__Proxy(LibraryTemplate.$LibraryImplementations implementations, Integer __parameter_name__) {
    this(implementations, false, new ClassTemplate(__parameter_name__));
  }

  public __class_name__Proxy(LibraryTemplate.$LibraryImplementations implementations, boolean create, ClassTemplate classTemplate) {
    this.implementations = implementations;
    this.classTemplate = classTemplate;
    if (create) {
      implementations.__class_name__Channel.$create(this, false, classTemplate.fieldTemplate);
    }
  }

  public String __method_name__(String __parameter_name__) {
    return classTemplate.methodTemplate(__parameter_name__);
  }
}
