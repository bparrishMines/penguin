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
                ?.toList()));
    return val;
  });
}

Map<String, dynamic> _$ClassToJson(Class instance) =>
    <String, dynamic>{'name': instance.name, 'methods': instance.methods};

Method _$MethodFromJson(Map json) {
  return $checkedNew('Method', json, () {
    final val = Method($checkedConvert(json, 'name', (v) => v as String));
    return val;
  });
}

Map<String, dynamic> _$MethodToJson(Method instance) =>
    <String, dynamic>{'name': instance.name};
