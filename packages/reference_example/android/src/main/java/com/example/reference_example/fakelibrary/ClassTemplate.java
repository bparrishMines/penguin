package com.example.reference_example.fakelibrary;

public class ClassTemplate {
  public Integer fieldTemplate;

  public static double staticMethodTemplate(String parameterTemplate) {
    return parameterTemplate.length() / 1.0;
  }

  public ClassTemplate(Integer fieldTemplate) {
    this.fieldTemplate = fieldTemplate;
  }

  public String methodTemplate(String parameterTemplate) {
    return parameterTemplate + " World!";
  }
}
