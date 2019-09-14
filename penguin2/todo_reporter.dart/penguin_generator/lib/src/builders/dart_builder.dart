import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:path/path.dart' as p;
import 'package:penguin/penguin.dart';
import 'package:penguin_generator/src/info.dart';

import '../templates.dart';
import 'platform_builder.dart';

//class DartBuilder extends PlatformBuilder {
//  @override
//  FutureOr<String> generateForMethod(
//    Class theClass,
//    MethodElement methodElement,
//    Method method,
//  ) {
//    return DartTemplateCreator().createMethod(
//      methodName: methodElement.name,
//      className: methodElement.enclosingElement.name,
//    );
//  }
//
//  @override
//  FutureOr<String> generateForClass(
//    ClassElement element,
//    Class theClass,
//    Iterable<String> methods,
//  ) {
//    return DartTemplateCreator().createClass(
//      methods: methods,
//      className: element.name,
//    );
//  }
//
//  @override
//  FutureOr<String> generateForFile(AssetId asset, Iterable<String> classes) {
//    final DartTemplateCreator dartCreator = DartTemplateCreator();
//    return dartCreator.createFile(
//      classes: classes,
//      libraryName: p.basenameWithoutExtension(asset.path),
//    );
//  }
//
//  @override
//  String get extension => '.penguin.g.dart';
//}

class FlutterBuilder extends PlatformBuilder {
  @override
  String build(List<ClassInfo> classes) {
    final MethodChannelTemplateCreator creator = MethodChannelTemplateCreator();
    return creator.createFile(
      classes: classes.map<String>(
        (ClassInfo classInfo) => creator.createClass(
          constructors: classInfo.constructors.map<String>(
            (ConstructorInfo constructorInfo) => creator.createConstructor(
              className: classInfo.name,
              platformClassName: (classInfo.aClass.platform as AndroidPlatform).type.name,
            ),
          ),
          methods: classInfo.methods.map<String>(
            (MethodInfo methodInfo) => creator.createMethod(
              platformClassName: (classInfo.aClass.platform as AndroidPlatform).type.name,
              methodName: methodInfo.name,
            ),
          ),
          className: classInfo.name,
        ),
      ),
    );
  }

  @override
  String get directory => 'lib';

  @override
  String get filename => 'penguin.g.dart';
}
