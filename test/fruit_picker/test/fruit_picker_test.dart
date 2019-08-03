import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fruit_picker/fruit_picker.dart';

void main() {
  const MethodChannel channel = MethodChannel('fruit_picker');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FruitPicker.platformVersion, '42');
  });
}
