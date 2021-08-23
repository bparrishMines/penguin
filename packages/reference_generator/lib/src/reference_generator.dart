import 'dart:async';
import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
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
  static const TypeChecker constructorAnnotation =
      TypeChecker.fromRuntime(ReferenceConstructor);

  static ReferenceMethod? tryReadMethodAnnotation(MethodElement element) {
    if (!methodAnnotation.hasAnnotationOfExact(element)) return null;
    final ConstantReader reader = ConstantReader(
      methodAnnotation.firstAnnotationOfExact(element),
    );
    return ReferenceMethod(ignore: reader.read('ignore').boolValue);
  }

  static ReferenceParameter? tryReadParameterAnnotation(Element element) {
    if (element is! ParameterElement && element is! MethodElement) {
      throw ArgumentError();
    }

    if (!parameterAnnotation.hasAnnotationOfExact(element)) return null;
    final ConstantReader reader = ConstantReader(
      parameterAnnotation.firstAnnotationOfExact(element),
    );

    final ConstantReader platformTypeImportReader =
        reader.read('platformTypeImport');
    final ConstantReader platformTypeNameReader =
        reader.read('platformTypeName');
    return ReferenceParameter(
      ignore: reader.read('ignore').boolValue,
      platformTypeImport: platformTypeImportReader.isNull
          ? null
          : platformTypeImportReader.stringValue,
      platformTypeName: platformTypeNameReader.isNull
          ? null
          : platformTypeNameReader.stringValue,
    );
  }

  static ReferenceConstructor? tryReadConstructorAnnotation(
    ConstructorElement element,
  ) {
    if (!constructorAnnotation.hasAnnotationOfExact(element)) return null;
    final ConstantReader reader = ConstantReader(
      constructorAnnotation.firstAnnotationOfExact(element),
    );
    return ReferenceConstructor(ignore: reader.read('ignore').boolValue);
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

    final LibraryNode ast = _toLibraryNode(
      libraryElement: reader.element,
      classes: classes,
      functions: functions,
    );

    await buildStep.writeAsString(newFile, jsonEncode(ast));
  }

  LibraryNode _toLibraryNode({
    required LibraryElement libraryElement,
    required Iterable<ClassElement> classes,
    required Iterable<TypeAliasElement> functions,
  }) {
    final Set<String> dartImports = <String>{
      libraryElement.source.uri.toString(),
    };
    final Set<String> platformImports = <String>{};

    final List<ClassNode> classNodes = classes
        .map<ClassNode>(
          (ClassElement classElement) => _toClassNode(
            classElement: classElement,
            dartImports: dartImports,
            platformImports: platformImports,
          ),
        )
        .toList();
    final List<FunctionNode> functionNodes = functions
        .map<FunctionNode>(
          (TypeAliasElement typeAliasElement) => _toFunctionNode(
            typeAliasElement: typeAliasElement,
            dartImports: dartImports,
            platformImports: platformImports,
          ),
        )
        .toList();

    return LibraryNode(
      classes: classNodes,
      functions: functionNodes,
      dartImports: dartImports.toList(),
      platformImports: platformImports.toList(),
    );
  }

  ClassNode _toClassNode({
    required ClassElement classElement,
    required Set<String> dartImports,
    required Set<String> platformImports,
  }) {
    // This is always non-null because these are filtered classes from the
    // current library.
    final Reference reference =
        _tryGetReferenceFromDartType(classElement.thisType)!;

    platformImports.add(reference.platformImport);
    return ClassNode(
      dartName: classElement.name,
      platformName: reference.platformClassName,
      channelName: reference.channel,
      constructors: classElement.constructors
          .where((ConstructorElement element) => !element.isPrivate)
          .where(
        (ConstructorElement element) {
          final ReferenceConstructor? referenceConstructor =
              tryReadConstructorAnnotation(element);
          if (referenceConstructor == null) return true;
          return !referenceConstructor.ignore;
        },
      ).map<ConstructorNode>(
        (ConstructorElement constructorElement) {
          return _toConstructorNode(
            constructorElement: constructorElement,
            dartImports: dartImports,
            platformImports: platformImports,
          );
        },
      ).toList(),
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
            (MethodElement methodElement) => _toMethodNode(
              methodElement: methodElement,
              dartImports: dartImports,
              platformImports: platformImports,
            ),
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
            (MethodElement methodElement) => _toMethodNode(
              methodElement: methodElement,
              dartImports: dartImports,
              platformImports: platformImports,
            ),
          )
          .toList(),
    );
  }

  ConstructorNode _toConstructorNode({
    required ConstructorElement constructorElement,
    required Set<String> dartImports,
    required Set<String> platformImports,
  }) {
    Iterable<ParameterNode> parameters =
        constructorElement.parameters.where((ParameterElement element) {
      final ReferenceParameter? referenceParameter =
          tryReadParameterAnnotation(element);
      if (referenceParameter == null) return true;
      return !referenceParameter.ignore;
    }).map<ParameterNode>(
      (ParameterElement parameterElement) => _toParameterNode(
        parameterElement: parameterElement,
        dartImports: dartImports,
        platformImports: platformImports,
      ),
    );

    if (parameters.isNotEmpty &&
        parameters.last.name == 'create' &&
        parameters.last.type.dartName == 'bool') {
      parameters = parameters.take(parameters.length - 1);
    }

    return ConstructorNode(
      name: constructorElement.name,
      parameters: parameters.toList(),
      isNamed: constructorElement.name != '',
    );
  }

  MethodNode _toMethodNode({
    required MethodElement methodElement,
    required Set<String> dartImports,
    required Set<String> platformImports,
  }) {
    final ReferenceParameter? referenceParameter =
        tryReadParameterAnnotation(methodElement);

    final String? platformReturnTypeImport =
        referenceParameter?.platformTypeImport;
    if (referenceParameter != null && platformReturnTypeImport != null) {
      platformImports.add(platformReturnTypeImport);
    }

    return MethodNode(
      name: methodElement.name,
      returnType: _toTypeNode(
        type: methodElement.returnType,
        dartImports: dartImports,
        platformImports: platformImports,
        platformTypeNameOverride: referenceParameter?.platformTypeName,
      ),
      parameters: methodElement.parameters
          .where((ParameterElement element) {
            final ReferenceParameter? referenceParameter =
                tryReadParameterAnnotation(element);
            if (referenceParameter == null) return true;
            return !referenceParameter.ignore;
          })
          .map<ParameterNode>(
            (ParameterElement parameterElement) => _toParameterNode(
              parameterElement: parameterElement,
              dartImports: dartImports,
              platformImports: platformImports,
            ),
          )
          .toList(),
    );
  }

  FunctionNode _toFunctionNode({
    required TypeAliasElement typeAliasElement,
    required Set<String> dartImports,
    required Set<String> platformImports,
  }) {
    final FunctionType functionType =
        typeAliasElement.aliasedType as FunctionType;

    // This is always non-null because these are filtered classes from the
    // current library.
    final Reference reference =
        _tryGetReferenceFromTypeAlias(typeAliasElement)!;
    platformImports.add(reference.platformImport);
    return FunctionNode(
      dartName: typeAliasElement.name,
      platformName: reference.platformClassName,
      channelName: reference.channel,
      returnType: _toTypeNode(
        type: functionType.returnType,
        dartImports: dartImports,
        platformImports: platformImports,
      ),
      parameters: functionType.parameters
          .where((ParameterElement element) {
            final ReferenceParameter? referenceParameter =
                tryReadParameterAnnotation(element);
            if (referenceParameter == null) return true;
            return !referenceParameter.ignore;
          })
          .map<ParameterNode>(
            (ParameterElement parameterElement) => _toParameterNode(
              parameterElement: parameterElement,
              dartImports: dartImports,
              platformImports: platformImports,
            ),
          )
          .toList(),
    );
  }

  ParameterNode _toParameterNode({
    required ParameterElement parameterElement,
    required Set<String> dartImports,
    required Set<String> platformImports,
  }) {
    final ReferenceParameter? referenceParameter =
        tryReadParameterAnnotation(parameterElement);

    final String? platformTypeImport = referenceParameter?.platformTypeImport;
    if (referenceParameter != null && platformTypeImport != null) {
      platformImports.add(platformTypeImport);
    }

    return ParameterNode(
      name: parameterElement.name,
      type: _toTypeNode(
        type: parameterElement.type,
        dartImports: dartImports,
        platformImports: platformImports,
        platformTypeNameOverride: referenceParameter?.platformTypeName,
      ),
      isNamed: parameterElement.isNamed,
    );
  }

  TypeNode _toTypeNode({
    required DartType type,
    required Set<String> dartImports,
    required Set<String> platformImports,
    String? platformTypeNameOverride,
  }) {
    DartType nonFutureType = type;
    if (type.isDartAsyncFuture || type.isDartAsyncFutureOr) {
      nonFutureType = (type as ParameterizedType).typeArguments.first;

      if (nonFutureType.isDartAsyncFuture ||
          nonFutureType.isDartAsyncFutureOr) {
        throw StateError('Why are you nesting Futures?');
      }
    }

    final String displayName =
        nonFutureType.getDisplayString(withNullability: false);
    final TypeAliasElement? aliasElement = nonFutureType.aliasElement;
    if (aliasElement != null) {
      final Reference? typeAliasReference =
          _tryGetReferenceFromTypeAlias(aliasElement);
      final bool isReference = typeAliasReference != null;
      if (isReference) {
        dartImports.add(aliasElement.source.uri.toString());
        platformImports.add(typeAliasReference.platformImport);
      } else {
        final String import = aliasElement.library.source.shortName.toString();
        dartImports.add(import);
      }
      return TypeNode(
        dartName: aliasElement.name,
        platformName: aliasElement.name,
        nullable: nonFutureType.nullabilitySuffix == NullabilitySuffix.question,
        typeArguments: <TypeNode>[],
        functionType: true,
        isFuture: type.isDartAsyncFuture || type.isDartAsyncFutureOr,
      );
    }

    final Reference? classReference =
        _tryGetReferenceFromDartType(nonFutureType);
    final bool isReference = classReference != null;
    if (isReference) {
      // Has source because it has a class reference.
      dartImports.add(nonFutureType.element!.source!.uri.toString());
      platformImports.add(classReference.platformImport);
    } else {
      // TODO: improve logic?
      String? import =
          nonFutureType.element?.library?.source.shortName.toString();
      import ??= nonFutureType.element?.source?.toString();
      if (import != null) dartImports.add(import);
    }

    return TypeNode(
      dartName: displayName.split(RegExp('[<]')).first,
      platformName: isReference
          ? classReference.platformClassName
          : platformTypeNameOverride ?? displayName.split(RegExp('[<]')).first,
      nullable: nonFutureType.nullabilitySuffix == NullabilitySuffix.question,
      functionType: false,
      typeArguments: nonFutureType is! ParameterizedType ||
              platformTypeNameOverride != null
          ? <TypeNode>[]
          : nonFutureType.typeArguments
              .map<TypeNode>(
                (DartType type) => _toTypeNode(
                  type: type,
                  dartImports: dartImports,
                  platformImports: platformImports,
                ),
              )
              .toList(),
      isFuture: type.isDartAsyncFuture || type.isDartAsyncFutureOr,
    );
  }

  Reference? _tryGetReferenceFromDartType(DartType type) {
    final TypeChecker typeChecker = TypeChecker.fromRuntime(Reference);
    final Element? element = type.element;

    if (element == null) {
      return null;
    } else if (type.isVoid || !typeChecker.hasAnnotationOf(element)) {
      return null;
    }

    final ConstantReader constantReader =
        ConstantReader(typeChecker.firstAnnotationOf(element));
    return Reference(
      channel: constantReader.read('channel').stringValue,
      platformImport: constantReader.read('platformImport').stringValue,
      platformClassName: constantReader.read('platformClassName').stringValue,
    );
  }

  Reference? _tryGetReferenceFromTypeAlias(TypeAliasElement element) {
    final TypeChecker typeChecker = TypeChecker.fromRuntime(Reference);
    final ConstantReader constantReader =
        ConstantReader(typeChecker.firstAnnotationOf(element));
    return Reference(
      channel: constantReader.read('channel').stringValue,
      platformImport: constantReader.read('platformImport').stringValue,
      platformClassName: constantReader.read('platformClassName').stringValue,
    );
  }

  @override
  Map<String, List<String>> get buildExtensions => <String, List<String>>{
        '.dart': <String>['.reference_ast'],
      };
}
