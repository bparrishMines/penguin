part of test_plugin;

class Trace {Trace._(Map source) { Channel.channel.invokeMethod<void>('Trace#()', <String, dynamic>{'source': source, 'handle': _handle}); }

final int _handle = Channel.nextHandle++;

static Future<int> get maxTraceNameLength { return  Channel.channel.invokeMethod<int>('Trace#maxTraceNameLength', <String, dynamic>{}); } 
Future<void> start() { return  Channel.channel.invokeMethod<void>('Trace#start', <String, dynamic>{'handle': _handle}); } 
Future<void> stop() { return  Channel.channel.invokeMethod<void>('Trace#stop', <String, dynamic>{'handle': _handle}); } 
Future<void> incrementMetric(String name, int value) { return  Channel.channel.invokeMethod<void>('Trace#incrementMetric', <String, dynamic>{'name': name, 'value': value, 'handle': _handle}); } 
Future<void> setMetric(String name, int value) { return  Channel.channel.invokeMethod<void>('Trace#setMetric', <String, dynamic>{'name': name, 'value': value, 'handle': _handle}); } 
Future<void> getMetric(String name) { return  Channel.channel.invokeMethod<void>('Trace#getMetric', <String, dynamic>{'name': name, 'handle': _handle}); } 
 }

