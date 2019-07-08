import 'dart:io';

import 'library.dart';

class DartLibrary extends OutputLibrary {
  const DartLibrary({List<DartClass> classes})
      : classes = classes ?? const <DartClass>[];

  final List<DartClass> classes;

  @override
  Map<File, String> asFiles() {
    final Map<File, String> files = <File, String>{};

    for (DartClass c in classes) {
      final String filename = _camelCaseToSnakeCase(c.name);
      files[File(filename)] = _classToString(c);
    }

    return files;
  }

  String _camelCaseToSnakeCase(String str) {
    final RegExp regExp = RegExp(r'([A-Z][a-z]*)');

    final StringBuffer buffer = StringBuffer();

    final List<Match> matches = regExp.allMatches(str).toList();
    for (int i = 0; i < matches.length; i++) {
      final String word = matches[i].group(0).toLowerCase();
      buffer.write(word);

      if (i < matches.length - 1) buffer.write('_');
    }

    buffer.write('.dart');
    return buffer.toString();
  }

  String _classToString(DartClass dartClass) {
    return '''
class ${dartClass.name} {}
    ''';
  }
}

class DartClass {
  DartClass({this.name}) : assert(name != null);

  final String name;
}
