package com.example.reference;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import io.flutter.plugin.common.MethodCall;

public class MethodChannelReference extends Reference {
  public MethodChannelReference(final String referenceId) {
    super(referenceId);
  }

  public MethodChannelReference() {
    super();
  }

  protected final MethodCall createMethodCall(final String methodName, final Object[] arguments) {
    final List<Object> newArgumentList = new ArrayList<>();
    newArgumentList.add(referenceId);
    newArgumentList.addAll(Arrays.asList(arguments));
    return new MethodCall(methodName, newArgumentList);
  }
}
