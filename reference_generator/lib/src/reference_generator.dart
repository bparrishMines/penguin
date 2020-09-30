import 'dart:async';

import 'package:build/build.dart';
//import 'package:source_gen/source_gen.dart';
import 'package:path/path.dart' as path;

//import 'ast/ast.dart';

abstract class BaseBuilder implements Builder {
 // String get fileExtension;

  // @override
  // FutureOr<void> build(BuildStep buildStep) {
  //   gen
  // }

  // String generateCode(LibraryNode libraryNode) {
  //
  // }
}

class DartBuilder implements Builder {
  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final AssetId newFile = buildStep.inputId.changeExtension('.g.dart');

    // final Resolver resolver = buildStep.resolver;
    // if (!await resolver.isLibrary(buildStep.inputId)) return null;
    //
    // final LibraryReader reader = LibraryReader(await buildStep.inputLibrary);

    await buildStep.writeAsString(newFile, 'void main() {print(\'hi\');}');
  }

  @override
  Map<String, List<String>> get buildExtensions => <String, List<String>>{
        '.dart': <String>['.g.dart'],
      };
}

class JavaBuilder implements Builder {
  @override
  FutureOr<void> build(BuildStep buildStep) {
    throw UnimplementedError();
  }

  @override
  Map<String, List<String>> get buildExtensions => <String, List<String>>{
        '.dart': <String>['.java'],
      };
}
