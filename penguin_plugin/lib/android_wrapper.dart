import 'dart:async';

import 'package:flutter/services.dart';
import 'package:penguin/penguin.dart';
import 'package:penguin_plugin/penguin_plugin.dart';

part 'android_wrapper.android.penguin.g.dart';

abstract class AndroidWrapper extends Wrapper {
  const AndroidWrapper({
    String uniqueId,
    String platformClassName,
    this.onCreateView,
  }) : super(uniqueId: uniqueId, platformClassName: platformClassName);

  final List<MethodCall> Function(Context context) onCreateView;
}

class AndroidCallbackHandler extends CallbackHandler {
  @override
  Future<List<MethodCall>> Function(
    Wrapper wrapper,
    Map<String, dynamic> arguments,
  ) get onCreateView =>
      (Wrapper wrapper, Map<String, dynamic> arguments) async {
        return (wrapper as AndroidWrapper).onCreateView(
          Context.fromUniqueId(arguments['context']),
        );
      };
}

@Class(AndroidPlatform(AndroidType('android.content', <String>['Context'])))
class Context extends $Context {
  Context._(String uniqueId) : super(uniqueId);

  static Context fromUniqueId(String uniqueId) => Context._(uniqueId);
}
