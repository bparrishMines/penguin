// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LibraryNode _$LibraryNodeFromJson(Map<String, dynamic> json) {
  return LibraryNode(
    classes: (json['classes'] as List<dynamic>)
        .map((e) => ClassNode.fromJson(e as Map<String, dynamic>))
        .toList(),
    functions: (json['functions'] as List<dynamic>)
        .map((e) => FunctionNode.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$LibraryNodeToJson(LibraryNode instance) =>
    <String, dynamic>{
      'classes': instance.classes,
      'functions': instance.functions,
    };

ClassNode _$ClassNodeFromJson(Map<String, dynamic> json) {
  return ClassNode(
    name: json['name'] as String,
    channelName: json['channelName'] as String?,
    fields: (json['fields'] as List<dynamic>)
        .map((e) => FieldNode.fromJson(e as Map<String, dynamic>))
        .toList(),
    methods: (json['methods'] as List<dynamic>)
        .map((e) => MethodNode.fromJson(e as Map<String, dynamic>))
        .toList(),
    staticMethods: (json['staticMethods'] as List<dynamic>)
        .map((e) => MethodNode.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ClassNodeToJson(ClassNode instance) => <String, dynamic>{
      'name': instance.name,
      'channelName': instance.channelName,
      'fields': instance.fields,
      'methods': instance.methods,
      'staticMethods': instance.staticMethods,
    };

FieldNode _$FieldNodeFromJson(Map<String, dynamic> json) {
  return FieldNode(
    name: json['name'] as String,
    type: ReferenceType.fromJson(json['type'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FieldNodeToJson(FieldNode instance) => <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
    };

MethodNode _$MethodNodeFromJson(Map<String, dynamic> json) {
  return MethodNode(
    name: json['name'] as String,
    returnType:
        ReferenceType.fromJson(json['returnType'] as Map<String, dynamic>),
    parameters: (json['parameters'] as List<dynamic>)
        .map((e) => ParameterNode.fromJson(e as Map<String, dynamic>))
        .toList(),
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
    type: ReferenceType.fromJson(json['type'] as Map<String, dynamic>),
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
    nullable: json['nullable'] as bool,
    codeGeneratedType: json['codeGeneratedType'] as bool,
    typeArguments: (json['typeArguments'] as List<dynamic>)
        .map((e) => ReferenceType.fromJson(e as Map<String, dynamic>))
        .toList(),
    functionType: json['functionType'] as bool,
  );
}

Map<String, dynamic> _$ReferenceTypeToJson(ReferenceType instance) =>
    <String, dynamic>{
      'name': instance.name,
      'nullable': instance.nullable,
      'codeGeneratedType': instance.codeGeneratedType,
      'functionType': instance.functionType,
      'typeArguments': instance.typeArguments,
    };

FunctionNode _$FunctionNodeFromJson(Map<String, dynamic> json) {
  return FunctionNode(
    name: json['name'] as String,
    returnType:
        ReferenceType.fromJson(json['returnType'] as Map<String, dynamic>),
    parameters: (json['parameters'] as List<dynamic>)
        .map((e) => ParameterNode.fromJson(e as Map<String, dynamic>))
        .toList(),
    channelName: json['channelName'] as String,
  );
}

Map<String, dynamic> _$FunctionNodeToJson(FunctionNode instance) =>
    <String, dynamic>{
      'name': instance.name,
      'channelName': instance.channelName,
      'returnType': instance.returnType,
      'parameters': instance.parameters,
    };
