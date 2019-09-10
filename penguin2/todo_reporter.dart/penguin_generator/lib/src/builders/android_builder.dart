import 'dart:async';
import 'dart:io';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:path/path.dart' as p;
import 'package:penguin/penguin.dart';
import 'package:pubspec_parse/pubspec_parse.dart';

import '../templates.dart';
import 'platform_builder.dart';

class AndroidBuilder extends PlatformBuilder {
  @override
  FutureOr<String> generateForClass(ClassElement element, Class theClass) {
    final JavaTemplateCreator javaCreator = JavaTemplateCreator();

    final Iterable<String> methods = element.methods
        .where((_) => PlatformBuilder.methodAnnotation.hasAnnotationOfExact(_))
        .map<String>(
          (MethodElement methodElement) => javaCreator.createMethod(
            methodName: methodElement.name,
            variableName: element.name.toLowerCase(),
          ),
        );

    return javaCreator.createClass(
      methods: methods,
      className: element.name,
      variableName: element.name.toLowerCase(),
    );
  }

  @override
  FutureOr<String> generateForFile(AssetId asset, List<String> classes) {
    final JavaTemplateCreator javaCreator = JavaTemplateCreator();
    return javaCreator.createFile(
      classes: classes,
      imports: ['not', 'real'],
      package: _androidPackage,
      libraryName: p.basenameWithoutExtension(asset.path),
    );
  }

  static String get _androidPackage {
    final File pubspecFile = File('pubspec.yaml');
    final Pubspec pubspec = Pubspec.parse(pubspecFile.readAsStringSync());
    return pubspec.flutter['plugin']['androidPackage'];
  }

  @override
  String get extension => '.android';
}

class AndroidMoveBuilder extends MoveBuilder {
  AndroidMoveBuilder() : super(<String>['.android']);

  @override
  String get outputDirectory => p.join('android/src/main/java',
      AndroidBuilder._androidPackage.replaceAll('.', '/'));

  @override
  String outputFilename(AssetId input) {
    return p.basename(input.changeExtension('.java').path);
  }
}
