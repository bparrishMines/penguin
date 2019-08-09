import 'package:code_builder/code_builder.dart';

class References {
  References._(Reference reference);

  static final methodChannel = refer(
    'MethodChannel',
    'package:flutter/services.dart',
  );

  static final methodCall = refer(
    'MethodCall',
    'package:flutter/services.dart',
  );

  static final visibleForTesting = refer(
    'visibleForTesting',
    'package:flutter/foundation.dart',
  );

  static final channel = refer('Channel', 'channel.dart');

  static final methodCallInvoker = refer(
    'MethodCallInvoker',
    'method_call_invoker.dart',
  );

  static final methodCallInvokerNode = refer(
    'MethodCallInvokerNode',
    'method_call_invoker.dart',
  );

  static TypeReference future(Reference type) {
    return TypeReference((TypeReferenceBuilder builder) {
      builder
        ..symbol = 'Future'
        ..types.add(type)
        ..url = 'dart:async';
    });
  }
}
