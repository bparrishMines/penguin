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

  static Platform _platformFromJson(Map json) {
    switch (json['name']) {
      case AndroidPlatform._platformName:
        return AndroidPlatform.fromJson(json);
      case IosPlatform._platformName:
        return IosPlatform.fromJson(json);
    }

    throw ArgumentError.value(
      json.toString(),
      'json',
      'Json doesn\'t contain a valid platform name',
    );
  }

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

@JsonSerializable()
class Platform {
  const Platform(this.name);

  @JsonKey()
  final String name;

  Map toJson() => _$PlatformToJson(this);
}

@JsonSerializable()
class AndroidPlatform extends Platform {
  const AndroidPlatform(this.type) : super(_platformName);

  static const String _platformName = 'android';

  factory AndroidPlatform.fromJson(Map json) => _$AndroidPlatformFromJson(json);

  @JsonKey(required: true, disallowNullValue: true)
  final AndroidType type;

  Map toJson() => _$AndroidPlatformToJson(this)..addAll(super.toJson());

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

@JsonSerializable()
class IosPlatform extends Platform {
  const IosPlatform(this.type) : super(_platformName);

  static const String _platformName = 'ios';

  factory IosPlatform.fromJson(Map json) => _$IosPlatformFromJson(json);

  @JsonKey(required: true)
  final IosType type;

  @override
  Map toJson() => _$IosPlatformToJson(this)..addAll(super.toJson());

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
class IosType {
  const IosType(this.name, {this.import});

  factory IosType.fromJson(Map json) => _$IosTypeFromJson(json);

  @JsonKey(required: true, nullable: true)
  final String import;

  @JsonKey(required: true, disallowNullValue: true)
  final String name;

  Map toJson() => _$IosTypeToJson(this);

  @override
  String toString() => toJson().toString();
}
