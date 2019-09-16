import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart' as p;
import 'package:penguin/penguin.dart';
import 'package:penguin_generator/src/builders/annotation_utils.dart';
import 'package:source_gen/source_gen.dart';

import '../info.dart';

const TypeChecker _classAnnotation = const TypeChecker.fromRuntime(Class);
const TypeChecker _methodAnnotation = const TypeChecker.fromRuntime(Method);
const TypeChecker _constructorAnnotation =
    const TypeChecker.fromRuntime(Constructor);

abstract class PlatformBuilder {
  String get filename;
  String get directory;
  String build(List<ClassInfo> classes);
}

class ReadInfoBuilder extends Builder {
  static const String extension = '.penguin.g.info';

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final Resolver resolver = buildStep.resolver;
    if (!await resolver.isLibrary(buildStep.inputId)) return null;

    final LibraryReader reader = LibraryReader(await buildStep.inputLibrary);

    final List<ClassInfo> allClassInfo = reader
        .annotatedWith(_classAnnotation)
        .map<ClassInfo>(
          (AnnotatedElement element) => ClassInfo(
            name: element.element.name,
            aClass: AnnotationUtils.classFromConstantReader(element.annotation),
            constructors: (element.element as ClassElement)
                .constructors
                .where((ConstructorElement constructorElement) =>
                    _constructorAnnotation
                        .hasAnnotationOfExact(constructorElement))
                .map<ConstructorInfo>(
                  (ConstructorElement constructorElement) => ConstructorInfo(
                    name: constructorElement.name,
                    constructor: AnnotationUtils.constructorFromConstantReader(
                      ConstantReader(
                        _constructorAnnotation
                            .firstAnnotationOfExact(constructorElement),
                      ),
                    ),
                  ),
                ),
            methods: (element.element as ClassElement)
                .methods
                .where(
                  (MethodElement element) =>
                      _methodAnnotation.hasAnnotationOfExact(element),
                )
                .map<MethodInfo>(
                  (MethodElement element) => MethodInfo(
                    parameters: element.parameters.map<ParameterInfo>(
                      (ParameterElement parameterElement) => ParameterInfo(
                        name: parameterElement.name,
                        type: _toTypeInfo(parameterElement.type),
                      ),
                    ),
                    name: element.name,
                    returnType: element.returnType.isDartAsyncFuture ||
                            element.returnType.isDartAsyncFutureOr
                        ? _toTypeInfo((element.returnType as ParameterizedType)
                            .typeArguments[0])
                        : _toTypeInfo(element.returnType),
                    method: AnnotationUtils.methodFromConstantReader(
                      ConstantReader(
                        _methodAnnotation.firstAnnotationOfExact(element),
                      ),
                    ),
                  ),
                ),
          ),
        )
        .toList();

    if (allClassInfo.isNotEmpty) {
      buildStep.writeAsString(
        buildStep.inputId.changeExtension(extension),
        jsonEncode(allClassInfo),
      );
    }
  }

  TypeInfo _toTypeInfo(DartType type) => type is ParameterizedType
      ? ParameterizedTypeInfo(
          name: type.name,
          isFuture: type.isDartAsyncFuture,
          isFutureOr: type.isDartAsyncFutureOr,
          isList: type.isDartCoreList,
          isMap: type.isDartCoreMap,
          typeArguments: type.typeArguments
              .map<TypeInfo>((DartType type) => _toTypeInfo(type)),
        )
      : TypeInfo(
          name: type.toString(),
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
        );

  @override
  Map<String, List<String>> get buildExtensions => <String, List<String>>{
        '.dart': <String>[extension],
      };
}

class WriteBuilder extends Builder {
  WriteBuilder(this.platformBuilders);

  static final String _fileHeader = r'''
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// PenguinGenerator
// **************************************************************************
''';

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
    for (PlatformBuilder builder in platformBuilders) {
      File(p.join(builder.directory, builder.filename))
          .writeAsStringSync(_fileHeader + builder.build(classes));
    }
  }

  @override
  Map<String, List<String>> get buildExtensions => <String, List<String>>{
        r'$lib$': platformBuilders
            .map<String>(
              (PlatformBuilder builder) =>
                  p.join(builder.directory, builder.filename),
            )
            .toList(),
      };
}
