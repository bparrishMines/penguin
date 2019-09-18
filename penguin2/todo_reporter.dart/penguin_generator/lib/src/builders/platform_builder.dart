import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart' as p;
import 'package:penguin/penguin.dart';
import 'package:source_gen/source_gen.dart';

import 'annotation_utils.dart';
import '../info.dart';
import '../templates.dart';

const TypeChecker _classAnnotation = const TypeChecker.fromRuntime(Class);
const TypeChecker _methodAnnotation = const TypeChecker.fromRuntime(Method);
const TypeChecker _constructorAnnotation =
    const TypeChecker.fromRuntime(Constructor);

abstract class PlatformBuilder {
  String get filename;
  String get directory;
  String build(List<ClassInfo> classes);

  // For passing methods over MethodChannel
  MethodChannelType getChannelType(TypeInfo info) {
    if (info.isMap ||
        info.isList &&
            info.typeArguments.every(
              (_) => getChannelType(_) == MethodChannelType.supported,
            )) {
      return MethodChannelType.supported;
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

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final Resolver resolver = buildStep.resolver;
    if (!await resolver.isLibrary(buildStep.inputId)) return null;

    final LibraryReader reader = LibraryReader(await buildStep.inputLibrary);

//    if (buildStep.inputId.path.endsWith('/usage.dart')) {
//      ClassElement element =
//          reader
//              .annotatedWith(_classAnnotation)
//              .skip(2)
//              .first
//              .element;
//      print(element.name);
//      TypeParameterType a;
//      print(element.typeParameters[0].type)
//      print(element is TypeParameterizedElement);
//      print(element.typeParameters);
//      TypeParameterElement tpe = element.typeParameters[0];
//      print(tpe.name);
//      print(element.isSimplyBounded);
//      print(tpe.type.bound);
//      print(tpe.type.isDartCoreInt);
//    }
//    throw ArgumentError();

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
                        ? _toTypeInfo(
                            (element.returnType as ParameterizedType)
                                .typeArguments[0],
                          )
                        : _toTypeInfo(element.returnType),
                    method: AnnotationUtils.methodFromConstantReader(
                      ConstantReader(
                        _methodAnnotation.firstAnnotationOfExact(element),
                      ),
                    ),
                  ),
                ),
            typeParameters:
                (element.element as ClassElement).typeParameters.map<TypeInfo>(
                      (TypeParameterElement typeParameterElement) =>
                          _toTypeInfo(typeParameterElement.type),
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

  TypeInfo _toTypeInfo(DartType type) => TypeInfo(
        name: type.toString(),
        typeArguments:
            type is ParameterizedType && type.typeArguments.isNotEmpty
                ? type.typeArguments
                    .map<TypeInfo>((DartType type) => _toTypeInfo(type))
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
        isWrapper:
            !type.isVoid && _classAnnotation.hasAnnotationOfExact(type.element),
        isTypeParameter: type is TypeParameterType,
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
