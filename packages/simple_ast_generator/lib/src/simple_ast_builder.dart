import 'dart:async';
import 'dart:convert';

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:simple_ast/annotations.dart';
import 'package:simple_ast/simple_ast.dart';
import 'package:source_gen/source_gen.dart';

const JsonEncoder jsonEncoder = JsonEncoder.withIndent('  ');

enum SimpleTypeCategory {
  isVoid,
  aClass,
  aFunction,
  anEnum,
  aSimpleClass,
  unknown
}

const TypeChecker classAnnotation =
    TypeChecker.fromRuntime(SimpleClassAnnotation);
const TypeChecker methodAnnotation =
    TypeChecker.fromRuntime(SimpleMethodAnnotation);
const TypeChecker parameterAnnotation =
    TypeChecker.fromRuntime(SimpleParameterAnnotation);
const TypeChecker constructorAnnotation =
    TypeChecker.fromRuntime(SimpleConstructorAnnotation);
const TypeChecker typeAnnotation =
    TypeChecker.fromRuntime(SimpleTypeAnnotation);

class SimpleAstBuilder extends Builder {
  static SimpleMethodAnnotation? tryReadMethodAnnotation(
      MethodElement element) {
    if (!methodAnnotation.hasAnnotationOfExact(element)) return null;
    final ConstantReader reader = ConstantReader(
      methodAnnotation.firstAnnotationOfExact(element),
    );
    return SimpleMethodAnnotation(
      ignore: reader.read('ignore').boolValue,
      customValues: readCustomValues(reader),
    );
  }

  static SimpleParameterAnnotation? tryReadParameterAnnotation(
    ParameterElement element,
  ) {
    if (!parameterAnnotation.hasAnnotationOfExact(element)) return null;
    final ConstantReader reader = ConstantReader(
      parameterAnnotation.firstAnnotationOfExact(element),
    );
    return SimpleParameterAnnotation(
      ignore: reader.read('ignore').boolValue,
      customValues: readCustomValues(reader),
    );
  }

  static SimpleTypeAnnotation? tryReadTypeAnnotation(Element element) {
    if (!typeAnnotation.hasAnnotationOfExact(element)) return null;
    final ConstantReader reader = ConstantReader(
      typeAnnotation.firstAnnotationOfExact(element),
    );
    return SimpleTypeAnnotation(customValues: readCustomValues(reader));
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

  static SimpleClassAnnotation? tryReadClassAnnotation(
    ClassElement element,
  ) {
    if (!classAnnotation.hasAnnotationOfExact(element)) return null;
    final ConstantReader reader = ConstantReader(
      classAnnotation.firstAnnotationOfExact(element),
    );
    return SimpleClassAnnotation(
      ignore: reader.read('ignore').boolValue,
      customValues: readCustomValues(reader),
    );
  }

  static Map<String, Object?> readCustomValues(ConstantReader reader) {
    return reader.read('customValues').mapValue.map<String, Object?>(
      (DartObject? key, DartObject? value) {
        final ArgumentError argumentError = ArgumentError(
            'Custom value is not supported: ${value?.type?.getDisplayString(withNullability: true)}');

        final Object? mapValue;
        if (value == null || value.isNull) {
          mapValue = null;
        } else if (!value.hasKnownValue || value.type == null) {
          throw argumentError;
        } else if (value.type!.isDartCoreString) {
          mapValue = value.toStringValue()!;
        } else if (value.type!.isDartCoreBool) {
          mapValue = value.toBoolValue()!;
        } else if (value.type!.isDartCoreInt) {
          mapValue = value.toIntValue()!;
        } else if (value.type!.isDartCoreDouble) {
          mapValue = value.toDoubleValue()!;
        } else {
          throw argumentError;
        }

        return MapEntry<String, Object?>(
          key!.toStringValue()!,
          mapValue,
        );
      },
    );
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

    final Iterable<EnumElement> enums = reader
        .annotatedWith(const TypeChecker.fromRuntime(SimpleEnumAnnotation))
        .where(
      (AnnotatedElement annotatedElement) {
        return annotatedElement.element is EnumElement;
      },
    ).map<EnumElement>(
      (AnnotatedElement annotatedElement) =>
          annotatedElement.element as EnumElement,
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
    Iterable<EnumElement> enums,
  ) {
    return SimpleLibrary(
      classes: classes
          .where(
            (ClassElement element) {
              final SimpleClassAnnotation? classAnnotation =
                  tryReadClassAnnotation(element);
              if (classAnnotation == null) return true;
              return !classAnnotation.ignore;
            },
          )
          .map<SimpleClass>(_toClass)
          .toList(),
      functions: functions.map<SimpleFunction>(_toFunction).toList(),
      enums: enums.map<SimpleEnum>(_toEnum).toList(),
    );
  }

  SimpleEnum _toEnum(EnumElement enumElement) {
    return SimpleEnum(
      name: enumElement.name,
      private: enumElement.isPrivate,
      values: enumElement.fields
          .where((FieldElement element) {
            return element.name != 'index' && element.name != 'values';
          })
          .map<SimpleField>(_toField)
          .toList(),
    );
  }

  SimpleClass _toClass(ClassElement classElement) {
    return SimpleClass(
      name: classElement.name,
      private: classElement.isPrivate,
      constructors: classElement.constructors
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
      fields: classElement.fields.map<SimpleField>(_toField).toList(),
      methods: classElement.methods
          .where((MethodElement element) {
            final SimpleMethodAnnotation? methodAnnotation =
                tryReadMethodAnnotation(element);
            if (methodAnnotation == null) return true;
            return !methodAnnotation.ignore;
          })
          .map<SimpleMethod>(_toMethod)
          .toList(),
      customValues: tryReadClassAnnotation(classElement)?.customValues ??
          <String, Object?>{},
    );
  }

  SimpleField _toField(FieldElement fieldElement) {
    return SimpleField(
      name: fieldElement.name,
      private: fieldElement.isPrivate,
      static: fieldElement.isStatic,
      type: _toType(fieldElement.type),
    );
  }

  SimpleConstructor _toConstructor(ConstructorElement constructorElement) {
    return SimpleConstructor(
      name: constructorElement.name,
      private: constructorElement.isPrivate,
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
      private: methodElement.isPrivate,
      returnType: _toType(
        methodElement.returnType,
        typeAnnotation: tryReadTypeAnnotation(methodElement),
      ),
      returnsVoid: methodElement.returnType.isVoid ||
          (methodElement.returnType.isDartAsyncFuture &&
              (methodElement.returnType as ParameterizedType)
                  .typeArguments
                  .single
                  .isVoid),
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
      customValues: tryReadMethodAnnotation(methodElement)?.customValues ??
          <String, Object?>{},
    );
  }

  SimpleFunction _toFunction(TypeAliasElement typeAliasElement) {
    final FunctionType functionType =
        typeAliasElement.aliasedType as FunctionType;
    return SimpleFunction(
      name: typeAliasElement.name,
      returnType: _toType(functionType.returnType),
      private: typeAliasElement.isPrivate,
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
      type: _toType(
        parameterElement.type,
        typeAnnotation: tryReadTypeAnnotation(parameterElement),
      ),
      isNamed: parameterElement.isNamed,
      customValues:
          tryReadParameterAnnotation(parameterElement)?.customValues ??
              <String, Object?>{},
    );
  }

  SimpleType _toType(
    DartType type, {
    SimpleTypeAnnotation? typeAnnotation,
  }) {
    final InstantiatedTypeAliasElement? alias = type.alias;
    if (alias != null) {
      return SimpleType(
        name: alias.element.name.split(RegExp('[<]')).first,
        nullable: type.nullabilitySuffix == NullabilitySuffix.question,
        typeArguments: alias.typeArguments.map<SimpleType>(_toType).toList(),
        isVoid: false,
        isFunction: true,
        isClass: false,
        isSimpleClass: false,
        isEnum: false,
        isUnknownOrUnsupportedType: false,
        functionParameters: type is FunctionType
            ? type.parameters.map<SimpleParameter>(_toParameter).toList()
            : <SimpleParameter>[],
        functionReturnType:
            type is FunctionType ? _toType(type.returnType) : null,
        customValues: typeAnnotation?.customValues ?? <String, Object?>{},
      );
    }

    final SimpleTypeCategory typeCategory = _getTypeCategory(type);
    return SimpleType(
      name: _getNameWithoutTypeArguments(type),
      nullable: type.nullabilitySuffix == NullabilitySuffix.question,
      typeArguments: type is! ParameterizedType
          ? <SimpleType>[]
          : type.typeArguments
              .map<SimpleType>((DartType type) => _toType(type))
              .toList(),
      isVoid: typeCategory == SimpleTypeCategory.isVoid,
      isFunction: typeCategory == SimpleTypeCategory.aFunction,
      isClass: typeCategory == SimpleTypeCategory.aClass ||
          typeCategory == SimpleTypeCategory.aSimpleClass,
      isSimpleClass: typeCategory == SimpleTypeCategory.aSimpleClass,
      isEnum: typeCategory == SimpleTypeCategory.anEnum,
      isUnknownOrUnsupportedType: typeCategory == SimpleTypeCategory.unknown,
      functionParameters: type is FunctionType
          ? type.parameters.map<SimpleParameter>(_toParameter).toList()
          : <SimpleParameter>[],
      functionReturnType:
          type is FunctionType ? _toType(type.returnType) : null,
      customValues: typeAnnotation?.customValues ?? <String, Object?>{},
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
      }

      return SimpleTypeCategory.aClass;
    } else if (element is EnumElement) {
      return SimpleTypeCategory.anEnum;
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
