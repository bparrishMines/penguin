package com.example.penguin_usage;

import io.flutter.plugin.common.MethodCall;

public interface FlutterWrapper {
  Object onMethodCall(MethodCall call);
  static class MethodNotImplemented {}
}
