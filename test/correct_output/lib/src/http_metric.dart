part of test_plugin;

class HttpMetric {HttpMetric._(Map source) { Channel.channel.invokeMethod<void>('HttpMetric#()', <String, dynamic>{'source': source, 'handle': _handle}); }

final int _handle = Channel.nextHandle++;

Future<int> get httpResponseCode { return  Channel.channel.invokeMethod<int>('HttpMetric#httpResponseCode', <String, dynamic>{'handle': _handle}); } 
Future<int> get requestPayloadSize { return  Channel.channel.invokeMethod<int>('HttpMetric#requestPayloadSize', <String, dynamic>{'handle': _handle}); } 
Future<String> get responseContentType { return  Channel.channel.invokeMethod<String>('HttpMetric#responseContentType', <String, dynamic>{'handle': _handle}); } 
Future<int> get responsePayloadSize { return  Channel.channel.invokeMethod<int>('HttpMetric#responsePayloadSize', <String, dynamic>{'handle': _handle}); } 
Future<void> start() { return  Channel.channel.invokeMethod<void>('HttpMetric#start', <String, dynamic>{'handle': _handle}); } 
Future<void> stop() { return  Channel.channel.invokeMethod<void>('HttpMetric#stop', <String, dynamic>{'handle': _handle}); } 
Future<void> setHttpResponseCode(int httpResponseCode) { return  Channel.channel.invokeMethod<void>('HttpMetric#setHttpResponseCode', <String, dynamic>{'httpResponseCode': httpResponseCode, 'handle': _handle}); } 
Future<void> setRequestPayloadSize(int requestPayloadSize) { return  Channel.channel.invokeMethod<void>('HttpMetric#setRequestPayloadSize', <String, dynamic>{'requestPayloadSize': requestPayloadSize, 'handle': _handle}); } 
Future<void> setResponseContentType(String responseConentType) { return  Channel.channel.invokeMethod<void>('HttpMetric#setResponseContentType', <String, dynamic>{'responseConentType': responseConentType, 'handle': _handle}); } 
Future<void> setResponsePayloadSize(int responsePayloadSize) { return  Channel.channel.invokeMethod<void>('HttpMetric#setResponsePayloadSize', <String, dynamic>{'responsePayloadSize': responsePayloadSize, 'handle': _handle}); } 
 }

