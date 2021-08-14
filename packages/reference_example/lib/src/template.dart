import 'dart:async';

import 'package:reference/annotations.dart';

import 'template.g.dart';

@Reference(r'github.penguin/template/template/$$function_name$$')
typedef $$function_name$$ = void Function(String value);

@JavaReference(
  channel: r'github.penguin/template/template/$$class_name$$',
  package: 'com.example.reference_example',
  className: 'classNameProxy.java',
)
class $$class_name$$ {
  $$class_name$$({required this.$$parameter_name$$, bool create = true}) {
    if (create) {
      _channel.$create(
        this,
        $owner: true,
        $$parameter_name$$: $$parameter_name$$,
      );
    }
  }

  $$class_name$$.$$constructor_name$$({
    required this.$$parameter_name$$,
    bool create = true,
  }) {
    if (create) {
      _channel.$create$__constructor_name__(
        this,
        $owner: true,
        $$parameter_name$$: $$parameter_name$$,
      );
    }
  }

  static $$$class_name$$Channel get _channel =>
      $ChannelRegistrar.instance.implementations.channel__class_name__;

  final int $$parameter_name$$;

  static Future<double> $$staticMethod_name$$(String $$parameter_name$$) {
    return _channel.$__staticMethod_name__($$parameter_name$$);
  }

  Future<String> $$method_name$$(String $$parameter_name$$) {
    return _channel.$__method_name__(this, $$parameter_name$$);
  }
}
