import 'package:flutter/services.dart';
import 'package:penguin/penguin.dart';

import '../penguin_plugin.dart';

part 'android_view_creator.android.penguin.g.dart';

abstract class AndroidViewCreator with ViewCreator {
  Future<void> onCreateView(FrameLayout layout, int viewId);
}

@Class(AndroidPlatform(AndroidType('android.widget', ['FrameLayout'])))
class FrameLayout extends $FrameLayout {
  FrameLayout.fromUniqueId(String uniqueId) : super.fromUniqueId(uniqueId);
}