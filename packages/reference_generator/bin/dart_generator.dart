import 'dart:collection';

import 'package:reference_generator/src/ast.dart';

import 'generator.dart';

// TODO: returnType casting
String generateDart({
  required String template,
  required LibraryNode libraryNode,
}) {
  final Map<String, Object> data = <String, Object>{};

  final List<Map<String, Object>> importData = <Map<String, Object>>[];
  for (String import in libraryNode.dartImports) {
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
      constructorData['isNamed'] = constructorNode.isNamed;

      final List<Map<String, Object>> parameters = <Map<String, Object>>[];
      for (int i = 0; i < constructorNode.parameters.length; i++) {
        final Map<String, Object> parameterData = <String, Object>{};
        parameterData['name'] = constructorNode.parameters[i].name;
        parameterData['type'] =
            getTrueTypeName(constructorNode.parameters[i].type);
        parameterData['index'] = '${i + 1}';
        parameterData['isNamed'] = constructorNode.parameters[i].isNamed;
        parameterData['casting'] = (String input) {
          return getArgumentCasting(
            type: constructorNode.parameters[i].type,
            input: input,
          );
        };

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
      methodData['returnsVoid'] = methodNode.returnType.dartName == 'void';
      methodData['casting'] = (String input) {
        if (methodNode.returnType.dartName == 'void') return input;
        return getArgumentCasting(type: methodNode.returnType, input: input);
      };

      final List<Map<String, Object>> parameters = <Map<String, Object>>[];
      for (int i = 0; i < methodNode.parameters.length; i++) {
        final Map<String, Object> parameterData = <String, Object>{};
        parameterData['name'] = methodNode.parameters[i].name;
        parameterData['type'] = getTrueTypeName(methodNode.parameters[i].type);
        parameterData['index'] = '$i';
        parameterData['isNamed'] = methodNode.parameters[i].isNamed;
        parameterData['casting'] = (String input) {
          return getArgumentCasting(
            type: methodNode.parameters[i].type,
            input: input,
          );
        };

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
      methodData['returnsVoid'] = methodNode.returnType.dartName == 'void';
      methodData['casting'] = (String input) {
        if (methodNode.returnType.dartName == 'void') return input;
        return getArgumentCasting(type: methodNode.returnType, input: input);
      };

      final List<Map<String, Object>> parameters = <Map<String, Object>>[];
      for (int i = 0; i < methodNode.parameters.length; i++) {
        final Map<String, Object> parameterData = <String, Object>{};
        parameterData['name'] = methodNode.parameters[i].name;
        parameterData['type'] = getTrueTypeName(methodNode.parameters[i].type);
        parameterData['index'] = '$i';
        parameterData['isNamed'] = methodNode.parameters[i].isNamed;
        parameterData['casting'] = (String input) {
          return getArgumentCasting(
            type: methodNode.parameters[i].type,
            input: input,
          );
        };

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
    functionData['name'] = functionNode.dartName;
    functionData['channel'] = functionNode.channelName;

    final List<Map<String, Object>> parameters = <Map<String, Object>>[];
    for (int i = 0; i < functionNode.parameters.length; i++) {
      final Map<String, Object> parameterData = <String, Object>{};
      parameterData['name'] = functionNode.parameters[i].name;
      parameterData['type'] = getTrueTypeName(functionNode.parameters[i].type);
      parameterData['index'] = '$i';
      parameterData['casting'] = (String input) {
        return getArgumentCasting(
          type: functionNode.parameters[i].type,
          input: input,
        );
      };

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

String getArgumentCasting({required TypeNode type, required String input}) {
  final String dartName = dartTypeNameConversion(type.dartName);

  if (dartName == 'List' && type.typeArguments.isNotEmpty) {
    return _getListArgumentCasting(type: type, input: input);
  } else if (dartName == 'Map' && type.typeArguments.isNotEmpty) {
    return _getMapArgumentCasting(type: type, input: input);
  } else {
    final String typeName = getTrueTypeName(type);
    return '$input as $typeName';
  }
}

String _getListArgumentCasting({
  required TypeNode type,
  required String input,
}) {
  final String typeCast =
      getArgumentCasting(type: type.typeArguments.first, input: '_');
  final String nullability = type.nullable ? '?' : '';
  return '($input as List<dynamic>$nullability)$nullability.map((_) => $typeCast).toList()';
}

String _getMapArgumentCasting({required TypeNode type, required String input}) {
  final String keyTypeCast = getArgumentCasting(
    type: type.typeArguments.first,
    input: '_',
  );
  final String valueTypeCast = getArgumentCasting(
    type: type.typeArguments[1],
    input: '__',
  );
  final String nullability = type.nullable ? '?' : '';
  return '($input as Map<dynamic, dynamic>$nullability)$nullability.map((_, __) => MapEntry($keyTypeCast, $valueTypeCast))';
}

String getTrueTypeName(TypeNode type) {
  final String dartName = dartTypeNameConversion(type.dartName);

  final String nullability = type.nullable ? '?' : '';

  final Iterable<String> typeArguments = type.typeArguments.map<String>(
    (TypeNode type) => getTrueTypeName(type),
  );

  if (typeArguments.isNotEmpty) {
    return '$dartName<${typeArguments.join(',')}>$nullability';
  }

  return '$dartName$nullability';
}

String dartTypeNameConversion(String type) {
  switch (type) {
    case 'Set':
      return 'List';
  }

  return type;
}
