import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:penguin/penguin.dart';

part 'info.g.dart';

@JsonSerializable()
class ClassInfo {
  const ClassInfo({
    this.typeParameters,
    this.name,
    this.aClass,
    this.constructors,
    this.methods,
    this.fields,
  });

  factory ClassInfo.fromJson(Map json) => _$ClassInfoFromJson(json);

  @JsonKey(required: true, disallowNullValue: true)
  final Iterable<TypeInfo> typeParameters;

  @JsonKey(required: true, disallowNullValue: true)
  final String name;

  @JsonKey(required: true, disallowNullValue: true)
  final Class aClass;

  @JsonKey(required: true, disallowNullValue: true)
  final Iterable<ConstructorInfo> constructors;

  @JsonKey(required: true, disallowNullValue: true)
  final Iterable<MethodInfo> methods;

  @JsonKey(required: true, disallowNullValue: true)
  final Iterable<FieldInfo> fields;

  Map toJson() => _$ClassInfoToJson(this);

  @override
  String toString() => toJson().toString();

  @override
  bool operator ==(other) => toString() == other.toString();

  @override
  int get hashCode => toString().hashCode;
}

@JsonSerializable()
class MethodInfo {
  const MethodInfo({
    this.isStatic,
    this.name,
    this.method,
    this.returnType,
    this.parameters,
  });

  factory MethodInfo.fromJson(Map json) => _$MethodInfoFromJson(json);

  @JsonKey(required: true, disallowNullValue: true)
  final String name;

  @JsonKey(required: true, disallowNullValue: true)
  final TypeInfo returnType;

  @JsonKey(required: true, disallowNullValue: true)
  final Method method;

  @JsonKey(required: true, disallowNullValue: true)
  final bool isStatic;

  @JsonKey(required: true, disallowNullValue: true)
  final Iterable<ParameterInfo> parameters;

  Map toJson() => _$MethodInfoToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
class FieldInfo {
  const FieldInfo({
    this.isMutable,
    this.isStatic,
    this.name,
    this.field,
    this.type,
  });

  factory FieldInfo.fromJson(Map json) => _$FieldInfoFromJson(json);

  @JsonKey(required: true, disallowNullValue: true)
  final String name;

  @JsonKey(required: true, disallowNullValue: true)
  final TypeInfo type;

  @JsonKey(required: true, disallowNullValue: true)
  final Field field;

  @JsonKey(required: true, disallowNullValue: true)
  final bool isStatic;

  @JsonKey(required: true, disallowNullValue: true)
  final bool isMutable;

  Map toJson() => _$FieldInfoToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
class ConstructorInfo {
  const ConstructorInfo({
    this.name,
    this.constructor,
    @required this.parameters,
  });

  factory ConstructorInfo.fromJson(Map json) => _$ConstructorInfoFromJson(json);

  @JsonKey(required: true, disallowNullValue: true)
  final String name;

  @JsonKey(required: true, disallowNullValue: true)
  final Constructor constructor;

  @JsonKey(required: true, disallowNullValue: true)
  final Iterable<ParameterInfo> parameters;

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
    this.isTypeParameter,
    @required this.isNativeInt32,
    @required this.isNativeInt64,
    @required this.isStruct,
    @required this.isProtocol,
  }) {
    if (isStruct && isProtocol) {
      throw ArgumentError.value(
        this.toString(),
        'isProtocol & isStruct',
        'Type cannot be a struct & a protocol',
      );
    }
  }

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

  /// The type introduced by a type parameter.
  ///
  /// i.e. T is a type parameter in List<T>.
  @JsonKey(required: true, disallowNullValue: true)
  final bool isTypeParameter;

  @JsonKey(required: true, disallowNullValue: true)
  final bool isNativeInt32;

  @JsonKey(required: true, disallowNullValue: true)
  final bool isNativeInt64;

  @JsonKey(required: true, disallowNullValue: true)
  final bool isStruct;

  @JsonKey(required: true, disallowNullValue: true)
  final bool isProtocol;

  Map toJson() => _$TypeInfoToJson(this);

  @override
  String toString() => toJson().toString();
}
