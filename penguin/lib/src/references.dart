import 'package:code_builder/code_builder.dart';

class References {
  References._();

  static final methodChannel = refer(
    'MethodChannel',
    'package:flutter/services.dart',
  );

  static final methodCall = refer(
    'MethodCall',
    'package:flutter/services.dart',
  );

  static final channel = refer('Channel', 'channel.dart');

  static final methodCallInvokerNode = refer(
    'MethodCallInvokerNode',
    'method_call_invoker.dart',
  );

  static final nodeType = refer('NodeType', 'method_call_invoker.dart');

  static TypeReference future(Reference type) {
    return TypeReference((TypeReferenceBuilder builder) {
      builder
        ..symbol = 'Future'
        ..types.add(type)
        ..url = 'dart:async';
    });
  }

  static TypeReference completer(Reference type) {
    return TypeReference((TypeReferenceBuilder builder) {
      builder
        ..symbol = 'Completer'
        ..types.add(type)
        ..url = 'dart:async';
    });
  }

  static final standardMap = refer('Map<String, dynamic>');
}
