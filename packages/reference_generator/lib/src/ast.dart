import 'package:json_annotation/json_annotation.dart';

part 'ast.g.dart';

@JsonSerializable()
class LibraryNode {
  LibraryNode({
    required this.classes,
    required this.functions,
    required this.dartImports,
    required this.platformImports,
  });

  final List<ClassNode> classes;

  final List<FunctionNode> functions;

  final List<String> dartImports;

  final List<String> platformImports;

  factory LibraryNode.fromJson(Map<String, dynamic> json) =>
      _$LibraryNodeFromJson(json);

  Map<String, dynamic> toJson() => _$LibraryNodeToJson(this);

  @override
  String toString() => '$runtimeType(${toJson().toString()})';
}

@JsonSerializable()
class ClassNode {
  ClassNode({
    required this.dartName,
    required this.platformName,
    required this.channelName,
    required this.methods,
    required this.staticMethods,
    required this.constructors,
  });

  final String dartName;

  final String platformName;

  final String channelName;

  final List<MethodNode> methods;

  final List<MethodNode> staticMethods;

  final List<ConstructorNode> constructors;

  factory ClassNode.fromJson(Map<String, dynamic> json) =>
      _$ClassNodeFromJson(json);

  Map<String, dynamic> toJson() => _$ClassNodeToJson(this);

  @override
  String toString() => '$runtimeType(${toJson().toString()})';
}

@JsonSerializable()
class MethodNode {
  MethodNode({
    required this.name,
    required this.returnType,
    required this.parameters,
  });

  final String name;
  final TypeNode returnType;
  final List<ParameterNode> parameters;

  factory MethodNode.fromJson(Map<String, dynamic> json) =>
      _$MethodNodeFromJson(json);

  Map<String, dynamic> toJson() => _$MethodNodeToJson(this);

  @override
  String toString() => '$runtimeType(${toJson().toString()})';
}

@JsonSerializable()
class ParameterNode {
  ParameterNode({
    required this.name,
    required this.type,
    required this.isNamed,
  });

  final String name;
  final TypeNode type;
  final bool isNamed;

  factory ParameterNode.fromJson(Map<String, dynamic> json) =>
      _$ParameterNodeFromJson(json);

  Map<String, dynamic> toJson() => _$ParameterNodeToJson(this);

  @override
  String toString() => '$runtimeType(${toJson().toString()})';
}

@JsonSerializable()
class TypeNode {
  TypeNode({
    required this.dartName,
    required this.platformName,
    required this.nullable,
    required this.typeArguments,
    required this.functionType,
    //required this.codeGeneratedType,
    required this.isFuture,
  });

  final String dartName;
  final String platformName;
  final bool nullable;
  //final bool codeGeneratedType;
  final bool functionType;
  final bool isFuture;
  final List<TypeNode> typeArguments;

  factory TypeNode.fromJson(Map<String, dynamic> json) =>
      _$TypeNodeFromJson(json);

  Map<String, dynamic> toJson() => _$TypeNodeToJson(this);

  @override
  String toString() => '$runtimeType(${toJson().toString()})';
}

@JsonSerializable()
class FunctionNode {
  FunctionNode({
    required this.dartName,
    required this.platformName,
    required this.returnType,
    required this.parameters,
    required this.channelName,
  });

  final String dartName;
  final String platformName;
  final String channelName;
  final TypeNode returnType;
  final List<ParameterNode> parameters;

  factory FunctionNode.fromJson(Map<String, dynamic> json) =>
      _$FunctionNodeFromJson(json);

  Map<String, dynamic> toJson() => _$FunctionNodeToJson(this);

  @override
  String toString() => '$runtimeType(${toJson().toString()})';
}

@JsonSerializable()
class ConstructorNode {
  ConstructorNode({
    required this.name,
    required this.parameters,
    required this.isNamed,
  });

  factory ConstructorNode.fromJson(Map<String, dynamic> json) =>
      _$ConstructorNodeFromJson(json);

  final String name;
  final List<ParameterNode> parameters;
  final bool isNamed;

  Map<String, dynamic> toJson() => _$ConstructorNodeToJson(this);

  @override
  String toString() => '$runtimeType(${toJson().toString()})';
}
