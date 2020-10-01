import 'package:json_annotation/json_annotation.dart';

part 'ast.g.dart';

@JsonSerializable()
class LibraryNode {
  LibraryNode(this.classes);

  final Iterable<ClassNode> classes;

  factory LibraryNode.fromJson(Map<String, dynamic> json) =>
      _$LibraryNodeFromJson(json);

  Map<String, dynamic> toJson() => _$LibraryNodeToJson(this);

  @override
  String toString() => '$runtimeType(${toJson().toString()})';
}

@JsonSerializable()
class ClassNode {
  ClassNode(this.name);

  final String name;

  factory ClassNode.fromJson(Map<String, dynamic> json) =>
      _$ClassNodeFromJson(json);

  Map<String, dynamic> toJson() => _$ClassNodeToJson(this);

  @override
  String toString() => '$runtimeType(${toJson().toString()})';
}
