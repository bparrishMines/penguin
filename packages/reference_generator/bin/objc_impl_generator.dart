import 'dart:collection';

import 'package:reference_generator/src/ast.dart';

import 'generator.dart';
import 'objc_header_generator.dart' show getTrueTypeName;

String generateObjcImpl({
  required String template,
  required LibraryNode libraryNode,
  required String prefix,
  required String headerFilename,
  required Map<String, String> typeAliases,
}) {
  final Map<String, Object> data = <String, Object>{};
  data['prefix'] = prefix;
  data['headerFilename'] = headerFilename;

  final List<Map<String, Object>> classes = <Map<String, Object>>[];
  for (ClassNode classNode in libraryNode.classes) {
    final Map<String, Object> classData = <String, Object>{};
    classData['name'] = classNode.name;
    classData['channel'] = classNode.channelName!;

    final List<Map<String, Object>> constructors = <Map<String, Object>>[];
    for (ConstructorNode constructorNode in classNode.constructors) {
      final Map<String, Object> constructorData = <String, Object>{};
      constructorData['name'] = constructorNode.name;

      final List<Map<String, Object>> parameters = <Map<String, Object>>[];
      for (int i = 0; i < constructorNode.parameters.length; i++) {
        final Map<String, Object> parameterData = <String, Object>{};
        parameterData['name'] = constructorNode.parameters[i].name;
        parameterData['type'] = getTrueTypeName(
          type: constructorNode.parameters[i].type,
          prefix: prefix,
          typeAliases: typeAliases,
        );
        parameterData['index'] = '${i + 1}';

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
      methodData['returnsFuture'] = methodNode.returnType.name == 'Future';

      final List<Map<String, Object>> parameters = <Map<String, Object>>[];
      for (int i = 0; i < methodNode.parameters.length; i++) {
        final Map<String, Object> parameterData = <String, Object>{};
        parameterData['name'] = methodNode.parameters[i].name;
        parameterData['type'] = getTrueTypeName(
          type: methodNode.parameters[i].type,
          prefix: prefix,
          typeAliases: typeAliases,
        );
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
        parameterData['type'] = getTrueTypeName(
          type: methodNode.parameters[i].type,
          prefix: prefix,
          typeAliases: typeAliases,
        );
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
        type: functionNode.parameters[i].type,
        prefix: prefix,
        typeAliases: typeAliases,
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
