import 'dart:async';

import 'package:build/build.dart';

class ReferenceGenerator implements Builder {
  @override
  FutureOr<void> build(BuildStep buildStep) {
    final AssetId newFile = buildStep.inputId.changeExtension('.g.dart');
    return buildStep.writeAsString(newFile, 'void main() {print(\'hi\');}');
  }

  @override
  Map<String, List<String>> get buildExtensions => <String, List<String>>{
        '.dart': <String>['.g.dart'],
      };
}
