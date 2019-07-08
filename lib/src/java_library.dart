import 'android_library.dart';
import 'library.dart';
import 'dart_library.dart';

class JavaClass {
  JavaClass(this.name) : assert(name != null);
  final String name;
}

class JavaLibrary extends InputLibrary {
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
}
