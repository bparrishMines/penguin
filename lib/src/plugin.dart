import 'package:checked_yaml/checked_yaml.dart';
import 'package:code_builder/code_builder.dart';
import 'package:json_annotation/json_annotation.dart';

import 'plugin_creator.dart';

part 'plugin.g.dart';

@JsonSerializable()
class Plugin {
  Plugin({this.name, this.channel, this.classes});

  factory Plugin.parse(String yaml) {
    return checkedYamlDecode<Plugin>(yaml, (Map map) => Plugin.fromJson(map));
  }

  @JsonKey(required: true, disallowNullValue: true)
  final String name;

  @JsonKey(required: true, disallowNullValue: true)
  final String channel;

  @JsonKey(defaultValue: const <Class>[])
  final List<Class> classes;

  factory Plugin.fromJson(Map json) => _$PluginFromJson(json);

  Map toJson() => _$PluginToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
class Class {
  Class(this.name, this.javaPackage, {this.methods, this.fields, this.constructors,});

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

  factory Class.fromJson(Map json) => _$ClassFromJson(json);

  Map toJson() => _$ClassToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
class Method {
  Method(
    this.name, {
    this.returns,
    this.requiredParameters,
    this.optionalParameters,
    this.type,
    this.isStatic,
  });

  @JsonKey(required: true, disallowNullValue: true)
  final String name;

  @JsonKey(defaultValue: 'void')
  final String returns;

  @JsonKey(defaultValue: const <Parameter>[])
  final List<Parameter> requiredParameters;

  @JsonKey(defaultValue: const <Parameter>[])
  final List<Parameter> optionalParameters;

  final MethodType type;

  @JsonKey(defaultValue: false)
  final bool isStatic;

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
  Field(this.name, {this.type, this.isStatic});

  @JsonKey(required: true, disallowNullValue: true)
  final String name;

  @JsonKey(defaultValue: false)
  final bool isStatic;

  @JsonKey(defaultValue: 'dynamic')
  final String type;

  factory Field.fromJson(Map json) => _$FieldFromJson(json);

  Map toJson() => _$FieldToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
class Constructor {
  Constructor({this.name, this.requiredParameters, this.optionalParameters});

  @JsonKey(defaultValue: '')
  final String name;

  @JsonKey(defaultValue: const <Parameter>[])
  final List<Parameter> requiredParameters;

  @JsonKey(defaultValue: const <Parameter>[])
  final List<Parameter> optionalParameters;

  factory Constructor.fromJson(Map json) => _$ConstructorFromJson(json);

  Map toJson() => _$ConstructorToJson(this);

  @override
  String toString() => toJson().toString();
}
