import 'dart:collection';

import 'package:reference_generator/src/ast.dart';

import 'generator.dart';

// TODO: returnType casting
String generateDart({
  required String template,
  required LibraryNode libraryNode,
  required List<String> imports,
}) {
  final Map<String, Object> data = <String, Object>{};

  final List<Map<String, Object>> importData = <Map<String, Object>>[];
  for (String import in imports) {
    importData.add(<String, Object>{'value': import});
  }
  data['imports'] = importData;

  final List<Map<String, Object>> classes = <Map<String, Object>>[];
  for (ClassNode classNode in libraryNode.classes) {
    final Map<String, Object> classData = <String, Object>{};
    classData['name'] = classNode.dartName;
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
        parameterData['isNamed'] = constructorNode.parameters[i].isNamed;
        parameterData['argumentCasting'] = getArgumentCasting(
          type: constructorNode.parameters[i].type,
          index: i + 1,
        );

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
      methodData['returnsFuture'] = methodNode.returnType.isFuture;
      methodData['returnType'] = getTrueTypeName(methodNode.returnType);

      final List<Map<String, Object>> parameters = <Map<String, Object>>[];
      for (int i = 0; i < methodNode.parameters.length; i++) {
        final Map<String, Object> parameterData = <String, Object>{};
        parameterData['name'] = methodNode.parameters[i].name;
        parameterData['type'] = getTrueTypeName(methodNode.parameters[i].type);
        parameterData['index'] = '$i';
        parameterData['isNamed'] = methodNode.parameters[i].isNamed;
        parameterData['argumentCasting'] = getArgumentCasting(
          type: methodNode.parameters[i].type,
          index: i,
        );

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
      methodData['returnsFuture'] = methodNode.returnType.isFuture;
      methodData['returnType'] = getTrueTypeName(methodNode.returnType);

      final List<Map<String, Object>> parameters = <Map<String, Object>>[];
      for (int i = 0; i < methodNode.parameters.length; i++) {
        final Map<String, Object> parameterData = <String, Object>{};
        parameterData['name'] = methodNode.parameters[i].name;
        parameterData['type'] = getTrueTypeName(methodNode.parameters[i].type);
        parameterData['index'] = '$i';
        parameterData['isNamed'] = methodNode.parameters[i].isNamed;
        parameterData['argumentCasting'] = getArgumentCasting(
          type: methodNode.parameters[i].type,
          index: i,
        );

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
      parameterData['argumentCasting'] = getArgumentCasting(
        type: functionNode.parameters[i].type,
        index: i,
      );

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

String getArgumentCasting({
  required TypeNode type,
  required int index,
}) {
  final String dartName = dartTypeNameConversion(type.dartName);

  if ((dartName != 'List' && dartName != 'Map') || type.typeArguments.isEmpty) {
    final String typeName = getTrueTypeName(type);
    return 'arguments[$index] as $typeName,';
  }

  if (dartName == 'List') {
    final String typeCast = _getListArgumentCasting(type.typeArguments.first);
    return '(arguments[$index] as List<dynamic>).map((_) => $typeCast).toList(),';
  } else if (dartName == 'Map') {
    return 'arguments[$index] as Map,';
  }

  throw UnimplementedError();
}

String _getListArgumentCasting(TypeNode type) {
  final String dartName = dartTypeNameConversion(type.dartName);

  if ((dartName != 'List' && dartName != 'Map') || type.typeArguments.isEmpty) {
    final String typeName = getTrueTypeName(type);
    return '_ as $typeName';
  }

  if (dartName == 'List') {
    final String typeCast = _getListArgumentCasting(
      type.typeArguments.first,
    );
    return '(_ as List<dynamic>).map((_) => $typeCast).toList()';
  }

  throw UnimplementedError();
}

String getTrueTypeName(TypeNode type) {
  final String dartName = dartTypeNameConversion(type.dartName);

  final String nullability = type.nullable ? '?' : '';
  // TODO: Consequences?
  // if (dartName == 'Map') return 'Map$nullability';

  final Iterable<String> typeArguments = type.typeArguments.map<String>(
    (TypeNode type) => getTrueTypeName(type),
  );

  if (typeArguments.isEmpty) {
    return '$dartName$nullability';
  } else {
    return '$dartName<${typeArguments.join(',')}>$nullability';
  }
}

String dartTypeNameConversion(String type) {
  switch (type) {
    case 'Set':
      return 'List';
  }

  return type;
}
