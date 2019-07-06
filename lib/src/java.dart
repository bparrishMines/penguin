class JavaClass {
  JavaClass(this.name) : assert(name != null);
  final String name;
}

class JavaLibrary implements InputLibrary {
  List<JavaClass> classes;

  @override
  PluginLibrary asPluginLibrary() {
    final List<PluginClass> pluginClasses = classes.map<PluginClass>(
      (JavaClass c) => PluginClass(name: c.name),
    );
    return PluginLibrary(classes: pluginClasses);
  }
}

class PluginLibrary {
  const PluginLibrary({List<PluginClass> classes})
      : classes = classes ?? const <PluginClass>[];

  final List<PluginClass> classes;
}

abstract class InputLibrary {
  PluginLibrary asPluginLibrary();
}

class PluginClass {
  PluginClass({this.name}) : assert(name != null);

  final String name;
}
