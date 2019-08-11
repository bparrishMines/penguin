import 'package:checked_yaml/checked_yaml.dart';
import 'package:code_builder/code_builder.dart';
import 'package:json_annotation/json_annotation.dart';

import 'plugin_creator.dart';

part 'plugin.g.dart';

@JsonSerializable()
class Plugin {
  Plugin({this.name, this.organization, this.classes});

  factory Plugin.parse(String yaml) {
    return checkedYamlDecode<Plugin>(yaml, (Map map) => Plugin.fromJson(map));
  }

  @JsonKey(required: true, disallowNullValue: true)
  final String name;

  @JsonKey(defaultValue: 'com.example')
  final String organization;

  @JsonKey(defaultValue: const <Class>[])
  final List<Class> classes;

  static String returnType(dynamic fieldOrMethod) {
    if (fieldOrMethod is! Field && fieldOrMethod is! Method) {
      throw ArgumentError();
    }

    if (fieldOrMethod is Field) return fieldOrMethod.type;
    return fieldOrMethod.returns;
  }

  static bool mutable(dynamic fieldOrMethod) {
    if (fieldOrMethod is! Field && fieldOrMethod is! Method) {
      throw ArgumentError();
    }

    if (fieldOrMethod is Field) return fieldOrMethod.mutable;
    return false;
  }

  static bool initialized(dynamic fieldOrMethod) {
    if (fieldOrMethod is! Field && fieldOrMethod is! Method) {
      throw ArgumentError();
    }

    if (fieldOrMethod is Field) return fieldOrMethod.initialized;
    return false;
  }

  static bool allocator(dynamic fieldOrMethod) {
    if (fieldOrMethod is! Field && fieldOrMethod is! Method) {
      throw ArgumentError();
    }

    if (fieldOrMethod is Method) return fieldOrMethod.allocator;
    return false;
  }

  static bool disposer(dynamic fieldOrMethod) {
    if (fieldOrMethod is! Field && fieldOrMethod is! Method) {
      throw ArgumentError();
    }

    if (fieldOrMethod is Method) return fieldOrMethod.disposer;
    return false;
  }

  static List<Parameter> parameters(dynamic fieldMethodOrConstructor) {
    if (fieldMethodOrConstructor is! Field &&
        fieldMethodOrConstructor is! Method &&
        fieldMethodOrConstructor is! Constructor) {
      throw ArgumentError();
    }

    if (fieldMethodOrConstructor is ParameterHolder) {
      return fieldMethodOrConstructor.allParameters;
    }

    return <Parameter>[];
  }

  factory Plugin.fromJson(Map json) => _$PluginFromJson(json);

  Map toJson() => _$PluginToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
class Class {
  Class(
    this.name,
    this.javaPackage, {
    this.methods,
    this.fields,
    this.constructors,
  });

  @JsonKey(required: true, disallowNullValue: true)
  final String name;

  @JsonKey(required: true, disallowNullValue: true)
  final String javaPackage;

  @JsonKey(defaultValue: const <Method>[])
  final List<Method> methods;

  @JsonKey(defaultValue: const <Field>[])
  final List<Field> fields;

  @JsonKey(defaultValue: const <Constructor>[])
  final List<Constructor> constructors;

  ClassDetails _details;

  @JsonKey(ignore: true)
  ClassDetails get details => _details;
  set details(ClassDetails details) {
    assert(_details == null);
    _details = details;
  }

  @JsonKey(ignore: true)
  List<dynamic> get fieldsAndMethods => List<dynamic>.unmodifiable(
        <dynamic>[...fields, ...methods],
      );

  factory Class.fromJson(Map json) => _$ClassFromJson(json);

  Map toJson() => _$ClassToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
class Method extends ParameterHolder {
  Method(
    this.name, {
    this.returns,
    List<Parameter> requiredParameters,
    List<Parameter> optionalParameters,
    this.type,
    this.isStatic,
    this.allocator,
    this.disposer,
  }) : super(requiredParameters, optionalParameters) {
    if (isStatic && (allocator || disposer)) throw ArgumentError();
  }

  @JsonKey(required: true, disallowNullValue: true)
  final String name;

  @JsonKey(defaultValue: 'void')
  final String returns;

  final MethodType type;

  @JsonKey(defaultValue: false)
  final bool isStatic;

  @JsonKey(defaultValue: false)
  final bool allocator;

  @JsonKey(defaultValue: false)
  final bool disposer;

  factory Method.fromJson(Map json) => _$MethodFromJson(json);

  Map toJson() => _$MethodToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
class Parameter {
  Parameter(this.name, {this.type});

  @JsonKey(required: true, disallowNullValue: true)
  final String name;

  @JsonKey(defaultValue: 'dynamic')
  final String type;

  factory Parameter.fromJson(Map json) => _$ParameterFromJson(json);

  Map toJson() => _$ParameterToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
class Field {
  Field(this.name, {this.type, this.isStatic, this.mutable, this.initialized});

  @JsonKey(required: true, disallowNullValue: true)
  final String name;

  @JsonKey(defaultValue: false)
  final bool isStatic;

  @JsonKey(defaultValue: 'dynamic')
  final String type;

  @JsonKey(defaultValue: false)
  final bool mutable;

  @JsonKey(defaultValue: false)
  final bool initialized;

  factory Field.fromJson(Map json) => _$FieldFromJson(json);

  Map toJson() => _$FieldToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
class Constructor extends ParameterHolder {
  Constructor({
    this.isDefault,
    this.name,
    List<Parameter> requiredParameters,
    List<Parameter> optionalParameters,
  })  : assert((isDefault &&
                name == null &&
                requiredParameters.isEmpty &&
                optionalParameters.isEmpty) ||
            (!isDefault &&
                (name != null ||
                    requiredParameters.isNotEmpty ||
                    optionalParameters.isNotEmpty))),
        super(requiredParameters, optionalParameters);

  final String name;

  @JsonKey(defaultValue: false)
  final bool isDefault;

  factory Constructor.fromJson(Map json) => _$ConstructorFromJson(json);

  Map toJson() => _$ConstructorToJson(this);

  @override
  String toString() => toJson().toString();
}

class ParameterHolder {
  ParameterHolder(this.requiredParameters, this.optionalParameters)
      : allParameters = List<Parameter>.unmodifiable(
          <Parameter>[...requiredParameters, ...optionalParameters],
        );

  final List<Parameter> allParameters;

  @JsonKey(defaultValue: const <Parameter>[])
  final List<Parameter> requiredParameters;

  @JsonKey(defaultValue: const <Parameter>[])
  final List<Parameter> optionalParameters;
}
