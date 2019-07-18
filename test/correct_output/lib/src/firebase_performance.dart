part of test_plugin;

class FirebasePerformance {FirebasePerformance._(Map source) { Channel.channel.invokeMethod<void>('FirebasePerformance#()', <String, dynamic>{'source': source, 'handle': _handle}); }

final int _handle = Channel.nextHandle++;

static FirebasePerformance get instance { return  FirebasePerformance._(<String, dynamic>{}); } 
Future<bool> isPerformanceCollectionEnabled() { return  Channel.channel.invokeMethod<bool>('FirebasePerformance#isPerformanceCollectionEnabled', <String, dynamic>{'handle': _handle}); } 
Future<void> setPerformanceCollectionEnabled(bool enable) { return  Channel.channel.invokeMethod<void>('FirebasePerformance#setPerformanceCollectionEnabled', <String, dynamic>{'enable': enable, 'handle': _handle}); } 
Trace newTrace(String name) { return  Trace._({'name': name}); } 
HttpMetric newHttpMetric(String url, HttpMethod httpMethod) { return  HttpMetric._({'url': url, 'httpMethod': httpMethod}); } 
 }

