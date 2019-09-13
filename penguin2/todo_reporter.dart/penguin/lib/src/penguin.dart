import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen/source_gen.dart';

part 'penguin.g.dart';

@JsonSerializable()
class Class {
  const Class(this.platform);

  factory Class.fromJson(Map json) => _$ClassFromJson(json);

  @JsonKey(
    required: true,
    disallowNullValue: true,
    fromJson: _platformFromJson,
    toJson: _platformToJson,
  )
  final Platform platform;

  static Class fromConstantReader(ConstantReader reader) =>
      Class(Platform.fromConstantReader(reader.read('platform')));

  static Platform _platformFromJson(Map json) => AndroidPlatform.fromJson(json);
  static Map _platformToJson(Platform platform) => platform.toJson();

  Map toJson() => _$ClassToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
class Method {
  const Method();
  factory Method.fromJson(Map json) => _$MethodFromJson(json);
  static Method fromConstantReader(ConstantReader reader) => Method();
  Map toJson() => _$MethodToJson(this);
  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
class Constructor {
  const Constructor();
  factory Constructor.fromJson(Map json) => _$ConstructorFromJson(json);
  static Constructor fromConstantReader(ConstantReader reader) => Constructor();
  Map toJson() => _$ConstructorToJson(this);
  @override
  String toString() => toJson().toString();
}

abstract class Platform {
  const Platform(this.name);

  final String name;

  static Platform fromConstantReader(ConstantReader reader) {
    final String platform = reader.read('name').stringValue;

    if (platform == 'android') {
      return AndroidPlatform.fromConstantReader(reader);
    }

    throw UnsupportedError('$platform platform is not supported!');
  }

  Map toJson();
}

@JsonSerializable()
class AndroidPlatform extends Platform {
  const AndroidPlatform(this.type) : super('android');

  factory AndroidPlatform.fromJson(Map json) => _$AndroidPlatformFromJson(json);

  @JsonKey(required: true, disallowNullValue: true)
  final AndroidType type;

  static AndroidPlatform fromConstantReader(ConstantReader reader) {
    return AndroidPlatform(
      AndroidType.fromConstantReader(reader.read('type')),
    );
  }

  Map toJson() => _$AndroidPlatformToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
class AndroidType {
  const AndroidType(this.package, this.name);

  factory AndroidType.fromJson(Map json) => _$AndroidTypeFromJson(json);

  @JsonKey(required: true, disallowNullValue: true)
  final String package;

  @JsonKey(required: true, disallowNullValue: true)
  final String name;

  static AndroidType fromConstantReader(ConstantReader reader) {
    return AndroidType(
      reader.read('package').stringValue,
      reader.read('name').stringValue,
    );
  }

  Map toJson() => _$AndroidTypeToJson(this);

  @override
  String toString() => toJson().toString();
}
