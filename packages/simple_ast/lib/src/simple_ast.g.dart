// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_ast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleLibrary _$SimpleLibraryFromJson(Map<String, dynamic> json) =>
    SimpleLibrary(
      classes: (json['classes'] as List<dynamic>)
          .map((e) => SimpleClass.fromJson(e as Map<String, dynamic>))
          .toList(),
      functions: (json['functions'] as List<dynamic>)
          .map((e) => SimpleFunction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SimpleLibraryToJson(SimpleLibrary instance) =>
    <String, dynamic>{
      'classes': instance.classes,
      'functions': instance.functions,
    };

SimpleClass _$SimpleClassFromJson(Map<String, dynamic> json) => SimpleClass(
      name: json['name'] as String,
      methods: (json['methods'] as List<dynamic>)
          .map((e) => SimpleMethod.fromJson(e as Map<String, dynamic>))
          .toList(),
      constructors: (json['constructors'] as List<dynamic>)
          .map((e) => SimpleConstructor.fromJson(e as Map<String, dynamic>))
          .toList(),
      fields: (json['fields'] as List<dynamic>)
          .map((e) => SimpleField.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SimpleClassToJson(SimpleClass instance) =>
    <String, dynamic>{
      'name': instance.name,
      'methods': instance.methods,
      'constructors': instance.constructors,
      'fields': instance.fields,
    };

SimpleMethod _$SimpleMethodFromJson(Map<String, dynamic> json) => SimpleMethod(
      name: json['name'] as String,
      returnType:
          SimpleType.fromJson(json['returnType'] as Map<String, dynamic>),
      parameters: (json['parameters'] as List<dynamic>)
          .map((e) => SimpleParameter.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SimpleMethodToJson(SimpleMethod instance) =>
    <String, dynamic>{
      'name': instance.name,
      'returnType': instance.returnType,
      'parameters': instance.parameters,
    };

SimpleField _$SimpleFieldFromJson(Map<String, dynamic> json) => SimpleField(
      name: json['name'] as String,
      type: SimpleType.fromJson(json['type'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SimpleFieldToJson(SimpleField instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
    };

SimpleParameter _$SimpleParameterFromJson(Map<String, dynamic> json) =>
    SimpleParameter(
      name: json['name'] as String,
      type: SimpleType.fromJson(json['type'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SimpleParameterToJson(SimpleParameter instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
    };

SimpleType _$SimpleTypeFromJson(Map<String, dynamic> json) => SimpleType(
      name: json['name'] as String,
      nullable: json['nullable'] as bool,
      typeArguments: (json['typeArguments'] as List<dynamic>)
          .map((e) => SimpleType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SimpleTypeToJson(SimpleType instance) =>
    <String, dynamic>{
      'name': instance.name,
      'nullable': instance.nullable,
      'typeArguments': instance.typeArguments,
    };

SimpleFunction _$SimpleFunctionFromJson(Map<String, dynamic> json) =>
    SimpleFunction(
      name: json['name'] as String,
      returnType:
          SimpleType.fromJson(json['returnType'] as Map<String, dynamic>),
      parameters: (json['parameters'] as List<dynamic>)
          .map((e) => SimpleParameter.fromJson(e as Map<String, dynamic>))
          .toList(),
      channelName: json['channelName'] as String,
    );

Map<String, dynamic> _$SimpleFunctionToJson(SimpleFunction instance) =>
    <String, dynamic>{
      'name': instance.name,
      'channelName': instance.channelName,
      'returnType': instance.returnType,
      'parameters': instance.parameters,
    };

SimpleConstructor _$SimpleConstructorFromJson(Map<String, dynamic> json) =>
    SimpleConstructor(
      name: json['name'] as String,
      parameters: (json['parameters'] as List<dynamic>)
          .map((e) => SimpleParameter.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SimpleConstructorToJson(SimpleConstructor instance) =>
    <String, dynamic>{
      'name': instance.name,
      'parameters': instance.parameters,
    };
