import 'dart:io';

import 'dart.dart';

abstract class InputLibrary {
  DartLibrary createDartLibrary();
}

abstract class OutputLibrary {
  const OutputLibrary();
  Map<File, String> asFiles();
}
