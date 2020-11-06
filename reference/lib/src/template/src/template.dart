import 'dart:async';

import 'package:reference/reference.dart';
import 'package:reference/annotations.dart';

import 'template.g.dart';

abstract class PluginTemplate {
  static void initialize() {
    // ignore: unnecessary_statements
    ClassTemplate._channel;
    // ignore: unnecessary_statements
    ClassTemplate2._channel;
  }
}

@Channel('github.penguin/template/template/ClassTemplate')
class ClassTemplate with $ClassTemplate {
  ClassTemplate(this.fieldTemplate, this.referenceParameterTemplate);

  static final $ClassTemplateChannel _channel = $ClassTemplateChannel(
    MethodChannelReferenceChannelManager.instance,
  )..registerHandler($ClassTemplateHandler(
      onCreate: (
        ReferenceChannelManager manager,
        $ClassTemplateCreationArgs args,
      ) {
        return ClassTemplate(
          args.fieldTemplate,
          args.referenceParameterTemplate,
        );
      },
    ));

  final int fieldTemplate;
  final ClassTemplate2 referenceParameterTemplate;

  static Future<double> staticMethodTemplate(
    String parameterTemplate,
    ClassTemplate2 referenceParameterTemplate,
  ) async {
    return (await _channel.$invokeStaticMethodTemplate(
      parameterTemplate,
      referenceParameterTemplate,
    )) as double;
  }

  @override
  Future<String> methodTemplate(
    String parameterTemplate,
    covariant ClassTemplate2 referenceParameterTemplate,
  ) async {
    return (await _channel.$invokeMethodTemplate(
      this,
      parameterTemplate,
      referenceParameterTemplate,
    )) as String;
  }
}

@Channel('github.penguin/template/template/ClassTemplate2')
class ClassTemplate2 with $ClassTemplate2 {
  // ignore: unused_field
  static final $ClassTemplate2Channel _channel = $ClassTemplate2Channel(
    MethodChannelReferenceChannelManager.instance,
  )..registerHandler($ClassTemplate2Handler(
      onCreate: (
        ReferenceChannelManager manager,
        $ClassTemplate2CreationArgs args,
      ) {
        return ClassTemplate2();
      },
    ));
}
