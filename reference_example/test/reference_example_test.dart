import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reference_example/reference_example.dart';

void main() {
  const MethodChannel channel = MethodChannel('reference_example');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await ReferenceExample.platformVersion, '42');
  });
}
