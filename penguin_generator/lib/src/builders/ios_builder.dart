import 'package:penguin/penguin.dart';

import 'platform_builder.dart';
import '../info.dart';
import '../templates/templates.dart';
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
          classes: classes.map<String>(
            (ClassInfo classInfo) => creator.createClass(
                staticMethodCalls: <String>[
                  ...classInfo.constructors.map<String>(
                    (ConstructorInfo constructorInfo) =>
                        creator.createStaticMethodCall(
                      ClassMemberType.constructor,
                      platformClassName:
                          (classInfo.aClass.platform as IosPlatform).type.name,
                    ),
                  ),
                  ...classInfo.methods
                      .where((MethodInfo methodInfo) => methodInfo.isStatic)
                      .map<String>(
                        (MethodInfo methodInfo) =>
                            creator.createStaticMethodCall(
                          ClassMemberType.method,
                          platformClassName:
                              (classInfo.aClass.platform as IosPlatform)
                                  .type
                                  .name,
                          methodName: methodInfo.name,
                        ),
                      ),
                  ...classInfo.fields
                      .where((FieldInfo fieldInfo) => fieldInfo.isStatic)
                      .map<String>(
                        (FieldInfo fieldInfo) => creator.createStaticMethodCall(
                          ClassMemberType.field,
                          platformClassName:
                              (classInfo.aClass.platform as IosPlatform)
                                  .type
                                  .name,
                          fieldName: fieldInfo.name,
                        ),
                      ),
                ],
                constructors: classInfo.constructors.map<String>(
                  (ConstructorInfo constructorInfo) =>
                      creator.createConstructor(
                    platformClassName:
                        (classInfo.aClass.platform as IosPlatform).type.name,
                  ),
                ),
                platformClassName:
                    (classInfo.aClass.platform as IosPlatform).type.name,
                methodCalls: <String>[
                  ...classInfo.methods
                      .where((MethodInfo methodInfo) => !methodInfo.isStatic)
                      .map<String>(
                        (MethodInfo methodInfo) => creator.createMethodCall(
                          ClassMemberType.method,
                          platformClassName:
                              (classInfo.aClass.platform as IosPlatform)
                                  .type
                                  .name,
                          methodName: methodInfo.name,
                        ),
                      ),
                  ...classInfo.fields
                      .where((FieldInfo fieldInfo) => !fieldInfo.isStatic)
                      .map<String>(
                        (FieldInfo fieldInfo) => creator.createMethodCall(
                          ClassMemberType.field,
                          platformClassName:
                              (classInfo.aClass.platform as IosPlatform)
                                  .type
                                  .name,
                          fieldName: fieldInfo.name,
                        ),
                      ),
                ]),
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
