const ignoreParam = SimpleParameterAnnotation(ignore: true);

class SimpleClassAnnotation {}

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
