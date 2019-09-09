import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:path/path.dart' as p;
import 'package:penguin/penguin.dart';
import 'package:source_gen/source_gen.dart';

abstract class PlatformBuilder extends Builder {
  FutureOr<String> generateForClass(ClassElement element, Class theClass);
  FutureOr<String> generateForFile(AssetId asset, String classes);
  String get classExtension;
  String get directory;

  final TypeChecker methodAnnotation = const TypeChecker.fromRuntime(Method);

  static const TypeChecker classAnnotation = TypeChecker.fromRuntime(Class);

  static final String fileHeader = r'''
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// PenguinGenerator
// **************************************************************************
''';

  @override
  Future<void> build(BuildStep buildStep) async {
    final Resolver resolver = buildStep.resolver;
    if (!await resolver.isLibrary(buildStep.inputId)) return;

    final LibraryReader library = LibraryReader(await buildStep.inputLibrary);

    final List<String> classOutput = <String>[];
    for (AnnotatedElement element in library.annotatedWith(classAnnotation)) {
      final ClassElement classElement = element.element as ClassElement;
      final String output = generateForClass(
        classElement,
        _convertToClass(element.annotation),
      );

      classOutput.add(output);
    }

    if (classOutput.isEmpty) return;

    final String generatedFilename =
        '${p.basenameWithoutExtension(buildStep.inputId.path)}$classExtension';

    final AssetId outputAsset = AssetId(
      buildStep.inputId.package,
      p.join(directory, generatedFilename),
    );

    final String fileOutput = '$fileHeader\n'
        '${generateForFile(buildStep.inputId, classOutput.join('\n'))}\n';

    await buildStep.writeAsString(outputAsset, fileOutput);
  }

  Class _convertToClass(ConstantReader annotation) {
    return Class(annotation.read('channel').stringValue);
  }
}
