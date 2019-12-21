import 'dart:async';

import 'package:flutter/services.dart';

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
