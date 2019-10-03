import 'package:penguin/penguin.dart';
import 'package:source_gen/source_gen.dart';

class AnnotationUtils {
  static Class classFromConstantReader(ConstantReader reader) {
    return Class(_platformFromConstantReader(reader.read('platform')));
  }

  static Constructor constructorFromConstantReader(ConstantReader reader) {
    return Constructor();
  }

  static Method methodFromConstantReader(ConstantReader reader) {
    return Method();
  }

  static Field fieldFromConstantReader(ConstantReader reader) {
    return Field();
  }

  static Platform _platformFromConstantReader(ConstantReader reader) {
    final String platform = reader.read('name').stringValue;

    if (platform == 'android') {
      return _androidPlatformFromConstantReader(reader);
    }

    throw UnsupportedError('$platform platform is not supported!');
  }

  static AndroidPlatform _androidPlatformFromConstantReader(
      ConstantReader reader) {
    return AndroidPlatform(
      _androidTypeFromConstantReader(reader.read('type')),
    );
  }

  static AndroidType _androidTypeFromConstantReader(ConstantReader reader) {
    return AndroidType(
      reader.read('package').stringValue,
      reader.read('name').stringValue,
    );
  }
}
