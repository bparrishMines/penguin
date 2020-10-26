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
            return ClassTemplate(
              args.fieldTemplate,
              args.referenceParameterTemplate,
            );
          },
        ),
      )
      ..registerHandler(
        $ClassTemplate2Handler.$handlerChannel,
        $ClassTemplate2Handler(
          onCreateClassTemplate2: (
            ReferenceChannelManager manager,
            $ClassTemplate2CreationArgs args,
          ) {
            return ClassTemplate2();
          },
        ),
      );

@ReferenceChannel('github.penguin/template/template/ClassTemplate')
class ClassTemplate with $ClassTemplate {
  ClassTemplate(this.fieldTemplate, this.referenceParameterTemplate);

  final int fieldTemplate;
  final ClassTemplate2 referenceParameterTemplate;

  static Future<double> staticMethodTemplate(
    String parameterTemplate,
    ClassTemplate2 referenceParameterTemplate,
  ) async {
    return (await $ClassTemplateHandler.$invokeStaticMethodTemplate(
      _manager,
      parameterTemplate,
      referenceParameterTemplate,
    )) as double;
  }

  @override
  Future<String> methodTemplate(
    String parameterTemplate,
    covariant ClassTemplate2 referenceParameterTemplate,
  ) async {
    return (await $ClassTemplateHandler.$invokeMethodTemplate(
      _manager,
      this,
      parameterTemplate,
      referenceParameterTemplate,
    )) as String;
  }
}

@ReferenceChannel('github.penguin/template/template/ClassTemplate2')
class ClassTemplate2 with $ClassTemplate2 {}
