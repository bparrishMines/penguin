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

const Int8 int8 = const Int8._();
const Int16 int16 = const Int16._();
const Int32 int32 = const Int32._();
const Int64 int64 = const Int64._();
const IntPtr intPtr = const IntPtr._();
const Float float = const Float._();
const Double nativeDouble = const Double._();
const Bool nativeBool = const Bool._();

/// [NativeType]'s subtypes represent a native type in C.
///
/// [NativeType]'s subtypes are not constructible in the Dart code and serve
/// purely as markers in type signatures.
abstract class NativeType {
  const NativeType();
}

/// Represents a native signed 8 bit integer in C.
///
/// [Int8] is not constructible in the Dart code and serves purely as marker in
/// type signatures.
class Int8 extends NativeType {
  const Int8._();
}

/// Represents a native signed 16 bit integer in C.
///
/// [Int16] is not constructible in the Dart code and serves purely as marker in
/// type signatures.
class Int16 extends NativeType {
  const Int16._();
}

/// Represents a native signed 32 bit integer in C.
///
/// [Int32] is not constructible in the Dart code and serves purely as marker in
/// type signatures.
class Int32 extends NativeType {
  const Int32._();
}

/// Represents a native signed 64 bit integer in C.
///
/// [Int64] is not constructible in the Dart code and serves purely as marker in
/// type signatures.
class Int64 extends NativeType {
  const Int64._();
}

/// Represents a native unsigned 8 bit integer in C.
///
/// [Uint8] is not constructible in the Dart code and serves purely as marker in
/// type signatures.
class Uint8 extends NativeType {
  const Uint8._();
}

/// Represents a native unsigned 16 bit integer in C.
///
/// [Uint16] is not constructible in the Dart code and serves purely as marker
/// in type signatures.
class Uint16 extends NativeType {
  const Uint16._();
}

/// Represents a native unsigned 32 bit integer in C.
///
/// [Uint32] is not constructible in the Dart code and serves purely as marker
/// in type signatures.
class Uint32 extends NativeType {
  const Uint32._();
}

/// Represents a native unsigned 64 bit integer in C.
///
/// [Uint64] is not constructible in the Dart code and serves purely as marker
/// in type signatures.
class Uint64 extends NativeType {
  const Uint64._();
}

/// Represents a native pointer-sized integer in C.
///
/// [IntPtr] is not constructible in the Dart code and serves purely as marker
/// in type signatures.
class IntPtr extends NativeType {
  const IntPtr._();
}

/// Represents a native 32 bit float in C.
///
/// [Float] is not constructible in the Dart code and serves purely as marker
/// in type signatures.
class Float extends NativeType {
  const Float._();
}

/// Represents a native 64 bit double in C.
///
/// [Double] is not constructible in the Dart code and serves purely as marker
/// in type signatures.
class Double extends NativeType {
  const Double._();
}

/// Represents a BOOL in Obj-c.
///
/// [Bool] is not constructible in the Dart code and serves purely as marker
/// in type signatures.
class Bool extends NativeType {
  const Bool._();
}
