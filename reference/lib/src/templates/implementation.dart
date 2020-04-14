import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:reference/reference.dart';
import 'package:reference/src/templates/interface.dart';

import '../annotations.dart';

part 'implementation.g.dart';

GeneratedReferenceManager referenceManager;

@Implementation()
class ClassTemplate extends ClassTemplateInterface with ReferenceHolder {
  ClassTemplate(int fieldTemplate, CallbackTemplate onTemplateCallback)
      : super(fieldTemplate, onTemplateCallback);

  @override
  FutureOr<String> methodTemplate(String parameterTemplate) async {
    final Completer<String> completer = Completer<String>();

    referenceManager.sendMethodCall(
      this,
      'methodTemplate',
      <dynamic>[parameterTemplate],
      ResultListener(
        onSuccess: ([dynamic result]) => completer.complete(result),
        onError: (dynamic error, [StackTrace stackTrace]) {
          return completer.completeError(error, stackTrace);
        },
      ),
    );

    return completer.future;
  }
}
