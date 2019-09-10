import 'dart:async';
import 'dart:io';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:path/path.dart' as p;
import 'package:penguin/penguin.dart';
import 'package:source_gen/source_gen.dart';

abstract class PlatformBuilder extends Builder {
  FutureOr<String> generateForClass(ClassElement element, Class theClass);
  FutureOr<String> generateForFile(AssetId asset, List<String> classes);
  String get extension;

  static const TypeChecker classAnnotation =
      const TypeChecker.fromRuntime(Class);
  static const TypeChecker methodAnnotation =
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

    final List<String> classOutput = <String>[];
    for (AnnotatedElement element in library.annotatedWith(classAnnotation)) {
      final ClassElement classElement = element.element as ClassElement;
      final String output = generateForClass(
        classElement,
        _convertAnnotationToClass(element.annotation),
      );

      classOutput.add(output);
    }

    if (classOutput.isEmpty) return;

    final AssetId outputAsset = input.changeExtension(extension);

    final String fileOutput = '$_fileHeader\n'
        '${generateForFile(input, classOutput)}\n';

    await buildStep.writeAsString(outputAsset, fileOutput);
  }

  Class _convertAnnotationToClass(ConstantReader annotation) {
    return Class(annotation.read('channel').stringValue);
  }
}

abstract class MoveBuilder extends FileDeletingBuilder {
  MoveBuilder(List<String> inputExtensions) : super(inputExtensions);

  String outputFilename(AssetId input);
  String get outputDirectory;

  @override
  FutureOr<Null> build(PostProcessBuildStep buildStep) async {
    if (!buildStep.inputId.path.startsWith('lib')) return null;
    final AssetId input = buildStep.inputId;

    final AssetId outputAsset = AssetId(
      input.package,
      p.join(outputDirectory, outputFilename(input)),
    );

    final String outputContent = await buildStep.readInputAsString();

    File(outputAsset.path).writeAsStringSync(outputContent);
    await buildStep.writeAsString(outputAsset, outputContent);

    return super.build(buildStep);
  }
}
