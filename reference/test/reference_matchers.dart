import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reference/reference.dart';
import 'package:reference/src/templates/template_interface.dart';

// Extends isMethodCall in packager:test/test.dart to support matchers in arguments.
Matcher isMethodCallWithMatchers(String name, {dynamic arguments}) {
  return _IsMethodCallWithMatchers(name, arguments);
}

class _IsMethodCallWithMatchers extends Matcher with DeepEquals {
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
Matcher isUnpairedRemoteReferenceWithSame(
  TypeReference typeReference,
  List<dynamic> creationArguments,
) {
  return _IsUnpairedRemoteReferenceWithSame(typeReference, creationArguments);
}

class _IsUnpairedRemoteReferenceWithSame extends Matcher with DeepEquals {
  const _IsUnpairedRemoteReferenceWithSame(
    this.typeReference,
    this.creationArguments,
  );

  final TypeReference typeReference;

  final List<dynamic> creationArguments;

  @override
  Description describe(Description description) {
    return description
        .add(' Is an $UnpairedRemoteReference with type reference: ')
        .addDescriptionOf(typeReference)
        .add(' and creation arguments: ')
        .addDescriptionOf(creationArguments);
  }

  @override
  bool matches(dynamic item, Map<dynamic, dynamic> matchState) {
    if (item is! UnpairedRemoteReference) return false;
    if (item.typeReference != typeReference) return false;
    return deepEquals(creationArguments, item.creationArguments, matchState);
  }
}

mixin DeepEquals {
  bool deepEquals(dynamic a, dynamic b, Map<dynamic, dynamic> matchState) {
    if (a == b) return true;
    if (b is Matcher) return b.matches(a, matchState);
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

Matcher isClassTemplateWithSame(int field, dynamic reference) {
  return _IsClassTemplateWithSame(field, reference);
}

class _IsClassTemplateWithSame extends Matcher {
  const _IsClassTemplateWithSame(this.fieldTemplate, this.referenceFieldTemplate);

  final int fieldTemplate;
  final dynamic referenceFieldTemplate;

  @override
  Description describe(Description description) {
    return description
        .add(' Is a $ClassTemplate with field: ')
        .addDescriptionOf(fieldTemplate)
        .add(' and reference: ')
        .addDescriptionOf(referenceFieldTemplate);
  }

  @override
  bool matches(dynamic item, Map<dynamic, dynamic> matchState) {
    if (item is! ClassTemplate) return false;
    if (item.fieldTemplate != fieldTemplate) return false;
    if (item.referenceFieldTemplate == referenceFieldTemplate) return true;
    if (referenceFieldTemplate is Matcher) {
      return referenceFieldTemplate.matches(
        item.referenceFieldTemplate,
        matchState,
      );
    }
    return false;
  }
}
