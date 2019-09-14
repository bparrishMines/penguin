import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:penguin/penguin.dart';
import 'package:penguin_generator/src/info.dart';
import 'package:pubspec_parse/pubspec_parse.dart';
import 'package:recase/recase.dart';

import '../templates.dart';
import 'platform_builder.dart';

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
              platformClassName:
                  (classInfo.aClass.platform as AndroidPlatform).type.name,
            ),
          )
          .toSet(),
      classes: classes.map<String>(
        (ClassInfo classInfo) => creator.createClass(
          constructors: classInfo.constructors.map<String>(
            (ConstructorInfo constructorInfo) => creator.createConstructor(
              platformClassName:
                  (classInfo.aClass.platform as AndroidPlatform).type.name,
              variableName: ReCase(
                (classInfo.aClass.platform as AndroidPlatform).type.name,
              ).camelCase,
            ),
          ),
          methods: classInfo.methods.map<String>(
            (MethodInfo methodInfo) => creator.createMethod(
              methodName: methodInfo.name,
              variableName: ReCase(
                (classInfo.aClass.platform as AndroidPlatform).type.name,
              ).camelCase,
            ),
          ),
          methodCalls: classInfo.methods.map<String>(
            (MethodInfo methodInfo) => creator.createMethodCall(
              platformClassName:
                  (classInfo.aClass.platform as AndroidPlatform).type.name,
              methodName: methodInfo.name,
            ),
          ),
          platformClassName:
              (classInfo.aClass.platform as AndroidPlatform).type.name,
          variableName: ReCase(
            (classInfo.aClass.platform as AndroidPlatform).type.name,
          ).camelCase,
        ),
      ),
      staticMethodCalls: classes.expand<String>(
        (ClassInfo classInfo) => classInfo.constructors.map<String>(
          (ConstructorInfo constructorInfo) => creator.createStaticMethodCall(
            platformClassName:
                (classInfo.aClass.platform as AndroidPlatform).type.name,
          ),
        ),
      ),
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
