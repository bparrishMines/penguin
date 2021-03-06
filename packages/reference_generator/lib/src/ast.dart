import 'package:json_annotation/json_annotation.dart';

part 'ast.g.dart';

@JsonSerializable()
class LibraryNode {
  LibraryNode({required this.classes, required this.functions});

  final List<ClassNode> classes;

  final List<FunctionNode> functions;

  factory LibraryNode.fromJson(Map<String, dynamic> json) =>
      _$LibraryNodeFromJson(json);

  Map<String, dynamic> toJson() => _$LibraryNodeToJson(this);

  @override
  String toString() => '$runtimeType(${toJson().toString()})';
}

@JsonSerializable()
class ClassNode {
  ClassNode({
    required this.name,
    required this.channelName,
    required this.methods,
    required this.staticMethods,
    required this.constructors,
  });

  final String name;

  final String? channelName;

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
  MethodNode(
      {required this.name, required this.returnType, required this.parameters});

  final String name;
  final ReferenceType returnType;
  final List<ParameterNode> parameters;

  factory MethodNode.fromJson(Map<String, dynamic> json) =>
      _$MethodNodeFromJson(json);

  Map<String, dynamic> toJson() => _$MethodNodeToJson(this);

  @override
  String toString() => '$runtimeType(${toJson().toString()})';
}

@JsonSerializable()
class ParameterNode {
  ParameterNode({required this.name, required this.type});

  final String name;
  final ReferenceType type;

  factory ParameterNode.fromJson(Map<String, dynamic> json) =>
      _$ParameterNodeFromJson(json);

  Map<String, dynamic> toJson() => _$ParameterNodeToJson(this);

  @override
  String toString() => '$runtimeType(${toJson().toString()})';
}

@JsonSerializable()
class ReferenceType {
  ReferenceType({
    required this.name,
    required this.nullable,
    required this.codeGeneratedType,
    required this.typeArguments,
    required this.functionType,
  });

  final String name;
  final bool nullable;
  final bool codeGeneratedType;
  final bool functionType;
  final List<ReferenceType> typeArguments;

  factory ReferenceType.fromJson(Map<String, dynamic> json) =>
      _$ReferenceTypeFromJson(json);

  Map<String, dynamic> toJson() => _$ReferenceTypeToJson(this);

  @override
  String toString() => '$runtimeType(${toJson().toString()})';
}

@JsonSerializable()
class FunctionNode {
  FunctionNode({
    required this.name,
    required this.returnType,
    required this.parameters,
    required this.channelName,
  });

  final String name;
  final String channelName;
  final ReferenceType returnType;
  final List<ParameterNode> parameters;

  factory FunctionNode.fromJson(Map<String, dynamic> json) =>
      _$FunctionNodeFromJson(json);

  Map<String, dynamic> toJson() => _$FunctionNodeToJson(this);

  @override
  String toString() => '$runtimeType(${toJson().toString()})';
}

@JsonSerializable()
class ConstructorNode {
  ConstructorNode({required this.name, required this.parameters});

  factory ConstructorNode.fromJson(Map<String, dynamic> json) =>
      _$ConstructorNodeFromJson(json);

  final String name;
  final List<ParameterNode> parameters;

  Map<String, dynamic> toJson() => _$ConstructorNodeToJson(this);

  @override
  String toString() => '$runtimeType(${toJson().toString()})';
}
