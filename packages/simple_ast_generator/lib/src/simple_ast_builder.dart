import 'dart:async';
import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:simple_ast/annotations.dart';
import 'package:simple_ast/simple_ast.dart';
import 'package:source_gen/source_gen.dart';

const JsonEncoder jsonEncoder = JsonEncoder.withIndent('  ');

const TypeChecker classAnnotation =
    TypeChecker.fromRuntime(SimpleClassAnnotation);
const TypeChecker methodAnnotation =
    TypeChecker.fromRuntime(SimpleMethodAnnotation);
const TypeChecker parameterAnnotation =
    TypeChecker.fromRuntime(SimpleParameterAnnotation);
const TypeChecker constructorAnnotation =
    TypeChecker.fromRuntime(SimpleConstructorAnnotation);

class SimpleAstBuilder extends Builder {
  static SimpleMethodAnnotation? tryReadMethodAnnotation(
      MethodElement element) {
    if (!methodAnnotation.hasAnnotationOfExact(element)) return null;
    final ConstantReader reader = ConstantReader(
      methodAnnotation.firstAnnotationOfExact(element),
    );
    return SimpleMethodAnnotation(ignore: reader.read('ignore').boolValue);
  }

  static SimpleParameterAnnotation? tryReadParameterAnnotation(
    ParameterElement element,
  ) {
    if (!parameterAnnotation.hasAnnotationOfExact(element)) return null;
    final ConstantReader reader = ConstantReader(
      parameterAnnotation.firstAnnotationOfExact(element),
    );
    return SimpleParameterAnnotation(ignore: reader.read('ignore').boolValue);
  }

  static SimpleConstructorAnnotation? tryReadConstructorAnnotation(
    ConstructorElement element,
  ) {
    if (!constructorAnnotation.hasAnnotationOfExact(element)) return null;
    final ConstantReader reader = ConstantReader(
      constructorAnnotation.firstAnnotationOfExact(element),
    );
    return SimpleConstructorAnnotation(ignore: reader.read('ignore').boolValue);
  }

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final AssetId newFile =
        buildStep.inputId.changeExtension('.simple_ast.json');

    final Resolver resolver = buildStep.resolver;
    if (!await resolver.isLibrary(buildStep.inputId)) return null;

    final LibraryReader reader = LibraryReader(await buildStep.inputLibrary);

    final Iterable<ClassElement> classes = reader
        .annotatedWith(const TypeChecker.fromRuntime(SimpleClassAnnotation))
        .where(
          (AnnotatedElement annotatedElement) =>
              annotatedElement.element is ClassElement,
        )
        .map<ClassElement>(
          (AnnotatedElement annotatedElement) =>
              annotatedElement.element as ClassElement,
        );

    final Iterable<TypeAliasElement> functions = reader
        .annotatedWith(const TypeChecker.fromRuntime(SimpleFunctionAnnotation))
        .where(
          (AnnotatedElement annotatedElement) =>
              annotatedElement.element is TypeAliasElement,
        )
        .map<TypeAliasElement>(
          (AnnotatedElement annotatedElement) =>
              annotatedElement.element as TypeAliasElement,
        );

    if (classes.isEmpty && functions.isEmpty) return;

    final SimpleLibrary ast = _toLibrary(reader.element, classes, functions);

    await buildStep.writeAsString(newFile, jsonEncoder.convert(ast.toJson()));
  }

  SimpleLibrary _toLibrary(
    LibraryElement libraryElement,
    Iterable<ClassElement> classes,
    Iterable<TypeAliasElement> functions,
  ) {
    return SimpleLibrary(
      classes: classes
          .map<SimpleClass>(
            (ClassElement classElement) => _toClass(classElement),
          )
          .toList(),
      functions: functions
          .map<SimpleFunction>(
            (TypeAliasElement typeAliasElement) => _toFunction(
              typeAliasElement,
            ),
          )
          .toList(),
    );
  }

  SimpleClass _toClass(ClassElement classElement) {
    return SimpleClass(
      name: classElement.name,
      constructors: classElement.constructors
          .where((ConstructorElement constructorElement) {
            return !constructorElement.isPrivate;
          })
          .where(
            (ConstructorElement element) {
              final SimpleConstructorAnnotation? constructorAnnotation =
                  tryReadConstructorAnnotation(element);
              if (constructorAnnotation == null) return true;
              return !constructorAnnotation.ignore;
            },
          )
          .map<SimpleConstructor>(_toConstructor)
          .toList(),
      fields: classElement.fields
          .where((FieldElement fieldElement) => !fieldElement.isPrivate)
          .map<SimpleField>(_toField)
          .toList(),
      methods: classElement.methods
          .where((MethodElement element) => !element.isPrivate)
          .where((MethodElement element) {
            final SimpleMethodAnnotation? methodAnnotation =
                tryReadMethodAnnotation(element);
            if (methodAnnotation == null) return true;
            return !methodAnnotation.ignore;
          })
          .map<SimpleMethod>(_toMethod)
          .toList(),
    );
  }

  SimpleField _toField(FieldElement fieldElement) {
    return SimpleField(
      name: fieldElement.name,
      type: _toType(fieldElement.type),
    );
  }

  SimpleConstructor _toConstructor(ConstructorElement constructorElement) {
    return SimpleConstructor(
      name: constructorElement.name,
      parameters:
          constructorElement.parameters.where((ParameterElement element) {
        final SimpleParameterAnnotation? parameterAnnotation =
            tryReadParameterAnnotation(element);
        if (parameterAnnotation == null) return true;
        return !parameterAnnotation.ignore;
      }).map<SimpleParameter>(
        (ParameterElement parameterElement) {
          return _toParameter(parameterElement);
        },
      ).toList(),
    );
  }

  SimpleMethod _toMethod(MethodElement methodElement) {
    return SimpleMethod(
      name: methodElement.name,
      returnType: _toType(methodElement.returnType),
      static: methodElement.isStatic,
      parameters: methodElement.parameters.where((ParameterElement element) {
        final SimpleParameterAnnotation? parameterAnnotation =
            tryReadParameterAnnotation(element);
        if (parameterAnnotation == null) return true;
        return !parameterAnnotation.ignore;
      }).map<SimpleParameter>(
        (ParameterElement parameterElement) {
          return _toParameter(parameterElement);
        },
      ).toList(),
    );
  }

  SimpleFunction _toFunction(TypeAliasElement typeAliasElement) {
    final FunctionType functionType =
        typeAliasElement.aliasedType as FunctionType;
    return SimpleFunction(
      name: typeAliasElement.name,
      returnType: _toType(functionType.returnType),
      parameters: functionType.parameters.where((ParameterElement element) {
        final SimpleParameterAnnotation? parameterAnnotation =
            tryReadParameterAnnotation(element);
        if (parameterAnnotation == null) return true;
        return !parameterAnnotation.ignore;
      }).map<SimpleParameter>(
        (ParameterElement parameterElement) {
          return _toParameter(parameterElement);
        },
      ).toList(),
    );
  }

  SimpleParameter _toParameter(ParameterElement parameterElement) {
    return SimpleParameter(
      name: parameterElement.name,
      type: _toType(parameterElement.type),
    );
  }

  SimpleType _toType(DartType type) {
    final InstantiatedTypeAliasElement? alias = type.alias;
    if (alias != null) {
      return SimpleType(
        name: alias.element.name.split(RegExp('[<]')).first,
        nullable: type.nullabilitySuffix == NullabilitySuffix.question,
        typeArguments: alias.typeArguments.map<SimpleType>(_toType).toList(),
      );
    }

    return SimpleType(
      name: _getNameWithoutTypeArguments(type),
      nullable: type.nullabilitySuffix == NullabilitySuffix.question,
      typeArguments: type is! ParameterizedType
          ? <SimpleType>[]
          : type.typeArguments
              .map<SimpleType>((DartType type) => _toType(type))
              .toList(),
    );
  }

  String _getNameWithoutTypeArguments(DartType type) {
    if (type is! ParameterizedType) {
      return type.getDisplayString(withNullability: false);
    }

    final String displayName = type.getDisplayString(withNullability: false);
    if (type.isDartCoreFunction) {
      return RegExp(r'.*Function.*(?=\()', multiLine: true)
          .stringMatch(displayName)!;
    }

    return displayName.split(RegExp('[<]')).first;
  }

  @override
  Map<String, List<String>> get buildExtensions => <String, List<String>>{
        '.dart': <String>['.simple_ast.json'],
      };
}
