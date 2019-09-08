package com.example.penguin_usage;

import io.flutter.plugin.common.MethodCall;

// CLASS
class FlutterUsage1 implements FlutterWrapper {
  private final String handle;
  public final Usage1 usage1;
  
  
  Object method() {
    return usage1.method();
  }
  
}
// end CLASS
