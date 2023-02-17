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
      enums: (json['enums'] as List<dynamic>)
          .map((e) => SimpleEnum.fromJson(e as Map<String, dynamic>))
          .toList(),
      customValues: json['customValues'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$SimpleLibraryToJson(SimpleLibrary instance) =>
    <String, dynamic>{
      'classes': instance.classes,
      'functions': instance.functions,
      'enums': instance.enums,
      'customValues': instance.customValues,
    };

SimpleEnum _$SimpleEnumFromJson(Map<String, dynamic> json) => SimpleEnum(
      name: json['name'] as String,
      private: json['private'] as bool,
      values: (json['values'] as List<dynamic>)
          .map((e) => SimpleField.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SimpleEnumToJson(SimpleEnum instance) =>
    <String, dynamic>{
      'name': instance.name,
      'private': instance.private,
      'values': instance.values,
    };

SimpleClass _$SimpleClassFromJson(Map<String, dynamic> json) => SimpleClass(
      name: json['name'] as String,
      methods: (json['methods'] as List<dynamic>)
          .map((e) => SimpleMethod.fromJson(e as Map<String, dynamic>))
          .toList(),
      private: json['private'] as bool,
      constructors: (json['constructors'] as List<dynamic>)
          .map((e) => SimpleConstructor.fromJson(e as Map<String, dynamic>))
          .toList(),
      fields: (json['fields'] as List<dynamic>)
          .map((e) => SimpleField.fromJson(e as Map<String, dynamic>))
          .toList(),
      customValues: json['customValues'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$SimpleClassToJson(SimpleClass instance) =>
    <String, dynamic>{
      'name': instance.name,
      'private': instance.private,
      'methods': instance.methods,
      'constructors': instance.constructors,
      'fields': instance.fields,
      'customValues': instance.customValues,
    };

SimpleMethod _$SimpleMethodFromJson(Map<String, dynamic> json) => SimpleMethod(
      name: json['name'] as String,
      returnType:
          SimpleType.fromJson(json['returnType'] as Map<String, dynamic>),
      returnsVoid: json['returnsVoid'] as bool,
      parameters: (json['parameters'] as List<dynamic>)
          .map((e) => SimpleParameter.fromJson(e as Map<String, dynamic>))
          .toList(),
      private: json['private'] as bool,
      static: json['static'] as bool,
      customValues: json['customValues'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$SimpleMethodToJson(SimpleMethod instance) =>
    <String, dynamic>{
      'name': instance.name,
      'returnType': instance.returnType,
      'returnsVoid': instance.returnsVoid,
      'private': instance.private,
      'static': instance.static,
      'parameters': instance.parameters,
      'customValues': instance.customValues,
    };

SimpleField _$SimpleFieldFromJson(Map<String, dynamic> json) => SimpleField(
      name: json['name'] as String,
      private: json['private'] as bool,
      static: json['static'] as bool,
      type: SimpleType.fromJson(json['type'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SimpleFieldToJson(SimpleField instance) =>
    <String, dynamic>{
      'name': instance.name,
      'private': instance.private,
      'static': instance.static,
      'type': instance.type,
    };

SimpleParameter _$SimpleParameterFromJson(Map<String, dynamic> json) =>
    SimpleParameter(
      name: json['name'] as String,
      type: SimpleType.fromJson(json['type'] as Map<String, dynamic>),
      isNamed: json['isNamed'] as bool,
      customValues: json['customValues'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$SimpleParameterToJson(SimpleParameter instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'isNamed': instance.isNamed,
      'customValues': instance.customValues,
    };

SimpleType _$SimpleTypeFromJson(Map<String, dynamic> json) => SimpleType(
      name: json['name'] as String,
      nullable: json['nullable'] as bool,
      typeArguments: (json['typeArguments'] as List<dynamic>)
          .map((e) => SimpleType.fromJson(e as Map<String, dynamic>))
          .toList(),
      isVoid: json['isVoid'] as bool,
      isClass: json['isClass'] as bool,
      isFunction: json['isFunction'] as bool,
      isEnum: json['isEnum'] as bool,
      isSimpleClass: json['isSimpleClass'] as bool,
      isUnknownOrUnsupportedType: json['isUnknownOrUnsupportedType'] as bool,
      functionParameters: (json['functionParameters'] as List<dynamic>)
          .map((e) => SimpleParameter.fromJson(e as Map<String, dynamic>))
          .toList(),
      customValues: json['customValues'] as Map<String, dynamic>,
      functionReturnType: json['functionReturnType'] == null
          ? null
          : SimpleType.fromJson(
              json['functionReturnType'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SimpleTypeToJson(SimpleType instance) =>
    <String, dynamic>{
      'name': instance.name,
      'nullable': instance.nullable,
      'typeArguments': instance.typeArguments,
      'functionParameters': instance.functionParameters,
      'functionReturnType': instance.functionReturnType,
      'isVoid': instance.isVoid,
      'isClass': instance.isClass,
      'isFunction': instance.isFunction,
      'isEnum': instance.isEnum,
      'isSimpleClass': instance.isSimpleClass,
      'isUnknownOrUnsupportedType': instance.isUnknownOrUnsupportedType,
      'customValues': instance.customValues,
    };

SimpleFunction _$SimpleFunctionFromJson(Map<String, dynamic> json) =>
    SimpleFunction(
      name: json['name'] as String,
      returnType:
          SimpleType.fromJson(json['returnType'] as Map<String, dynamic>),
      parameters: (json['parameters'] as List<dynamic>)
          .map((e) => SimpleParameter.fromJson(e as Map<String, dynamic>))
          .toList(),
      private: json['private'] as bool,
    );

Map<String, dynamic> _$SimpleFunctionToJson(SimpleFunction instance) =>
    <String, dynamic>{
      'name': instance.name,
      'private': instance.private,
      'returnType': instance.returnType,
      'parameters': instance.parameters,
    };

SimpleConstructor _$SimpleConstructorFromJson(Map<String, dynamic> json) =>
    SimpleConstructor(
      name: json['name'] as String,
      private: json['private'] as bool,
      parameters: (json['parameters'] as List<dynamic>)
          .map((e) => SimpleParameter.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SimpleConstructorToJson(SimpleConstructor instance) =>
    <String, dynamic>{
      'name': instance.name,
      'private': instance.private,
      'parameters': instance.parameters,
    };
