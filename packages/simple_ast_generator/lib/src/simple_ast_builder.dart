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

    final Iterable<ClassElement> enums = reader
        .annotatedWith(const TypeChecker.fromRuntime(SimpleEnumAnnotation))
        .where(
      (AnnotatedElement annotatedElement) {
        if (annotatedElement.element is! ClassElement) return false;
        return (annotatedElement.element as ClassElement).isEnum;
      },
    ).map<ClassElement>(
      (AnnotatedElement annotatedElement) =>
          annotatedElement.element as ClassElement,
    );

    if (classes.isEmpty && functions.isEmpty && enums.isEmpty) return;

    final SimpleLibrary ast = _toLibrary(
      reader.element,
      classes,
      functions,
      enums,
    );

    await buildStep.writeAsString(newFile, jsonEncoder.convert(ast.toJson()));
  }

  SimpleLibrary _toLibrary(
    LibraryElement libraryElement,
    Iterable<ClassElement> classes,
    Iterable<TypeAliasElement> functions,
    Iterable<ClassElement> enums,
  ) {
    return SimpleLibrary(
      classes: classes.map<SimpleClass>(_toClass).toList(),
      functions: functions.map<SimpleFunction>(_toFunction).toList(),
      enums: enums.map<SimpleEnum>(_toEnum).toList(),
    );
  }

  SimpleEnum _toEnum(ClassElement element) {
    return SimpleEnum(
      name: element.name,
      values: element.fields
          .map<String>((FieldElement fieldElement) => fieldElement.name)
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
        typeCategory: SimpleTypeCategory.aFunction,
        functionParameters: type is FunctionType
            ? type.parameters.map<SimpleParameter>(_toParameter).toList()
            : <SimpleParameter>[],
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
      typeCategory: _getTypeCategory(type),
      functionParameters: type is FunctionType
          ? type.parameters.map<SimpleParameter>(_toParameter).toList()
          : <SimpleParameter>[],
    );
  }

  SimpleTypeCategory _getTypeCategory(DartType type) {
    if (type.isVoid) {
      return SimpleTypeCategory.isVoid;
    } else if (type is FunctionType) {
      return SimpleTypeCategory.aFunction;
    }

    final Element? element = type.element;
    if (element == null) {
      return SimpleTypeCategory.unknown;
    } else if (element is ClassElement) {
      final TypeChecker typeChecker =
          TypeChecker.fromRuntime(SimpleClassAnnotation);
      if (typeChecker.hasAnnotationOf(element)) {
        return SimpleTypeCategory.aSimpleClass;
      } else if (element.isEnum) {
        return SimpleTypeCategory.anEnum;
      }

      return SimpleTypeCategory.aClass;
    }

    return SimpleTypeCategory.unknown;
  }

  String _getNameWithoutTypeArguments(DartType type) {
    if (type is! ParameterizedType) {
      return type.getDisplayString(withNullability: false);
    }

    final String displayName = type.getDisplayString(withNullability: false);
    if (type is FunctionType) {
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
