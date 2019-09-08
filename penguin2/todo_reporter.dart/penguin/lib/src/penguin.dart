//class T odo {
//  final String name;
//  final String todoUrl;
//
//  const T odo(this.name, {this.todoUrl}) : assert(name != null);
//}

//import 'package:flutter/services.dart';

class Class {
  const Class(this.channel) : assert(channel != null);

  final String channel;
}

class Method {
  const Method();
}

class Callback {
  Callback(this.channel);

  final String channel;
}

// For every android file add to central file channel Class for method calls?

// Each class with callback gets its own methodchannel?
// No method channel requires binarymessenger

// Platform side doesn't matter
// Reflection for everything except callbacks?
