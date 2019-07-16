import 'package:checked_yaml/checked_yaml.dart';
import 'package:json_annotation/json_annotation.dart';

part 'plugin.g.dart';

@JsonSerializable()
class Plugin {
  Plugin({this.name, this.channel, this.classes});

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
  Class(this.name, {this.methods, this.constructors});

  final String name;

  final List<Method> methods;

  final List<Constructor> constructors;

  factory Class.fromJson(Map json) => _$ClassFromJson(json);

  Map toJson() => _$ClassToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
class Method {
  Method({this.name, this.returns, this.requiredParameters, this.optionalParameters});

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
  Constructor(this.private);

  final bool private;

  factory Constructor.fromJson(Map json) => _$ConstructorFromJson(json);

  Map toJson() => _$ConstructorToJson(this);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable()
class Parameter {
  Parameter({this.name, this.type});

  final String name;

  final String type;

  factory Parameter.fromJson(Map json) => _$ParameterFromJson(json);

  Map toJson() => _$ParameterToJson(this);

  @override
  String toString() => toJson().toString();
}
