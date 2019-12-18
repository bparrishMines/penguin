import 'package:penguin/penguin.dart';

import 'platform_builder.dart';
import '../info.dart';
import '../templates/templates.dart';
import '../templates/template_creator.dart';

class IosBuilder extends PlatformBuilder {
  static const String _headerFile = r'''
#import <Flutter/Flutter.h>
%%IMPORTS%%
%%IMPORT%%
#import __classPackage__
%%IMPORT%%
%%IMPORTS%%

@interface Wrapper : NSObject<FlutterPlatformView>
@end

@interface WrapperManager : NSObject
- (void)addAllocatedWrapper:(Wrapper *_Nonnull)wrapper;
- (void)removeAllocatedWrapper:(NSString *_Nonnull)uniqueId;
@end

@interface MethodCallHandler : NSObject
- (void)onMethodCall:(FlutterMethodCall *_Nonnull)call result:(FlutterResult _Nonnull)result;
@end

@interface ChannelHandler : NSObject
- (instancetype _Nonnull)initWithCallbackChannel:(FlutterMethodChannel *_Nonnull)callbackChannel;
@property WrapperManager *_Nonnull wrapperManager;
@property MethodCallHandler *_Nonnull methodCallHandler;
@property id<FlutterPlatformViewFactory> _Nonnull viewFactory;
@property FlutterMethodChannel *_Nonnull callbackChannel;
@end

%%CLASSES%%
%%CLASS%%
@interface $__platformClassName__ : Wrapper
- (instancetype _Nonnull)initWithWrapperManager:(WrapperManager *_Nonnull)wrapperManager
                                uniqueId:(NSString *_Nonnull)uniqueId
                                value:(
                                %%VALUETYPES%%
                                %%VALUETYPE structure:class%%
                                __platformClassName__ *
                                %%VALUETYPE structure:class%%
                                %%VALUETYPE structure:struct%%
                                NSValue *
                                %%VALUETYPE structure:struct%%
                                %%VALUETYPE structure:protocol%%
                                id<__platformClassName__>
                                %%VALUETYPE structure:protocol%%
                                %%VALUETYPES%%
                                _Nullable)value;
@end
%%CLASS%%
%%CLASSES%%
''';

  @override
  Future<void> build(
    List<ClassInfo> classes,
    PlatformBuilderBuildStep buildStep,
  ) async {
    if (classes.isEmpty) return;

    final IosTemplateCreator creator = IosTemplateCreator();
    await Future.wait<void>(<Future<void>>[
      buildStep.writeAsString(
        'ChannelHandler+Generated.h',
        IosTemplateCreator.createHeaderFile(
          headerTemplate: _headerFile,
          classPackages: classes
              .where((ClassInfo classInfo) =>
                  (classInfo.aClass.platform as IosPlatform).type.import !=
                  null)
              .map<String>(
                (ClassInfo classInfo) =>
                    (classInfo.aClass.platform as IosPlatform).type.import,
              ),
          classes: classes.map<String>(
            (ClassInfo classInfo) => IosTemplateCreator.createHeaderClass(
              _getStructure(classInfo),
              headerTemplate: _headerFile,
              platformClassName:
                  (classInfo.aClass.platform as IosPlatform).type.name,
            ),
          ),
        ),
      ),
      buildStep.writeAsString(
        'ChannelHandler+Generated.m',
        creator.createFile(
          structs: classes
              .where(
                (ClassInfo classInfo) =>
                    (classInfo.aClass.platform as IosPlatform).type.isStruct,
              )
              .map<String>(
                (ClassInfo classInfo) => creator.createStruct(
                  platformClassName:
                      (classInfo.aClass.platform as IosPlatform).type.name,
                ),
              ),
          staticRedirects: <String>[
            ...classes.expand<String>(
              (ClassInfo classInfo) => classInfo.constructors.map<String>(
                (ConstructorInfo constructorInfo) =>
                    creator.createStaticRedirect(
                  ClassMemberType.constructor,
                  constructorName: constructorInfo.name,
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
              _getStructure(classInfo),
              callbacks: classInfo.methods
                  .where((MethodInfo methodInfo) => methodInfo.method.callback)
                  .map<String>(
                    (MethodInfo methodInfo) => creator.createCallback(
                        platformClassName:
                            (classInfo.aClass.platform as IosPlatform)
                                .type
                                .name,
                        methodName: methodInfo.name),
                  ),
              callbackSwizzles: classInfo.methods
                  .where((MethodInfo methodInfo) => methodInfo.method.callback)
                  .map<String>((MethodInfo methodInfo) => creator
                      .createCallbackSwizzle(methodName: methodInfo.name)),
              staticMethodCalls: <String>[
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
                  _getStructure(classInfo),
                  constructorName: constructorInfo.name,
                  constructorSignature: constructorInfo.name,
                  parameters: constructorInfo.parameters.map<String>(
                    (ParameterInfo parameterInfo) => creator.createParameter(
                      getChannelType(parameterInfo.type),
                      parameterType:
                          _getPlatformClassName(parameterInfo.type, classes),
                      parameterName: parameterInfo.name,
                      primitiveConvertMethod: _getPrimitiveConvertMethod(
                        parameterInfo.type,
                      ),
                    ),
                  ),
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
                      parameterType:
                          _getPlatformClassName(parameterInfo.type, classes),
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
              fields: classInfo.fields.map<String>(
                (FieldInfo fieldInfo) => creator.createField(
                  getChannelType(fieldInfo.type),
                  isStatic: fieldInfo.isStatic,
                  isMutable: fieldInfo.isMutable,
                  fieldName: fieldInfo.name,
                  parameter: creator.createParameter(
                      getChannelType(fieldInfo.type),
                      parameterType:
                          _getPlatformClassName(fieldInfo.type, classes),
                      primitiveConvertMethod:
                          _getPrimitiveConvertMethod(fieldInfo.type),
                      parameterName: fieldInfo.name),
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
    } else if (info.isNativeInt64) {
      return 'longValue';
    }

    return null;
  }

  String _getPlatformClassName(TypeInfo info, List<ClassInfo> classes) {
    if (!info.isWrapper) return 'NSObject'; // Never used.
    return (classes
            .firstWhere((ClassInfo classInfo) => classInfo.name == info.name)
            .aClass
            .platform as IosPlatform)
        .type
        .name;
  }

  Structure _getStructure(ClassInfo classInfo) {
    final IosType type = (classInfo.aClass.platform as IosPlatform).type;
    if (type.isStruct) return Structure.struct;
    if (classInfo.methods.any((MethodInfo info) => info.method.callback)) {
      return Structure.protocol;
    }
    return Structure.$class;
  }

  @override
  Iterable<String> get filenames => <String>[
        'ChannelHandler+Generated.h',
        'ChannelHandler+Generated.m',
      ];

  @override
  Iterable<Type> get platformTypes => <Type>[IosPlatform];
}
