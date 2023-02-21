import 'package:json_annotation/json_annotation.dart';

part 'simple_ast.g.dart';

@JsonSerializable()
class SimpleLibrary {
  const SimpleLibrary({
    required this.classes,
    required this.functions,
    required this.enums,
    required this.customValues,
  });

  final List<SimpleClass> classes;

  final List<SimpleFunction> functions;

  final List<SimpleEnum> enums;

  final Map<String, Object?> customValues;

  factory SimpleLibrary.fromJson(Map<String, dynamic> json) =>
      _$SimpleLibraryFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleLibraryToJson(this);

  // TODO: Make this better
  @override
  String toString() => '$runtimeType(${toJson().toString()})';
}

@JsonSerializable()
class SimpleEnum {
  const SimpleEnum({
    required this.name,
    required this.private,
    required this.values,
  });

  final String name;
  final bool private;
  final List<SimpleField> values;

  factory SimpleEnum.fromJson(Map<String, dynamic> json) =>
      _$SimpleEnumFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleEnumToJson(this);

  @override
  String toString() => '$runtimeType(${toJson().toString()})';
}

@JsonSerializable()
class SimpleClass {
  const SimpleClass({
    required this.name,
    required this.methods,
    required this.private,
    required this.constructors,
    required this.fields,
    required this.customValues,
  });

  final String name;

  final bool private;

  final List<SimpleMethod> methods;

  final List<SimpleConstructor> constructors;

  final List<SimpleField> fields;

  final Map<String, Object?> customValues;

  factory SimpleClass.fromJson(Map<String, dynamic> json) =>
      _$SimpleClassFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleClassToJson(this);

  @override
  String toString() => '$runtimeType(${toJson().toString()})';
}

@JsonSerializable()
class SimpleMethod {
  const SimpleMethod({
    required this.name,
    required this.returnType,
    required this.returnsVoid,
    required this.parameters,
    required this.private,
    required this.static,
    required this.customValues,
  });

  final String name;
  final SimpleType returnType;

  /// Whether this method returns void.
  ///
  /// This also includes methods that return Future<void> in Dart.
  final bool returnsVoid;
  final bool private;
  final bool static;
  final List<SimpleParameter> parameters;
  final Map<String, Object?> customValues;

  factory SimpleMethod.fromJson(Map<String, dynamic> json) =>
      _$SimpleMethodFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleMethodToJson(this);

  @override
  String toString() => '$runtimeType(${toJson().toString()})';
}

@JsonSerializable()
class SimpleField {
  const SimpleField(
      {required this.name,
      required this.private,
      required this.static,
      required this.type});

  final String name;
  final bool private;
  final bool static;
  final SimpleType type;

  factory SimpleField.fromJson(Map<String, dynamic> json) =>
      _$SimpleFieldFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleFieldToJson(this);

  @override
  String toString() => '$runtimeType(${toJson().toString()})';
}

@JsonSerializable()
class SimpleParameter {
  const SimpleParameter({
    required this.name,
    required this.type,
    required this.isNamed,
    required this.customValues,
  });

  final String name;
  final SimpleType type;
  final bool isNamed;
  final Map<String, Object?> customValues;

  factory SimpleParameter.fromJson(Map<String, dynamic> json) =>
      _$SimpleParameterFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleParameterToJson(this);

  @override
  String toString() => '$runtimeType(${toJson().toString()})';
}

@JsonSerializable()
class SimpleType {
  const SimpleType({
    required this.name,
    required this.nullable,
    required this.typeArguments,
    required this.isVoid,
    required this.isClass,
    required this.isFunction,
    required this.isEnum,
    required this.isSimpleClass,
    required this.isUnknownOrUnsupportedType,
    required this.functionParameters,
    required this.customValues,
    required this.functionReturnType,
  }) : assert((functionReturnType != null && isFunction) ||
            (functionReturnType == null && !isFunction));

  final String name;
  final bool nullable;
  final List<SimpleType> typeArguments;
  final List<SimpleParameter> functionParameters;
  final SimpleType? functionReturnType;

  final bool isVoid;
  final bool isClass;
  final bool isFunction;
  final bool isEnum;
  final bool isSimpleClass;
  final bool isUnknownOrUnsupportedType;

  final Map<String, Object?> customValues;

  factory SimpleType.fromJson(Map<String, dynamic> json) =>
      _$SimpleTypeFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleTypeToJson(this);

  @override
  String toString() => '$runtimeType(${toJson().toString()})';
}

@JsonSerializable()
class SimpleFunction {
  const SimpleFunction({
    required this.name,
    required this.returnType,
    required this.parameters,
    required this.private,
  });

  final String name;
  final bool private;
  final SimpleType returnType;
  final List<SimpleParameter> parameters;

  factory SimpleFunction.fromJson(Map<String, dynamic> json) =>
      _$SimpleFunctionFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleFunctionToJson(this);

  @override
  String toString() => '$runtimeType(${toJson().toString()})';
}

@JsonSerializable()
class SimpleConstructor {
  const SimpleConstructor({
    required this.name,
    required this.private,
    required this.parameters,
    required this.customValues,
  });

  factory SimpleConstructor.fromJson(Map<String, dynamic> json) =>
      _$SimpleConstructorFromJson(json);

  final String name;
  final bool private;
  final List<SimpleParameter> parameters;
  final Map<String, Object?> customValues;

  Map<String, dynamic> toJson() => _$SimpleConstructorToJson(this);

  @override
  String toString() => '$runtimeType(${toJson().toString()})';
}
