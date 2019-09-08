import 'dart:async';
import 'dart:io';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:path/path.dart' as path;
import 'package:penguin/penguin.dart';
import 'package:penguin_generator/src/templates.dart';
import 'package:pubspec_parse/pubspec_parse.dart';
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

    final File pubspecFile = File('pubspec.yaml');
    final Pubspec pubspec = Pubspec.parse(pubspecFile.readAsStringSync());
    final String androidPackage = pubspec.flutter['plugin']['androidPackage'];
    final Directory androidDirectory = Directory(
      path.join('android/src/main/java', androidPackage.replaceAll('.', '/')),
    );
    final File generatedFile = File(
      path.join(androidDirectory.path, 'Flutter${element.name}.java'),
    );

    final File wrapperFile = File(
      path.join(androidDirectory.path, 'FlutterWrapper.java'),
    );
    wrapperFile.writeAsStringSync(
      Templates.javaWrapper
          .replaceAll(TemplateIdentifiers.package, androidPackage),
    );

    generatedFile.writeAsStringSync(
      Templates.java
          .replaceAll(TemplateIdentifiers.className, element.name)
          .replaceAll(TemplateIdentifiers.package, androidPackage)
          .replaceAll(
            TemplateIdentifiers.variableName,
            element.name.toLowerCase(),
          ),
    );

    final Iterable<MethodElement> methodElements = classElement.methods
        .where((_) => _methodAnnotation.hasAnnotationOfExact(_));

    return Templates.dart
        .replaceAll(TemplateIdentifiers.className, element.name)
        .replaceAll(
          TemplateIdentifiers.channelName,
          annotation.read('channel').stringValue,
        )
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
