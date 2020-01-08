import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart' as path;
import 'package:penguin/penguin.dart';

import '../info.dart';
import '../templates/template_creator.dart';
import '../templates/templates.dart';
import 'penguin_builder.dart';

class DartMethodChannelBuilder extends PenguinBuilder {
  static const androidExtension = '.android.penguin.g.dart';
  static const iosExtension = '.ios.penguin.g.dart';

  @override
  Future<void> build(
    List<ClassInfo> libraryClasses,
    List<ClassInfo> importedClasses,
    PenguinBuilderBuildStep buildStep,
  ) async {
    final MethodChannelTemplateCreator creator = MethodChannelTemplateCreator();

    final bool hasAndroid = libraryClasses.any(
        (ClassInfo classInfo) => classInfo.aClass.platform is AndroidPlatform);
    final bool hasIos = libraryClasses
        .any((ClassInfo classInfo) => classInfo.aClass.platform is IosPlatform);

    await Future.wait<void>(<Future<void>>[
      if (hasAndroid)
        _buildAndroid(
          buildStep,
          creator,
          libraryClasses,
          importedClasses,
        ),
      if (hasIos)
        _buildIos(
          buildStep,
          creator,
          libraryClasses,
          importedClasses,
        ),
    ]);
  }

  Future<void> _buildAndroid(
    PenguinBuilderBuildStep buildStep,
    MethodChannelTemplateCreator creator,
    Iterable<ClassInfo> libraryClasses,
    Iterable<ClassInfo> importedClasses,
  ) {
    return buildStep.writeToAsset(
      buildStep.inputId.changeExtension(androidExtension),
      DartFormatter().format(
        creator.createFile(
          genericTypeHelpers: libraryClasses
              .followedBy(importedClasses)
              .where((ClassInfo classInfo) =>
                  classInfo.aClass.platform is AndroidPlatform)
              .map<String>(
                (ClassInfo classInfo) =>
                    creator.createGenericTypeHelper(className: classInfo.name),
              ),
          genericCreationHelpers: libraryClasses
              .followedBy(importedClasses)
              .where((ClassInfo classInfo) =>
                  classInfo.aClass.platform is AndroidPlatform)
              .map<String>(
                (ClassInfo classInfo) => creator.createGenericCreationHelper(
                    className: classInfo.name),
              ),
          filename:
              '${path.basenameWithoutExtension(buildStep.inputId.path)}.dart',
          classes: libraryClasses
              .where((ClassInfo classInfo) =>
                  classInfo.aClass.platform is AndroidPlatform)
              .map<String>(
                (ClassInfo classInfo) => creator.createClass(
                  wrapperInterface: 'AndroidWrapper',
                  platformViewClass: 'Context',
                  platformViewVariable: 'context',
                  typeParameters: classInfo.typeParameters.map<String>(
                    (TypeInfo info) => info.name,
                  ),
                  callbacks: classInfo.methods
                      .where(
                        (MethodInfo methodInfo) => methodInfo.method.callback,
                      )
                      .map<String>(
                        (MethodInfo methodInfo) => creator.createCallback(
                          methodName: methodInfo.name,
                          wrapperName:
                              (classInfo.aClass.platform as AndroidPlatform)
                                  .type
                                  .names
                                  .join(),
                          callbackChannelParams:
                              methodInfo.parameters.map<String>(
                            (ParameterInfo parameterInfo) =>
                                creator.createCallbackChannelParam(
                              getChannelType(parameterInfo.type),
                              className: getChannelType(parameterInfo.type) ==
                                      MethodChannelType.wrapper
                                  ? parameterInfo.type.name
                                  : null,
                              parameterName: parameterInfo.name,
                            ),
                          ),
                        ),
                      ),
                  constructors: classInfo.constructors.map<String>(
                    (ConstructorInfo constructorInfo) =>
                        creator.createConstructor(
                      parameters: constructorInfo.parameters.map<String>(
                        (ParameterInfo parameterInfo) =>
                            creator.createParameter(
                          getChannelType(parameterInfo.type),
                          parameterType: parameterInfo.type.name,
                          parameterName: parameterInfo.name,
                        ),
                      ),
                      methodCallParams: constructorInfo.parameters.map<String>(
                        (ParameterInfo parameterInfo) =>
                            creator.createMethodCallParam(
                          getChannelType(parameterInfo.type),
                          parameterName: parameterInfo.name,
                        ),
                      ),
                      constructorName: constructorInfo.name,
                      className: classInfo.name,
                      platformClassName:
                          (classInfo.aClass.platform as AndroidPlatform)
                              .type
                              .names
                              .join(),
                    ),
                  ),
                  methods: classInfo.methods.map<String>(
                    (MethodInfo methodInfo) => creator.createMethod(
                      methodInfo.isStatic,
                      getChannelType(methodInfo.returnType),
                      returnType: methodInfo.returnType.name,
                      parameters: methodInfo.parameters.map<String>(
                        (ParameterInfo parameterInfo) =>
                            creator.createParameter(
                          getChannelType(parameterInfo.type),
                          parameterType: parameterInfo.type.name,
                          parameterName: parameterInfo.name,
                        ),
                      ),
                      methodCallParams: methodInfo.parameters.map<String>(
                        (ParameterInfo parameterInfo) =>
                            creator.createMethodCallParam(
                          getChannelType(parameterInfo.type),
                          parameterName: parameterInfo.name,
                        ),
                      ),
                      platformClassName:
                          (classInfo.aClass.platform as AndroidPlatform)
                              .type
                              .names
                              .join(),
                      methodName: methodInfo.name,
                    ),
                  ),
                  fields: classInfo.fields.map<String>(
                    (FieldInfo fieldInfo) => creator.createField(
                      fieldInfo.isStatic,
                      platformClassName:
                          (classInfo.aClass.platform as AndroidPlatform)
                              .type
                              .names
                              .join(),
                      fieldName: fieldInfo.name,
                      fieldType: fieldInfo.type.name,
                      methodCallParam: creator.createMethodCallParam(
                        getChannelType(fieldInfo.type),
                        parameterName: fieldInfo.name,
                      ),
                      parameter: creator.createParameter(
                        getChannelType(fieldInfo.type),
                        parameterType: fieldInfo.type.name,
                        parameterName: fieldInfo.name,
                      ),
                    ),
                  ),
                  className: classInfo.name,
                  platformClassName:
                      (classInfo.aClass.platform as AndroidPlatform)
                          .type
                          .names
                          .join(),
                ),
              ),
        ),
      ),
    );
  }

  Future<void> _buildIos(
    PenguinBuilderBuildStep buildStep,
    MethodChannelTemplateCreator creator,
    Iterable<ClassInfo> libraryClasses,
    Iterable<ClassInfo> importedClasses,
  ) {
    return buildStep.writeToAsset(
      buildStep.inputId.changeExtension(iosExtension),
      DartFormatter().format(
        creator.createFile(
          genericTypeHelpers: libraryClasses
              .followedBy(importedClasses)
              .where((ClassInfo classInfo) =>
                  classInfo.aClass.platform is IosPlatform)
              .map<String>(
                (ClassInfo classInfo) =>
                    creator.createGenericTypeHelper(className: classInfo.name),
              ),
          genericCreationHelpers: libraryClasses
              .followedBy(importedClasses)
              .where((ClassInfo classInfo) =>
                  classInfo.aClass.platform is IosPlatform)
              .map<String>(
                (ClassInfo classInfo) => creator.createGenericCreationHelper(
                    className: classInfo.name),
              ),
          filename:
              '${path.basenameWithoutExtension(buildStep.inputId.path)}.dart',
          classes: libraryClasses
              .where((ClassInfo classInfo) =>
                  classInfo.aClass.platform is IosPlatform)
              .map<String>(
                (ClassInfo classInfo) => creator.createClass(
                  wrapperInterface: 'IosWrapper',
                  platformViewClass: 'CGRect',
                  platformViewVariable: 'cgRect',
                  typeParameters: classInfo.typeParameters.map<String>(
                    (TypeInfo info) => info.name,
                  ),
                  callbacks: classInfo.methods
                      .where(
                        (MethodInfo methodInfo) => methodInfo.method.callback,
                      )
                      .map<String>(
                        (MethodInfo methodInfo) => creator.createCallback(
                          methodName: methodInfo.name,
                          wrapperName:
                              (classInfo.aClass.platform as IosPlatform)
                                  .type
                                  .name,
                          callbackChannelParams:
                              methodInfo.parameters.map<String>(
                            (ParameterInfo parameterInfo) =>
                                creator.createCallbackChannelParam(
                              getChannelType(parameterInfo.type),
                              className: getChannelType(parameterInfo.type) ==
                                      MethodChannelType.wrapper
                                  ? parameterInfo.type.name
                                  : null,
                              parameterName: parameterInfo.name,
                            ),
                          ),
                        ),
                      ),
                  constructors: classInfo.constructors.map<String>(
                    (ConstructorInfo constructorInfo) =>
                        creator.createConstructor(
                      parameters: constructorInfo.parameters.map<String>(
                        (ParameterInfo parameterInfo) =>
                            creator.createParameter(
                          getChannelType(parameterInfo.type),
                          parameterType: parameterInfo.type.name,
                          parameterName: parameterInfo.name,
                        ),
                      ),
                      methodCallParams: constructorInfo.parameters.map<String>(
                        (ParameterInfo parameterInfo) =>
                            creator.createMethodCallParam(
                          getChannelType(parameterInfo.type),
                          parameterName: parameterInfo.name,
                        ),
                      ),
                      constructorName: constructorInfo.name,
                      className: classInfo.name,
                      platformClassName:
                          (classInfo.aClass.platform as IosPlatform).type.name,
                    ),
                  ),
                  methods: classInfo.methods.map<String>(
                    (MethodInfo methodInfo) => creator.createMethod(
                      methodInfo.isStatic,
                      getChannelType(methodInfo.returnType),
                      returnType: methodInfo.returnType.name,
                      parameters: methodInfo.parameters.map<String>(
                        (ParameterInfo parameterInfo) =>
                            creator.createParameter(
                          getChannelType(parameterInfo.type),
                          parameterType: parameterInfo.type.name,
                          parameterName: parameterInfo.name,
                        ),
                      ),
                      methodCallParams: methodInfo.parameters.map<String>(
                        (ParameterInfo parameterInfo) =>
                            creator.createMethodCallParam(
                          getChannelType(parameterInfo.type),
                          parameterName: parameterInfo.name,
                        ),
                      ),
                      platformClassName:
                          (classInfo.aClass.platform as IosPlatform).type.name,
                      methodName: methodInfo.name,
                    ),
                  ),
                  fields: classInfo.fields.map<String>(
                    (FieldInfo fieldInfo) => creator.createField(
                      fieldInfo.isStatic,
                      platformClassName:
                          (classInfo.aClass.platform as IosPlatform).type.name,
                      fieldName: fieldInfo.name,
                      fieldType: fieldInfo.type.name,
                      methodCallParam: creator.createMethodCallParam(
                        getChannelType(fieldInfo.type),
                        parameterName: fieldInfo.name,
                      ),
                      parameter: creator.createParameter(
                        getChannelType(fieldInfo.type),
                        parameterType: fieldInfo.type.name,
                        parameterName: fieldInfo.name,
                      ),
                    ),
                  ),
                  className: classInfo.name,
                  platformClassName:
                      (classInfo.aClass.platform as IosPlatform).type.name,
                ),
              ),
        ),
      ),
    );
  }

  @override
  Iterable<String> get filenames => <String>[
        androidExtension,
        iosExtension,
      ];

  Iterable<Type> get platformTypes => <Type>[AndroidPlatform, IosPlatform];
}
