// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'penguin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Class _$ClassFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['platform'], disallowNullValues: const ['platform']);
  return Class(
    Class._platformFromJson(json['platform'] as Map),
    androidApi: json['androidApi'] == null
        ? null
        : AndroidApi.fromJson(json['androidApi'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ClassToJson(Class instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('platform', Class._platformToJson(instance.platform));
  val['androidApi'] = instance.androidApi;
  return val;
}

Method _$MethodFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['callback'], disallowNullValues: const ['callback']);
  return Method(
    callback: json['callback'] as bool,
  );
}

Map<String, dynamic> _$MethodToJson(Method instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('callback', instance.callback);
  return val;
}

Constructor _$ConstructorFromJson(Map<String, dynamic> json) {
  return Constructor();
}

Map<String, dynamic> _$ConstructorToJson(Constructor instance) =>
    <String, dynamic>{};

Field _$FieldFromJson(Map<String, dynamic> json) {
  return Field();
}

Map<String, dynamic> _$FieldToJson(Field instance) => <String, dynamic>{};

Platform _$PlatformFromJson(Map<String, dynamic> json) {
  return Platform(
    json['name'] as String,
  );
}

Map<String, dynamic> _$PlatformToJson(Platform instance) => <String, dynamic>{
      'name': instance.name,
    };

AndroidPlatform _$AndroidPlatformFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['type'], disallowNullValues: const ['type']);
  return AndroidPlatform(
    json['type'] == null
        ? null
        : AndroidType.fromJson(json['type'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AndroidPlatformToJson(AndroidPlatform instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', instance.type);
  return val;
}

AndroidType _$AndroidTypeFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['package', 'names'],
      disallowNullValues: const ['names']);
  return AndroidType(
    json['package'] as String,
    (json['names'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$AndroidTypeToJson(AndroidType instance) {
  final val = <String, dynamic>{
    'package': instance.package,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('names', instance.names);
  return val;
}

IosPlatform _$IosPlatformFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['type']);
  return IosPlatform(
    json['type'] == null
        ? null
        : IosType.fromJson(json['type'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$IosPlatformToJson(IosPlatform instance) =>
    <String, dynamic>{
      'type': instance.type,
    };

AndroidApi _$AndroidApiFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['api']);
  return AndroidApi(
    json['api'] as int,
  );
}

Map<String, dynamic> _$AndroidApiToJson(AndroidApi instance) =>
    <String, dynamic>{
      'api': instance.api,
    };

IosType _$IosTypeFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['import', 'name', 'isStruct'],
      disallowNullValues: const ['name', 'isStruct']);
  return IosType(
    json['name'] as String,
    import: json['import'] as String,
    isStruct: json['isStruct'] as bool,
  );
}

Map<String, dynamic> _$IosTypeToJson(IosType instance) {
  final val = <String, dynamic>{
    'import': instance.import,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('isStruct', instance.isStruct);
  return val;
}
