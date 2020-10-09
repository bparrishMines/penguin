mixin TemplateRegExp {
  static RegExp regExp(String pattern) {
    return RegExp(pattern, multiLine: true, dotAll: true);
  }

  RegExp get exp;

  TemplateRegExp get parent;

  String get template => parent.template;

  String stringMatch() {
    final List<TemplateRegExp> expressions = <TemplateRegExp>[];

    TemplateRegExp currentExp = this;
    while (currentExp.parent != null) {
      expressions.add(currentExp);
      currentExp = currentExp.parent;
    }

    String result = template;
    for (TemplateRegExp expression in expressions.reversed) {
      result = expression.exp.stringMatch(result);
    }

    return result;
  }
}