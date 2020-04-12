import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:penguin/penguin.dart';
import 'package:reference/reference.dart';
import 'package:test_plugin_platform_interface/test_plugin_platform_interface.dart';

part 'implementation.g.dart';

@MethodChannelImplementation()
class MobileTestClass extends TestClass with ReferenceHolder {
  const MobileTestClass(String testField, onTestCallback)
      : super(testField, onTestCallback);

  @override
  FutureOr<int> testMethod(String testParameter) {

  }
}
