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
    required this.fields,
    required this.methods,
    required this.staticMethods,
  });

  final String name;

  final String? channelName;

  final List<FieldNode> fields;

  final List<MethodNode> methods;

  final List<MethodNode> staticMethods;

  factory ClassNode.fromJson(Map<String, dynamic> json) =>
      _$ClassNodeFromJson(json);

  Map<String, dynamic> toJson() => _$ClassNodeToJson(this);

  @override
  String toString() => '$runtimeType(${toJson().toString()})';
}

@JsonSerializable()
class FieldNode {
  FieldNode({required this.name, required this.type});

  final String name;
  final ReferenceType type;

  factory FieldNode.fromJson(Map<String, dynamic> json) =>
      _$FieldNodeFromJson(json);

  Map<String, dynamic> toJson() => _$FieldNodeToJson(this);

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
    required this.codeGeneratedClass,
    required this.typeArguments,
  });

  final String name;
  final bool nullable;
  final bool codeGeneratedClass;
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
  });

  final String name;
  final ReferenceType returnType;
  final List<ParameterNode> parameters;

  factory FunctionNode.fromJson(Map<String, dynamic> json) =>
      _$FunctionNodeFromJson(json);

  Map<String, dynamic> toJson() => _$FunctionNodeToJson(this);

  @override
  String toString() => '$runtimeType(${toJson().toString()})';
}
