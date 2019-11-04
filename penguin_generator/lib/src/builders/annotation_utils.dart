import 'package:penguin/penguin.dart';
import 'package:source_gen/source_gen.dart';

class Annotation {
  Annotation._();

  static const TypeChecker $class = const TypeChecker.fromRuntime(Class);
  static const TypeChecker method = const TypeChecker.fromRuntime(Method);
  static const TypeChecker field = const TypeChecker.fromRuntime(Field);
  static const TypeChecker constructor =
      const TypeChecker.fromRuntime(Constructor);
  static const TypeChecker int32Annotation =
      const TypeChecker.fromRuntime(Int32);
}

class AnnotationUtils {
  static Class classFromConstantReader(ConstantReader reader) {
    return Class(
      _platformFromConstantReader(reader.read('platform')),
      androidApi: reader.peek('androidApi') == null
          ? null
          : _androidApiFromConstantReader(reader.read('androidApi')),
    );
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

  static AndroidApi _androidApiFromConstantReader(ConstantReader reader) {
    return AndroidApi(reader.read('api').intValue);
  }

  static Platform _platformFromConstantReader(ConstantReader reader) {
    final String platform = reader.read('name').stringValue;

    if (platform == 'android') {
      return _androidPlatformFromConstantReader(reader);
    } else if (platform == 'ios') {
      return _iosPlatformFromConstantReader(reader);
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
      reader
          .read('names')
          .listValue
          .map<String>(
            (object) => object.toStringValue(),
          )
          .toList(),
    );
  }

  static IosPlatform _iosPlatformFromConstantReader(ConstantReader reader) {
    return IosPlatform(
      _iosTypeFromConstantReader(reader.read('type')),
    );
  }

  static IosType _iosTypeFromConstantReader(ConstantReader reader) {
    return IosType(
      reader.read('name').stringValue,
      import: reader.peek('import') != null
          ? reader.read('import').stringValue
          : null,
    );
  }
}
