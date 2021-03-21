import 'package:flutter/services.dart';

class Reference {
  const Reference(this.channel);

  final String channel;
}

void main() {
  BinaryMessenger messenger;
  MethodChannel channel;
}
