import 'dart:async';
import 'dart:io';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:path/path.dart' as p;
import 'package:penguin/penguin.dart';
import 'package:source_gen/source_gen.dart';

abstract class PlatformBuilder extends Builder {
  FutureOr<String> generateForClass(
    ClassElement element,
    Class theClass,
    Iterable<String> methods,
  );
  FutureOr<String> generateForMethod(
    Class theClass,
    MethodElement methodElement,
    Method method,
  );
  FutureOr<String> generateForFile(AssetId asset, Iterable<String> classes);
  String get extension;

  static const TypeChecker _classAnnotation =
      const TypeChecker.fromRuntime(Class);
  static const TypeChecker _methodAnnotation =
      const TypeChecker.fromRuntime(Method);

  static final String _fileHeader = r'''
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// PenguinGenerator
// **************************************************************************
''';

  @override
  Map<String, List<String>> get buildExtensions => {
        r'.dart': <String>[extension],
      };

  @override
  Future<void> build(BuildStep buildStep) async {
    final Resolver resolver = buildStep.resolver;
    if (!await resolver.isLibrary(buildStep.inputId)) return;

    final AssetId input = buildStep.inputId;

    final LibraryReader library = LibraryReader(await buildStep.inputLibrary);

    final List<String> classes = <String>[];
    for (AnnotatedElement element in library.annotatedWith(_classAnnotation)) {
      final ClassElement classElement = element.element as ClassElement;
      final Class theClass = Class.fromConstantReader(element.annotation);

      // TODO: use annotated with and methodElements to find all Method()
      final Iterable<MethodElement> methodElements = classElement.methods.where(
        (_) => PlatformBuilder._methodAnnotation.hasAnnotationOfExact(_),
      );

      final String output = generateForClass(
        classElement,
        theClass,
        methodElements.map<String>(
          (MethodElement element) {
            return generateForMethod(
              theClass,
              element,
              Method.fromConstantReader(_getMethodAnnotation(element)),
            );
          },
        ),
      );

      classes.add(output);
    }

    if (classes.isEmpty) return;

    final AssetId outputAsset = input.changeExtension(extension);
    final String fileOutput = '$_fileHeader'
        '${generateForFile(input, classes)}';

    await buildStep.writeAsString(outputAsset, fileOutput);
  }

  ConstantReader _getMethodAnnotation(MethodElement element) =>
      ConstantReader(_methodAnnotation.firstAnnotationOfExact(element));
}

abstract class MoveBuilder extends FileDeletingBuilder {
  MoveBuilder(List<String> inputExtensions) : super(inputExtensions);

  String outputFilename(AssetId input);
  String get outputDirectory;

  @override
  FutureOr<Null> build(PostProcessBuildStep buildStep) async {
    if (!buildStep.inputId.path.startsWith('lib')) return null;
    final AssetId input = buildStep.inputId;

    final String outputPath = p.join(outputDirectory, outputFilename(input));
    final String outputContent = await buildStep.readInputAsString();
    File(outputPath).writeAsStringSync(outputContent);

    return super.build(buildStep);
  }
}
