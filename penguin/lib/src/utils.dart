String camelCaseToSnakeCase(String str) {
  final RegExp regExp = RegExp(r'([A-Z][a-z]*)');

  final StringBuffer buffer = StringBuffer();

  final List<Match> matches = regExp.allMatches(str).toList();
  for (int i = 0; i < matches.length; i++) {
    final String word = matches[i].group(0).toLowerCase();
    buffer.write(word);

    if (i < matches.length - 1) buffer.write('_');
  }

  return buffer.toString();
}

String snakeCaseToCamelCase(String str) {
  final RegExp regExp = RegExp(r'([a-z]+)_*');

  final StringBuffer buffer = StringBuffer();

  final List<Match> matches = regExp.allMatches(str).toList();
  for (int i = 0; i < matches.length; i++) {
    final String match = matches[i].group(1);
    final String word = match[0].toUpperCase() + match.substring(1);
    buffer.write(word);
  }

  return buffer.toString();
}
