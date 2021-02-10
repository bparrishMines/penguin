import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penguin_android_camera/penguin_android_camera.dart';

void main() {
  const MethodChannel channel = MethodChannel('penguin_android_camera');

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
    expect(await PenguinAndroidCamera.platformVersion, '42');
  });
}
