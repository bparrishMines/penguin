import 'package:penguin/penguin.dart';

import 'platform_builder.dart';
import '../info.dart';
import '../templates/template_creator.dart';

class IosBuilder extends PlatformBuilder {
  static const String _headerFile = r'''
#import <Flutter/Flutter.h>

@interface ChannelHandler : NSObject
- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result;
@end
''';

  @override
  Future<void> build(
    List<ClassInfo> classes,
    PlatformBuilderBuildStep buildStep,
  ) async {
    if (classes.isEmpty) return;

    final IosTemplateCreator creator = IosTemplateCreator();
    await Future.wait<void>(<Future<void>>[
      buildStep.writeAsString('ChannelHandler+Generated.h', _headerFile),
      buildStep.writeAsString(
        'ChannelHandler+Generated.m',
        creator.createFile(
          imports: classes
              .where((ClassInfo classInfo) =>
                  (classInfo.aClass.platform as IosPlatform).type.import !=
                  null)
              .map<String>(
                (ClassInfo classInfo) => creator.createImport(
                  classPackage:
                      (classInfo.aClass.platform as IosPlatform).type.import,
                ),
              ),
        ),
      ),
    ]);
  }

  @override
  Iterable<String> get filenames => <String>[
        'ChannelHandler+Generated.h',
        'ChannelHandler+Generated.m',
      ];

  @override
  Iterable<Type> get platformTypes => <Type>[IosPlatform];
}
