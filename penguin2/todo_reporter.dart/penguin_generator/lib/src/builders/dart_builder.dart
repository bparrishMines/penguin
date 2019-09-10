import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:path/path.dart' as p;
import 'package:penguin/penguin.dart';

import '../templates.dart';
import 'platform_builder.dart';

class DartBuilder extends PlatformBuilder {
  @override
  FutureOr<String> generateForClass(ClassElement element, Class theClass) {
    final DartTemplateCreator dartCreator = DartTemplateCreator();

    final Iterable<String> methods = element.methods
        .where((_) => PlatformBuilder.methodAnnotation.hasAnnotationOfExact(_))
        .map<String>(
          (MethodElement methodElement) => dartCreator.createMethod(
            methodName: methodElement.name,
            className: element.name,
          ),
        );

    return dartCreator.createFile(
      methods: methods,
      className: element.name,
      channelName: theClass.channel,
    );
  }

  @override
  FutureOr<String> generateForFile(AssetId asset, List<String> classes) {
    return 'part of \'${p.basename(asset.path)}\';\n\n${classes.join('\n')}';
  }

  @override
  String get extension => '.penguin.g.dart';
}
