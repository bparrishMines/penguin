// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plugin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Plugin _$PluginFromJson(Map json) {
  return $checkedNew('Plugin', json, () {
    $checkKeys(json,
        requiredKeys: const ['name', 'channel'],
        disallowNullValues: const ['name', 'channel']);
    final val = Plugin(
        name: $checkedConvert(json, 'name', (v) => v as String),
        channel: $checkedConvert(json, 'channel', (v) => v as String),
        classes: $checkedConvert(
                json,
                'classes',
                (v) => (v as List)
                    ?.map((e) => e == null ? null : Class.fromJson(e as Map))
                    ?.toList()) ??
            []);
    return val;
  });
}

Map<String, dynamic> _$PluginToJson(Plugin instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('channel', instance.channel);
  val['classes'] = instance.classes;
  return val;
}

Class _$ClassFromJson(Map json) {
  return $checkedNew('Class', json, () {
    $checkKeys(json,
        requiredKeys: const ['name'], disallowNullValues: const ['name']);
    final val = Class($checkedConvert(json, 'name', (v) => v as String),
        methods: $checkedConvert(
                json,
                'methods',
                (v) => (v as List)
                    ?.map((e) => e == null ? null : Method.fromJson(e as Map))
                    ?.toList()) ??
            [],
        fields: $checkedConvert(
                json,
                'fields',
                (v) => (v as List)
                    ?.map((e) => e == null ? null : Field.fromJson(e as Map))
                    ?.toList()) ??
            []);
    return val;
  });
}

Map<String, dynamic> _$ClassToJson(Class instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  val['methods'] = instance.methods;
  val['fields'] = instance.fields;
  return val;
}

Method _$MethodFromJson(Map json) {
  return $checkedNew('Method', json, () {
    $checkKeys(json,
        requiredKeys: const ['name'], disallowNullValues: const ['name']);
    final val = Method($checkedConvert(json, 'name', (v) => v as String),
        returns: $checkedConvert(json, 'returns', (v) => v as String) ?? 'void',
        requiredParameters: $checkedConvert(
                json,
                'required_parameters',
                (v) => (v as List)
                    ?.map(
                        (e) => e == null ? null : Parameter.fromJson(e as Map))
                    ?.toList()) ??
            [],
        optionalParameters: $checkedConvert(
                json,
                'optional_parameters',
                (v) => (v as List)
                    ?.map(
                        (e) => e == null ? null : Parameter.fromJson(e as Map))
                    ?.toList()) ??
            []);
    return val;
  }, fieldKeyMap: const {
    'requiredParameters': 'required_parameters',
    'optionalParameters': 'optional_parameters'
  });
}

Map<String, dynamic> _$MethodToJson(Method instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  val['returns'] = instance.returns;
  val['required_parameters'] = instance.requiredParameters;
  val['optional_parameters'] = instance.optionalParameters;
  return val;
}

Constructor _$ConstructorFromJson(Map json) {
  return $checkedNew('Constructor', json, () {
    final val = Constructor(
        name: $checkedConvert(json, 'name', (v) => v as String) ?? '',
        requiredParameters: $checkedConvert(
                json,
                'required_parameters',
                (v) => (v as List)
                    ?.map(
                        (e) => e == null ? null : Parameter.fromJson(e as Map))
                    ?.toList()) ??
            [],
        optionalParameters: $checkedConvert(
                json,
                'optional_parameters',
                (v) => (v as List)
                    ?.map(
                        (e) => e == null ? null : Parameter.fromJson(e as Map))
                    ?.toList()) ??
            []);
    return val;
  }, fieldKeyMap: const {
    'requiredParameters': 'required_parameters',
    'optionalParameters': 'optional_parameters'
  });
}

Map<String, dynamic> _$ConstructorToJson(Constructor instance) =>
    <String, dynamic>{
      'required_parameters': instance.requiredParameters,
      'optional_parameters': instance.optionalParameters,
      'name': instance.name
    };

Parameter _$ParameterFromJson(Map json) {
  return $checkedNew('Parameter', json, () {
    $checkKeys(json,
        requiredKeys: const ['name'], disallowNullValues: const ['name']);
    final val = Parameter($checkedConvert(json, 'name', (v) => v as String),
        type: $checkedConvert(json, 'type', (v) => v as String) ?? 'dynamic');
    return val;
  });
}

Map<String, dynamic> _$ParameterToJson(Parameter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  val['type'] = instance.type;
  return val;
}

Field _$FieldFromJson(Map json) {
  return $checkedNew('Field', json, () {
    $checkKeys(json,
        requiredKeys: const ['name'], disallowNullValues: const ['name']);
    final val = Field($checkedConvert(json, 'name', (v) => v as String),
        type: $checkedConvert(json, 'type', (v) => v as String) ?? 'dynamic',
        static: $checkedConvert(json, 'static', (v) => v as bool) ?? false);
    return val;
  });
}

Map<String, dynamic> _$FieldToJson(Field instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  val['static'] = instance.static;
  val['type'] = instance.type;
  return val;
}
