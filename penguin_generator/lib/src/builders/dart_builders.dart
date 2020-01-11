import 'package:dart_style/dart_style.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as path;
import 'package:penguin/penguin.dart';

import '../info.dart';
import '../templates/template_creator.dart';
import 'penguin_builder.dart';

enum _BuilderPlatform { android, ios }

class DartMethodChannelBuilder extends PenguinBuilder {
  static const androidExtension = '.android.penguin.g.dart';
  static const iosExtension = '.ios.penguin.g.dart';

  @override
  Iterable<String> get filenames => <String>[
        androidExtension,
        iosExtension,
      ];

  Iterable<Type> get platformTypes => <Type>[AndroidPlatform, IosPlatform];

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
        _build(
          platform: _BuilderPlatform.android,
          buildStep: buildStep,
          creator: creator,
          libraryClasses: libraryClasses,
          importedClasses: importedClasses,
        ),
      if (hasIos)
        _build(
          platform: _BuilderPlatform.ios,
          buildStep: buildStep,
          creator: creator,
          libraryClasses: libraryClasses,
          importedClasses: importedClasses,
        ),
    ]);
  }

  Future<void> _build({
    @required _BuilderPlatform platform,
    @required PenguinBuilderBuildStep buildStep,
    @required MethodChannelTemplateCreator creator,
    @required Iterable<ClassInfo> libraryClasses,
    @required Iterable<ClassInfo> importedClasses,
  }) {
    final String content = creator.createFile(
      filename: '${path.basenameWithoutExtension(buildStep.inputId.path)}.dart',
      classes: libraryClasses.where(_whereClassInfoFor(platform)).map<String>(
            (ClassInfo classInfo) => creator.createClass(
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
                      callbackChannelParams: methodInfo.parameters.map<String>(
                        (ParameterInfo parameterInfo) =>
                            creator.createCallbackChannelParam(
                          getChannelType(parameterInfo.type),
                          parameterClassName: parameterInfo.type.name,
                          parameterName: parameterInfo.name,
                        ),
                      ),
                    ),
                  ),
              constructors: classInfo.constructors.map<String>(
                (ConstructorInfo constructorInfo) => creator.createConstructor(
                  parameters: constructorInfo.parameters.map<String>(
                    (ParameterInfo parameterInfo) => creator.createParameter(
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
                ),
              ),
              methods: classInfo.methods.map<String>(
                (MethodInfo methodInfo) => creator.createMethod(
                  methodInfo.isStatic,
                  getChannelType(methodInfo.returnType),
                  returnType: methodInfo.returnType.name,
                  parameters: methodInfo.parameters.map<String>(
                    (ParameterInfo parameterInfo) => creator.createParameter(
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
                  methodName: methodInfo.name,
                ),
              ),
              fields: classInfo.fields.map<String>(
                (FieldInfo fieldInfo) => creator.createField(
                  fieldInfo.isStatic,
                  fieldName: fieldInfo.name,
                  fieldType: fieldInfo.type.name,
                  methodCallParam: creator.createMethodCallParam(
                    getChannelType(fieldInfo.type),
                    parameterName: fieldInfo.name,
                  ),
                  parameter: creator.createParameter(
                    parameterType: fieldInfo.type.name,
                    parameterName: fieldInfo.name,
                  ),
                ),
              ),
              className: classInfo.name,
              platformClassName: _platformClassNameFor(classInfo, platform),
            ),
          ),
      genericPlatformTypeNameHelpers: libraryClasses
          .followedBy(importedClasses)
          .where(_whereClassInfoFor(platform))
          .map<String>(
            (ClassInfo classInfo) =>
                creator.createGenericPlatformTypeNameHelper(
              className: classInfo.name,
              platformClassName: _platformClassNameFor(classInfo, platform),
            ),
          ),
      genericTypeHelpers: libraryClasses
          .followedBy(importedClasses)
          .where(_whereClassInfoFor(platform))
          .map<String>(
            (ClassInfo classInfo) =>
                creator.createGenericTypeHelper(className: classInfo.name),
          ),
    );
    return buildStep.writeToAsset(
      buildStep.inputId.changeExtension(_fileExtensionFor(platform)),
      DartFormatter().format(content),
    );
  }

  bool Function(ClassInfo) _whereClassInfoFor(_BuilderPlatform platform) {
    switch (platform) {
      case _BuilderPlatform.android:
        return (ClassInfo classInfo) =>
            classInfo.aClass.platform is AndroidPlatform;
      case _BuilderPlatform.ios:
        return (ClassInfo classInfo) =>
            classInfo.aClass.platform is IosPlatform;
    }

    return null; // Unreachable.
  }

  String _platformClassNameFor(ClassInfo classInfo, _BuilderPlatform platform) {
    switch (platform) {
      case _BuilderPlatform.android:
        return (classInfo.aClass.platform as AndroidPlatform).type.names.join();
      case _BuilderPlatform.ios:
        return (classInfo.aClass.platform as IosPlatform).type.name;
    }

    return null; // Unreachable.
  }

  String _fileExtensionFor(_BuilderPlatform platform) {
    switch (platform) {
      case _BuilderPlatform.android:
        return androidExtension;
      case _BuilderPlatform.ios:
        return iosExtension;
    }

    return null; // Unreachable.
  }
}
