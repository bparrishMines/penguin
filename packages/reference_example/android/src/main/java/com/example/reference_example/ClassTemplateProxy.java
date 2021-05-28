package com.example.reference_example;

import com.example.reference_example.fakelibrary.ClassTemplate;

public class ClassTemplateProxy implements LibraryTemplate.$ClassTemplate {
  public final ClassTemplate classTemplate;

  public static Double staticMethodTemplate(String parameterTemplate) {
    return ClassTemplate.staticMethodTemplate(parameterTemplate);
  }

  public ClassTemplateProxy(Integer fieldTemplate) {
    this(new ClassTemplate(fieldTemplate));
  }

  public ClassTemplateProxy(ClassTemplate classTemplate) {
    this.classTemplate = classTemplate;
  }

  public String methodTemplate(String parameterTemplate) {
    return classTemplate.methodTemplate(parameterTemplate);
  }
}
