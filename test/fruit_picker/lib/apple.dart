import 'channel.dart';import 'dart:async';class Apple {Apple() { Channel.channel.invokeMethod<void>('Apple()', <String, dynamic>{'appleHandle': handle}); }

Apple.internal();

final int handle = Channel.nextHandle++;

static Future<bool> areApplesGood() { return  Channel.channel.invokeMethod<bool>('Apple#areApplesGood', <String, dynamic>{}); } 
 }
