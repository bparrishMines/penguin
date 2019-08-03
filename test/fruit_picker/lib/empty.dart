import 'channel.dart';class Empty {Empty() { Channel.channel.invokeMethod<void>('Empty()', <String, dynamic>{'emptyHandle': handle}); }

final int handle = Channel.nextHandle++;

 }
