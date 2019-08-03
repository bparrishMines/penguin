import 'channel.dart';import 'dart:async';abstract class Banana {final int handle = Channel.nextHandle++;

Future<double> get length { return  Channel.channel.invokeMethod<double>('Banana#length', <String, dynamic>{'handle': handle}); } 
 }
