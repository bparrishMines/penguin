import 'dart:collection';

import 'package:reference_generator/src/ast.dart';

import 'generator.dart';

String generateDart(
  String template,
  LibraryNode libraryNode,
  List<String>? imports,
) {
  final Map<String, Object> data = <String, Object>{};

  final List<Map<String, Object>> importData = <Map<String, Object>>[];
  for (String import in imports ?? <String>[]) {
    importData.add(<String, Object>{'value': import});
  }
  data['imports'] = importData;

  final List<Map<String, Object>> classes = <Map<String, Object>>[];
  for (ClassNode classNode in libraryNode.classes) {
    final Map<String, Object> classData = <String, Object>{};
    classData['name'] = classNode.name;
    classData['channel'] = classNode.channelName!;

    final List<Map<String, Object>> fields = <Map<String, Object>>[];
    for (int i = 0; i < classNode.fields.length; i++) {
      final Map<String, Object> fieldData = <String, Object>{};
      fieldData['name'] = classNode.fields[i].name;
      fieldData['type'] = getTrueTypeName(classNode.fields[i].type);
      fieldData['index'] = '$i';
      fieldData['argumentCasting'] = getArgumentCasting(
        type: classNode.fields[i].type,
        index: i,
      );

      fields.add(fieldData);
    }
    classData['fields'] = fields;

    final List<Map<String, Object>> staticMethods = <Map<String, Object>>[];
    for (MethodNode methodNode in classNode.staticMethods) {
      final Map<String, Object> methodData = <String, Object>{};
      methodData['name'] = methodNode.name;
      methodData['returnsFuture'] = methodNode.returnType.name == 'Future';

      final List<Map<String, Object>> parameters = <Map<String, Object>>[];
      for (int i = 0; i < methodNode.parameters.length; i++) {
        final Map<String, Object> parameterData = <String, Object>{};
        parameterData['name'] = methodNode.parameters[i].name;
        parameterData['type'] = getTrueTypeName(methodNode.parameters[i].type);
        parameterData['index'] = '$i';
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
      methodData['returnsFuture'] = methodNode.returnType.name == 'Future';

      final List<Map<String, Object>> parameters = <Map<String, Object>>[];
      for (int i = 0; i < methodNode.parameters.length; i++) {
        final Map<String, Object> parameterData = <String, Object>{};
        parameterData['name'] = methodNode.parameters[i].name;
        parameterData['type'] = getTrueTypeName(methodNode.parameters[i].type);
        parameterData['index'] = '$i';
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
      parameterData['type'] = getTrueTypeName(
        functionNode.parameters[i].type,
        generatedSymbol: '',
      );
      parameterData['index'] = '$i';
      parameterData['argumentCasting'] = getArgumentCasting(
        type: functionNode.parameters[i].type,
        index: i,
        generatedSymbol: '',
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
  required ReferenceType type,
  required int index,
  String generatedSymbol = '\$',
}) {
  final String dartName = dartTypeNameConversion(type.name);

  if ((dartName != 'List' && dartName != 'Map') || type.typeArguments.isEmpty) {
    final String typeName = getTrueTypeName(
      type,
      generatedSymbol: generatedSymbol,
    );
    return 'arguments[$index] as $typeName,';
  }

  if (dartName == 'List') {
    final String typeCast = _getListArgumentCasting(
      type: type.typeArguments.first,
      generatedSymbol: generatedSymbol,
    );
    return '(arguments[$index] as List<dynamic>).map((_) => $typeCast).toList(),';
  } else if (dartName == 'Map') {
    return 'arguments[$index] as Map,';
  }

  throw UnimplementedError();
}

String _getListArgumentCasting({
  required ReferenceType type,
  String generatedSymbol = '\$',
}) {
  final String dartName = dartTypeNameConversion(type.name);

  if ((dartName != 'List' && dartName != 'Map') || type.typeArguments.isEmpty) {
    final String typeName = getTrueTypeName(
      type,
      generatedSymbol: generatedSymbol,
    );
    return '_ as $typeName';
  }

  if (dartName == 'List') {
    final String typeCast = _getListArgumentCasting(
      type: type.typeArguments.first,
      generatedSymbol: generatedSymbol,
    );
    return '(_ as List<dynamic>).map((_) => $typeCast).toList()';
  }

  throw UnimplementedError();
}

String getTrueTypeName(ReferenceType type, {String generatedSymbol = '\$'}) {
  final String dartName = dartTypeNameConversion(type.name);

  final String nullability = type.nullable ? '?' : '';
  if (dartName == 'Map') return 'Map$nullability';

  final Iterable<String> typeArguments = type.typeArguments.map<String>(
    (ReferenceType type) => getTrueTypeName(
      type,
      generatedSymbol: generatedSymbol,
    ),
  );

  if (type.codeGeneratedType && typeArguments.isEmpty) {
    return '$generatedSymbol$dartName$nullability';
  } else if (type.codeGeneratedType && typeArguments.isNotEmpty) {
    return '$generatedSymbol$dartName<${typeArguments.join(',')}>$nullability';
  } else if (!type.codeGeneratedType && typeArguments.isNotEmpty) {
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
