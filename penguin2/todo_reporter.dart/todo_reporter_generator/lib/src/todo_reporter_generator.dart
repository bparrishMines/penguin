import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:source_gen/source_gen.dart';

import 'package:todo_reporter/todo_reporter.dart';

class TodoReporterGenerator extends GeneratorForAnnotation<PenguinClass> {
  @override
  FutureOr<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final String javaPackage = annotation.read('javaPackage').literalValue;
    return "// $javaPackage";
  }
}
