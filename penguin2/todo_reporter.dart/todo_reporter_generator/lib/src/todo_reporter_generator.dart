import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:penguin/penguin.dart';
import 'package:source_gen/source_gen.dart';

class ClassGenerator extends GeneratorForAnnotation<Class> {
  @override
  FutureOr<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final String javaPackage = annotation.read('javaPackage').literalValue;
    return "// $javaPackage 67 penguin";
  }
}
