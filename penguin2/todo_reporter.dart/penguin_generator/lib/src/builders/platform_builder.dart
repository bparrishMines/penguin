import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:path/path.dart' as p;
import 'package:penguin/penguin.dart';
import 'package:source_gen/source_gen.dart';

abstract class PlatformBuilder extends Builder {
  FutureOr<String> generateForClass(ClassElement element, Class theClass);
  FutureOr<String> generateForFile(AssetId asset, String classes);
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

    final AssetId outputAsset = AssetId(
      input.package,
      p.join(
        p.dirname(input.path),
        p.basenameWithoutExtension(input.path) + extension,
      ),
    );

    final String fileOutput = '$_fileHeader\n'
        '${generateForFile(input, classOutput.join('\n'))}\n';

    await buildStep.writeAsString(outputAsset, fileOutput);
  }

  Class _convertAnnotationToClass(ConstantReader annotation) {
    return Class(annotation.read('channel').stringValue);
  }
}
