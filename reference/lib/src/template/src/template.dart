import 'dart:async';

import 'package:reference/reference.dart';
import 'package:reference/annotations.dart';

import 'template.g.dart';

@Reference('github.penguin/template/template/ClassTemplate')
class ClassTemplate with $ClassTemplate {
  ClassTemplate(this.fieldTemplate);

  static final $ClassTemplateChannel _channel = $ClassTemplateChannel(
    MethodChannelManager.instance,
  )..setHandler(
      $ClassTemplateHandler(
        onCreate: (
          ReferenceChannelManager manager,
          $ClassTemplateCreationArgs args,
        ) {
          return ClassTemplate(args.fieldTemplate);
        },
      ),
    );

  final int fieldTemplate;

  static Future<double> staticMethodTemplate(String parameterTemplate) async {
    return (await _channel.$invokeStaticMethodTemplate(parameterTemplate))
        as double;
  }

  @override
  Future<String> methodTemplate(String parameterTemplate) async {
    return (await _channel.$invokeMethodTemplate(
      this,
      parameterTemplate,
    )) as String;
  }
}
