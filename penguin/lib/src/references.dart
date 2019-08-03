import 'package:code_builder/code_builder.dart';

class References {
  References._(Reference reference);

  static final methodChannel = refer(
    'MethodChannel',
    'package:flutter/services.dart',
  );

  static final visibleForTesting = refer(
    'visibleForTesting',
    'package:flutter/foundation.dart',
  );

  static final channel = refer('Channel', 'channel.dart');

  static future(Reference type) {
    return TypeReference((TypeReferenceBuilder builder) {
      builder
        ..symbol = 'Future'
        ..types.add(type)
        ..url = 'dart:async';
    });
  }
}