import 'dart:async';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:reference/src/templates/template.dart';

abstract class PlatformInterfaceTemplate extends PlatformInterface {
  PlatformInterfaceTemplate() : super(token: _token);

  static PlatformInterfaceTemplate _instance = PlatformTemplateImpl();

  static final Object _token = Object();

  static PlatformInterfaceTemplate get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [PlatformInterfaceTemplate] when they register
  /// themselves.
  static set instance(PlatformInterfaceTemplate instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  ClassTemplate createClassTemplate(
    int fieldTemplate,
    ClassTemplate referenceFieldTemplate,
  );
}

class ClassTemplate {
  factory ClassTemplate(
    int fieldTemplate,
    ClassTemplate referenceFieldTemplate,
  ) {
    return PlatformInterfaceTemplate.instance.createClassTemplate(
      fieldTemplate,
      referenceFieldTemplate,
    );
  }

  int get fieldTemplate => throw UnimplementedError();
  ClassTemplate get referenceFieldTemplate => throw UnimplementedError();

  FutureOr<String> methodTemplate(
    String parameterTemplate,
    ClassTemplate referenceParameterTemplate,
  ) {
    throw UnimplementedError();
  }

  // TODO: Remove and add to reference_matcher.dart.
  @override
  bool operator ==(dynamic other) =>
      other is ClassTemplate &&
      other.fieldTemplate == fieldTemplate &&
      referenceFieldTemplate == other.referenceFieldTemplate;

  @override
  int get hashCode => fieldTemplate.hashCode;
}
