import 'package:flutter/services.dart';
import 'package:penguin/penguin.dart';

import '../penguin_plugin.dart';

part 'android_view_creator.android.penguin.g.dart';

abstract class AndroidViewCreator {
  Future<String> onCreateView(Context context, String viewId);
}

@Class(AndroidPlatform(
  AndroidType('android.content', ['Context']),
))
class Context extends $Context {
  Context.fromUniqueId(String uniqueId, {MethodChannel channel}) : super.fromUniqueId(uniqueId, channel: channel);
}
