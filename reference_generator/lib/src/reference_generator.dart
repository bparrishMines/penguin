import 'dart:async';
import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'ast.dart';

class ReferenceAstBuilder extends Builder {
  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final AssetId newFile = buildStep.inputId.changeExtension('.reference_ast');

    final Resolver resolver = buildStep.resolver;
    if (!await resolver.isLibrary(buildStep.inputId)) return null;

    final LibraryReader reader = LibraryReader(await buildStep.inputLibrary);
    final LibraryNode ast = _toLibraryNode(reader.element, reader.classes);

    await buildStep.writeAsString(newFile, jsonEncode(ast));
  }

  LibraryNode _toLibraryNode(
    LibraryElement libraryElement,
    Iterable<ClassElement> classes,
  ) {
    return LibraryNode(
      classes.map<ClassNode>(
        (ClassElement classElement) => _toClassNode(classElement),
      ).toList(),
    );
  }

  ClassNode _toClassNode(ClassElement classElement) {
    return ClassNode(classElement.name);
  }

  @override
  Map<String, List<String>> get buildExtensions => <String, List<String>>{
        '.dart': <String>['.reference_ast'],
      };
}

class JavaBuilder implements Builder {
  @override
  FutureOr<void> build(BuildStep buildStep) {
    throw UnimplementedError();
  }

  @override
  Map<String, List<String>> get buildExtensions => <String, List<String>>{
        '.dart': <String>['.java'],
      };
}
