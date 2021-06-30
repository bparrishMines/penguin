import 'dart:collection';

import 'package:reference_generator/src/ast.dart';

import 'generator.dart';

String generateObjcHeader({
  required String template,
  required LibraryNode libraryNode,
  required String prefix,
}) {
  final Map<String, Object> data = <String, Object>{};
  data['prefix'] = prefix;

  final List<Map<String, Object>> classes = <Map<String, Object>>[];
  for (ClassNode classNode in libraryNode.classes) {
    final Map<String, Object> classData = <String, Object>{};
    classData['name'] = classNode.name;
    classData['channel'] = classNode.channelName!;

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
      methodData['hasParameters'] = methodNode.parameters.isNotEmpty;
      methodData['returnsFuture'] = methodNode.returnType.name == 'Future';

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

      staticMethods.add(methodData);
    }
    classData['staticMethods'] = staticMethods;

    final List<Map<String, Object>> methods = <Map<String, Object>>[];
    for (MethodNode methodNode in classNode.methods) {
      final Map<String, Object> methodData = <String, Object>{};
      methodData['name'] = methodNode.name;
      methodData['returnsFuture'] = methodNode.returnType.name == 'Future';

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

  final List<Map<String, Object>> functions = <Map<String, Object>>[];
  for (FunctionNode functionNode in libraryNode.functions) {
    final Map<String, Object> functionData = <String, Object>{};
    functionData['name'] = functionNode.name;
    functionData['channel'] = functionNode.channelName;

    final List<Map<String, Object>> parameters = <Map<String, Object>>[];
    for (int i = 0; i < functionNode.parameters.length; i++) {
      final Map<String, Object> parameterData = <String, Object>{};
      parameterData['name'] = functionNode.parameters[i].name;
      parameterData['type'] = getTrueTypeName(
        functionNode.parameters[i].type,
        prefix,
      );
      parameterData['index'] = '$i';

      parameters.add(parameterData);
    }
    functionData['parameters'] = parameters;

    functions.add(functionData);
  }
  data['functions'] = functions;

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

  if (type.codeGeneratedType && type.functionType) {
    return '$prefix$objcName';
  } else if (type.codeGeneratedType && typeArguments.isEmpty) {
    return 'NSObject<$prefix$objcName> *';
  } else if (type.codeGeneratedType && typeArguments.isNotEmpty) {
    return 'NSObject<$prefix$objcName<${typeArguments.join(', ')}>> *';
  } else if (!type.codeGeneratedType && typeArguments.isNotEmpty) {
    return '$objcName<${typeArguments.join(', ')}> *';
  }

  return '$objcName';
}

// TODO: A user could extend a list/map so we want a boolean flag to check.
String objcTypeNameConversion(String type) {
  switch (type) {
    case 'Uint8List':
      return 'NSData *';
    case 'int':
    case 'double':
    case 'num':
    case 'bool':
      return 'NSNumber *';
    case 'String':
      return 'NSString *';
    case 'Object':
      return 'NSObject *';
    case 'List':
      return 'NSArray';
    case 'Map':
      return 'NSDictionary';
  }

  return type;
}
