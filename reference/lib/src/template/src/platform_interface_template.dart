import 'dart:async';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'template.dart';

abstract class PlatformInterfaceTemplate extends PlatformInterface {
  PlatformInterfaceTemplate() : super(token: _token);

  static PlatformInterfaceTemplate _instance = PlatformInterfaceTemplateImpl();

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
    List<ClassTemplate> referenceListTemplate,
  );
}

class ClassTemplate {
  factory ClassTemplate(
    int fieldTemplate,
    ClassTemplate referenceFieldTemplate,
    List<ClassTemplate> referenceListTemplate,
  ) {
    return PlatformInterfaceTemplate.instance.createClassTemplate(
      fieldTemplate,
      referenceFieldTemplate,
      referenceListTemplate,
    );
  }

  int get fieldTemplate => throw UnimplementedError();
  ClassTemplate get referenceFieldTemplate => throw UnimplementedError();
  List<ClassTemplate> get referenceListTemplate => throw UnimplementedError();

  FutureOr<String> methodTemplate(
    String parameterTemplate,
    ClassTemplate referenceParameterTemplate,
  ) {
    throw UnimplementedError();
  }
}
