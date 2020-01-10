import 'dart:async';

import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

abstract class PenguinPlugin {
  static final _WrapperManager _wrapperManager = _WrapperManager();

  static MethodChannel _globalMethodChannel;
  static set globalMethodChannel(MethodChannel methodChannel) =>
      _globalMethodChannel = methodChannel;
  static MethodChannel get globalMethodChannel {
    assert(
      _globalMethodChannel != null,
      'PenguinPlugin.globalMethodChannel is null.',
    );
    return _globalMethodChannel;
  }

  static Future<dynamic> Function(MethodCall call) get methodCallHandler =>
      (MethodCall call) {
        return _wrapperManager.wrappers[call.arguments[r'$uniqueId']]
            .onMethodCall(call);
      };
}

class _WrapperManager {
  _WrapperManager();

  final Map<String, Wrapper> wrappers = <String, Wrapper>{};

  void addWrapper(Wrapper wrapper) {
    assert(!wrappers.containsKey(wrapper.uniqueId));
    wrappers[wrapper.uniqueId] = wrapper;
  }

  FutureOr<void> removeWrapper(String uniqueId) {
    final Wrapper wrapper = wrappers.remove(uniqueId);
    if (wrapper != null) {
      return invoke<void>(
        PenguinPlugin.globalMethodChannel,
        <MethodCall>[
          MethodCall(
            '${wrapper.platformClassName}#deallocate',
            <String, String>{r'$uniqueId': uniqueId},
          )
        ],
      );
    }
  }
}

abstract class Wrapper {
  Wrapper([String uniqueId]) : _uniqueId = uniqueId ?? _uuid.v4() {
    PenguinPlugin._wrapperManager.addWrapper(this);
  }

  static final Uuid _uuid = Uuid();

  final String _uniqueId;
  String get uniqueId => _uniqueId;

  int _retainCount = 1;
  int get retainCount => _retainCount;

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

  String get platformClassName;

  Future<void> onMethodCall(MethodCall call);
}

Future<T> invoke<T>(MethodChannel channel, Iterable<MethodCall> calls) {
  final Completer<T> completer = Completer<T>();

  invokeForAll(
    channel,
    calls.where((MethodCall call) => call != null),
  ).then(
    (List<dynamic> results) => completer.complete(results.last),
  );

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
