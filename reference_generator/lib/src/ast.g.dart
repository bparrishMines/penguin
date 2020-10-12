// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LibraryNode _$LibraryNodeFromJson(Map<String, dynamic> json) {
  return LibraryNode(
    (json['classes'] as List)
        ?.map((e) =>
            e == null ? null : ClassNode.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$LibraryNodeToJson(LibraryNode instance) =>
    <String, dynamic>{
      'classes': instance.classes,
    };

ClassNode _$ClassNodeFromJson(Map<String, dynamic> json) {
  return ClassNode(
    name: json['name'] as String,
    fields: (json['fields'] as List)
        ?.map((e) =>
            e == null ? null : FieldNode.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    methods: (json['methods'] as List)
        ?.map((e) =>
            e == null ? null : MethodNode.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    staticMethods: (json['staticMethods'] as List)
        ?.map((e) =>
            e == null ? null : MethodNode.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ClassNodeToJson(ClassNode instance) => <String, dynamic>{
      'name': instance.name,
      'fields': instance.fields,
      'methods': instance.methods,
      'staticMethods': instance.staticMethods,
    };

FieldNode _$FieldNodeFromJson(Map<String, dynamic> json) {
  return FieldNode(
    name: json['name'] as String,
    type: json['type'] == null
        ? null
        : ReferenceType.fromJson(json['type'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FieldNodeToJson(FieldNode instance) => <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
    };

MethodNode _$MethodNodeFromJson(Map<String, dynamic> json) {
  return MethodNode(
    name: json['name'] as String,
    returnType: json['returnType'] == null
        ? null
        : ReferenceType.fromJson(json['returnType'] as Map<String, dynamic>),
    parameters: (json['parameters'] as List)
        ?.map((e) => e == null
            ? null
            : ParameterNode.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MethodNodeToJson(MethodNode instance) =>
    <String, dynamic>{
      'name': instance.name,
      'returnType': instance.returnType,
      'parameters': instance.parameters,
    };

ParameterNode _$ParameterNodeFromJson(Map<String, dynamic> json) {
  return ParameterNode(
    name: json['name'] as String,
    type: json['type'] == null
        ? null
        : ReferenceType.fromJson(json['type'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ParameterNodeToJson(ParameterNode instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
    };

ReferenceType _$ReferenceTypeFromJson(Map<String, dynamic> json) {
  return ReferenceType(
    name: json['name'] as String,
    codeGeneratedClass: json['codeGeneratedClass'] as bool,
    typeArguments: (json['typeArguments'] as List)
        ?.map((e) => e == null
            ? null
            : ReferenceType.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ReferenceTypeToJson(ReferenceType instance) =>
    <String, dynamic>{
      'name': instance.name,
      'codeGeneratedClass': instance.codeGeneratedClass,
      'typeArguments': instance.typeArguments,
    };
