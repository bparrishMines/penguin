import 'dart:async';

import 'package:reference/annotations.dart';

import 'template.g.dart';
import 'template_channels.dart';

@Reference('github.penguin/template/template/ClassTemplate')
class ClassTemplate with $ClassTemplate {
  ClassTemplate(this.fieldTemplate);

  @override
  final int fieldTemplate;

  static Future<double> staticMethodTemplate(String parameterTemplate) async {
    return await Channels.instance.classTemplateChannel
        .$invokeStaticMethodTemplate(parameterTemplate) as double;
  }

  @override
  Future<String> methodTemplate(String parameterTemplate) async {
    return await Channels.instance.classTemplateChannel.$invokeMethodTemplate(
      this,
      parameterTemplate,
    ) as String;
  }
}
