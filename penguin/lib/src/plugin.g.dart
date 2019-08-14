// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plugin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Plugin _$PluginFromJson(Map json) {
  return $checkedNew('Plugin', json, () {
    $checkKeys(json,
        requiredKeys: const ['name'], disallowNullValues: const ['name']);
    final val = Plugin(
        name: $checkedConvert(json, 'name', (v) => v as String),
        organization:
            $checkedConvert(json, 'organization', (v) => v as String) ??
                'com.example',
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
  val['organization'] = instance.organization;
  val['classes'] = instance.classes;
  return val;
}

Class _$ClassFromJson(Map json) {
  return $checkedNew('Class', json, () {
    $checkKeys(json,
        requiredKeys: const ['name', 'java_package'],
        disallowNullValues: const ['name', 'java_package']);
    final val = Class($checkedConvert(json, 'name', (v) => v as String),
        $checkedConvert(json, 'java_package', (v) => v as String),
        methods: $checkedConvert(
                json,
                'methods',
                (v) => (v as List)
                    ?.map((e) => e == null ? null : Method.fromJson(e as Map))
                    ?.toList()) ??
            [],
        fields:
            $checkedConvert(json, 'fields', (v) => (v as List)?.map((e) => e == null ? null : Field.fromJson(e as Map))?.toList()) ??
                [],
        constructors: $checkedConvert(
                json,
                'constructors',
                (v) => (v as List)
                    ?.map((e) => e == null ? null : Constructor.fromJson(e as Map))
                    ?.toList()) ??
            [],
        constants: $checkedConvert(json, 'constants', (v) => (v as List)?.map((e) => e == null ? null : Constant.fromJson(e as Map))?.toList()) ?? []);
    return val;
  }, fieldKeyMap: const {'javaPackage': 'java_package'});
}

Map<String, dynamic> _$ClassToJson(Class instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('java_package', instance.javaPackage);
  val['methods'] = instance.methods;
  val['fields'] = instance.fields;
  val['constructors'] = instance.constructors;
  val['constants'] = instance.constants;
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
            [],
        type: $checkedConvert(
            json, 'type', (v) => _$enumDecodeNullable(_$MethodTypeEnumMap, v)),
        isStatic: $checkedConvert(json, 'is_static', (v) => v as bool) ?? false,
        allocator:
            $checkedConvert(json, 'allocator', (v) => v as bool) ?? false,
        disposer: $checkedConvert(json, 'disposer', (v) => v as bool) ?? false,
        force: $checkedConvert(json, 'force', (v) => v as bool) ?? false);
    return val;
  }, fieldKeyMap: const {
    'requiredParameters': 'required_parameters',
    'optionalParameters': 'optional_parameters',
    'isStatic': 'is_static'
  });
}

Map<String, dynamic> _$MethodToJson(Method instance) {
  final val = <String, dynamic>{
    'required_parameters': instance.requiredParameters,
    'optional_parameters': instance.optionalParameters,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  val['returns'] = instance.returns;
  val['type'] = _$MethodTypeEnumMap[instance.type];
  val['is_static'] = instance.isStatic;
  val['allocator'] = instance.allocator;
  val['disposer'] = instance.disposer;
  val['force'] = instance.force;
  return val;
}

T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}

const _$MethodTypeEnumMap = <MethodType, dynamic>{
  MethodType.getter: 'getter',
  MethodType.setter: 'setter'
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
        isStatic: $checkedConvert(json, 'is_static', (v) => v as bool) ?? false,
        mutable: $checkedConvert(json, 'mutable', (v) => v as bool) ?? false,
        initialized:
            $checkedConvert(json, 'initialized', (v) => v as bool) ?? false,
        force: $checkedConvert(json, 'force', (v) => v as bool) ?? false);
    return val;
  }, fieldKeyMap: const {'isStatic': 'is_static'});
}

Map<String, dynamic> _$FieldToJson(Field instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  val['is_static'] = instance.isStatic;
  val['type'] = instance.type;
  val['mutable'] = instance.mutable;
  val['initialized'] = instance.initialized;
  val['force'] = instance.force;
  return val;
}

Constructor _$ConstructorFromJson(Map json) {
  return $checkedNew('Constructor', json, () {
    final val = Constructor(
        isDefault:
            $checkedConvert(json, 'is_default', (v) => v as bool) ?? false,
        name: $checkedConvert(json, 'name', (v) => v as String),
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
    'isDefault': 'is_default',
    'requiredParameters': 'required_parameters',
    'optionalParameters': 'optional_parameters'
  });
}

Map<String, dynamic> _$ConstructorToJson(Constructor instance) =>
    <String, dynamic>{
      'required_parameters': instance.requiredParameters,
      'optional_parameters': instance.optionalParameters,
      'name': instance.name,
      'is_default': instance.isDefault
    };

Constant _$ConstantFromJson(Map json) {
  return $checkedNew('Constant', json, () {
    $checkKeys(json,
        requiredKeys: const ['type', 'literal_value', 'name'],
        disallowNullValues: const ['type', 'literal_value', 'name']);
    final val = Constant($checkedConvert(json, 'name', (v) => v as String),
        type: $checkedConvert(json, 'type', (v) => v as String),
        literalValue:
            $checkedConvert(json, 'literal_value', (v) => v as String));
    return val;
  }, fieldKeyMap: const {'literalValue': 'literal_value'});
}

Map<String, dynamic> _$ConstantToJson(Constant instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', instance.type);
  writeNotNull('literal_value', instance.literalValue);
  writeNotNull('name', instance.name);
  return val;
}
