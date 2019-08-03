import 'channel.dart';import 'dart:async';class Strawberry {Strawberry() { Channel.channel.invokeMethod<void>('Strawberry()', <String, dynamic>{'strawberryHandle': handle}); }

final int handle = Channel.nextHandle++;

static Future<int> get averageNumberOfSeeds { return  Channel.channel.invokeMethod<int>('Strawberry#averageNumberOfSeeds', <String, dynamic>{}); } 
 }
