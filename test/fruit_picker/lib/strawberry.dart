import 'channel.dart';import 'dart:async';abstract class Strawberry {final int handle = Channel.nextHandle++;

static Future<int> get averageNumberOfSeeds { return  Channel.channel.invokeMethod<int>('Strawberry#averageNumberOfSeeds', <String, dynamic>{}); } 
 }
