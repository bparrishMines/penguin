import 'package:source_gen/source_gen.dart';

class Class {
  const Class(this.platform) : assert(platform != null);

  final Platform platform;

  static Class fromConstantReader(ConstantReader reader) =>
      Class(Platform.fromConstantReader(reader.read('platform')));
}

class Method {
  const Method();
  static Method fromConstantReader(ConstantReader reader) => Method();
}

abstract class Platform {
  const Platform();

  String get name;

  static Platform fromConstantReader(ConstantReader reader) {
    final String platform = reader.read('name').stringValue;

    if (platform == 'android') {
      return AndroidPlatform.fromConstantReader(reader);
    }

    throw UnsupportedError('$platform platform is not supported!');
  }
}

class AndroidPlatform extends Platform {
  const AndroidPlatform(this.type) : assert(type != null);

  final AndroidType type;

  @override
  final String name = 'android';

  static AndroidPlatform fromConstantReader(ConstantReader reader) {
    return AndroidPlatform(
      AndroidType.fromConstantReader(reader.read('type')),
    );
  }
}

class AndroidType {
  const AndroidType(this.package, this.name);

  final String package;
  final String name;

  static AndroidType fromConstantReader(ConstantReader reader) {
    return AndroidType(
      reader.read('package').stringValue,
      reader.read('name').stringValue,
    );
  }
}
