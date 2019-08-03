import 'channel.dart';

abstract class Empty {
  final int handle = Channel.nextHandle++;
}
