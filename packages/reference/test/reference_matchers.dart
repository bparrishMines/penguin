import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

// Extends isMethodCall in package:test/test.dart to support matchers in arguments.
Matcher isMethodCallWithMatchers(String method, {Object? arguments}) {
  return _IsMethodCallWithMatchers(method, arguments);
}

class _IsMethodCallWithMatchers extends Matcher with _DeepEquals {
  const _IsMethodCallWithMatchers(this.method, this.arguments);

  final String method;
  final Object? arguments;

  @override
  bool matches(dynamic item, Map<dynamic, dynamic> matchState) {
    if (item is! MethodCall) return false;
    if (item.method != method) return false;
    return deepEquals(item.arguments, arguments, matchState);
  }

  @override
  Description describe(Description description) {
    return description
        .add('Is a $MethodCall with method name: ')
        .addDescriptionOf(method)
        .add(' and arguments: ')
        .addDescriptionOf(arguments);
  }
}

mixin _DeepEquals {
  bool deepEquals(Object? a, Object? b, Map<Object?, Object?> matchState) {
    if (a == b) return true;
    if (b is Matcher) return b.matches(a, matchState);
    if (a is Matcher) return a.matches(b, matchState);
    if (a is List) return b is List && _deepEqualsList(a, b, matchState);
    if (a is Map) return b is Map && _deepEqualsMap(a, b, matchState);
    return false;
  }

  bool _deepEqualsList(
    List<Object?> a,
    List<Object?> b,
    Map<Object?, Object?> matchState,
  ) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (!deepEquals(a[i], b[i], matchState)) return false;
    }
    return true;
  }

  bool _deepEqualsMap(
    Map<Object?, Object?> a,
    Map<Object?, Object?> b,
    Map<Object?, Object?> matchState,
  ) {
    if (a.length != b.length) return false;
    for (final Object? key in a.keys) {
      if (!b.containsKey(key) || !deepEquals(a[key], b[key], matchState)) {
        return false;
      }
    }
    return true;
  }
}
