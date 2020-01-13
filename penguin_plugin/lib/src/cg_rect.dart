import 'package:flutter/services.dart';
import 'package:penguin/penguin.dart';

import '../penguin_plugin.dart';

part 'cg_rect.ios.penguin.g.dart';

@Class(IosPlatform(IosType('CGRect', isStruct: true)))
class CGRect extends $CGRect {
  CGRect.fromUniqueId(String uniqueId, {MethodChannel channel})
      : super.fromUniqueId(uniqueId, channel: channel);
}
