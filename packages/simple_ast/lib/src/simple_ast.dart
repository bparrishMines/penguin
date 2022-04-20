import 'package:json_annotation/json_annotation.dart';

part 'simple_ast.g.dart';

enum SimpleTypeCategory {
  isVoid,
  aClass,
  aFunction,
  anEnum,
  aSimpleClass,
  unknown
}

@JsonSerializable()
class SimpleLibrary {
  const SimpleLibrary({
    required this.classes,
    required this.functions,
    required this.enums,
  });

  final List<SimpleClass> classes;

  final List<SimpleFunction> functions;

  final List<SimpleEnum> enums;

  factory SimpleLibrary.fromJson(Map<String, dynamic> json) =>
      _$SimpleLibraryFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleLibraryToJson(this);

  // TODO: Make this better
  @override
  String toString() => '$runtimeType(${toJson().toString()})';
}

@JsonSerializable()
class SimpleEnum {
  const SimpleEnum({required this.name, required this.values});

  final String name;
  final List<String> values;

  factory SimpleEnum.fromJson(Map<String, dynamic> json) =>
      _$SimpleEnumFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleEnumToJson(this);

  @override
  String toString() => '$runtimeType(${toJson().toString()})';
}

@JsonSerializable()
class SimpleClass {
  const SimpleClass({
    required this.name,
    required this.methods,
    required this.constructors,
    required this.fields,
  });

  final String name;

  final List<SimpleMethod> methods;

  final List<SimpleConstructor> constructors;

  final List<SimpleField> fields;

  factory SimpleClass.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassToJson(this);

  @override
  String toString() => '$runtimeType(${toJson().toString()})';
}

@JsonSerializable()
class SimpleMethod {
  const SimpleMethod({
    required this.name,
    required this.returnType,
    required this.parameters,
    required this.static,
  });

  final String name;
  final SimpleType returnType;
  final bool static;
  final List<SimpleParameter> parameters;

  factory SimpleMethod.fromJson(Map<String, dynamic> json) =>
      _$SimpleMethodFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleMethodToJson(this);

  @override
  String toString() => '$runtimeType(${toJson().toString()})';
}

@JsonSerializable()
class SimpleField {
  const SimpleField({required this.name, required this.type});

  final String name;
  final SimpleType type;

  factory SimpleField.fromJson(Map<String, dynamic> json) =>
      _$SimpleFieldFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleFieldToJson(this);

  @override
  String toString() => '$runtimeType(${toJson().toString()})';
}

@JsonSerializable()
class SimpleParameter {
  const SimpleParameter({required this.name, required this.type});

  final String name;
  final SimpleType type;

  factory SimpleParameter.fromJson(Map<String, dynamic> json) =>
      _$SimpleParameterFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleParameterToJson(this);

  @override
  String toString() => '$runtimeType(${toJson().toString()})';
}

@JsonSerializable()
class SimpleType {
  const SimpleType({
    required this.name,
    required this.nullable,
    required this.typeArguments,
    required this.typeCategory,
    required this.functionParameters,
  });

  final String name;
  final bool nullable;
  final List<SimpleType> typeArguments;
  final SimpleTypeCategory typeCategory;
  final List<SimpleParameter> functionParameters;

  factory SimpleType.fromJson(Map<String, dynamic> json) =>
      _$SimpleTypeFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleTypeToJson(this);

  @override
  String toString() => '$runtimeType(${toJson().toString()})';
}

@JsonSerializable()
class SimpleFunction {
  const SimpleFunction({
    required this.name,
    required this.returnType,
    required this.parameters,
  });

  final String name;
  final SimpleType returnType;
  final List<SimpleParameter> parameters;

  factory SimpleFunction.fromJson(Map<String, dynamic> json) =>
      _$SimpleFunctionFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleFunctionToJson(this);

  @override
  String toString() => '$runtimeType(${toJson().toString()})';
}

@JsonSerializable()
class SimpleConstructor {
  const SimpleConstructor({required this.name, required this.parameters});

  factory SimpleConstructor.fromJson(Map<String, dynamic> json) =>
      _$SimpleConstructorFromJson(json);

  final String name;
  final List<SimpleParameter> parameters;

  Map<String, dynamic> toJson() => _$SimpleConstructorToJson(this);

  @override
  String toString() => '$runtimeType(${toJson().toString()})';
}
