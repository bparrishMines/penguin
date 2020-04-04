package com.example.reference;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import io.flutter.plugin.common.MethodCall;

public abstract class Reference {
  public final String referenceId;

  public Reference(String referenceId) {
    this.referenceId = referenceId;
  }

  protected final MethodCall createMethodCall(final String methodName, final Object[] arguments) {
    final List<Object> newArgumentList = new ArrayList<>();
    newArgumentList.add(referenceId);
    newArgumentList.addAll(Arrays.asList(arguments));
    return new MethodCall(methodName, newArgumentList);
  }
}
