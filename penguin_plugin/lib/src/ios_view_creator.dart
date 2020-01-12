import 'package:flutter/services.dart';
import 'package:penguin/penguin.dart';

import '../penguin_plugin.dart';

part 'ios_view_creator.ios.penguin.g.dart';

abstract class IosViewCreator with ViewCreator {
  Future<void> onCreateView(UIView uiView, String viewId);
}

@Class(IosPlatform(IosType('UIView')))
class UIView extends $UIView {
  UIView.fromUniqueId(String uniqueId) : super.fromUniqueId(uniqueId);
}