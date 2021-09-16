import 'dart:collection';

import 'package:reference_generator/src/ast.dart';

import 'generator.dart';

String generateJava({
  required String template,
  required LibraryNode libraryNode,
  required String libraryName,
  required String package,
  //required Map<String, String> typeAliases,
}) {
  final Map<String, Object> data = <String, Object>{};
  data['libraryName'] = libraryName;
  data['package'] = package;

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
      constructorData['platformThrowsAsDefault'] =
          constructorNode.platformThrowsAsDefault;

      final List<Map<String, Object>> parameters = <Map<String, Object>>[];
      for (int i = 0; i < constructorNode.parameters.length; i++) {
        final Map<String, Object> parameterData = <String, Object>{};
        parameterData['name'] = constructorNode.parameters[i].name;
        parameterData['type'] = getTrueTypeName(
          constructorNode.parameters[i].type,
        );
        parameterData['index'] = '${i + 1}';

        parameters.add(parameterData);
      }
      constructorData['parameters'] = parameters;

      final List<Map<String, Object>> callbackMethods = <Map<String, Object>>[];
      final Iterable<ParameterNode> callbackMethodNodes =
          constructorNode.parameters.where(
        (ParameterNode parameterNode) => parameterNode.type.functionType,
      );
      for (ParameterNode callbackMethodNode in callbackMethodNodes) {
        final Map<String, Object> methodData = <String, Object>{};
        methodData['name'] = callbackMethodNode.name;
        methodData['returnsFuture'] = callbackMethodNode.type.isFuture;

        final List<Map<String, Object>> parameters = <Map<String, Object>>[];
        for (ParameterNode parameterNode
            in callbackMethodNode.type.function!.parameters) {
          final Map<String, Object> parameterData = <String, Object>{};
          parameterData['name'] = parameterNode.name;
          parameterData['type'] = getTrueTypeName(parameterNode.type);

          parameters.add(parameterData);
        }
        methodData['parameters'] = parameters;

        callbackMethods.add(methodData);
      }
      classData['callbackMethods'] = callbackMethods;

      constructors.add(constructorData);
    }
    classData['constructors'] = constructors;

    final List<Map<String, Object>> staticMethods = <Map<String, Object>>[];
    for (MethodNode methodNode in classNode.staticMethods) {
      final Map<String, Object> methodData = <String, Object>{};
      methodData['name'] = methodNode.name;
      methodData['platformThrowsAsDefault'] =
          methodNode.platformThrowsAsDefault;

      final bool returnsVoid = methodNode.returnType.platformName == 'void';
      final bool returnsFuture = methodNode.returnType.isFuture;

      methodData['returnsVoid'] = returnsVoid;
      methodData['returnsFuture'] = returnsFuture;
      if (returnsVoid && !returnsFuture) {
        methodData['returnType'] = 'Void';
      } else {
        methodData['returnType'] = getTrueTypeName(methodNode.returnType);
      }

      final List<Map<String, Object>> parameters = <Map<String, Object>>[];
      for (int i = 0; i < methodNode.parameters.length; i++) {
        final Map<String, Object> parameterData = <String, Object>{};
        parameterData['name'] = methodNode.parameters[i].name;
        parameterData['type'] = getTrueTypeName(methodNode.parameters[i].type);
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
      methodData['platformThrowsAsDefault'] =
          methodNode.platformThrowsAsDefault;

      final bool returnsVoid = methodNode.returnType.platformName == 'void';
      final bool returnsFuture = methodNode.returnType.isFuture;

      methodData['returnsVoid'] = returnsVoid;
      methodData['returnsFuture'] = returnsFuture;
      if (returnsVoid && !returnsFuture) {
        methodData['returnType'] = 'Void';
      } else {
        methodData['returnType'] = getTrueTypeName(methodNode.returnType);
      }

      final List<Map<String, Object>> parameters = <Map<String, Object>>[];
      for (int i = 0; i < methodNode.parameters.length; i++) {
        final Map<String, Object> parameterData = <String, Object>{};
        parameterData['name'] = methodNode.parameters[i].name;
        parameterData['type'] = getTrueTypeName(methodNode.parameters[i].type);
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
    functionData['name'] = functionNode.platformName;
    functionData['channel'] = functionNode.channelName;
    functionData['returnsFuture'] = functionNode.returnType.isFuture;

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
  final String javaName = javaTypeNameConversion(type.platformName);
  // if (typeAliases.containsKey(type.platformName)) {
  //   javaName = typeAliases[type.platformName]!;
  // } else {
  //   javaName = javaTypeNameConversion(type.platformName);
  // }

  final Iterable<String> typeArguments = type.typeArguments.map<String>(
    (TypeNode type) => getTrueTypeName(type),
  );

  if (typeArguments.isNotEmpty) {
    return '$javaName<${typeArguments.join(',')}>';
  }

  return javaName;
}

String javaTypeNameConversion(String type) {
  switch (type) {
    case 'Uint8List':
      return 'byte[]';
    case 'int':
      return 'Integer';
    case 'double':
      return 'Double';
    case 'bool':
      return 'Boolean';
    case 'num':
      return 'Number';
    case 'String':
      return 'String';
    case 'Set':
      return 'List';
  }

  return type;
}
