import 'dart:async';
import 'dart:io';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:path/path.dart' as path;
import 'package:penguin/penguin.dart';
import 'package:penguin_generator/src/templates.dart';
import 'package:pubspec_parse/pubspec_parse.dart';
import 'package:source_gen/source_gen.dart';

//final _methodAnnotation = const TypeChecker.fromRuntime(Method);
//
//class ClassGenerator extends GeneratorForAnnotation<Class> {
//  @override
//  FutureOr<String> generateForAnnotatedElement(
//    Element element,
//    ConstantReader annotation,
//    BuildStep buildStep,
//  ) async {
//    if (element.kind != ElementKind.CLASS) throw ArgumentError();
//    final ClassElement classElement = element as ClassElement;
//
//    createJava(classElement);
//    return createDart(classElement, annotation);
//  }
//
//  String createDart(ClassElement classElement, ConstantReader annotation) {
//    final DartTemplateCreator dartCreator = DartTemplateCreator();
//
//    final Iterable<String> methods = classElement.methods
//        .where((_) => _methodAnnotation.hasAnnotationOfExact(_))
//        .map<String>(
//          (MethodElement methodElement) => dartCreator.createMethod(
//            methodName: methodElement.name,
//            className: classElement.name,
//          ),
//        );
//
//    return dartCreator.createFile(
//      methods: methods,
//      className: classElement.name,
//      channelName: annotation.read('channel').stringValue,
//    );
//  }
//
//  void createJava(ClassElement classElement) {
//    final File pubspecFile = File('pubspec.yaml');
//    final Pubspec pubspec = Pubspec.parse(pubspecFile.readAsStringSync());
//    final String androidPackage = pubspec.flutter['plugin']['androidPackage'];
//    final Directory androidDirectory = Directory(
//      path.join('android/src/main/java', androidPackage.replaceAll('.', '/')),
//    );
//    final File generatedFile = File(
//      path.join(androidDirectory.path, 'Flutter${classElement.name}.java'),
//    );
//
//    final File wrapperFile = File(
//      path.join(androidDirectory.path, 'FlutterWrapper.java'),
//    );
//
//    final JavaTemplateCreator javaCreator = JavaTemplateCreator();

//    wrapperFile.writeAsStringSync(
//      javaCreator.createCentral(package: androidPackage),
//    );

//    final Iterable<String> methods = classElement.methods
//        .where((_) => _methodAnnotation.hasAnnotationOfExact(_))
//        .map<String>(
//          (MethodElement methodElement) => javaCreator.createMethod(
//            methodName: methodElement.name,
//            className: classElement.name,
//            variableName: classElement.name.toLowerCase(),
//          ),
//        );

//    generatedFile.writeAsStringSync(javaCreator.createFile(
//      methods: methods,
//      className: classElement.name,
//      package: androidPackage,
//      variableName: classElement.name.toLowerCase(),
//    ));
//  }
//}
