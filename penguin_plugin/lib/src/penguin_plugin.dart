import 'dart:async';
import 'dart:io' as io;

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

import 'android_view_creator.dart';
import 'ios_view_creator.dart';

abstract class PenguinPlugin {
  static final _WrapperManager _wrapperManager = _WrapperManager();
  static AndroidViewCreator androidCreator;
  static IosViewCreator iosCreator;

  static Future<dynamic> Function(MethodCall call) methodCallHandler(
          MethodChannel channel) =>
      (MethodCall call) {
        if (call.method == 'onCreateView' && io.Platform.isAndroid) {
          final Context context = Context.fromUniqueId(
            call.arguments['context'],
            channel: channel,
          );
          return androidCreator.onCreateView(context, call.arguments['viewId']);
        } else if (call.method == 'onCreateView' && io.Platform.isIOS) {
          final CGRect frame = CGRect.fromUniqueId(
            call.arguments['frame'],
            channel: channel,
          );
          return iosCreator.onCreateView(frame, call.arguments['viewId']);
        }

        return _wrapperManager.wrappers[call.arguments[r'$uniqueId']]
            .onMethodCall(call);
      };
}

class _WrapperManager {
  final Map<String, Wrapper> wrappers = <String, Wrapper>{};
  final List<Wrapper> autoReleasePool = <Wrapper>[];

  void addWrapper(Wrapper wrapper) {
    assert(!wrappers.containsKey(wrapper.uniqueId), wrapper.uniqueId);
    wrappers[wrapper.uniqueId] = wrapper;
  }

  FutureOr<void> removeWrapper(String uniqueId) {
    final Wrapper wrapper = wrappers.remove(uniqueId);
    if (wrapper != null) {
      return invoke<void>(
        wrapper.channel,
        <MethodCall>[
          MethodCall(
            '${wrapper.platformClassName}#deallocate',
            <String, String>{r'$uniqueId': uniqueId},
          )
        ],
      );
    }
  }

  void drainAutoreleasePool(Duration duration) {
    for (Wrapper wrapper in autoReleasePool) wrapper.release();
    autoReleasePool.clear();
  }

  void addWrapperToAutoReleasePool(Wrapper wrapper) {
    autoReleasePool.add(wrapper);
    if (autoReleasePool.length == 1) {
      WidgetsBinding.instance.addPostFrameCallback(drainAutoreleasePool);
    }
  }
}

abstract class Wrapper with ReferenceCounter {
  Wrapper(this.channel, [String uniqueId])
      : _uniqueId = uniqueId ?? _uuid.v4(),
        assert(channel != null) {
    PenguinPlugin._wrapperManager.addWrapper(this);
  }

  static final Uuid _uuid = Uuid();

  final MethodChannel channel;

  final String _uniqueId;
  String get uniqueId => _uniqueId;

  String get platformClassName;

  Future<void> onMethodCall(MethodCall call);
}

mixin ReferenceCounter {
  int _retainCount = 1;
  int get retainCount => _retainCount;

  String get uniqueId;

  Wrapper retain() {
    _retainCount++;
    return this;
  }

  FutureOr<void> release() {
    _retainCount--;
    if (retainCount == 0) {
      return PenguinPlugin._wrapperManager.removeWrapper(uniqueId);
    }
  }

  Wrapper autoReleasePool() {
    PenguinPlugin._wrapperManager.addWrapperToAutoReleasePool(this);
    return this;
  }
}

abstract class GenericHelper {
  const GenericHelper();

  T getWrapperForType<T>(String uniqueId);
}

Future<T> invoke<T>(
  MethodChannel channel,
  Iterable<MethodCall> calls, {
  GenericHelper genericHelper,
}) {
  final Completer<T> completer = Completer<T>();

  invokeForAll(
    channel,
    calls.where((MethodCall call) => call != null),
  ).then((List<dynamic> results) {
    if (isTypeOf<T, Wrapper>()) {
      completer.complete(genericHelper.getWrapperForType<T>(results.last));
    } else {
      completer.complete(results.last);
    }
  });

  return completer.future;
}

Future<List<T>> invokeList<T>(
  MethodChannel channel,
  Iterable<MethodCall> calls,
) {
  final Completer<List<T>> completer = Completer<List<T>>();
  invoke<List>(channel, calls).then(
    (List result) => completer.complete(result.cast<T>()),
  );
  return completer.future;
}

Future<Map<S, T>> invokeMap<S, T>(
  MethodChannel channel,
  Iterable<MethodCall> calls,
) {
  final Completer<Map<S, T>> completer = Completer<Map<S, T>>();
  invoke<Map>(channel, calls).then(
    (Map result) => completer.complete(result.cast<S, T>()),
  );
  return completer.future;
}

Future<List<dynamic>> invokeForAll(
  MethodChannel channel,
  Iterable<MethodCall> methodCalls,
) {
  final List<Map<String, dynamic>> serializedCalls = methodCalls
      .map<Map<String, dynamic>>(
        (MethodCall methodCall) => <String, dynamic>{
          'method': methodCall.method,
          'arguments': methodCall.arguments,
        },
      )
      .toList();

  return channel.invokeListMethod<dynamic>('MultiInvoke', serializedCalls);
}

bool isTypeOf<ThisType, OfType>() => _Instance<ThisType>() is _Instance<OfType>;

class _Instance<T> {}
