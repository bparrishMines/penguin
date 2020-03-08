import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import '../test_plugin.dart';

class TestPluginPlatform extends PlatformInterface {
  TestPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static TestPluginPlatform _instance;

  static TestPluginPlatform get instance => _instance;

  /// Sets the platform instance that handles instantiating objects.
  ///
  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [TestPluginPlatform] when they register themselves.
  static set instance(TestPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  TestClass createTestClass(TestClass testClass) {
    throw UnimplementedError('createTestClass() has not been implemented.');
  }
}