import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reference/reference.dart';

void main() {
  const MethodChannel channel = MethodChannel('reference');

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
    expect(await Reference.platformVersion, '42');
  });
}
