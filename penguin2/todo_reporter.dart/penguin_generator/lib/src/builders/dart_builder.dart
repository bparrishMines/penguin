import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:path/path.dart' as p;
import 'package:penguin/penguin.dart';

import '../templates.dart';
import 'builder.dart';

class DartBuilder extends PlatformBuilder {
  @override
  Map<String, List<String>> get buildExtensions => {
        r'.dart': const ['.penguin.g.dart'],
      };

  @override
  String get classExtension => '.penguin.g.dart';

  @override
  String get directory => 'lib';

  @override
  FutureOr<String> generateForClass(ClassElement element, Class theClass) {
    final DartTemplateCreator dartCreator = DartTemplateCreator();

    final Iterable<String> methods = element.methods
        .where((_) => methodAnnotation.hasAnnotationOfExact(_))
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
  FutureOr<String> generateForFile(AssetId asset, String classes) {
    return 'part of \'${p.basename(asset.path)}\';\n\n$classes';
  }
}
