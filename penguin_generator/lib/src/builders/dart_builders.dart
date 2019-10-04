import 'package:dart_style/dart_style.dart';
import 'package:penguin/penguin.dart';
import 'package:penguin_generator/src/info.dart';

import '../templates.dart';
import 'platform_builder.dart';

class DartMethodChannelBuilder extends PlatformBuilder {
  @override
  Future<void> build(
    List<ClassInfo> classes,
    PlatformBuilderBuildStep buildStep,
  ) {
    final MethodChannelTemplateCreator creator = MethodChannelTemplateCreator();
    return buildStep.writeAsString(
      'android.penguin.g.dart',
      DartFormatter().format(
        creator.createFile(
          classes: classes
              .where((ClassInfo classInfo) =>
                  classInfo.aClass.platform is AndroidPlatform)
              .map<String>(
                (ClassInfo classInfo) => creator.createClass(
                  typeParameters: classInfo.typeParameters.map<String>(
                    (TypeInfo info) => info.name,
                  ),
                  constructors: classInfo.constructors.map<String>(
                    (ConstructorInfo constructorInfo) =>
                        creator.createConstructor(
                      className: classInfo.name,
                      platformClassName:
                          (classInfo.aClass.platform as AndroidPlatform)
                              .type
                              .name,
                    ),
                  ),
                  methods: classInfo.methods.map<String>(
                    (MethodInfo methodInfo) => creator.createMethod(
                      methodInfo.isStatic,
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
                              .name,
                      methodName: methodInfo.name,
                    ),
                  ),
                  fields: classInfo.fields.map<String>(
                    (FieldInfo fieldInfo) => creator.createField(
                      fieldInfo.isStatic,
                      platformClassName:
                          (classInfo.aClass.platform as AndroidPlatform)
                              .type
                              .name,
                      fieldName: fieldInfo.name,
                      fieldType: fieldInfo.type.name,
                      fieldSetterParam: creator.createFieldSetterParam(
                        getChannelType(fieldInfo.type),
                        fieldName: fieldInfo.name,
                      ),
                      fieldSetter: creator.createFieldSetter(
                        getChannelType(fieldInfo.type),
                        fieldType: fieldInfo.type.name,
                        fieldName: fieldInfo.name,
                      ),
                    ),
                  ),
                  className: classInfo.name,
                  platformClassName:
                      (classInfo.aClass.platform as AndroidPlatform).type.name,
                ),
              ),
        ),
      ),
    );
  }

  @override
  Iterable<String> get filenames => <String>[
        'android.penguin.g.dart',
        'ios.penguin.g.dart',
      ];

  Iterable<Type> get platformTypes => <Type>[AndroidPlatform];
}
