import 'channel.dart';import 'banana.dart';import 'apple.dart';abstract class Basket {final int handle = Channel.nextHandle++;

static Banana get ripestBanana { final banana = _BananaImpl();
Channel.channel.invokeMethod<void>('Basket#ripestBanana', <String, dynamic>{'bananaHandle': banana.handle});
return  banana; } 
Apple takeApple() { final apple = _AppleImpl();
Channel.channel.invokeMethod<void>('Basket#takeApple', <String, dynamic>{'appleHandle': apple.handle, 'handle': handle});
return  apple; } 
 }
class _AppleImpl extends Apple {_AppleImpl() : super.internal();

 }
class _BananaImpl extends Banana { }
