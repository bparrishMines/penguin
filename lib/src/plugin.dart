import 'package:checked_yaml/checked_yaml.dart';
import 'package:code_builder/code_builder.dart';
import 'package:json_annotation/json_annotation.dart';

part 'plugin.g.dart';

@JsonSerializable()
class Plugin {
  Plugin({this.name, this.channel, List<Class> classes})
      : classes = classes ?? <Class>[],
        assert(name != null),
        assert(channel != null);

  factory Plugin.parse(String yaml) {
    return checkedYamlDecode<Plugin>(yaml, (Map map) => Plugin.fromJson(map));
  }

  final String name;

  final String channel;

  final List<Class> classes;

  factory Plugin.fromJson(Map json) => _$PluginFromJson(json);

  Map toJson() => _$PluginToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
class Class {
  Class(
    this.name, {
    List<Method> methods,
    List<Constructor> constructors,
    List<Field> fields,
  })  : methods = methods ?? const <Method>[],
        constructors = const <Constructor>[],
        fields = fields ?? const <Field>[],
        assert(name != null);

  final String name;

  final List<Method> methods;

  final List<Constructor> constructors;

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
    String returns,
    List<Parameter> requiredParameters,
    List<Parameter> optionalParameters,
  })  : returns = returns ?? 'void',
        requiredParameters = requiredParameters ?? const <Parameter>[],
        optionalParameters = optionalParameters ?? const <Parameter>[],
        assert(name != null);

  final String name;

  final String returns;

  final List<Parameter> requiredParameters;

  final List<Parameter> optionalParameters;

  factory Method.fromJson(Map json) => _$MethodFromJson(json);

  Map toJson() => _$MethodToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
class Constructor {
  Constructor({bool private}) : private = private ?? false;

  final bool private;

  factory Constructor.fromJson(Map json) => _$ConstructorFromJson(json);

  Map toJson() => _$ConstructorToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
class Parameter {
  Parameter(this.name, {String type})
      : type = type ?? 'dynamic',
        assert(name != null);

  final String name;

  final String type;

  factory Parameter.fromJson(Map json) => _$ParameterFromJson(json);

  Map toJson() => _$ParameterToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
class Field {
  Field(
    this.name, {
    String type,
    FieldModifier modifier,
    bool static,
  })  : type = type ?? 'dynamic',
        static = static ?? false,
        modifier = modifier ?? FieldModifier.var$,
        assert(name != null);

  final String name;

  final FieldModifier modifier;

  final bool static;

  final String type;

  factory Field.fromJson(Map json) => _$FieldFromJson(json);

  Map toJson() => _$FieldToJson(this);

  @override
  String toString() => toJson().toString();
}
