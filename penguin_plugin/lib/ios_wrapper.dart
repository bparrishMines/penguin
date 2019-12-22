import 'package:flutter/services.dart';
import 'package:penguin/penguin.dart';
import 'package:penguin_plugin/penguin_plugin.dart';

part 'ios_wrapper.ios.penguin.g.dart';

abstract class IosWrapper extends Wrapper {
  const IosWrapper({
    String uniqueId,
    String platformClassName,
    this.onCreateView,
  }) : super(uniqueId: uniqueId, platformClassName: platformClassName);

  final List<MethodCall> Function(CGRect frame) onCreateView;
}

class IosCallbackHandler extends CallbackHandler {
  @override
  Future<List<MethodCall>> Function(
    Wrapper wrapper,
    Map<String, dynamic> arguments,
  ) get onCreateView =>
      (Wrapper wrapper, Map<String, dynamic> arguments) async {
        return (wrapper as IosWrapper).onCreateView(
          CGRect._fromUniqueId(arguments['frame']),
        );
      };
}

@Class(IosPlatform(IosType('CGRect', isStruct: true)))
class CGRect extends $CGRect {
  CGRect._fromUniqueId(String uniqueId) : super(uniqueId);
}
