import 'package:flutter/services.dart';
import 'package:penguin/penguin.dart';

import '../penguin_plugin.dart';

part 'context.android.penguin.g.dart';

@Class(AndroidPlatform(
  AndroidType('android.content', ['Context']),
))
class Context extends $Context {
  Context.fromUniqueId(String uniqueId, {MethodChannel channel})
      : super.fromUniqueId(uniqueId, channel: channel);
}
