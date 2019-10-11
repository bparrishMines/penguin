import 'package:penguin/penguin.dart';

import 'platform_builder.dart';
import '../info.dart';
import '../templates/template_creator.dart';

class IosBuilder extends PlatformBuilder {
  static const String _headerFile = r'''
''';

  @override
  Future<void> build(
    List<ClassInfo> classes,
    PlatformBuilderBuildStep buildStep,
  ) async {
    final IosTemplateCreator creator = IosTemplateCreator();
    buildStep.writeAsString('ChannelHandler+Generated.h', _headerFile);
    buildStep.writeAsString('ChannelHandler+Generated.m', creator.createFile());
  }

  @override
  Iterable<String> get filenames => <String>[
        'ChannelHandler+Generated.h',
        'ChannelHandler+Generated.m',
      ];

  @override
  Iterable<Type> get platformTypes => <Type>[IosPlatform];
}
