import 'dart:async';

import 'package:reference/reference.dart';
import 'package:reference/annotations.dart';

import 'template.g.dart';

MethodChannelReferenceChannelManager _manager =
    MethodChannelReferenceChannelManager.instance
      ..registerHandler(
        $ClassTemplateHandler.$handlerChannel,
        $ClassTemplateHandler(
          onCreateClassTemplate: (
            ReferenceChannelManager manager,
            $ClassTemplateCreationArgs args,
          ) {
            return ClassTemplate(args.fieldTemplate);
          },
        ),
      );

@ReferenceChannel('github.penguin/template/template/ClassTemplate')
class ClassTemplate with $ClassTemplate {
  ClassTemplate(this.fieldTemplate);

  final int fieldTemplate;

  static Future<double> staticMethodTemplate(String parameterTemplate) async {
    return (await $ClassTemplateHandler.$invokeStaticMethodTemplate(
      _manager,
      parameterTemplate,
    )) as double;
  }

  @override
  Future<String> methodTemplate(String parameterTemplate) async {
    return (await $ClassTemplateHandler.$invokeMethodTemplate(
      _manager,
      this,
      parameterTemplate,
    )) as String;
  }
}
