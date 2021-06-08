import 'dart:async';
import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:reference/annotations.dart';
import 'package:source_gen/source_gen.dart';

import 'ast.dart';

class ReferenceAstBuilder extends Builder {
  static const TypeChecker methodAnnotation =
      TypeChecker.fromRuntime(ReferenceMethod);
  static const TypeChecker parameterAnnotation =
      TypeChecker.fromRuntime(ReferenceParameter);

  static ReferenceMethod? tryReadMethodAnnotation(MethodElement element) {
    if (!methodAnnotation.hasAnnotationOfExact(element)) return null;
    final ConstantReader reader = ConstantReader(
      methodAnnotation.firstAnnotationOfExact(element),
    );
    return ReferenceMethod(ignore: reader.read('ignore').boolValue);
  }

  static ReferenceParameter? tryReadParameterAnnotation(
    ParameterElement element,
  ) {
    if (!parameterAnnotation.hasAnnotationOfExact(element)) return null;
    final ConstantReader reader = ConstantReader(
      parameterAnnotation.firstAnnotationOfExact(element),
    );
    return ReferenceParameter(ignore: reader.read('ignore').boolValue);
  }

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final AssetId newFile = buildStep.inputId.changeExtension('.reference_ast');

    final Resolver resolver = buildStep.resolver;
    if (!await resolver.isLibrary(buildStep.inputId)) return null;

    final LibraryReader reader = LibraryReader(await buildStep.inputLibrary);

    final Iterable<ClassElement> classes = reader
        .annotatedWith(const TypeChecker.fromRuntime(Reference))
        .where(
          (AnnotatedElement annotatedElement) =>
              annotatedElement.element is ClassElement,
        )
        .map<ClassElement>(
          (AnnotatedElement annotatedElement) =>
              annotatedElement.element as ClassElement,
        );

    final Iterable<TypeAliasElement> functions = reader
        .annotatedWith(const TypeChecker.fromRuntime(Reference))
        .where(
          (AnnotatedElement annotatedElement) =>
              annotatedElement.element is TypeAliasElement,
        )
        .map<TypeAliasElement>(
          (AnnotatedElement annotatedElement) =>
              annotatedElement.element as TypeAliasElement,
        );

    if (classes.isEmpty && functions.isEmpty) return;

    final LibraryNode ast = _toLibraryNode(reader.element, classes, functions);
    print('-' * 20);
    print(ast.functions);

    await buildStep.writeAsString(newFile, jsonEncode(ast));
  }

  LibraryNode _toLibraryNode(
    LibraryElement libraryElement,
    Iterable<ClassElement> classes,
    Iterable<TypeAliasElement> functions,
  ) {
    return LibraryNode(
      classes: classes
          .map<ClassNode>(
            (ClassElement classElement) => _toClassNode(
              classElement,
              classes.toSet(),
            ),
          )
          .toList(),
      functions: functions
          .map<FunctionNode>(
            (TypeAliasElement typeAliasElement) => _toFunctionNode(
              typeAliasElement,
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
    final ConstructorElement? defaultConstructor = classElement.constructors
        .cast<ConstructorElement?>()
        .firstWhere(
            (ConstructorElement? constructorElement) =>
                constructorElement != null && constructorElement.name.isEmpty,
            orElse: () => null);
    if (defaultConstructor == null) {
      parameters = <ParameterElement>[];
    } else {
      parameters = defaultConstructor.parameters;
    }

    return ClassNode(
      name: classElement.name,
      channelName: _getChannel(classElement.thisType),
      fields: parameters
          .where((ParameterElement element) {
            final ReferenceParameter? referenceParameter =
                tryReadParameterAnnotation(element);
            if (referenceParameter == null) return true;
            return !referenceParameter.ignore;
          })
          .map<FieldNode>((ParameterElement parameterElement) =>
              _toFieldNode(parameterElement, allGeneratedClasses))
          .toList(),
      methods: classElement.methods
          .where((MethodElement element) => !element.isPrivate)
          .where((MethodElement methodElement) => !methodElement.isStatic)
          .where((MethodElement element) {
            final ReferenceMethod? referenceMethod =
                tryReadMethodAnnotation(element);
            if (referenceMethod == null) return true;
            return !referenceMethod.ignore;
          })
          .map<MethodNode>(
            (MethodElement methodElement) =>
                _toMethodNode(methodElement, allGeneratedClasses),
          )
          .toList(),
      staticMethods: classElement.methods
          .where((MethodElement element) => !element.isPrivate)
          .where((MethodElement methodElement) => methodElement.isStatic)
          .where((MethodElement element) {
            final ReferenceMethod? referenceMethod =
                tryReadMethodAnnotation(element);
            if (referenceMethod == null) return true;
            return !referenceMethod.ignore;
          })
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
          .where((ParameterElement element) {
            final ReferenceParameter? referenceParameter =
                tryReadParameterAnnotation(element);
            if (referenceParameter == null) return true;
            return !referenceParameter.ignore;
          })
          .map<ParameterNode>(
            (ParameterElement parameterElement) =>
                _toParameterNode(parameterElement, allGeneratedClasses),
          )
          .toList(),
    );
  }

  FunctionNode _toFunctionNode(
    TypeAliasElement typeAliasElement,
    Set<ClassElement> allGeneratedClasses,
  ) {
    final FunctionType functionType =
        typeAliasElement.aliasedType as FunctionType;
    return FunctionNode(
      name: typeAliasElement.name,
      returnType: _toReferenceType(
        functionType,
        allGeneratedClasses,
      ),
      parameters: functionType.parameters
          .where((ParameterElement element) {
            final ReferenceParameter? referenceParameter =
                tryReadParameterAnnotation(element);
            if (referenceParameter == null) return true;
            return !referenceParameter.ignore;
          })
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
    final String displayName = type.getDisplayString(withNullability: true);
    return ReferenceType(
      name: displayName.split(RegExp('[<?]')).first,
      nullable: displayName.endsWith('?'),
      codeGeneratedClass: allGeneratedClasses.contains(type.element),
      typeArguments: type is! ParameterizedType
          ? <ReferenceType>[]
          : type.typeArguments
              .map<ReferenceType>(
                (DartType type) => _toReferenceType(type, allGeneratedClasses),
              )
              .toList(),
    );
  }

  String? _getChannel(DartType type) {
    final TypeChecker typeChecker = TypeChecker.fromRuntime(Reference);
    final Element? element = type.element;

    if (element == null) {
      return null;
    } else if (type.isVoid || !typeChecker.hasAnnotationOf(element)) {
      return null;
    }

    final ConstantReader constantReader =
        ConstantReader(typeChecker.firstAnnotationOf(element));
    return constantReader.read('channel').stringValue;
  }

  @override
  Map<String, List<String>> get buildExtensions => <String, List<String>>{
        '.dart': <String>['.reference_ast'],
      };
}
