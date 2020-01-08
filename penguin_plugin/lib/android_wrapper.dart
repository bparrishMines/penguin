import 'dart:async';

import 'package:flutter/services.dart';
import 'package:penguin/penguin.dart';
import 'package:penguin_plugin/penguin_plugin.dart';

part 'android_wrapper.android.penguin.g.dart';

abstract class AndroidWrapper extends Wrapper {
  AndroidWrapper({
    String uniqueId,
    String platformClassName,
  }) : super(uniqueId: uniqueId, platformClassName: platformClassName);

  FutureOr<Iterable<MethodCall>> onCreateView(Context context) =>
      throw UnimplementedError();
}

class AndroidCallbackHandler extends CallbackHandler {
  @override
  FutureOr<Iterable<MethodCall>> Function(
    Wrapper wrapper,
    Map<String, dynamic> arguments,
  ) get onCreateView =>
      (Wrapper wrapper, Map<String, dynamic> arguments) {
        return (wrapper as AndroidWrapper).onCreateView(
          Context._(arguments['context']),
        );
      };
}

@Class(AndroidPlatform(AndroidType('android.content', <String>['Context'])))
class Context extends $Context {
  Context._(String uniqueId) : super(uniqueId);

  static Context onAllocated($Context wrapper) => Context._(wrapper.uniqueId);
}
