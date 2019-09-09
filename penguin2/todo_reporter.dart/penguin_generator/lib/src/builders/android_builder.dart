import 'dart:async';
import 'dart:io';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:penguin/penguin.dart';
import 'package:pubspec_parse/pubspec_parse.dart';

import '../templates.dart';
import 'platform_builder.dart';

class AndroidBuilder extends PlatformBuilder {
  @override
  Map<String, List<String>> get buildExtensions => {
        r'.dart': const ['.java'],
      };

  @override
  FutureOr<String> generateForClass(ClassElement element, Class theClass) {
    final JavaTemplateCreator javaCreator = JavaTemplateCreator();

    final Iterable<String> methods = element.methods
        .where((_) => PlatformBuilder.methodAnnotation.hasAnnotationOfExact(_))
        .map<String>(
          (MethodElement methodElement) => javaCreator.createMethod(
            methodName: methodElement.name,
            className: element.name,
            variableName: element.name.toLowerCase(),
          ),
        );

    return javaCreator.createFile(
      methods: methods,
      className: element.name,
      package: _androidPackage,
      variableName: element.name.toLowerCase(),
    );
  }

  @override
  FutureOr<String> generateForFile(AssetId asset, String classes) {
    return classes;
  }

  String get _androidPackage {
    final File pubspecFile = File('pubspec.yaml');
    final Pubspec pubspec = Pubspec.parse(pubspecFile.readAsStringSync());
    return pubspec.flutter['plugin']['androidPackage'];
  }

  @override
  String get extension => '.java';
}
