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
    dartImports:
        (json['dartImports'] as List<dynamic>).map((e) => e as String).toList(),
    platformImports: (json['platformImports'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
  );
}

Map<String, dynamic> _$LibraryNodeToJson(LibraryNode instance) =>
    <String, dynamic>{
      'classes': instance.classes,
      'functions': instance.functions,
      'dartImports': instance.dartImports,
      'platformImports': instance.platformImports,
    };

ClassNode _$ClassNodeFromJson(Map<String, dynamic> json) {
  return ClassNode(
    dartName: json['dartName'] as String,
    platformName: json['platformName'] as String,
    channelName: json['channelName'] as String,
    methods: (json['methods'] as List<dynamic>)
        .map((e) => MethodNode.fromJson(e as Map<String, dynamic>))
        .toList(),
    staticMethods: (json['staticMethods'] as List<dynamic>)
        .map((e) => MethodNode.fromJson(e as Map<String, dynamic>))
        .toList(),
    constructors: (json['constructors'] as List<dynamic>)
        .map((e) => ConstructorNode.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ClassNodeToJson(ClassNode instance) => <String, dynamic>{
      'dartName': instance.dartName,
      'platformName': instance.platformName,
      'channelName': instance.channelName,
      'methods': instance.methods,
      'staticMethods': instance.staticMethods,
      'constructors': instance.constructors,
    };

MethodNode _$MethodNodeFromJson(Map<String, dynamic> json) {
  return MethodNode(
    name: json['name'] as String,
    returnType: TypeNode.fromJson(json['returnType'] as Map<String, dynamic>),
    parameters: (json['parameters'] as List<dynamic>)
        .map((e) => ParameterNode.fromJson(e as Map<String, dynamic>))
        .toList(),
    handlerImplThrows: json['handlerImplThrows'] as bool,
    channelImplThrows: json['channelImplThrows'] as bool,
  );
}

Map<String, dynamic> _$MethodNodeToJson(MethodNode instance) =>
    <String, dynamic>{
      'name': instance.name,
      'returnType': instance.returnType,
      'parameters': instance.parameters,
      'handlerImplThrows': instance.handlerImplThrows,
      'channelImplThrows': instance.channelImplThrows,
    };

ParameterNode _$ParameterNodeFromJson(Map<String, dynamic> json) {
  return ParameterNode(
    name: json['name'] as String,
    type: TypeNode.fromJson(json['type'] as Map<String, dynamic>),
    isNamed: json['isNamed'] as bool,
  );
}

Map<String, dynamic> _$ParameterNodeToJson(ParameterNode instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'isNamed': instance.isNamed,
    };

TypeNode _$TypeNodeFromJson(Map<String, dynamic> json) {
  return TypeNode(
    dartName: json['dartName'] as String,
    platformName: json['platformName'] as String,
    nullable: json['nullable'] as bool,
    typeArguments: (json['typeArguments'] as List<dynamic>)
        .map((e) => TypeNode.fromJson(e as Map<String, dynamic>))
        .toList(),
    functionType: json['functionType'] as bool,
    isReference: json['isReference'] as bool,
    isFuture: json['isFuture'] as bool,
    function: json['function'] == null
        ? null
        : FunctionNode.fromJson(json['function'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TypeNodeToJson(TypeNode instance) => <String, dynamic>{
      'dartName': instance.dartName,
      'platformName': instance.platformName,
      'nullable': instance.nullable,
      'isReference': instance.isReference,
      'functionType': instance.functionType,
      'isFuture': instance.isFuture,
      'typeArguments': instance.typeArguments,
      'function': instance.function,
    };

FunctionNode _$FunctionNodeFromJson(Map<String, dynamic> json) {
  return FunctionNode(
    dartName: json['dartName'] as String,
    platformName: json['platformName'] as String,
    returnType: TypeNode.fromJson(json['returnType'] as Map<String, dynamic>),
    parameters: (json['parameters'] as List<dynamic>)
        .map((e) => ParameterNode.fromJson(e as Map<String, dynamic>))
        .toList(),
    channelName: json['channelName'] as String,
  );
}

Map<String, dynamic> _$FunctionNodeToJson(FunctionNode instance) =>
    <String, dynamic>{
      'dartName': instance.dartName,
      'platformName': instance.platformName,
      'channelName': instance.channelName,
      'returnType': instance.returnType,
      'parameters': instance.parameters,
    };

ConstructorNode _$ConstructorNodeFromJson(Map<String, dynamic> json) {
  return ConstructorNode(
    name: json['name'] as String,
    parameters: (json['parameters'] as List<dynamic>)
        .map((e) => ParameterNode.fromJson(e as Map<String, dynamic>))
        .toList(),
    isNamed: json['isNamed'] as bool,
    handlerImplThrows: json['handlerImplThrows'] as bool,
    channelImplThrows: json['channelImplThrows'] as bool,
  );
}

Map<String, dynamic> _$ConstructorNodeToJson(ConstructorNode instance) =>
    <String, dynamic>{
      'name': instance.name,
      'parameters': instance.parameters,
      'isNamed': instance.isNamed,
      'handlerImplThrows': instance.handlerImplThrows,
      'channelImplThrows': instance.channelImplThrows,
    };
