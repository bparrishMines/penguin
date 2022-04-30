const ignoreParam = SimpleParameterAnnotation(ignore: true);

class SimpleClassAnnotation {
  const SimpleClassAnnotation({
    this.ignore = false,
    this.customValues = const <String, Object?>{},
  });

  final bool ignore;
  final Map<String, Object?> customValues;
}

class SimpleFunctionAnnotation {
  const SimpleFunctionAnnotation();
}

class SimpleEnumAnnotation {
  const SimpleEnumAnnotation();
}

class SimpleMethodAnnotation {
  const SimpleMethodAnnotation({
    this.ignore = false,
    this.customValues = const <String, Object?>{},
  });

  final bool ignore;
  final Map<String, Object?> customValues;
}

class SimpleConstructorAnnotation {
  const SimpleConstructorAnnotation({this.ignore = false});

  final bool ignore;
}

class SimpleParameterAnnotation {
  const SimpleParameterAnnotation({this.ignore = false});

  final bool ignore;
}

class SimpleTypeAnnotation {
  const SimpleTypeAnnotation({
    this.customValues = const <String, Object?>{},
  });

  final Map<String, Object?> customValues;
}
