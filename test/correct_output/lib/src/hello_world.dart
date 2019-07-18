part of test_plugin;

class HelloWorld {HelloWorld() { Channel.channel.invokeMethod<void>('HelloWorld#()', <String, dynamic>{'handle': _handle}); }

final int _handle = Channel.nextHandle++;

Future<void> call([String optionalParam]) { return  Channel.channel.invokeMethod<void>('HelloWorld#call', <String, dynamic>{'optionalParam': optionalParam, 'handle': _handle}); } 
 }

