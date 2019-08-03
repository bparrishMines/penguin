import 'channel.dart';import 'dart:async';abstract class Apple {final int handle = Channel.nextHandle++;

static Future<bool> areApplesGood() { return  Channel.channel.invokeMethod<bool>('Apple#areApplesGood', <String, dynamic>{}); } 
 }
