import 'package:json_annotation/json_annotation.dart';

part 'ast.g.dart';

@JsonSerializable()
class LibraryNode {
  LibraryNode(this.classes);

  final List<ClassNode> classes;

  factory LibraryNode.fromJson(Map<String, dynamic> json) =>
      _$LibraryNodeFromJson(json);

  Map<String, dynamic> toJson() => _$LibraryNodeToJson(this);

  @override
  String toString() => '$runtimeType(${toJson().toString()})';
}

@JsonSerializable()
class ClassNode {
  ClassNode({
    this.name,
    this.channelName,
    this.fields,
    this.methods,
    this.staticMethods,
  });

  final String name;

  final String channelName;

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
  FieldNode({this.name, this.type});

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
  MethodNode({this.name, this.returnType, this.parameters});

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
  ParameterNode({this.name, this.type});

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
    this.name,
    this.codeGeneratedClass,
    this.referenceChannel,
    this.typeArguments,
  });

  final String name;
  final bool codeGeneratedClass;
  // TODO: remove
  final String referenceChannel;
  final List<ReferenceType> typeArguments;

  bool get hasReferenceChannel => referenceChannel != null;

  factory ReferenceType.fromJson(Map<String, dynamic> json) =>
      _$ReferenceTypeFromJson(json);

  Map<String, dynamic> toJson() => _$ReferenceTypeToJson(this);

  @override
  String toString() => '$runtimeType(${toJson().toString()})';
}
