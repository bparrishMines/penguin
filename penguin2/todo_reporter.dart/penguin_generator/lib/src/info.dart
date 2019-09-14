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
  const MethodInfo({this.name, this.method, this.returnType});

  factory MethodInfo.fromJson(Map json) => _$MethodInfoFromJson(json);

  @JsonKey(required: true, disallowNullValue: true)
  final String name;

  @JsonKey(required: true, disallowNullValue: true)
  final String returnType;

  @JsonKey(required: true, disallowNullValue: true)
  final Method method;

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
