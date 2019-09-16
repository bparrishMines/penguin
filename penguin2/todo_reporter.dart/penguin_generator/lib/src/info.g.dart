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
      requiredKeys: const ['name', 'returnType', 'method', 'parameters'],
      disallowNullValues: const ['name', 'returnType', 'method', 'parameters']);
  return MethodInfo(
    name: json['name'] as String,
    method: json['method'] == null
        ? null
        : Method.fromJson(json['method'] as Map<String, dynamic>),
    returnType: json['returnType'] == null
        ? null
        : TypeInfo.fromJson(json['returnType'] as Map<String, dynamic>),
    parameters: (json['parameters'] as List)?.map((e) =>
        e == null ? null : ParameterInfo.fromJson(e as Map<String, dynamic>)),
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
  writeNotNull('parameters', instance.parameters?.toList());
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

ParameterInfo _$ParameterInfoFromJson(Map<String, dynamic> json) {
  return ParameterInfo(
    type: json['type'] == null
        ? null
        : TypeInfo.fromJson(json['type'] as Map<String, dynamic>),
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$ParameterInfoToJson(ParameterInfo instance) =>
    <String, dynamic>{
      'type': instance.type,
      'name': instance.name,
    };

TypeInfo _$TypeInfoFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const [
    'typeArguments',
    'isFuture',
    'isFutureOr',
    'isBool',
    'isDouble',
    'isFunction',
    'isInt',
    'isList',
    'isMap',
    'isNull',
    'isNum',
    'isObject',
    'isSet',
    'isString',
    'isSymbol',
    'isDynamic',
    'isVoid',
    'isWrapper'
  ], disallowNullValues: const [
    'typeArguments',
    'isFuture',
    'isFutureOr',
    'isBool',
    'isDouble',
    'isFunction',
    'isInt',
    'isList',
    'isMap',
    'isNull',
    'isNum',
    'isObject',
    'isSet',
    'isString',
    'isSymbol',
    'isDynamic',
    'isVoid',
    'isWrapper'
  ]);
  return TypeInfo(
    name: json['name'] as String,
    isFuture: json['isFuture'] as bool,
    isFutureOr: json['isFutureOr'] as bool,
    isBool: json['isBool'] as bool,
    isDouble: json['isDouble'] as bool,
    isFunction: json['isFunction'] as bool,
    isInt: json['isInt'] as bool,
    isList: json['isList'] as bool,
    isMap: json['isMap'] as bool,
    isNull: json['isNull'] as bool,
    isNum: json['isNum'] as bool,
    isObject: json['isObject'] as bool,
    isSet: json['isSet'] as bool,
    isString: json['isString'] as bool,
    isSymbol: json['isSymbol'] as bool,
    isDynamic: json['isDynamic'] as bool,
    isVoid: json['isVoid'] as bool,
    typeArguments: (json['typeArguments'] as List)?.map(
        (e) => e == null ? null : TypeInfo.fromJson(e as Map<String, dynamic>)),
    isWrapper: json['isWrapper'] as bool,
  );
}

Map<String, dynamic> _$TypeInfoToJson(TypeInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('typeArguments', instance.typeArguments?.toList());
  val['name'] = instance.name;
  writeNotNull('isFuture', instance.isFuture);
  writeNotNull('isFutureOr', instance.isFutureOr);
  writeNotNull('isBool', instance.isBool);
  writeNotNull('isDouble', instance.isDouble);
  writeNotNull('isFunction', instance.isFunction);
  writeNotNull('isInt', instance.isInt);
  writeNotNull('isList', instance.isList);
  writeNotNull('isMap', instance.isMap);
  writeNotNull('isNull', instance.isNull);
  writeNotNull('isNum', instance.isNum);
  writeNotNull('isObject', instance.isObject);
  writeNotNull('isSet', instance.isSet);
  writeNotNull('isString', instance.isString);
  writeNotNull('isSymbol', instance.isSymbol);
  writeNotNull('isDynamic', instance.isDynamic);
  writeNotNull('isVoid', instance.isVoid);
  writeNotNull('isWrapper', instance.isWrapper);
  return val;
}
