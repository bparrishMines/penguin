import 'dart:io';

import 'package:penguin/penguin.dart';
import 'package:penguin_generator/src/info.dart';
import 'package:pubspec_parse/pubspec_parse.dart';

import 'platform_builder.dart';
import '../templates/templates.dart';
import '../templates/template_creator.dart';

class AndroidBuilder extends PlatformBuilder {
  static String _androidPackageCache;

  @override
  Future<void> build(
    List<ClassInfo> classes,
    PlatformBuilderBuildStep buildStep,
  ) {
    if (classes.isEmpty) return Future<void>.value();

    final AndroidTemplateCreator creator = AndroidTemplateCreator();
    return buildStep.writeAsString(
      'ChannelGenerated.java',
      creator.createFile(
        imports: classes
            .where((ClassInfo classInfo) =>
                (classInfo.aClass.platform as AndroidPlatform).type.package !=
                _androidPackage)
            .map<String>(
              (ClassInfo classInfo) => creator.createImport(
                classPackage:
                    (classInfo.aClass.platform as AndroidPlatform).type.package,
                platformClassName:
                    (classInfo.aClass.platform as AndroidPlatform)
                        .type
                        .names
                        .first,
              ),
            )
            .toSet(),
        classes: classes.map<String>(
          (ClassInfo classInfo) => creator.createClass(
            api: classInfo.aClass.androidApi?.api?.toString(),
            staticMethodCalls: <String>[
              ...classInfo.constructors.map<String>(
                (ConstructorInfo constructorInfo) =>
                    creator.createStaticMethodCall(
                  ClassMemberType.constructor,
                  wrapperName: (classInfo.aClass.platform as AndroidPlatform)
                      .type
                      .names
                      .join(),
                  constructorName: constructorInfo.name,
                ),
              ),
              ...classInfo.methods
                  .where((MethodInfo methodInfo) => methodInfo.isStatic)
                  .map<String>(
                    (MethodInfo methodInfo) => creator.createStaticMethodCall(
                      ClassMemberType.method,
                      wrapperName:
                          (classInfo.aClass.platform as AndroidPlatform)
                              .type
                              .names
                              .join(),
                      methodName: methodInfo.name,
                    ),
                  ),
              ...classInfo.fields
                  .where((FieldInfo fieldInfo) => fieldInfo.isStatic)
                  .map<String>(
                    (FieldInfo fieldInfo) => creator.createStaticMethodCall(
                      ClassMemberType.field,
                      wrapperName:
                          (classInfo.aClass.platform as AndroidPlatform)
                              .type
                              .names
                              .join(),
                      fieldName: fieldInfo.name,
                    ),
                  ),
            ],
            constructors: classInfo.constructors.map<String>(
              (ConstructorInfo constructorInfo) => creator.createConstructor(
                constructorName: constructorInfo.name,
                parameters: constructorInfo.parameters.map<String>(
                  (ParameterInfo parameterInfo) => creator.createParameter(
                    getChannelType(parameterInfo.type),
                    parameterType: _convertType(parameterInfo.type, classes),
                    parameterName: parameterInfo.name,
                  ),
                ),
                wrapperName: (classInfo.aClass.platform as AndroidPlatform)
                    .type
                    .names
                    .join(),
                platformClassName:
                    (classInfo.aClass.platform as AndroidPlatform)
                        .type
                        .names
                        .join('.'),
                callbacks: classInfo.methods
                    .where(
                      (MethodInfo methodInfo) => methodInfo.method.callback,
                    )
                    .map<String>(
                      (MethodInfo methodInfo) => creator.createCallback(
                        methodName: methodInfo.name,
                        callbackParams: methodInfo.parameters.map<String>(
                          (ParameterInfo parameterInfo) =>
                              creator.createCallbackParam(
                            getChannelType(parameterInfo.type),
                            wrapperName: getChannelType(parameterInfo.type) !=
                                    MethodChannelType.wrapper
                                ? null
                                : _convertType(parameterInfo.type, classes)
                                    .replaceAll(('.'), ''),
                            parameterName: parameterInfo.name,
                          ),
                        ),
                      ),
                    ),
              ),
            ),
            methods: classInfo.methods.map<String>(
              (MethodInfo methodInfo) => creator.createMethod(
                getChannelType(methodInfo.returnType),
                methodInfo.isStatic,
                platformClassName:
                    (classInfo.aClass.platform as AndroidPlatform)
                        .type
                        .names
                        .join('.'),
                package: _androidPackage,
                parameters: methodInfo.parameters.map<String>(
                  (ParameterInfo parameterInfo) => creator.createParameter(
                    getChannelType(parameterInfo.type),
                    parameterType: _convertType(parameterInfo.type, classes),
                    parameterName: parameterInfo.name,
                  ),
                ),
                returnType: _convertType(methodInfo.returnType, classes),
                methodName: methodInfo.name,
              ),
            ),
            fields: classInfo.fields.map<String>(
              (FieldInfo fieldInfo) => creator.createField(
                getChannelType(fieldInfo.type),
                isStatic: fieldInfo.isStatic,
                isMutable: fieldInfo.isMutable,
                fieldType: _convertType(fieldInfo.type, classes),
                fieldName: fieldInfo.name,
                package: _androidPackage,
                platformClassName:
                    (classInfo.aClass.platform as AndroidPlatform)
                        .type
                        .names
                        .join('.'),
              ),
            ),
            methodCalls: <String>[
              ...classInfo.methods
                  .where((MethodInfo methodInfo) => !methodInfo.isStatic)
                  .map<String>(
                    (MethodInfo methodInfo) => creator.createMethodCall(
                      ClassMemberType.method,
                      wrapperName:
                          (classInfo.aClass.platform as AndroidPlatform)
                              .type
                              .names
                              .join(),
                      methodName: methodInfo.name,
                    ),
                  ),
              ...classInfo.fields
                  .where((FieldInfo fieldInfo) => !fieldInfo.isStatic)
                  .map<String>(
                    (FieldInfo fieldInfo) => creator.createMethodCall(
                      ClassMemberType.field,
                      wrapperName:
                          (classInfo.aClass.platform as AndroidPlatform)
                              .type
                              .names
                              .join(),
                      fieldName: fieldInfo.name,
                    ),
                  ),
            ],
            platformClassName: (classInfo.aClass.platform as AndroidPlatform)
                .type
                .names
                .join('.'),
            wrapperName: (classInfo.aClass.platform as AndroidPlatform)
                .type
                .names
                .join(),
          ),
        ),
        staticRedirects: <String>[
          ...classes.expand<String>(
            (ClassInfo classInfo) => classInfo.constructors.map<String>(
              (ConstructorInfo constructorInfo) => creator.createStaticRedirect(
                ClassMemberType.constructor,
                constructorName: constructorInfo.name,
                wrapperName: (classInfo.aClass.platform as AndroidPlatform)
                    .type
                    .names
                    .join(),
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
                    wrapperName: (classInfo.aClass.platform as AndroidPlatform)
                        .type
                        .names
                        .join(),
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
                    wrapperName: (classInfo.aClass.platform as AndroidPlatform)
                        .type
                        .names
                        .join(),
                    fieldName: fieldInfo.name,
                  ),
                ),
          ),
        ],
        package: _androidPackage,
      ),
    );
  }

  // TODO: handle longs (Actually.... this should be an override)
  String _convertType(TypeInfo info, [List<ClassInfo> classes]) {
    if (info.isVoid) {
      return 'void';
    } else if (info.isDynamic || info.isObject) {
      return 'Object';
    } else if (info.isString) {
      return 'String';
    } else if (info.isInt) {
      return 'Integer';
    } else if (info.isDouble) {
      return 'Double';
    } else if (info.isNum) {
      return 'Number';
    } else if (info.isBool) {
      return 'Boolean';
    } else if (info.isList &&
        getChannelType(info) == MethodChannelType.supported) {
      return 'ArrayList<${_convertType(info.typeArguments.first)}>';
    } else if (info.isMap &&
        getChannelType(info) == MethodChannelType.supported) {
      final List<TypeInfo> infos = info.typeArguments.toList();
      return 'HashMap<${_convertType(infos[0])}, ${_convertType(infos[1])}>';
    } else if (info.isWrapper) {
      return (classes
              .firstWhere((ClassInfo classInfo) => classInfo.name == info.name)
              .aClass
              .platform as AndroidPlatform)
          .type
          .names
          .join('.');
    } else if (info.isTypeParameter) {
      return 'Object';
    }

    throw ArgumentError.value(
      info.toString(),
      'info',
      'Can\'t convert to Android type for info',
    );
  }

  static String get _androidPackage {
    if (_androidPackageCache != null) return _androidPackageCache;

    final File pubspecFile = File('pubspec.yaml');
    final Pubspec pubspec = Pubspec.parse(pubspecFile.readAsStringSync());
    return _androidPackageCache = pubspec.flutter['plugin']['androidPackage'];
  }

  @override
  Iterable<String> get filenames => <String>['ChannelGenerated.java'];

  Iterable<Type> get platformTypes => <Type>[AndroidPlatform];
}
