import 'dart:io';

import 'android_library.dart';
import 'library.dart';
import 'dart_library.dart';

class JavaLibrary extends InputLibrary {
  JavaLibrary();

  factory JavaLibrary.fromFiles(List<File> files) {
    assert(files.every((File file) => file.path.endsWith('.java')));

    final List<JavaClass> classes = <JavaClass>[];

    for (File file in files) {
      final String fileString = file.readAsStringSync().replaceAll('\n', ' ');

      final String classStr = _parseClass(fileString);
      print(_parseClassName(classStr));
    }
    /*
    for (File file in files) {
      for (String line in file.readAsLinesSync()) {
        final RegExp exp = RegExp(r'class\s(\w+)');

        final RegExpMatch match = exp.firstMatch(line);
        if (match != null) {
          final JavaClass javaClass = JavaClass(match.group(1));
          classes.add(javaClass);
        }
      }
    }
    */

    final JavaLibrary library = JavaLibrary()..classes = classes;
    return library;
  }

  List<JavaClass> classes;

  @override
  DartLibrary createDartLibrary() {
    final List<DartClass> dartClasses = classes
        .map<DartClass>(
          (JavaClass c) => DartClass(name: c.name),
        )
        .toList();
    return DartLibrary(classes: dartClasses);
  }

  AndroidLibrary createAndroidLibrary({String org, String pluginName}) {
    assert(org != null);
    assert(pluginName != null);

    final List<AndroidClass> androidClasses = classes
        .map<AndroidClass>(
          (JavaClass c) => AndroidClass(name: 'Flutter${c.name}'),
        )
        .toList();
    return AndroidLibrary(classes: androidClasses, package: '$org.$pluginName');
  }

  static String _parseClass(String string) {
    final RegExp exp = RegExp(
      r'(public|private=?)?\s?class\s+\w+[\s|\w|,]*\{.+}',
    );

    final RegExpMatch match = exp.firstMatch(string);

    if (match == null) return null;

    return match.group(0);
  }

  static String _parseClassName(String string) {
    final RegExp exp = RegExp(r'class\s+(\w+)');

    final RegExpMatch match = exp.firstMatch(string);

    if (match == null) return null;

    return match.group(1);
  }
}

class JavaClass {
  JavaClass(this.name) : assert(name != null);

  final String name;
}
