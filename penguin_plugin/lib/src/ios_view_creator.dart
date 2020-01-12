import 'package:flutter/services.dart';
import 'package:penguin/penguin.dart';

import '../penguin_plugin.dart';

part 'ios_view_creator.ios.penguin.g.dart';

abstract class IosViewCreator {
  Future<String> onCreateView(CGRect frame, String viewId);
}

@Class(IosPlatform(IosType('CGRect', isStruct: true)))
class CGRect extends $CGRect {
  CGRect.fromUniqueId(String uniqueId) : super.fromUniqueId(uniqueId);
}