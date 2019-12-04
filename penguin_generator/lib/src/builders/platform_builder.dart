import 'dart:async';
import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart' as p;
import 'package:penguin/penguin.dart';
import 'package:source_gen/source_gen.dart';

import '../info.dart';
import '../templates/templates.dart';
import 'annotation_utils.dart';

class PlatformBuilderBuildStep {
  PlatformBuilderBuildStep._(this._buildStep) {}

  static final String _fileHeader = r'''
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// PenguinGenerator
// **************************************************************************
''';

  final BuildStep _buildStep;

  Future<void> writeAsString(String filename, String content) {
    return _buildStep.writeAsString(
      AssetId(_buildStep.inputId.package, p.join('lib', filename)),
      _fileHeader + content,
    );
  }
}

abstract class PlatformBuilder {
  Iterable<String> get filenames;
  // Platform annotation for the builder (e.g. AndroidPlatform)
  Iterable<Type> get platformTypes;
  Future<void> build(
    List<ClassInfo> classes,
    PlatformBuilderBuildStep buildStep,
  );

  // For passing methods over MethodChannel
  MethodChannelType getChannelType(TypeInfo info) {
    if (info.isMap ||
        info.isList &&
            info.typeArguments.every(
              (_) => getChannelType(_) == MethodChannelType.supported,
            )) {
      return MethodChannelType.supported;
    } else if (info.isNativeInt32 || info.isNativeInt64) {
      // We must check for primitive before supported because a type will be both.
      return MethodChannelType.primitive;
    } else if (info.isDynamic ||
        info.isObject ||
        info.isString ||
        info.isNum ||
        info.isInt ||
        info.isDouble ||
        info.isBool) {
      return MethodChannelType.supported;
    } else if (info.isVoid) {
      return MethodChannelType.$void;
    } else if (info.isWrapper) {
      return MethodChannelType.wrapper;
    } else if (info.isTypeParameter) {
      return MethodChannelType.typeParameter;
    }

    throw ArgumentError.value(
      info.toString(),
      'info',
      'Can\'t find $MethodChannelType for info',
    );
  }
}

class ReadInfoBuilder extends Builder {
  static const String extension = '.penguin.g.info';

  final Set<ClassInfo> _externalClasses = <ClassInfo>{};

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final Resolver resolver = buildStep.resolver;
    if (!await resolver.isLibrary(buildStep.inputId)) return null;

    final LibraryReader reader = LibraryReader(await buildStep.inputLibrary);
    final LibraryReader penguinReader = await _getPenguinReader(resolver);

    final List<ClassInfo> allClassInfo = reader
        .annotatedWith(Annotation.$class)
        .followedBy(penguinReader.annotatedWith(Annotation.$class))
        .map<ClassInfo>(
          (AnnotatedElement element) => _toClassInfo(
            element.element,
            AnnotationUtils.classFromConstantReader(element.annotation),
          ),
        )
        .followedBy(_externalClasses)
        .toSet()
        .toList();

    if (allClassInfo.isNotEmpty) {
      buildStep.writeAsString(
        buildStep.inputId.changeExtension(extension),
        jsonEncode(allClassInfo),
      );
    }
  }

  Future<LibraryReader> _getPenguinReader(Resolver resolver) async {
    final AssetId penguinLibraryAsset = AssetId.resolve(
      'package:penguin/penguin.dart',
    );
    final AssetId penguinAsset = AssetId.resolve(
      'src/penguin.dart',
      from: penguinLibraryAsset,
    );

    final LibraryElement penguinLibrary =
        await resolver.libraryFor(penguinAsset);

    return LibraryReader(penguinLibrary.library);
  }

  ClassInfo _toClassInfo(ClassElement classElement, Class classAnnotation) =>
      ClassInfo(
        name: classElement.name,
        aClass: classAnnotation,
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
                    type: _toTypeInfo(
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
                    type: _toTypeInfo(
                      parameterElement.type,
                      parameterElement,
                    ),
                  ),
                ),
                name: methodElement.name,
                returnType: methodElement.returnType.isDartAsyncFuture ||
                        methodElement.returnType.isDartAsyncFutureOr
                    ? _toTypeInfo(
                        (methodElement.returnType as ParameterizedType)
                            .typeArguments[0],
                        methodElement,
                      )
                    : _toTypeInfo(
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
                  name: fieldElement.name,
                  type: fieldElement.type.isDartAsyncFuture ||
                          fieldElement.type.isDartAsyncFutureOr
                      ? _toTypeInfo(
                          (fieldElement.type as ParameterizedType)
                              .typeArguments[0],
                          fieldElement,
                        )
                      : _toTypeInfo(
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
                  name: accessorElement.name.replaceAll('=', ''),
                  type: accessorElement.variable.type.isDartAsyncFuture ||
                          accessorElement.variable.type.isDartAsyncFutureOr
                      ? _toTypeInfo(
                          (accessorElement.variable.type as ParameterizedType)
                              .typeArguments[0],
                          accessorElement,
                        )
                      : _toTypeInfo(
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
              _toTypeInfo(typeParameterElement.type, typeParameterElement),
        ),
      );

  TypeInfo _toTypeInfo(DartType type, Element element) {
    final bool isWrapper =
        !type.isVoid && Annotation.$class.hasAnnotationOfExact(type.element);

    if (isWrapper && type.element is ClassElement) {
      _externalClasses.add(_toClassInfo(
        type.element,
        AnnotationUtils.classFromConstantReader(
          ConstantReader(
            Annotation.$class.firstAnnotationOfExact(type.element),
          ),
        ),
      ));
    }

    return TypeInfo(
      name: type.toString(),
      typeArguments: type is ParameterizedType && type.typeArguments.isNotEmpty
          ? type.typeArguments.map<TypeInfo>(
              (DartType type) => _toTypeInfo(
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
      isTypeParameter: type is TypeParameterType,
      isNativeInt32: Annotation.int32.hasAnnotationOfExact(element),
      isNativeInt64: Annotation.int64.hasAnnotationOfExact(element),
    );
  }

  @override
  Map<String, List<String>> get buildExtensions => <String, List<String>>{
        '.dart': <String>[extension],
      };
}

class WriteBuilder extends Builder {
  WriteBuilder(this.platformBuilders);

  static final Glob _allInfoFiles = Glob('lib/**${ReadInfoBuilder.extension}');

  final List<PlatformBuilder> platformBuilders;

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final List<ClassInfo> classes = <ClassInfo>[];

    await for (AssetId input in buildStep.findAssets(_allInfoFiles)) {
      final String info = await buildStep.readAsString(input);
      classes.addAll(
        jsonDecode(info).map<ClassInfo>(
          (dynamic json) => ClassInfo.fromJson(json),
        ),
      );
    }

    if (classes.isEmpty) return;
    await Future.wait<void>(
      platformBuilders.map<Future<void>>(
        (PlatformBuilder builder) => builder.build(
          classes
              .where(
                (ClassInfo classInfo) => builder.platformTypes.any(
                  (Type type) =>
                      classInfo.aClass.platform.runtimeType.toString() ==
                      type.toString(),
                ),
              )
              .toList(),
          PlatformBuilderBuildStep._(buildStep),
        ),
      ),
    );
  }

  @override
  Map<String, List<String>> get buildExtensions => <String, List<String>>{
        r'$lib$': platformBuilders
            .expand<String>((PlatformBuilder builder) => builder.filenames)
            .toList(),
      };
}
