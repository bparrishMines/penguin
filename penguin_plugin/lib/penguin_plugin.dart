import 'dart:async';

import 'package:flutter/services.dart';

abstract class CallbackHandler {
  CallbackHandler() {
    _methodCallHandler = (MethodCall call) async {
      List<MethodCall> result;
      if (call.method == 'CreateView') {
        result = await onCreateView(
          _wrappers[call.arguments[r'$uniqueId']],
          call.arguments.cast<String, dynamic>(),
        );
      } else {
        result = _wrappers[call.arguments[r'$uniqueId']].onMethodCall(call);
      }

      if (result == null) return <MethodCall>[];
      return result
          .map<Map<String, dynamic>>(
            (MethodCall methodCall) => <String, dynamic>{
              'method': methodCall.method,
              'arguments': methodCall.arguments,
            },
          )
          .toList();
    };
  }

  Future<List<MethodCall>> Function(
    Wrapper wrapper,
    Map<String, dynamic> arguments,
  ) get onCreateView;

  final Map<String, Wrapper> _wrappers = <String, Wrapper>{};
  Future<dynamic> Function(MethodCall call) _methodCallHandler;

  Future<dynamic> Function(MethodCall call) get methodCallHandler =>
      _methodCallHandler;

  void addWrapper(Wrapper wrapper) => _wrappers[wrapper.uniqueId] = wrapper;

  Wrapper removeWrapper(Wrapper wrapper) => _wrappers.remove(wrapper.uniqueId);

  void clearAll() => _wrappers.clear();
}

abstract class Wrapper {
  Wrapper({this.uniqueId, this.platformClassName});

  final String uniqueId;

  final String platformClassName;

  final MethodCallStorageHelper methodCallStorageHelper =
      MethodCallStorageHelper();

  List<MethodCall> onMethodCall(MethodCall call);

  MethodCall allocate() {
    return MethodCall(
      '$platformClassName#allocate',
      <String, String>{r'$uniqueId': uniqueId},
    );
  }

  MethodCall deallocate() {
    return MethodCall(
      '$platformClassName#deallocate',
      <String, String>{r'$uniqueId': uniqueId},
    );
  }
}

class MethodCallStorageHelper {
  final Map<String, int> _callIndexes = <String, int>{};
  final List<MethodCall> _storedMethodCalls = <MethodCall>[];

  List<MethodCall> get methodCalls => List<MethodCall>.from(_storedMethodCalls);

  void storeMethodCall(MethodCall call) {
    _callIndexes[call.method] = _storedMethodCalls.length;
    _storedMethodCalls.add(call);
  }

  void replaceMethodCall(MethodCall call) {
    final int index = _callIndexes[call.method];
    if (index != null) {
      _storedMethodCalls[index] = call;
    } else {
      storeMethodCall(call);
    }
  }

  void clearMethodCalls() {
    _storedMethodCalls.clear();
    _callIndexes.clear();
  }
}

Future<T> invoke<T>(
  MethodChannel channel,
  MethodCall call, [
  Iterable<MethodCall> following = const <MethodCall>[],
]) {
  final Completer<T> completer = Completer<T>();

  invokeAll(
    channel,
    <MethodCall>[call, ...following].where((MethodCall call) => call != null),
  ).then(
    (List<dynamic> results) => completer.complete(results.last),
  );

  return completer.future;
}

Future<List<T>> invokeList<T>(
  MethodChannel channel,
  MethodCall call, [
  Iterable<MethodCall> following = const <MethodCall>[],
]) {
  final Completer<List<T>> completer = Completer<List<T>>();

  invokeAll(
    channel,
    <MethodCall>[call, ...following].where((MethodCall call) => call != null),
  ).then(
    (List<dynamic> results) => completer.complete(results.last.cast<T>()),
  );

  return completer.future;
}

Future<Map<S, T>> invokeMap<S, T>(
  MethodChannel channel,
  MethodCall call, [
  Iterable<MethodCall> following = const <MethodCall>[],
]) {
  final Completer<Map<S, T>> completer = Completer<Map<S, T>>();

  invokeAll(
    channel,
    <MethodCall>[call, ...following].where((MethodCall call) => call != null),
  ).then(
    (List<dynamic> results) => completer.complete(results.last.cast<S, T>()),
  );

  return completer.future;
}

Future<List<dynamic>> invokeAll(
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
