import 'dart:io';

import 'package:path/path.dart' as path;

import 'library.dart';

class AndroidLibrary extends OutputLibrary {
  const AndroidLibrary({this.classes, this.package});

  final List<AndroidClass> classes;
  final String package;

  @override
  Map<File, String> asFiles() {
    final Map<File, String> files = <File, String>{};

    for (AndroidClass c in classes) {
      final String filename = '${c.name}.java';
      files[File(filename)] = _classToString(c);
    }

    return files;
  }

  String _classToString(AndroidClass androidClass) {
    return '''
package $package;

class ${androidClass.name} {}
    ''';
  }

  static Directory getAndroidDirectory({
    Directory pluginDir,
    String organization,
    String pluginName,
  }) {
    return Directory(path.join(
      pluginDir.path,
      'android/src/main/java',
      organization.replaceAll('.', '/'),
      pluginName,
    ));
  }
}

class AndroidClass {
  AndroidClass({this.name}) : assert(name != null);

  final String name;
}
