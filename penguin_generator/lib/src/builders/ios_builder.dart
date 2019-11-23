import 'package:penguin/penguin.dart';

import 'platform_builder.dart';
import '../info.dart';
import '../templates/templates.dart';
import '../templates/template_creator.dart';

class IosBuilder extends PlatformBuilder {
  static const String _headerFile = r'''
#import <Flutter/Flutter.h>

@interface Wrapper : NSObject
@end

@interface WrapperManager : NSObject
- (void)addAllocatedWrapper:(Wrapper *)wrapper;
- (void)removeAllocatedWrapper:(NSString *)uniqueId;
@end

@interface MethodCallHandler : NSObject
- (void)onMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result;
@end

@interface ChannelHandler : NSObject
@property WrapperManager *wrapperManager;
@property MethodCallHandler *methodCallHandler;
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
          staticRedirects: <String>[
            ...classes.expand<String>(
              (ClassInfo classInfo) => classInfo.constructors.map<String>(
                (ConstructorInfo constructorInfo) =>
                    creator.createStaticRedirect(
                  ClassMemberType.constructor,
                  platformClassName:
                      (classInfo.aClass.platform as IosPlatform).type.name,
                  methodName: '',
                ),
              ),
            ),
            ...classes.expand<String>(
              (ClassInfo classInfo) => classInfo.methods
                  .where((MethodInfo methodInfo) => methodInfo.isStatic)
                  .map<String>(
                    (MethodInfo methodInfo) => creator.createStaticRedirect(
                      ClassMemberType.method,
                      platformClassName:
                          (classInfo.aClass.platform as IosPlatform).type.name,
                      methodName: methodInfo.name,
                    ),
                  ),
            ),
            ...classes.expand<String>(
              (ClassInfo classInfo) => classInfo.fields
                  .where((FieldInfo fieldInfo) => fieldInfo.isStatic)
                  .map<String>(
                    (FieldInfo fieldInfo) => creator.createStaticRedirect(
                      ClassMemberType.field,
                      platformClassName:
                          (classInfo.aClass.platform as IosPlatform).type.name,
                      fieldName: fieldInfo.name,
                    ),
                  ),
            ),
          ],
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
                      (MethodInfo methodInfo) => creator.createStaticMethodCall(
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
                (ConstructorInfo constructorInfo) => creator.createConstructor(
                  platformClassName:
                      (classInfo.aClass.platform as IosPlatform).type.name,
                ),
              ),
              methods: classInfo.methods.map<String>(
                (MethodInfo methodInfo) => creator.createMethod(
                  getChannelType(methodInfo.returnType),
                  methodInfo.isStatic,
                  platformClassName:
                      (classInfo.aClass.platform as IosPlatform).type.name,
                  parameters: methodInfo.parameters.map<String>(
                    (ParameterInfo parameterInfo) => creator.createParameter(
                      getChannelType(parameterInfo.type),
                      parameterName: parameterInfo.name,
                      primitiveConvertMethod: _getPrimitiveConvertMethod(
                        parameterInfo.type,
                      ),
                    ),
                  ),
                  returnType: methodInfo.returnType.name,
                  methodName: methodInfo.name,
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
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  String _getPrimitiveConvertMethod(TypeInfo info) {
    if (info.isNativeInt32) {
      return 'intValue';
    }

    return null;
  }

  @override
  Iterable<String> get filenames => <String>[
        'ChannelHandler+Generated.h',
        'ChannelHandler+Generated.m',
      ];

  @override
  Iterable<Type> get platformTypes => <Type>[IosPlatform];
}
