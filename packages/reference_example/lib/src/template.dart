import 'dart:async';

import 'package:reference/annotations.dart';

import 'template.g.dart';
import 'template_channels.dart';

@Reference('github.penguin/template/template/ACallback')
typedef $$function_name$$ = void Function(String value);

@Reference('github.penguin/template/template/ClassTemplate')
class $$class_name$$ with $$$class_name$$ {
  $$class_name$$(int $$field_name$$, $$function_name$$ aFunction) {
    _channel.$$create(this, $owner: true, $$field_name$$: $$field_name$$);
  }

  static $$$class_name$$Channel get _channel =>
      ChannelRegistrar.instance.implementations.channel__class_name__;

  static Future<double> $__staticMethod_name__(
    String $$parameter_name$$,
  ) async {
    return await _channel.$__staticMethod_name__($$parameter_name$$) as double;
  }

  @override
  Future<String> $$method_name$$(String $$parameter_name$$) async {
    return await _channel.$__method_name__(
      this,
      $$parameter_name$$,
    ) as String;
  }
}
