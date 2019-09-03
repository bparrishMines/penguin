class TemplateIdentifiers {
  const TemplateIdentifiers._(this._id);

  final String _id;

  static final String methodName = '__methodName__';
  static final String className = '__className__';
}

class Templates {
  const Templates();

  static String getMethod(String input) {
    final RegExp methodRegExp = RegExp(
      r'// METHOD$(.*)// end METHOD$',
      multiLine: true,
      dotAll: true,
    );

    return methodRegExp.firstMatch(input).group(1);
  }

  static final String dart = r'''
// CLASS
class _$__className__ {
  _$__className__(this.$uniqueId);
  
  final String $uniqueId;
  
  // METHODS
  // METHOD
  MethodCall _$__methodName__() {
    return MethodCall('__className__#__methodName__');
  }
  // end METHOD
  // end METHODS
}
// end CLASS
''';
}
