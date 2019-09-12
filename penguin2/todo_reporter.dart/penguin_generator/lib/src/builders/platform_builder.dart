import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart' as p;
import 'package:penguin/penguin.dart';
import 'package:source_gen/source_gen.dart';

import '../info.dart';

const TypeChecker _classAnnotation = const TypeChecker.fromRuntime(Class);
const TypeChecker _methodAnnotation = const TypeChecker.fromRuntime(Method);

//abstract class PlatformBuilder extends Builder {
//  FutureOr<String> generateForClass(
//    ClassElement element,
//    Class theClass,
//    Iterable<String> methods,
//  );
//  FutureOr<String> generateForMethod(
//    Class theClass,
//    MethodElement methodElement,
//    Method method,
//  );
//  FutureOr<String> generateForFile(AssetId asset, Iterable<String> classes);
//  String get extension;
//
//  static final String _fileHeader = r'''
//// GENERATED CODE - DO NOT MODIFY BY HAND
//
//// **************************************************************************
//// PenguinGenerator
//// **************************************************************************
//''';
//
//  @override
//  Map<String, List<String>> get buildExtensions => {
//        r'.dart': <String>[extension],
//      };
//
//  @override
//  Future<void> build(BuildStep buildStep) async {
//    final Resolver resolver = buildStep.resolver;
//    if (!await resolver.isLibrary(buildStep.inputId)) return;
//
//    final AssetId input = buildStep.inputId;
//
//    final LibraryReader library = LibraryReader(await buildStep.inputLibrary);
//
//    final List<String> classes = <String>[];
//    for (AnnotatedElement element in library.annotatedWith(_classAnnotation)) {
//      final ClassElement classElement = element.element as ClassElement;
//      final Class theClass = Class.fromConstantReader(element.annotation);
//
//      // TODO: use annotated with and methodElements to find all Method()
//      final Iterable<MethodElement> methodElements = classElement.methods.where(
//        (_) => _methodAnnotation.hasAnnotationOfExact(_),
//      );
//
//      final String output = generateForClass(
//        classElement,
//        theClass,
//        methodElements.map<String>(
//          (MethodElement element) {
//            return generateForMethod(
//              theClass,
//              element,
//              Method.fromConstantReader(_getMethodAnnotation(element)),
//            );
//          },
//        ),
//      );
//
//      classes.add(output);
//    }
//
//    if (classes.isEmpty) return;
//
//    final AssetId outputAsset = input.changeExtension(extension);
//    final String fileOutput = '$_fileHeader'
//        '${generateForFile(input, classes)}';
//
//    await buildStep.writeAsString(outputAsset, fileOutput);
//  }
//
//  ConstantReader _getMethodAnnotation(MethodElement element) =>
//      ConstantReader(_methodAnnotation.firstAnnotationOfExact(element));
//}
//
//abstract class MoveBuilder extends FileDeletingBuilder {
//  MoveBuilder(List<String> inputExtensions) : super(inputExtensions);
//
//  String outputFilename(AssetId input);
//  String get outputDirectory;
//
//  @override
//  FutureOr<Null> build(PostProcessBuildStep buildStep) async {
//    if (!buildStep.inputId.path.startsWith('lib')) return null;
//    final AssetId input = buildStep.inputId;
//
//    final String outputPath = p.join(outputDirectory, outputFilename(input));
//    final String outputContent = await buildStep.readInputAsString();
//    File(outputPath).writeAsStringSync(outputContent);
//
//    return super.build(buildStep);
//  }
//}
//
//class ClassInfo {
//  ClassInfo({this.element, this.aClass, this.assetId, this.methods});
//
//  final AssetId assetId;
//  final ClassElement element;
//  final Class aClass;
//  final Iterable<MethodInfo> methods;
//}
//
//class MethodInfo {
//  MethodInfo(this.element, this.method);
//
//  final MethodElement element;
//  final Method method;
//}
//
//abstract class AggregateBuilder {
//  final List<ClassInfo> _classes = <ClassInfo>[];
//  String _build() => build(_classes);
//
//  FutureOr<String> build(List<ClassInfo> classes);
//  String get filename;
//}
//
//class ReadBuilder extends Builder {
//  ReadBuilder(this.aggregateBuilders);
//
//  final List<AggregateBuilder> aggregateBuilders;
//
//  @override
//  FutureOr<void> build(BuildStep buildStep) async {
//    final Resolver resolver = buildStep.resolver;
//    if (!await resolver.isLibrary(buildStep.inputId)) return null;
//
//    final LibraryReader reader = LibraryReader(await buildStep.inputLibrary);
//
//    for (AggregateBuilder builder in aggregateBuilders) {
//      builder._classes.addAll(
//        reader.annotatedWith(_classAnnotation).map<ClassInfo>(
//              (AnnotatedElement element) => ClassInfo(
//                assetId: buildStep.inputId,
//                element: element.element,
//                aClass: Class.fromConstantReader(element.annotation),
//                methods: (element.element as ClassElement)
//                    .methods
//                    .where((MethodElement element) =>
//                        _methodAnnotation.hasAnnotationOfExact(element))
//                    .map<MethodInfo>(
//                      (MethodElement element) => MethodInfo(
//                        element,
//                        Method.fromConstantReader(
//                          ConstantReader(
//                            _methodAnnotation.firstAnnotationOfExact(element),
//                          ),
//                        ),
//                      ),
//                    ),
//              ),
//            ),
//      );
//    }
//  }
//
//  @override
//  Map<String, List<String>> get buildExtensions => <String, List<String>>{
//        '.dart': <String>['none']
//      };
//}
//
//class WriteBuilder extends Builder {
//  WriteBuilder(this.aggregateBuilders);
//
//  final List<AggregateBuilder> aggregateBuilders;
//  bool built = false;
//
//  AssetId _allFileOutput(String package, String filename) {
//    return AssetId(package, p.join('lib', filename));
//  }
//
//  @override
//  Map<String, List<String>> get buildExtensions => <String, List<String>>{
//        r'$lib$': aggregateBuilders
//            .map<String>((builder) => builder.filename)
//            .toList(),
//      };
//
//  @override
//  FutureOr<void> build(BuildStep buildStep) async {
//    if (built) return null;
//    built = true;
//
//    for (AggregateBuilder builder in aggregateBuilders) {
//      await buildStep.writeAsString(
//        _allFileOutput(buildStep.inputId.package, builder.filename),
//        builder._build(),
//      );
//    }
//  }
//}

class ReadBuilder extends Builder {
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
            aClass: Class.fromConstantReader(element.annotation),
            methods: (element.element as ClassElement)
                .methods
                .where((MethodElement element) =>
                    _methodAnnotation.hasAnnotationOfExact(element))
                .map<MethodInfo>(
                  (MethodElement element) => MethodInfo(
                    Method.fromConstantReader(
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

  @override
  Map<String, List<String>> get buildExtensions => <String, List<String>>{
        '.dart': <String>[extension],
      };
}
