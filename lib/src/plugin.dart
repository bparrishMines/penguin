import 'package:checked_yaml/checked_yaml.dart';
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
        constructors = constructors ?? const <Constructor>[],
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
  Constructor({
    List<Parameter> requiredParameters,
    List<Parameter> optionalParameters,
    String name,
  })  : requiredParameters = requiredParameters ?? const <Parameter>[],
        optionalParameters = optionalParameters ?? const <Parameter>[],
        name = name ?? '',
        assert(!name.startsWith('_'));

  final List<Parameter> requiredParameters;

  final List<Parameter> optionalParameters;

  final String name;

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
    bool static,
  })  : type = type ?? 'dynamic',
        static = static ?? false,
        assert(name != null);

  final String name;

  final bool static;

  final String type;

  factory Field.fromJson(Map json) => _$FieldFromJson(json);

  Map toJson() => _$FieldToJson(this);

  @override
  String toString() => toJson().toString();
}

class Pace implements _Pace {
  Pace._(this._pace);

  factory Pace._fromJson(Map json) {
    return Pace._(_$_PaceFromJson(json));
  }

  final _Pace _pace;

  @override
  void apple() => _pace.apple();

  @override
  String get name => _pace.name;

  @override
  Map _toJson() => _pace._toJson();

  /*
  @override
  String apple() {
    return super.apple();
  }
  */
}

@JsonSerializable()
class _Pace {
  _Pace(this.name);

  factory _Pace.fromJson(Map json) => _$_PaceFromJson(json);

  Map _toJson() => _$_PaceToJson(this);

  final String name;

  void apple() {
    print('apple');
  }
}
