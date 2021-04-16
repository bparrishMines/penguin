import 'dart:async';

import 'package:reference/annotations.dart';

import 'template.g.dart';
import 'template_channels.dart';

@Reference('github.penguin/template/template/ClassTemplate')
class ClassTemplate with $ClassTemplate {
  ClassTemplate(this.fieldTemplate) {
    _channel.createNewInstancePair(this, owner: true);
  }

  static $ClassTemplateChannel get _channel =>
      ChannelRegistrar.instance.implementations.classTemplateChannel;

  @override
  final int fieldTemplate;

  static Future<double> staticMethodTemplate(String parameterTemplate) async {
    return await _channel.$invokeStaticMethodTemplate(parameterTemplate)
        as double;
  }

  @override
  Future<String> methodTemplate(String parameterTemplate) async {
    return await _channel.$invokeMethodTemplate(
      this,
      parameterTemplate,
    ) as String;
  }
}
