package com.example.reference_example;

import com.example.reference_example.fakelibrary.ClassTemplate;

public class ClassTemplateProxy implements LibraryTemplate.$ClassTemplate {
  private final Integer fieldTemplate;
  private final ClassTemplate classTemplate;

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

  public ClassTemplate getClassTemplate() {
    return classTemplate;
  }

  @Override
  public Integer getFieldTemplate() {
    return fieldTemplate;
  }
}
