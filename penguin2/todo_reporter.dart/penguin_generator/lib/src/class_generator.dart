import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:glob/glob.dart';
import 'package:penguin/penguin.dart';
import 'package:penguin_generator/src/templates.dart';
import 'package:source_gen/source_gen.dart';

final _methodAnnotation = const TypeChecker.fromRuntime(Method);

class ClassGenerator extends GeneratorForAnnotation<Class> {
  @override
  FutureOr<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    if (element.kind != ElementKind.CLASS) throw ArgumentError();
    final ClassElement classElement = element as ClassElement;

    final Iterable<MethodElement> methodElements = classElement.methods
        .where((_) => _methodAnnotation.hasAnnotationOfExact(_));

    return Templates.dart
        .replaceAll(TemplateIdentifiers.className, element.name)
        .replaceAll(
          RegExp(r'// METHODS.*// end METHODS', multiLine: true, dotAll: true),
          methods(classElement.name, methodElements),
        );
  }

  String methods(String className, Iterable<MethodElement> elements) {
    final StringBuffer methods = StringBuffer();

    for (MethodElement element in elements) {
      methods.writeln(Templates.getMethod(Templates.dart)
          .replaceAll(TemplateIdentifiers.methodName, element.name)
          .replaceAll(TemplateIdentifiers.className, className));
    }

    return methods.toString();
  }
}
