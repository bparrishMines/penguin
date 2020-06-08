import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reference/reference.dart';
import 'package:reference/src/template/template.dart';

// Extends isMethodCall in packager:test/test.dart to support matchers in arguments.
Matcher isMethodCallWithMatchers(String name, {dynamic arguments}) {
  return _IsMethodCallWithMatchers(name, arguments);
}

class _IsMethodCallWithMatchers extends Matcher with _DeepEquals {
  const _IsMethodCallWithMatchers(this.name, this.arguments);

  final String name;
  final dynamic arguments;

  @override
  bool matches(dynamic item, Map<dynamic, dynamic> matchState) {
    if (item is! MethodCall) return false;
    if (item.method != name) return false;
    return deepEquals(item.arguments, arguments, matchState);
  }

  @override
  Description describe(Description description) {
    return description
        .add('Is a $MethodCall with method name: ')
        .addDescriptionOf(name)
        .add(' and arguments: ')
        .addDescriptionOf(arguments);
  }
}

// Extends isMethodCall in packager:test/test.dart to support matchers in arguments.
Matcher isUnpairedRemoteReference(
  int typeId,
  List<dynamic> creationArguments,
  String managerPoolId,
) {
  return _IsUnpairedRemoteReference(typeId, creationArguments, managerPoolId);
}

class _IsUnpairedRemoteReference extends Matcher with _DeepEquals {
  const _IsUnpairedRemoteReference(
    this.typeId,
    this.creationArguments,
    this.managerPoolId,
  );

  final int typeId;

  final List<dynamic> creationArguments;

  final String managerPoolId;

  @override
  Description describe(Description description) {
    return description
        .add(' Is an $UnpairedRemoteReference with type id: ')
        .addDescriptionOf(typeId)
        .add(' and creation arguments: ')
        .addDescriptionOf(creationArguments)
        .add(' and poolId: ')
        .addDescriptionOf(managerPoolId);
  }

  @override
  bool matches(dynamic item, Map<dynamic, dynamic> matchState) {
    if (item is! UnpairedRemoteReference) return false;
    if (item.typeId != typeId) return false;
    if (item.managerPoolId != managerPoolId) return false;
    return deepEquals(creationArguments, item.creationArguments, matchState);
  }
}

Matcher isClassTemplate(int fieldTemplate) {
  return _IsClassTemplate(fieldTemplate);
}

class _IsClassTemplate extends Matcher with _DeepEquals {
  const _IsClassTemplate(this.fieldTemplate);

  final int fieldTemplate;

  @override
  Description describe(Description description) {
    return description
        .add(' Is a $ClassTemplate with fieldTemplate: ')
        .addDescriptionOf(fieldTemplate)
        .add(' and referenceFieldTemplate: ');
  }

  @override
  bool matches(dynamic item, Map<dynamic, dynamic> matchState) {
    if (item is! ClassTemplate) return false;
    if (item.fieldTemplate != fieldTemplate) return false;
    return true;
  }
}

mixin _DeepEquals {
  bool deepEquals(dynamic a, dynamic b, Map<dynamic, dynamic> matchState) {
    if (a == b) return true;
    if (b is Matcher) return b.matches(a, matchState);
    if (a is Matcher) return a.matches(b, matchState);
    if (a is List) return b is List && _deepEqualsList(a, b, matchState);
    if (a is Map) return b is Map && _deepEqualsMap(a, b, matchState);
    return false;
  }

  bool _deepEqualsList(
    List<dynamic> a,
    List<dynamic> b,
    Map<dynamic, dynamic> matchState,
  ) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (!deepEquals(a[i], b[i], matchState)) return false;
    }
    return true;
  }

  bool _deepEqualsMap(
    Map<dynamic, dynamic> a,
    Map<dynamic, dynamic> b,
    Map<dynamic, dynamic> matchState,
  ) {
    if (a.length != b.length) return false;
    for (final dynamic key in a.keys) {
      if (!b.containsKey(key) || !deepEquals(a[key], b[key], matchState)) {
        return false;
      }
    }
    return true;
  }
}
