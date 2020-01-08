import 'dart:async';

import 'package:flutter/services.dart';
import 'package:penguin/penguin.dart';
import 'package:penguin_plugin/penguin_plugin.dart';

part 'ios_wrapper.ios.penguin.g.dart';

abstract class IosWrapper extends Wrapper {
  IosWrapper({
    String uniqueId,
    String platformClassName,
  }) : super(uniqueId: uniqueId, platformClassName: platformClassName);

  FutureOr<Iterable<MethodCall>> onCreateView(CGRect frame) =>
      throw UnimplementedError();
}

class IosCallbackHandler extends CallbackHandler {
  @override
  FutureOr<Iterable<MethodCall>> Function(
    Wrapper wrapper,
    Map<String, dynamic> arguments,
  ) get onCreateView =>
      (Wrapper wrapper, Map<String, dynamic> arguments) {
        return (wrapper as IosWrapper).onCreateView(
          CGRect._(arguments['cgRect']),
        );
      };
}

@Class(IosPlatform(IosType('CGRect', isStruct: true)))
class CGRect extends $CGRect {
  CGRect._(String uniqueId) : super(uniqueId);

  static FutureOr<CGRect> onAllocated($CGRect wrapper) =>
      CGRect._(wrapper.uniqueId);
}
