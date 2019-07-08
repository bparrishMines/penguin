import 'dart:io';

class JavaClass {
  JavaClass(this.name) : assert(name != null);
  final String name;
}

class JavaLibrary implements InputLibrary {
  List<JavaClass> classes;

  @override
  PluginLibrary asPluginLibrary() {
    final List<PluginClass> pluginClasses = classes
        .map<PluginClass>(
          (JavaClass c) => PluginClass(name: c.name),
        )
        .toList();
    return PluginLibrary(classes: pluginClasses);
  }
}

class PluginLibrary {
  const PluginLibrary({List<PluginClass> classes})
      : classes = classes ?? const <PluginClass>[];

  final List<PluginClass> classes;

  Map<File, String> asDartLibrary() {
    final Map<File, String> files = <File, String>{};

    for (PluginClass c in classes) {
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

  String _classToString(PluginClass pluginClass) {
    return '''
class ${pluginClass.name} {}
    ''';
  }
}

abstract class InputLibrary {
  PluginLibrary asPluginLibrary();
}

class PluginClass {
  PluginClass({this.name}) : assert(name != null);

  final String name;
}
