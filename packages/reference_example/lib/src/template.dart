import 'dart:async';

import 'package:reference/annotations.dart';

import 'template.g.dart';

@Reference(
  channel: r'github.penguin/template/template/__function_name__',
  platformImport: 'com.example.reference_example.__function_name__',
  platformClassName: '__function_name__',
)
typedef $$function_name$$ = void Function(String value);

@Reference(
  channel: r'__channel_name__',
  platformImport: 'com.example.reference_example.fakelibrary.__class_name__',
  platformClassName: '__class_name__',
)
class $$class_name$$ {
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

  static Future<double> $$staticMethod_name$$({
    required String $$parameter_name$$,
  }) {
    return _channel.$__staticMethod_name__($$parameter_name$$);
  }

  Future<String> $$method_name$$({required String $$parameter_name$$}) {
    return _channel.$__method_name__(this, $$parameter_name$$);
  }
}
