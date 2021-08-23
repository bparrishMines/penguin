import 'dart:collection';

import 'package:reference_generator/src/ast.dart';

import 'generator.dart';

String generateObjcHeader({
  required String template,
  required LibraryNode libraryNode,
  required String prefix,
  // required List<String> imports,
  // required Map<String, String> typeAliases,
}) {
  final Map<String, Object> data = <String, Object>{};
  data['prefix'] = prefix;

  final List<Map<String, Object>> importData = <Map<String, Object>>[];
  for (String import in libraryNode.platformImports) {
    importData.add(<String, Object>{'value': import});
  }
  data['imports'] = importData;

  final List<Map<String, Object>> classes = <Map<String, Object>>[];
  for (ClassNode classNode in libraryNode.classes) {
    final Map<String, Object> classData = <String, Object>{};
    classData['name'] = classNode.platformName;
    classData['channel'] = classNode.channelName;

    final List<Map<String, Object>> constructors = <Map<String, Object>>[];
    for (ConstructorNode constructorNode in classNode.constructors) {
      final Map<String, Object> constructorData = <String, Object>{};
      constructorData['name'] = constructorNode.name;

      final List<Map<String, Object>> parameters = <Map<String, Object>>[];
      for (int i = 0; i < constructorNode.parameters.length; i++) {
        final Map<String, Object> parameterData = <String, Object>{};
        parameterData['name'] = constructorNode.parameters[i].name;
        parameterData['type'] =
            getTrueTypeName(constructorNode.parameters[i].type);
        parameterData['index'] = '${i + 1}';
        parameterData['first'] = i == 0;

        parameters.add(parameterData);
      }
      constructorData['parameters'] = parameters;

      constructors.add(constructorData);
    }
    classData['constructors'] = constructors;

    final List<Map<String, Object>> staticMethods = <Map<String, Object>>[];
    for (MethodNode methodNode in classNode.staticMethods) {
      final Map<String, Object> methodData = <String, Object>{};
      methodData['name'] = methodNode.name;
      methodData['hasParameters'] = methodNode.parameters.isNotEmpty;

      final bool returnsVoid = methodNode.returnType.platformName == 'void';
      final bool returnsFuture = methodNode.returnType.isFuture;

      methodData['returnsVoid'] = returnsVoid;
      methodData['returnsFuture'] = returnsFuture;
      if (returnsVoid && !returnsFuture) {
        methodData['returnType'] = 'NSNull *';
      } else {
        methodData['returnType'] = getTrueTypeName(methodNode.returnType);
      }

      final List<Map<String, Object>> parameters = <Map<String, Object>>[];
      for (int i = 0; i < methodNode.parameters.length; i++) {
        final Map<String, Object> parameterData = <String, Object>{};
        parameterData['name'] = methodNode.parameters[i].name;
        parameterData['type'] = getTrueTypeName(methodNode.parameters[i].type);
        parameterData['first'] = i == 0;
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
      final bool returnsVoid = methodNode.returnType.platformName == 'void';
      final bool returnsFuture = methodNode.returnType.isFuture;

      methodData['returnsVoid'] = returnsVoid;
      methodData['returnsFuture'] = returnsFuture;
      if (returnsVoid && !returnsFuture) {
        methodData['returnType'] = 'NSNull *';
      } else {
        methodData['returnType'] = getTrueTypeName(methodNode.returnType);
      }

      final List<Map<String, Object>> parameters = <Map<String, Object>>[];
      for (int i = 0; i < methodNode.parameters.length; i++) {
        final Map<String, Object> parameterData = <String, Object>{};
        parameterData['name'] = methodNode.parameters[i].name;
        parameterData['type'] = getTrueTypeName(methodNode.parameters[i].type);
        parameterData['index'] = '$i';
        parameterData['first'] = i == 0;

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
      parameterData['type'] = getTrueTypeName(functionNode.parameters[i].type);
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

String getTrueTypeName(TypeNode type) {
  final String objcName = objcTypeNameConversion(type.platformName);
  final String pointer = type.functionType ? '' : '*';

  final Iterable<String> typeArguments = type.typeArguments.map<String>(
    (TypeNode type) => getTrueTypeName(type),
  );

  if (typeArguments.isNotEmpty) {
    return '$objcName<${typeArguments.join(', ')}> $pointer';
  }

  return '$objcName $pointer';
}

// TODO: A user could extend a list/map so we want a boolean flag to check.
String objcTypeNameConversion(String type) {
  switch (type) {
    case 'Uint8List':
      return 'NSData';
    case 'int':
    case 'double':
    case 'num':
    case 'bool':
      return 'NSNumber';
    case 'String':
      return 'NSString';
    case 'Object':
      return 'NSObject';
    case 'Set':
    case 'List':
      return 'NSArray';
    case 'Map':
      return 'NSDictionary';
  }

  return type;
}
