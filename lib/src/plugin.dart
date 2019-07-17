import 'package:checked_yaml/checked_yaml.dart';
import 'package:json_annotation/json_annotation.dart';

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
  Class(this.name, {this.methods, this.fields});

  @JsonKey(required: true, disallowNullValue: true)
  final String name;

  @JsonKey(defaultValue: const <Method>[])
  final List<Method> methods;

  /*
  @JsonKey(defaultValue: const <Constructor>[])
  final List<Constructor> constructors;
  */

  @JsonKey(defaultValue: const <Field>[])
  final List<Field> fields;

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
  });

  @JsonKey(required: true, disallowNullValue: true)
  final String name;

  @JsonKey(defaultValue: 'void')
  final String returns;

  @JsonKey(defaultValue: const <Parameter>[])
  final List<Parameter> requiredParameters;

  @JsonKey(defaultValue: const <Parameter>[])
  final List<Parameter> optionalParameters;

  factory Method.fromJson(Map json) => _$MethodFromJson(json);

  Map toJson() => _$MethodToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
class Constructor {
  Constructor({this.name, this.requiredParameters, this.optionalParameters})
      : assert(!name.startsWith('_'));

  @JsonKey(defaultValue: const <Parameter>[])
  final List<Parameter> requiredParameters;

  @JsonKey(defaultValue: const <Parameter>[])
  final List<Parameter> optionalParameters;

  @JsonKey(defaultValue: '')
  final String name;

  factory Constructor.fromJson(Map json) => _$ConstructorFromJson(json);

  Map toJson() => _$ConstructorToJson(this);

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
  Field(this.name, {this.type, this.static});

  @JsonKey(required: true, disallowNullValue: true)
  final String name;

  @JsonKey(defaultValue: false)
  final bool static;

  @JsonKey(defaultValue: 'dynamic')
  final String type;

  factory Field.fromJson(Map json) => _$FieldFromJson(json);

  Map toJson() => _$FieldToJson(this);

  @override
  String toString() => toJson().toString();
}
