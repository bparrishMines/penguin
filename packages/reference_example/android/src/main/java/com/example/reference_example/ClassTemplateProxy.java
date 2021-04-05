package com.example.reference_example;

import com.example.reference_example.fakelibrary.ClassTemplate;

public class ClassTemplateProxy implements LibraryTemplate.$ClassTemplate {
  public final ClassTemplate classTemplate;
  private final Integer fieldTemplate;

  public static Double staticMethodTemplate(String parameterTemplate) {
    return ClassTemplate.staticMethodTemplate(parameterTemplate);
  }

  public ClassTemplateProxy(Integer fieldTemplate) {
    this(new ClassTemplate(fieldTemplate), fieldTemplate);
  }

  public ClassTemplateProxy(ClassTemplate classTemplate, Integer fieldTemplate) {
    this.classTemplate = classTemplate;
    this.fieldTemplate = fieldTemplate;
  }

  @Override
  public Object methodTemplate(String parameterTemplate) {
    return getClassTemplate().methodTemplate(parameterTemplate);
  }

  @Override
  public Integer getFieldTemplate() {
    return fieldTemplate;
  }
}
