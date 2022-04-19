import 'package:json_annotation/json_annotation.dart';

part 'simple_ast.g.dart';

@JsonSerializable()
class SimpleLibrary {
  SimpleLibrary({required this.classes, required this.functions});

  final List<SimpleClass> classes;

  final List<SimpleFunction> functions;

  factory SimpleLibrary.fromJson(Map<String, dynamic> json) =>
      _$SimpleLibraryFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleLibraryToJson(this);

  // TODO: Make this better
  @override
  String toString() => '$runtimeType(${toJson().toString()})';
}

@JsonSerializable()
class SimpleClass {
  SimpleClass({
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
  SimpleMethod({
    required this.name,
    required this.returnType,
    required this.parameters,
  });

  final String name;
  final SimpleType returnType;
  final List<SimpleParameter> parameters;

  factory SimpleMethod.fromJson(Map<String, dynamic> json) =>
      _$SimpleMethodFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleMethodToJson(this);

  @override
  String toString() => '$runtimeType(${toJson().toString()})';
}

@JsonSerializable()
class SimpleField {
  SimpleField({required this.name, required this.type});

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
  SimpleParameter({required this.name, required this.type});

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
  SimpleType({
    required this.name,
    required this.nullable,
    required this.typeArguments,
  });

  final String name;
  final bool nullable;
  final List<SimpleType> typeArguments;

  factory SimpleType.fromJson(Map<String, dynamic> json) =>
      _$SimpleTypeFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleTypeToJson(this);

  @override
  String toString() => '$runtimeType(${toJson().toString()})';
}

@JsonSerializable()
class SimpleFunction {
  SimpleFunction({
    required this.name,
    required this.returnType,
    required this.parameters,
    required this.channelName,
  });

  final String name;
  final String channelName;
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
  SimpleConstructor({required this.name, required this.parameters});

  factory SimpleConstructor.fromJson(Map<String, dynamic> json) =>
      _$SimpleConstructorFromJson(json);

  final String name;
  final List<SimpleParameter> parameters;

  Map<String, dynamic> toJson() => _$SimpleConstructorToJson(this);

  @override
  String toString() => '$runtimeType(${toJson().toString()})';
}
