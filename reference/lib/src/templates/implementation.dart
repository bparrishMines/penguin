import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:reference/reference.dart';
import 'package:reference/src/templates/interface.dart';

import '../annotations.dart';

part 'implementation.g.dart';

class ReferenceManagerTemplate extends GeneratedReferenceManager {
  ReferenceManagerTemplate() : super('reference_plugin');

  @override
  ClassTemplate createClassTemplate(String referenceId, int fieldTemplate) {
    return ClassTemplate(
      fieldTemplate,
      (double testParameter) async {
        return (await sendMethodCall(
          referenceHolderFor(referenceId),
          'callbackTemplate',
          <dynamic>[testParameter],
        )) as String;
      },
    );
  }
}

ReferenceManagerTemplate referenceManager;

@MethodChannelImplementation()
class ClassTemplate extends ClassTemplateInterface with ReferenceHolder {
  const ClassTemplate(int fieldTemplate, CallbackTemplate onTemplateCallback)
      : super(fieldTemplate, onTemplateCallback);

  @override
  FutureOr<String> methodTemplate(String parameterTemplate) async {
    return await (referenceManager.sendMethodCall(
      this,
      'methodTemplate',
      <dynamic>[parameterTemplate],
    )) as String;
  }
}
