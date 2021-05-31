import 'dart:collection';

import 'package:reference_generator/src/ast.dart';

import 'generator.dart';

String generateObjcHeader({
  String template,
  LibraryNode libraryNode,
  String prefix,
}) {
  final Map<String, Object> data = <String, Object>{};
  data['prefix'] = prefix;

  final List<Map<String, Object>> classes = <Map<String, Object>>[];
  for (ClassNode classNode in libraryNode.classes) {
    final Map<String, Object> classData = <String, Object>{};
    classData['name'] = classNode.name;
    classData['channel'] = classNode.channelName;

    final List<Map<String, Object>> fields = <Map<String, Object>>[];
    for (int i = 0; i < classNode.fields.length; i++) {
      final Map<String, Object> fieldData = <String, Object>{};
      fieldData['name'] = classNode.fields[i].name;
      fieldData['type'] = getTrueTypeName(classNode.fields[i].type, prefix);
      fieldData['index'] = '$i';

      fields.add(fieldData);
    }
    classData['fields'] = fields;

    final List<Map<String, Object>> staticMethods = <Map<String, Object>>[];
    for (MethodNode methodNode in classNode.staticMethods) {
      final Map<String, Object> methodData = <String, Object>{};
      methodData['name'] = methodNode.name;

      final bool hasParameters = methodNode.parameters.isNotEmpty;
      methodData['hasParameters'] = hasParameters;
      methodData['firstParameterType'] = hasParameters
          ? getTrueTypeName(
              methodNode.parameters.first.type,
              prefix,
            )
          : '';
      methodData['firstParameterName'] =
          hasParameters ? methodNode.parameters.first.name : '';

      final List<Map<String, Object>> followingParameters =
          <Map<String, Object>>[];
      for (int i = 1; i < methodNode.parameters.length; i++) {
        final Map<String, Object> parameterData = <String, Object>{};
        parameterData['name'] = methodNode.parameters[i].name;
        parameterData['type'] = getTrueTypeName(
          methodNode.parameters[i].type,
          prefix,
        );
        parameterData['index'] = '$i';

        followingParameters.add(parameterData);
      }
      methodData['followingParameters'] = followingParameters;

      staticMethods.add(methodData);
    }
    classData['staticMethods'] = staticMethods;

    final List<Map<String, Object>> methods = <Map<String, Object>>[];
    for (MethodNode methodNode in classNode.methods) {
      final Map<String, Object> methodData = <String, Object>{};
      methodData['name'] = methodNode.name;

      final List<Map<String, Object>> parameters = <Map<String, Object>>[];
      for (int i = 0; i < methodNode.parameters.length; i++) {
        final Map<String, Object> parameterData = <String, Object>{};
        parameterData['name'] = methodNode.parameters[i].name;
        parameterData['type'] =
            getTrueTypeName(methodNode.parameters[i].type, prefix);
        parameterData['index'] = '$i';

        parameters.add(parameterData);
      }
      methodData['parameters'] = parameters;

      methods.add(methodData);
    }
    classData['methods'] = methods;

    classes.add(classData);
  }

  data['classes'] = classes;

  final Queue<String> templateQueue = Queue<String>();
  for (int i = 0; i < template.length; i++) {
    templateQueue.addLast(template[i]);
  }

  return runGenerator(templateQueue, Queue<Token>(), StringBuffer(), data);
}

String getTrueTypeName(ReferenceType type, String prefix) {
  final String objcName = objcTypeNameConversion(type.name);

  final Iterable<String> typeArguments = type.typeArguments.map<String>(
    (ReferenceType type) => getTrueTypeName(type, prefix),
  );

  if (type.codeGeneratedClass && typeArguments.isEmpty) {
    return 'NSObject<$prefix$objcName>';
  } else if (type.codeGeneratedClass && typeArguments.isNotEmpty) {
    return 'NSObject<$prefix$objcName<${typeArguments.join(' *,')} *>>';
  } else if (!type.codeGeneratedClass && typeArguments.isNotEmpty) {
    return '$objcName<${typeArguments.join(' *,')} *>';
  }

  return '$objcName';
}

// TODO: A user could extend a list/map so we want a boolean flag to check.
String objcTypeNameConversion(String type) {
  switch (type) {
    case 'Uint8List':
    case 'Uint8List?':
      return 'NSData';
    case 'int':
    case 'int?':
    case 'double':
    case 'double?':
    case 'num':
    case 'num?':
    case 'bool':
    case 'bool?':
      return 'NSNumber';
    case 'String':
    case 'String?':
      return 'NSString';
    case 'Object':
    case 'Object?':
      return 'NSObject';
    case 'List':
    case 'List?':
      return 'NSArray';
    case 'Map':
    case 'Map?':
      return 'NSDictionary';
  }

  return type.replaceAll('?', '');
}
