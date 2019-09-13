import 'dart:async';
import 'dart:io';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:path/path.dart' as p;
import 'package:penguin/penguin.dart';
import 'package:penguin_generator/src/info.dart';
import 'package:pubspec_parse/pubspec_parse.dart';
import 'package:recase/recase.dart';

import '../templates.dart';
import 'platform_builder.dart';

//class AndroidBuilder extends PlatformBuilder {
//  final Set<String> imports = <String>{};
//
//  @override
//  FutureOr<String> generateForMethod(
//    Class theClass,
//    MethodElement methodElement,
//    Method method,
//  ) {
//    final AndroidPlatform platform = theClass.platform as AndroidPlatform;
//
//    return JavaTemplateCreator().createMethod(
//      methodName: methodElement.name,
//      variableName: platform.type.name.toLowerCase(),
//    );
//  }
//
//  @override
//  FutureOr<String> generateForClass(
//    ClassElement element,
//    Class theClass,
//    Iterable<String> methods,
//  ) {
//    final JavaTemplateCreator javaCreator = JavaTemplateCreator();
//
//    final AndroidPlatform platform = theClass.platform as AndroidPlatform;
//    imports.add(javaCreator.createImport(
//      classPackage: platform.type.package,
//    ));
//
//    return javaCreator.createClass(
//      methods: methods,
//      className: platform.type.name,
//      variableName: platform.type.name.toLowerCase(),
//    );
//  }
//
//  @override
//  FutureOr<String> generateForFile(AssetId asset, Iterable<String> classes) {
//    final ReCase libraryName = ReCase(p.basenameWithoutExtension(asset.path));
//    return JavaTemplateCreator().createFile(
//      classes: classes,
//      imports: imports,
//      package: _androidPackage,
//      libraryName: '${libraryName.pascalCase}Generated',
//    );
//  }
//
//  static String get _androidPackage {
//    final File pubspecFile = File('pubspec.yaml');
//    final Pubspec pubspec = Pubspec.parse(pubspecFile.readAsStringSync());
//    return pubspec.flutter['plugin']['androidPackage'];
//  }
//
//  @override
//  String get extension => '.android';
//}
//
//class AndroidMoveBuilder extends MoveBuilder {
//  AndroidMoveBuilder() : super(<String>['.android']);
//
//  @override
//  String get outputDirectory => p.join('android/src/main/java',
//      AndroidBuilder._androidPackage.replaceAll('.', '/'));
//
//  @override
//  String outputFilename(AssetId input) {
//    final ReCase libraryName = ReCase(p.basenameWithoutExtension(input.path));
//    return '${libraryName.pascalCase}Generated.java';
//  }
//}
//
//class AndroidChannelBuilder extends AggregateBuilder {
//  @override
//  String get filename => 'channel.android';
//
//  @override
//  FutureOr<String> build(List<ClassInfo> classes) {
//    return '// #yolo';
//  }
//}

class AndroidBuilder extends PlatformBuilder {
  @override
  String build(List<ClassInfo> classes) {
    final AndroidTemplateCreator creator = AndroidTemplateCreator();
    return creator.createFile(
      imports: classes
          .map<String>(
            (ClassInfo classInfo) => creator.createImport(
              classPackage:
                  (classInfo.aClass.platform as AndroidPlatform).type.package,
            ),
          )
          .toSet(),
      classes: classes.map<String>(
        (ClassInfo classInfo) => creator.createClass(
          constructors: classInfo.constructors.map<String>(
            (ConstructorInfo constructorInfo) => creator.createConstructor(
              className:
                  (classInfo.aClass.platform as AndroidPlatform).type.name,
              variableName: (classInfo.aClass.platform as AndroidPlatform)
                  .type
                  .name
                  .toLowerCase(),
            ),
          ),
          methods: classInfo.methods.map<String>(
            (MethodInfo methodInfo) => creator.createMethod(
              methodName: methodInfo.name,
              variableName: (classInfo.aClass.platform as AndroidPlatform)
                  .type
                  .name
                  .toLowerCase(),
            ),
          ),
          methodCalls: classInfo.methods.map<String>(
            (MethodInfo methodInfo) => creator.createMethodCall(
              className:
                  (classInfo.aClass.platform as AndroidPlatform).type.name,
              methodName: methodInfo.name,
            ),
          ),
          className: (classInfo.aClass.platform as AndroidPlatform).type.name,
          variableName: (classInfo.aClass.platform as AndroidPlatform)
              .type
              .name
              .toLowerCase(),
        ),
      ),
      staticMethodCalls: <String>['// FIXXXXXXXXXXXXX'],
      package: _androidPackage,
    );
  }

  static String get _androidPackage {
    final File pubspecFile = File('pubspec.yaml');
    final Pubspec pubspec = Pubspec.parse(pubspecFile.readAsStringSync());
    return pubspec.flutter['plugin']['androidPackage'];
  }

  @override
  String get directory =>
      p.joinAll(<String>['android', 'src', 'main', 'java']..addAll(
          _androidPackage.split('.'),
        ));

  @override
  String get filename => 'ChannelGenerated.java';
}
