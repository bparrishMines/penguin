// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plugin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Plugin _$PluginFromJson(Map json) {
  return $checkedNew('Plugin', json, () {
    final val = Plugin(
        name: $checkedConvert(json, 'name', (v) => v as String),
        channel: $checkedConvert(json, 'channel', (v) => v as String),
        classes: $checkedConvert(
            json,
            'classes',
            (v) => (v as List)
                ?.map((e) => e == null ? null : Class.fromJson(e as Map))
                ?.toList()));
    return val;
  });
}

Map<String, dynamic> _$PluginToJson(Plugin instance) => <String, dynamic>{
      'name': instance.name,
      'channel': instance.channel,
      'classes': instance.classes
    };

Class _$ClassFromJson(Map json) {
  return $checkedNew('Class', json, () {
    final val = Class($checkedConvert(json, 'name', (v) => v as String),
        methods: $checkedConvert(
            json,
            'methods',
            (v) => (v as List)
                ?.map((e) => e == null ? null : Method.fromJson(e as Map))
                ?.toList()),
        constructors: $checkedConvert(
            json,
            'constructors',
            (v) => (v as List)
                ?.map((e) => e == null ? null : Constructor.fromJson(e as Map))
                ?.toList()),
        fields: $checkedConvert(
            json,
            'fields',
            (v) => (v as List)
                ?.map((e) => e == null ? null : Field.fromJson(e as Map))
                ?.toList()));
    return val;
  });
}

Map<String, dynamic> _$ClassToJson(Class instance) => <String, dynamic>{
      'name': instance.name,
      'methods': instance.methods,
      'constructors': instance.constructors,
      'fields': instance.fields
    };

Method _$MethodFromJson(Map json) {
  return $checkedNew('Method', json, () {
    final val = Method($checkedConvert(json, 'name', (v) => v as String),
        returns: $checkedConvert(json, 'returns', (v) => v as String),
        requiredParameters: $checkedConvert(
            json,
            'required_parameters',
            (v) => (v as List)
                ?.map((e) => e == null ? null : Parameter.fromJson(e as Map))
                ?.toList()),
        optionalParameters: $checkedConvert(
            json,
            'optional_parameters',
            (v) => (v as List)
                ?.map((e) => e == null ? null : Parameter.fromJson(e as Map))
                ?.toList()));
    return val;
  }, fieldKeyMap: const {
    'requiredParameters': 'required_parameters',
    'optionalParameters': 'optional_parameters'
  });
}

Map<String, dynamic> _$MethodToJson(Method instance) => <String, dynamic>{
      'name': instance.name,
      'returns': instance.returns,
      'required_parameters': instance.requiredParameters,
      'optional_parameters': instance.optionalParameters
    };

Constructor _$ConstructorFromJson(Map json) {
  return $checkedNew('Constructor', json, () {
    final val = Constructor(
        private: $checkedConvert(json, 'private', (v) => v as bool));
    return val;
  });
}

Map<String, dynamic> _$ConstructorToJson(Constructor instance) =>
    <String, dynamic>{'private': instance.private};

Parameter _$ParameterFromJson(Map json) {
  return $checkedNew('Parameter', json, () {
    final val = Parameter($checkedConvert(json, 'name', (v) => v as String),
        type: $checkedConvert(json, 'type', (v) => v as String));
    return val;
  });
}

Map<String, dynamic> _$ParameterToJson(Parameter instance) =>
    <String, dynamic>{'name': instance.name, 'type': instance.type};

Field _$FieldFromJson(Map json) {
  return $checkedNew('Field', json, () {
    final val = Field($checkedConvert(json, 'name', (v) => v as String),
        type: $checkedConvert(json, 'type', (v) => v as String),
        modifier: $checkedConvert(json, 'modifier',
            (v) => _$enumDecodeNullable(_$FieldModifierEnumMap, v)),
        static: $checkedConvert(json, 'static', (v) => v as bool));
    return val;
  });
}

Map<String, dynamic> _$FieldToJson(Field instance) => <String, dynamic>{
      'name': instance.name,
      'modifier': _$FieldModifierEnumMap[instance.modifier],
      'static': instance.static,
      'type': instance.type
    };

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

const _$FieldModifierEnumMap = <FieldModifier, dynamic>{
  FieldModifier.var$: r'var$',
  FieldModifier.final$: r'final$',
  FieldModifier.constant: 'constant'
};
