import 'package:flutter/foundation.dart';import 'package:flutter/services.dart';class Channel {@visibleForTesting static const MethodChannel channel = MethodChannel('dev.fruit/fruit_picker');

@visibleForTesting static int nextHandle = 0;

 }
