const ignoreParam = SimpleParameterAnnotation(ignore: true);

class SimpleClassAnnotation {
  const SimpleClassAnnotation();
}

class SimpleFunctionAnnotation {
  const SimpleFunctionAnnotation();
}

class SimpleEnumAnnotation {
  const SimpleEnumAnnotation();
}

class SimpleMethodAnnotation {
  const SimpleMethodAnnotation({this.ignore = false});

  final bool ignore;
}

class SimpleConstructorAnnotation {
  const SimpleConstructorAnnotation({this.ignore = false});

  final bool ignore;
}

class SimpleParameterAnnotation {
  const SimpleParameterAnnotation({this.ignore = false});

  final bool ignore;
}
