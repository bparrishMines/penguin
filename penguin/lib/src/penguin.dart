import 'package:json_annotation/json_annotation.dart';

part 'penguin.g.dart';

@JsonSerializable()
class Class {
  const Class(this.platform, {this.androidApi});

  factory Class.fromJson(Map json) => _$ClassFromJson(json);

  @JsonKey(
    required: true,
    disallowNullValue: true,
    fromJson: _platformFromJson,
    toJson: _platformToJson,
  )
  final Platform platform;

  @JsonKey(nullable: true)
  final AndroidApi androidApi;

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
  const Method({this.callback = false});

  factory Method.fromJson(Map json) => _$MethodFromJson(json);

  @JsonKey(required: true, disallowNullValue: true)
  final bool callback;

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
  const AndroidType(this.package, this.names);

  factory AndroidType.fromJson(Map json) => _$AndroidTypeFromJson(json);

  @JsonKey(required: true)
  final String package;

  @JsonKey(required: true, disallowNullValue: true)
  final List<String> names;

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
class AndroidApi {
  const AndroidApi(this.api);

  factory AndroidApi.fromJson(Map json) => _$AndroidApiFromJson(json);

  @JsonKey(required: true, nullable: false)
  final int api;

  Map toJson() => _$AndroidApiToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
class IosType {
  const IosType(this.name, {this.import, this.isStruct = false});

  factory IosType.fromJson(Map json) => _$IosTypeFromJson(json);

  @JsonKey(required: true, nullable: true)
  final String import;

  @JsonKey(required: true, disallowNullValue: true)
  final String name;

  @JsonKey(required: true, disallowNullValue: true)
  final bool isStruct;

  Map toJson() => _$IosTypeToJson(this);

  @override
  String toString() => toJson().toString();
}

const PenguinInt8 int8 = const PenguinInt8._();
const PenguinInt16 int16 = const PenguinInt16._();
const PenguinInt32 int32 = const PenguinInt32._();
const PenguinInt64 int64 = const PenguinInt64._();
const PenguinUint8 uint8 = const PenguinUint8._();
const PenguinUint16 uint16 = const PenguinUint16._();
const PenguinUint32 uint32 = const PenguinUint32._();
const PenguinUint64 uint64 = const PenguinUint64._();
const PenguinIntPtr intPtr = const PenguinIntPtr._();
const PenguinFloat float = const PenguinFloat._();
const PenguinDouble nativeDouble = const PenguinDouble._();
const PenguinBool nativeBool = const PenguinBool._();

/// [PenguinNativeType]'s subtypes represent a native type in C.
///
/// [PenguinNativeType]'s subtypes are not constructible in the Dart code and serve
/// purely as markers in type signatures.
abstract class PenguinNativeType {
  const PenguinNativeType();
}

/// Represents a native signed 8 bit integer in C.
///
/// [PenguinInt8] is not constructible in the Dart code and serves purely as marker in
/// type signatures.
class PenguinInt8 extends PenguinNativeType {
  const PenguinInt8._();
}

/// Represents a native signed 16 bit integer in C.
///
/// [PenguinInt16] is not constructible in the Dart code and serves purely as marker in
/// type signatures.
class PenguinInt16 extends PenguinNativeType {
  const PenguinInt16._();
}

/// Represents a native signed 32 bit integer in C.
///
/// [PenguinInt32] is not constructible in the Dart code and serves purely as marker in
/// type signatures.
class PenguinInt32 extends PenguinNativeType {
  const PenguinInt32._();
}

/// Represents a native signed 64 bit integer in C.
///
/// [PenguinInt64] is not constructible in the Dart code and serves purely as marker in
/// type signatures.
class PenguinInt64 extends PenguinNativeType {
  const PenguinInt64._();
}

/// Represents a native unsigned 8 bit integer in C.
///
/// [PenguinUint8] is not constructible in the Dart code and serves purely as marker in
/// type signatures.
class PenguinUint8 extends PenguinNativeType {
  const PenguinUint8._();
}

/// Represents a native unsigned 16 bit integer in C.
///
/// [PenguinUint16] is not constructible in the Dart code and serves purely as marker
/// in type signatures.
class PenguinUint16 extends PenguinNativeType {
  const PenguinUint16._();
}

/// Represents a native unsigned 32 bit integer in C.
///
/// [PenguinUint32] is not constructible in the Dart code and serves purely as marker
/// in type signatures.
class PenguinUint32 extends PenguinNativeType {
  const PenguinUint32._();
}

/// Represents a native unsigned 64 bit integer in C.
///
/// [PenguinUint64] is not constructible in the Dart code and serves purely as marker
/// in type signatures.
class PenguinUint64 extends PenguinNativeType {
  const PenguinUint64._();
}

/// Represents a native pointer-sized integer in C.
///
/// [PenguinIntPtr] is not constructible in the Dart code and serves purely as marker
/// in type signatures.
class PenguinIntPtr extends PenguinNativeType {
  const PenguinIntPtr._();
}

/// Represents a native 32 bit float in C.
///
/// [PenguinFloat] is not constructible in the Dart code and serves purely as marker
/// in type signatures.
class PenguinFloat extends PenguinNativeType {
  const PenguinFloat._();
}

/// Represents a native 64 bit double in C.
///
/// [PenguinDouble] is not constructible in the Dart code and serves purely as marker
/// in type signatures.
class PenguinDouble extends PenguinNativeType {
  const PenguinDouble._();
}

/// Represents a BOOL in Obj-c.
///
/// [PenguinBool] is not constructible in the Dart code and serves purely as marker
/// in type signatures.
class PenguinBool extends PenguinNativeType {
  const PenguinBool._();
}
