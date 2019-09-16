import 'package:json_annotation/json_annotation.dart';
import 'package:penguin/penguin.dart';

part 'info.g.dart';

@JsonSerializable()
class ClassInfo {
  const ClassInfo({this.name, this.aClass, this.constructors, this.methods});

  factory ClassInfo.fromJson(Map json) => _$ClassInfoFromJson(json);

  @JsonKey(required: true, disallowNullValue: true)
  final String name;

  @JsonKey(required: true, disallowNullValue: true)
  final Class aClass;

  @JsonKey(required: true, disallowNullValue: true)
  final Iterable<ConstructorInfo> constructors;

  @JsonKey(required: true, disallowNullValue: true)
  final Iterable<MethodInfo> methods;

  Map toJson() => _$ClassInfoToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
class MethodInfo {
  const MethodInfo({this.name, this.method, this.returnType, this.parameters});

  factory MethodInfo.fromJson(Map json) => _$MethodInfoFromJson(json);

  @JsonKey(required: true, disallowNullValue: true)
  final String name;

  @JsonKey(required: true, disallowNullValue: true)
  final TypeInfo returnType;

  @JsonKey(required: true, disallowNullValue: true)
  final Method method;

  @JsonKey(required: true, disallowNullValue: true)
  final Iterable<ParameterInfo> parameters;

  Map toJson() => _$MethodInfoToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
class ConstructorInfo {
  const ConstructorInfo({this.name, this.constructor});

  factory ConstructorInfo.fromJson(Map json) => _$ConstructorInfoFromJson(json);

  @JsonKey(required: true, disallowNullValue: true)
  final String name;

  @JsonKey(required: true, disallowNullValue: true)
  final Constructor constructor;

  Map toJson() => _$ConstructorInfoToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
class ParameterInfo {
  ParameterInfo({this.type, this.name});

  factory ParameterInfo.fromJson(Map json) => _$ParameterInfoFromJson(json);

  final TypeInfo type;
  final String name;

  Map toJson() => _$ParameterInfoToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
class TypeInfo {
  TypeInfo({
    this.name,
    this.isFuture,
    this.isFutureOr,
    this.isBool,
    this.isDouble,
    this.isFunction,
    this.isInt,
    this.isList,
    this.isMap,
    this.isNull,
    this.isNum,
    this.isObject,
    this.isSet,
    this.isString,
    this.isSymbol,
    this.isDynamic,
    this.isVoid,
    this.typeArguments,
    this.isWrapper,
  });

  factory TypeInfo.fromJson(Map json) => _$TypeInfoFromJson(json);

  @JsonKey(required: true, disallowNullValue: true)
  final Iterable<TypeInfo> typeArguments;

  final String name;

  /// Return `true` if this type represents the type 'Future' defined in the
  /// dart:async library.
  @JsonKey(required: true, disallowNullValue: true)
  final bool isFuture;

  /// Return `true` if this type represents the type 'FutureOr<T>' defined in
  /// the dart:async library.
  @JsonKey(required: true, disallowNullValue: true)
  final bool isFutureOr;

  /// Return `true` if this type represents the type 'bool' defined in the
  /// dart:core library.
  @JsonKey(required: true, disallowNullValue: true)
  final bool isBool;

  /// Return `true` if this type represents the type 'double' defined in the
  /// dart:core library.
  @JsonKey(required: true, disallowNullValue: true)
  final bool isDouble;

  /// Return `true` if this type represents the type 'Function' defined in the
  /// dart:core library.
  @JsonKey(required: true, disallowNullValue: true)
  final bool isFunction;

  /// Return `true` if this type represents the type 'int' defined in the
  /// dart:core library.
  @JsonKey(required: true, disallowNullValue: true)
  final bool isInt;

  /// Returns `true` if this type represents the type 'List' defined in the
  /// dart:core library.
  @JsonKey(required: true, disallowNullValue: true)
  final bool isList;

  /// Returns `true` if this type represents the type 'Map' defined in the
  /// dart:core library.
  @JsonKey(required: true, disallowNullValue: true)
  final bool isMap;

  /// Return `true` if this type represents the type 'Null' defined in the
  /// dart:core library.
  @JsonKey(required: true, disallowNullValue: true)
  final bool isNull;

  /// Return `true` if this type represents the type 'num' defined in the
  /// dart:core library.
  @JsonKey(required: true, disallowNullValue: true)
  final bool isNum;

  /// Return `true` if this type represents the type `Object` defined in the
  /// dart:core library.
  @JsonKey(required: true, disallowNullValue: true)
  final bool isObject;

  /// Returns `true` if this type represents the type 'Set' defined in the
  /// dart:core library.
  @JsonKey(required: true, disallowNullValue: true)
  final bool isSet;

  /// Return `true` if this type represents the type 'String' defined in the
  /// dart:core library.
  @JsonKey(required: true, disallowNullValue: true)
  final bool isString;

  /// Returns `true` if this type represents the type 'Symbol' defined in the
  /// dart:core library.
  @JsonKey(required: true, disallowNullValue: true)
  final bool isSymbol;

  /// Return `true` if this type represents the type 'dynamic'.
  @JsonKey(required: true, disallowNullValue: true)
  final bool isDynamic;

  /// Return `true` if this type represents the type 'void'.
  @JsonKey(required: true, disallowNullValue: true)
  final bool isVoid;

  @JsonKey(required: true, disallowNullValue: true)
  final bool isWrapper;

  Map toJson() => _$TypeInfoToJson(this);

  @override
  String toString() => toJson().toString();
}
