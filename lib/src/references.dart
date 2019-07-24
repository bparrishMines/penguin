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
}
