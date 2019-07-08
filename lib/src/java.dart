import 'android.dart';
import 'common.dart';
import 'dart.dart';

class JavaClass {
  JavaClass(this.name) : assert(name != null);
  final String name;
}

class JavaLibrary extends InputLibrary {
  List<JavaClass> classes;

  @override
  DartLibrary createDartLibrary() {
    final List<DartClass> pluginClasses = classes
        .map<DartClass>(
          (JavaClass c) => DartClass(name: c.name),
        )
        .toList();
    return DartLibrary(classes: pluginClasses);
  }

  AndroidLibrary createAndroidLibrary() {
    return null;
  }
}
