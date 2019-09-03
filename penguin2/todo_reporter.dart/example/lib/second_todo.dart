import 'dart:async';

import 'package:flutter/services.dart';
import 'package:penguin/penguin.dart';

part "second_todo.g.dart";

@Class(javaPackage: 'com.potample')
class SecondTodo extends _$SecondTodo {
  SecondTodo._(String $uniqueId) : super($uniqueId);

  @Method()
  Future<void> doSomething() {
    final MethodCall call = _$doSomething();
    MethodChannel channel = MethodChannel('');
    return channel.invokeMethod(call.method, call.arguments);
  }

  Future<void> doSomethingElse() {
    return null;
  }
}
