// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassInfo _$ClassInfoFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['name', 'aClass', 'methods'],
      disallowNullValues: const ['name', 'aClass', 'methods']);
  return ClassInfo(
    name: json['name'] as String,
    aClass: json['aClass'] == null
        ? null
        : Class.fromJson(json['aClass'] as Map<String, dynamic>),
    methods: (json['methods'] as List)?.map((e) =>
        e == null ? null : MethodInfo.fromJson(e as Map<String, dynamic>)),
  );
}

Map<String, dynamic> _$ClassInfoToJson(ClassInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('aClass', instance.aClass);
  writeNotNull('methods', instance.methods?.toList());
  return val;
}

MethodInfo _$MethodInfoFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['name', 'method'],
      disallowNullValues: const ['name', 'method']);
  return MethodInfo(
    name: json['name'] as String,
    method: json['method'] == null
        ? null
        : Method.fromJson(json['method'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MethodInfoToJson(MethodInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('method', instance.method);
  return val;
}
