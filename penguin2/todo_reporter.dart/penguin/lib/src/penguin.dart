import 'package:json_annotation/json_annotation.dart';

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
  Map toJson() => _$MethodToJson(this);
  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
class Constructor {
  const Constructor();
  factory Constructor.fromJson(Map json) => _$ConstructorFromJson(json);
  Map toJson() => _$ConstructorToJson(this);
  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
class Field {
  const Field();
  factory Field.fromJson(Map json) => _$FieldFromJson(json);
  Map toJson() => _$FieldToJson(this);
  @override
  String toString() => toJson().toString();
}

abstract class Platform {
  const Platform(this.name);

  final String name;

  Map toJson();
}

@JsonSerializable()
class AndroidPlatform extends Platform {
  const AndroidPlatform(this.type) : super('android');

  factory AndroidPlatform.fromJson(Map json) => _$AndroidPlatformFromJson(json);

  @JsonKey(required: true, disallowNullValue: true)
  final AndroidType type;

  Map toJson() => _$AndroidPlatformToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
class AndroidType {
  const AndroidType(this.package, this.name);

  factory AndroidType.fromJson(Map json) => _$AndroidTypeFromJson(json);

  @JsonKey(required: true)
  final String package;

  @JsonKey(required: true, disallowNullValue: true)
  final String name;

  Map toJson() => _$AndroidTypeToJson(this);

  @override
  String toString() => toJson().toString();
}
