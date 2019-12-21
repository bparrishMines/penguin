import 'package:flutter/services.dart';

class CallbackHandler {
  CallbackHandler() {
    _methodCallHandler = (MethodCall call) async {
      List<MethodCall> result;
      if (call.method == 'CreateView') {
        result = _wrappers[call.arguments[r'$uniqueId']].onCreateView(
          $CGRect(call.arguments[r'cgRect']),
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

  final Map<String, Wrapper> _wrappers = <String, Wrapper>{};
  Future<dynamic> Function(MethodCall call) _methodCallHandler;

  Future<dynamic> Function(MethodCall call) get methodCallHandler =>
      _methodCallHandler;

  void addWrapper(Wrapper wrapper) => _wrappers[wrapper.uniqueId] = wrapper;

  Wrapper removeWrapper(Wrapper wrapper) => _wrappers.remove(wrapper.uniqueId);

  void clearAll() => _wrappers.clear();
}

abstract class Wrapper {
  const Wrapper(this.uniqueId, {this.onCreateView});

  final String uniqueId;
  final List<MethodCall> Function($CGRect cgRect) onCreateView;

  String get platformClassName;
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

class $CGRect extends Wrapper {
  const $CGRect(
      String uniqueId, {
        List<MethodCall> Function($CGRect cgRect) onCreateView,
      }) : super(uniqueId, onCreateView: onCreateView);

  @override
  String get platformClassName => 'CGRect';

  @override
  List<MethodCall> onMethodCall(MethodCall call) {
    switch (call.method) {
    }
    throw UnimplementedError('No implementation for ${call.method}.');
  }

  MethodCall $CGRect$Default() {
    return MethodCall(
      'CGRect()',
      <String, dynamic>{
        r'$uniqueId': uniqueId,
      },
    );
  }
}