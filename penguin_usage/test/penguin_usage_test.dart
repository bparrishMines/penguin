import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penguin_usage/penguin_usage.dart';

void main() {
  const MethodChannel channel = MethodChannel('penguin_usage');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await PenguinUsage.platformVersion, '42');
  });
}
