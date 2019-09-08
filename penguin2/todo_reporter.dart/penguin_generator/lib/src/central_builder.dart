import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart' as p;
import 'package:penguin/penguin.dart';
import 'package:source_gen/source_gen.dart';

class CentralBuilder implements Builder {
  static const TypeChecker classAnnotation = TypeChecker.fromRuntime(Class);

  static final _allFilesInLib = Glob('lib/**.dart');

  static AssetId _allFileOutput(BuildStep buildStep) {
    return new AssetId(
      buildStep.inputId.package,
      p.join('lib', 'all_files.txt'),
    );
  }

  @override
  Map<String, List<String>> get buildExtensions {
    return const {
      r'$lib$': const ['all_files.txt'],
    };
  }

  @override
  Future<void> build(BuildStep buildStep) async {
    final files = <String>[];
    await for (AssetId input in buildStep.findAssets(_allFilesInLib)) {
      if (input.path.endsWith('.g.dart')) continue;

      final LibraryReader reader =
      LibraryReader(await buildStep.resolver.libraryFor(input));

      for (AnnotatedElement element in reader.annotatedWith(classAnnotation)) {
        print(element.element.name);
      }

      files.add(input.path);
    }
    final output = _allFileOutput(buildStep);
    return buildStep.writeAsString(output, files.join('\n'));
  }
}