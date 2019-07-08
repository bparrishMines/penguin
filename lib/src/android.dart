import 'dart:io';

import 'common.dart';

class AndroidLibrary extends OutputLibrary {
  const AndroidLibrary({this.classes});

  final List<AndroidClass> classes;

  @override
  Map<File, String> asFiles() {
    return null;
  }
}

class AndroidClass {
  AndroidClass({this.name}) : assert(name != null);

  final String name;
}
