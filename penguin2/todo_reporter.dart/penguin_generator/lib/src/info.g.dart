// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassInfo _$ClassInfoFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['name', 'aClass', 'constructors', 'methods'],
      disallowNullValues: const ['name', 'aClass', 'constructors', 'methods']);
  return ClassInfo(
    name: json['name'] as String,
    aClass: json['aClass'] == null
        ? null
        : Class.fromJson(json['aClass'] as Map<String, dynamic>),
    constructors: (json['constructors'] as List)?.map((e) =>
        e == null ? null : ConstructorInfo.fromJson(e as Map<String, dynamic>)),
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
  writeNotNull('constructors', instance.constructors?.toList());
  writeNotNull('methods', instance.methods?.toList());
  return val;
}

MethodInfo _$MethodInfoFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['name', 'returnType', 'method'],
      disallowNullValues: const ['name', 'returnType', 'method']);
  return MethodInfo(
    name: json['name'] as String,
    method: json['method'] == null
        ? null
        : Method.fromJson(json['method'] as Map<String, dynamic>),
    returnType: json['returnType'] as String,
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
  writeNotNull('returnType', instance.returnType);
  writeNotNull('method', instance.method);
  return val;
}

ConstructorInfo _$ConstructorInfoFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['name', 'constructor'],
      disallowNullValues: const ['name', 'constructor']);
  return ConstructorInfo(
    name: json['name'] as String,
    constructor: json['constructor'] == null
        ? null
        : Constructor.fromJson(json['constructor'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ConstructorInfoToJson(ConstructorInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('constructor', instance.constructor);
  return val;
}
