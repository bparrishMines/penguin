import 'dart:async';
import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
// The builder can't access Flutter, so this accesses just the independent reference file.
// TODO: Expose this in reference plugin
import 'package:reference/src/reference.dart';
import 'package:source_gen/source_gen.dart';

import 'ast.dart';

class ReferenceAstBuilder extends Builder {
  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final AssetId newFile = buildStep.inputId.changeExtension('.reference_ast');

    final Resolver resolver = buildStep.resolver;
    if (!await resolver.isLibrary(buildStep.inputId)) return null;

    final LibraryReader reader = LibraryReader(await buildStep.inputLibrary);

    final Iterable<ClassElement> classes = reader
        .annotatedWith(const TypeChecker.fromRuntime(Reference))
        .map<ClassElement>(
          (AnnotatedElement annotatedElement) => annotatedElement.element,
        );

    if (classes.isEmpty) return;

    final LibraryNode ast = _toLibraryNode(reader.element, classes);

    await buildStep.writeAsString(newFile, jsonEncode(ast));
  }

  LibraryNode _toLibraryNode(
    LibraryElement libraryElement,
    Iterable<ClassElement> classes,
  ) {
    return LibraryNode(
      classes
          .map<ClassNode>(
            (ClassElement classElement) => _toClassNode(
              classElement,
              classes.toSet(),
            ),
          )
          .toList(),
    );
  }

  ClassNode _toClassNode(
    ClassElement classElement,
    Set<ClassElement> allGeneratedClasses,
  ) {
    List<ParameterElement> parameters;
    final ConstructorElement defaultConstructor = classElement.constructors
        .firstWhere(
            (ConstructorElement constructorElement) =>
                constructorElement.name.isEmpty,
            orElse: () => null);
    if (defaultConstructor == null) {
      parameters = <ParameterElement>[];
    } else {
      parameters = defaultConstructor.parameters;
    }

    return ClassNode(
      name: classElement.name,
      fields: parameters
          .map<FieldNode>((ParameterElement parameterElement) =>
              _toFieldNode(parameterElement, allGeneratedClasses))
          .toList(),
      methods: classElement.methods
          .where((MethodElement element) => !element.isPrivate)
          .where((MethodElement methodElement) => !methodElement.isStatic)
          .map<MethodNode>(
            (MethodElement methodElement) =>
                _toMethodNode(methodElement, allGeneratedClasses),
          )
          .toList(),
      staticMethods: classElement.methods
          .where((MethodElement element) => !element.isPrivate)
          .where((MethodElement methodElement) => methodElement.isStatic)
          .map<MethodNode>(
            (MethodElement methodElement) =>
                _toMethodNode(methodElement, allGeneratedClasses),
          )
          .toList(),
    );
  }

  FieldNode _toFieldNode(
    ParameterElement parameterElement,
    Set<ClassElement> allGeneratedClasses,
  ) {
    return FieldNode(
      name: parameterElement.name,
      type: _toReferenceType(parameterElement.type, allGeneratedClasses),
    );
  }

  MethodNode _toMethodNode(
    MethodElement methodElement,
    Set<ClassElement> allGeneratedClasses,
  ) {
    return MethodNode(
      name: methodElement.name,
      returnType: _toReferenceType(
        methodElement.returnType,
        allGeneratedClasses,
      ),
      parameters: methodElement.parameters
          .map<ParameterNode>(
            (ParameterElement parameterElement) =>
                _toParameterNode(parameterElement, allGeneratedClasses),
          )
          .toList(),
    );
  }

  ParameterNode _toParameterNode(
    ParameterElement parameterElement,
    Set<ClassElement> allGeneratedClasses,
  ) {
    return ParameterNode(
      name: parameterElement.name,
      type: _toReferenceType(parameterElement.type, allGeneratedClasses),
    );
  }

  ReferenceType _toReferenceType(
    DartType type,
    Set<ClassElement> allGeneratedClasses,
  ) {
    return ReferenceType(
      name: type.getDisplayString(withNullability: false).split('<').first,
      codeGeneratedClass: allGeneratedClasses.contains(type.element),
      typeArguments: type is! ParameterizedType
          ? <ReferenceType>[]
          : (type as ParameterizedType)
              .typeArguments
              .map<ReferenceType>(
                (DartType type) => _toReferenceType(type, allGeneratedClasses),
              )
              .toList(),
    );
  }

  @override
  Map<String, List<String>> get buildExtensions => <String, List<String>>{
        '.dart': <String>['.reference_ast'],
      };
}