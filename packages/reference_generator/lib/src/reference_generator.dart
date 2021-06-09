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

    await buildStep.writeAsString(newFile, jsonEncode(ast));
  }

  LibraryNode _toLibraryNode(
    LibraryElement libraryElement,
    Iterable<ClassElement> classes,
    Iterable<TypeAliasElement> functions,
  ) {
    final Set<Element> allGeneratedElements = <Element>{
      ...classes,
      ...functions
    };
    return LibraryNode(
      classes: classes
          .map<ClassNode>(
            (ClassElement classElement) => _toClassNode(
              classElement,
              allGeneratedElements,
            ),
          )
          .toList(),
      functions: functions
          .map<FunctionNode>(
            (TypeAliasElement typeAliasElement) => _toFunctionNode(
              typeAliasElement,
              allGeneratedElements,
            ),
          )
          .toList(),
    );
  }

  ClassNode _toClassNode(
    ClassElement classElement,
    Set<Element> allGeneratedElements,
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
              _toFieldNode(parameterElement, allGeneratedElements))
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
                _toMethodNode(methodElement, allGeneratedElements),
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
                _toMethodNode(methodElement, allGeneratedElements),
          )
          .toList(),
    );
  }

  FieldNode _toFieldNode(
    ParameterElement parameterElement,
    Set<Element> allGeneratedElements,
  ) {
    return FieldNode(
      name: parameterElement.name,
      type: _toReferenceType(parameterElement.type, allGeneratedElements),
    );
  }

  MethodNode _toMethodNode(
    MethodElement methodElement,
    Set<Element> allGeneratedElements,
  ) {
    return MethodNode(
      name: methodElement.name,
      returnType: _toReferenceType(
        methodElement.returnType,
        allGeneratedElements,
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
                _toParameterNode(parameterElement, allGeneratedElements),
          )
          .toList(),
    );
  }

  FunctionNode _toFunctionNode(
    TypeAliasElement typeAliasElement,
    Set<Element> allGeneratedElements,
  ) {
    final FunctionType functionType =
        typeAliasElement.aliasedType as FunctionType;
    return FunctionNode(
      name: typeAliasElement.name,
      channelName: _getChannelFromTypeAlias(typeAliasElement),
      returnType: _toReferenceType(
        functionType,
        allGeneratedElements,
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
                _toParameterNode(parameterElement, allGeneratedElements),
          )
          .toList(),
    );
  }

  ParameterNode _toParameterNode(
    ParameterElement parameterElement,
    Set<Element> allGeneratedElements,
  ) {
    return ParameterNode(
      name: parameterElement.name,
      type: _toReferenceType(parameterElement.type, allGeneratedElements),
    );
  }

  ReferenceType _toReferenceType(
    DartType type,
    Set<Element> allGeneratedElements,
  ) {
    final String displayName = type.getDisplayString(withNullability: true);
    // TODO: Use type.nullabilitySuffix
    final TypeAliasElement? aliasElement = type.aliasElement;
    if (aliasElement != null) {
      return ReferenceType(
        name: aliasElement.name,
        nullable: displayName.endsWith('?'),
        codeGeneratedType: allGeneratedElements.contains(aliasElement),
        typeArguments: <ReferenceType>[],
        functionType: true,
      );
    }
    return ReferenceType(
      name: displayName.split(RegExp('[<?]')).first,
      nullable: displayName.endsWith('?'),
      codeGeneratedType: allGeneratedElements.contains(type.element),
      functionType: false,
      typeArguments: type is! ParameterizedType || type.isDartCoreMap
          ? <ReferenceType>[]
          : type.typeArguments
              .map<ReferenceType>(
                (DartType type) => _toReferenceType(type, allGeneratedElements),
              )
              .toList(),
    );
  }

  String _getChannelFromTypeAlias(TypeAliasElement element) {
    final TypeChecker typeChecker = TypeChecker.fromRuntime(Reference);
    final ConstantReader constantReader =
        ConstantReader(typeChecker.firstAnnotationOf(element));
    return constantReader.read('channel').stringValue;
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
