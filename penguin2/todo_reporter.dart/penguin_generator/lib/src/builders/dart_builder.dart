import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:path/path.dart' as p;
import 'package:penguin/penguin.dart';

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
