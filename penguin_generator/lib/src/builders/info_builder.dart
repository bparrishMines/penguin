import 'dart:async';
import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:penguin/penguin.dart';
import 'package:source_gen/source_gen.dart';

import '../info.dart';
import 'annotation_utils.dart';

class InfoBuilder extends Builder {
  static const String infoExtension = '.info';

  static const String libraryClassesKey = 'libraryClasses';
  static const String importedClassesKey = 'importedClasses';

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final Resolver resolver = buildStep.resolver;
    if (!await resolver.isLibrary(buildStep.inputId)) return null;

    final LibraryReader reader = LibraryReader(await buildStep.inputLibrary);

    final _InfoBuilderHelper builderHelper = _InfoBuilderHelper(
      reader.annotatedWith(Annotation.$class).map<ClassElement>(
          (AnnotatedElement annotatedElement) => annotatedElement.element),
    );

    if (builderHelper.libraryClasses.isEmpty) return Future<void>.value();

    buildStep.writeAsString(
      buildStep.inputId.changeExtension(infoExtension),
      jsonEncode(<String, List<ClassInfo>>{
        libraryClassesKey: builderHelper.libraryClasses,
        importedClassesKey: builderHelper.importedClasses,
      }),
    );
  }

  @override
  Map<String, List<String>> get buildExtensions => <String, List<String>>{
        '.dart': <String>[infoExtension],
      };
}

class _InfoBuilderHelper {
  _InfoBuilderHelper(this.libraryClassElements) {
    _allReferencedClassElements.addAll(libraryClassElements);
    libraryClasses.addAll(libraryClassElements.map<ClassInfo>(
        (ClassElement classElement) => _toClassInfo(classElement)));
  }

  final Iterable<ClassElement> libraryClassElements;
  final Set<ClassElement> _allReferencedClassElements = <ClassElement>{};

  final List<ClassInfo> libraryClasses = <ClassInfo>[];
  final List<ClassInfo> importedClasses = <ClassInfo>[];

  ClassInfo _toClassInfo(ClassElement classElement) => ClassInfo(
        name: classElement.name,
        aClass: AnnotationUtils.classFromConstantReader(
          ConstantReader(
            Annotation.$class.firstAnnotationOfExact(classElement),
          ),
        ),
        constructors: classElement.constructors
            .where((ConstructorElement constructorElement) =>
                Annotation.constructor.hasAnnotationOfExact(constructorElement))
            .map<ConstructorInfo>(
              (ConstructorElement constructorElement) => ConstructorInfo(
                name: constructorElement.name,
                constructor: AnnotationUtils.constructorFromConstantReader(
                  ConstantReader(
                    Annotation.constructor
                        .firstAnnotationOfExact(constructorElement),
                  ),
                ),
                parameters: constructorElement.parameters.map<ParameterInfo>(
                  (ParameterElement parameterElement) => ParameterInfo(
                    name: parameterElement.name,
                    type: toTypeInfo(
                      parameterElement.type,
                      parameterElement,
                    ),
                  ),
                ),
              ),
            ),
        methods: classElement.methods
            .followedBy(
              classElement.allSupertypes.expand<MethodElement>(
                (InterfaceType interfaceType) => interfaceType.element.methods
                    .where((MethodElement methodElement) =>
                        !methodElement.isStatic),
              ),
            )
            .where(
              (MethodElement element) =>
                  Annotation.method.hasAnnotationOfExact(element),
            )
            .map<MethodInfo>(
              (MethodElement methodElement) => MethodInfo(
                isStatic: methodElement.isStatic,
                parameters: methodElement.parameters.map<ParameterInfo>(
                  (ParameterElement parameterElement) => ParameterInfo(
                    name: parameterElement.name,
                    type: toTypeInfo(
                      parameterElement.type,
                      parameterElement,
                    ),
                  ),
                ),
                name: methodElement.name,
                returnType: methodElement.returnType.isDartAsyncFuture ||
                        methodElement.returnType.isDartAsyncFutureOr
                    ? toTypeInfo(
                        (methodElement.returnType as ParameterizedType)
                            .typeArguments[0],
                        methodElement,
                      )
                    : toTypeInfo(
                        methodElement.returnType,
                        methodElement,
                      ),
                method: AnnotationUtils.methodFromConstantReader(
                  ConstantReader(
                    Annotation.method.firstAnnotationOfExact(methodElement),
                  ),
                ),
              ),
            ),
        fields: [
          ...classElement.fields
              .followedBy(
                classElement.allSupertypes.expand<FieldElement>(
                  (InterfaceType interfaceType) => interfaceType.element.fields
                      .where((FieldElement fieldElement) =>
                          !fieldElement.isStatic),
                ),
              )
              .where(
                (FieldElement fieldElement) =>
                    Annotation.field.hasAnnotationOfExact(fieldElement),
              )
              .map<FieldInfo>(
                (FieldElement fieldElement) => FieldInfo(
                  isMutable: fieldElement.isPublic && !fieldElement.isFinal,
                  isStatic: fieldElement.isStatic,
                  name: getRealFieldName(fieldElement),
                  type: fieldElement.type.isDartAsyncFuture ||
                          fieldElement.type.isDartAsyncFutureOr
                      ? toTypeInfo(
                          (fieldElement.type as ParameterizedType)
                              .typeArguments[0],
                          fieldElement,
                        )
                      : toTypeInfo(
                          fieldElement.type,
                          fieldElement,
                        ),
                  field: AnnotationUtils.fieldFromConstantReader(
                    ConstantReader(
                      Annotation.field.firstAnnotationOfExact(fieldElement),
                    ),
                  ),
                ),
              ),
          ...classElement.accessors
              .followedBy(
                classElement.allSupertypes.expand<PropertyAccessorElement>(
                  (InterfaceType interfaceType) => interfaceType
                      .element.accessors
                      .where((PropertyAccessorElement accessorElement) =>
                          !accessorElement.isStatic),
                ),
              )
              .where(
                (PropertyAccessorElement accessorElement) =>
                    Annotation.field.hasAnnotationOfExact(accessorElement),
              )
              .where(
                (PropertyAccessorElement accessorElement) =>
                    accessorElement.isSetter ||
                    (accessorElement.isGetter &&
                        accessorElement.correspondingSetter == null),
              )
              .map<FieldInfo>(
                (PropertyAccessorElement accessorElement) => FieldInfo(
                  isMutable: accessorElement.isSetter,
                  isStatic: accessorElement.isStatic,
                  name: getRealFieldName(accessorElement),
                  type: accessorElement.variable.type.isDartAsyncFuture ||
                          accessorElement.variable.type.isDartAsyncFutureOr
                      ? toTypeInfo(
                          (accessorElement.variable.type as ParameterizedType)
                              .typeArguments[0],
                          accessorElement,
                        )
                      : toTypeInfo(
                          accessorElement.variable.type,
                          accessorElement,
                        ),
                  field: AnnotationUtils.fieldFromConstantReader(
                    ConstantReader(
                      Annotation.field.firstAnnotationOfExact(accessorElement),
                    ),
                  ),
                ),
              ),
        ],
        typeParameters: classElement.typeParameters.map<TypeInfo>(
          (TypeParameterElement typeParameterElement) =>
              toTypeInfo(typeParameterElement.type, typeParameterElement),
        ),
      );

  TypeInfo toTypeInfo(DartType type, Element element) {
    final ClassElement typeClassElement =
        type.element is ClassElement ? type.element : null;

    final bool isWrapper = !type.isVoid &&
        typeClassElement != null &&
        Annotation.$class.hasAnnotationOfExact(typeClassElement);

    if (isWrapper && !_allReferencedClassElements.contains(typeClassElement)) {
      _allReferencedClassElements.add(typeClassElement);
      importedClasses.add(_toClassInfo(typeClassElement));
    }

    return TypeInfo(
      name: type.toString(),
      typeArguments: type is ParameterizedType && type.typeArguments.isNotEmpty
          ? type.typeArguments.map<TypeInfo>(
              (DartType type) => toTypeInfo(
                type,
                element,
              ),
            )
          : <TypeInfo>[],
      isFuture: type.isDartAsyncFuture,
      isFutureOr: type.isDartAsyncFutureOr,
      isBool: type.isDartCoreBool,
      isDouble: type.isDartCoreDouble,
      isFunction: type.isDartCoreFunction,
      isInt: type.isDartCoreInt,
      isList: type.isDartCoreList,
      isMap: type.isDartCoreMap,
      isNull: type.isDartCoreNull,
      isNum: type.isDartCoreNum,
      isObject: type.isDartCoreObject,
      isSet: type.isDartCoreSet,
      isString: type.isDartCoreString,
      isSymbol: type.isDartCoreSymbol,
      isDynamic: type.isDynamic,
      isVoid: type.isVoid,
      isWrapper: isWrapper,
      isStruct:
          isWrapper && typeClassElement != null && isStruct(typeClassElement),
      isTypeParameter: type is TypeParameterType,
      isNativeInt32: Annotation.int32.hasAnnotationOfExact(element),
      isNativeInt64: Annotation.int64.hasAnnotationOfExact(element),
    );
  }

  bool isStruct(ClassElement classElement) {
    final Platform platform = getPlatform(classElement);
    return platform is IosPlatform && platform.type.isStruct;
  }

  Platform getPlatform(ClassElement classElement) {
    final ConstantReader classReader = ConstantReader(
      Annotation.$class.firstAnnotationOfExact(classElement),
    );

    final Class annotation = AnnotationUtils.classFromConstantReader(
      classReader,
    );

    return annotation.platform;
  }

  String getRealFieldName(Element element) {
    final Field field = AnnotationUtils.fieldFromConstantReader(
      ConstantReader(
        Annotation.field.firstAnnotationOfExact(element),
      ),
    );

    // Accessors include '=' in their names
    return field.nameOverride ?? element.name.replaceAll('=', '');
  }
}
