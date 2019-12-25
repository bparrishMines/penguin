import 'dart:io';

import 'package:penguin/penguin.dart';
import 'package:penguin_generator/src/info.dart';
import 'package:pubspec_parse/pubspec_parse.dart';

import 'platform_builder.dart';
import '../templates/templates.dart';
import '../templates/template_creator.dart';

class AndroidBuilder extends PenguinBuilder {
  static String _androidPackageCache;

  @override
  Future<void> build(
    List<ClassInfo> libraryClasses,
    List<ClassInfo> importedClasses,
    PenguinBuilderBuildStep buildStep,
  ) {
    if (libraryClasses.isEmpty) return Future<void>.value();

    final AndroidTemplateCreator creator = AndroidTemplateCreator();
    final List<ClassInfo> allClasses =
        libraryClasses.followedBy(importedClasses).toList();
    return buildStep.writeToLib(
      'ChannelGenerated.java',
      creator.createFile(
        imports: allClasses
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
        classes: allClasses.map<String>(
          (ClassInfo classInfo) => creator.createClass(
            api: classInfo.aClass.androidApi?.api?.toString(),
            staticMethodCalls: <String>[
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
                    primitiveConvertMethod: _getPrimitiveConvertMethod(
                      parameterInfo.type,
                    ),
                    parameterType:
                        _convertType(parameterInfo.type, classes: allClasses),
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
                        wrapperName:
                            (classInfo.aClass.platform as AndroidPlatform)
                                .type
                                .names
                                .join(),
                        callbackParams: methodInfo.parameters.map<String>(
                          (ParameterInfo parameterInfo) =>
                              creator.createCallbackParam(
                            parameterName: parameterInfo.name,
                            parameterType: _convertType(
                              parameterInfo.type,
                              classes: allClasses,
                              ignorePrimitives: false,
                            ),
                          ),
                        ),
                        callbackChannelParams:
                            methodInfo.parameters.map<String>(
                          (ParameterInfo parameterInfo) =>
                              creator.createCallbackChannelParam(
                            getChannelType(parameterInfo.type),
                            wrapperName: getChannelType(parameterInfo.type) !=
                                    MethodChannelType.wrapper
                                ? null
                                : _convertType(parameterInfo.type,
                                        classes: allClasses)
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
                    primitiveConvertMethod: _getPrimitiveConvertMethod(
                      parameterInfo.type,
                    ),
                    parameterType:
                        _convertType(parameterInfo.type, classes: allClasses),
                    parameterName: parameterInfo.name,
                  ),
                ),
                returnType:
                    _convertType(methodInfo.returnType, classes: allClasses),
                methodName: methodInfo.name,
              ),
            ),
            fields: classInfo.fields.map<String>(
              (FieldInfo fieldInfo) => creator.createField(
                getChannelType(fieldInfo.type),
                isStatic: fieldInfo.isStatic,
                isMutable: fieldInfo.isMutable,
                fieldType: _convertType(fieldInfo.type, classes: allClasses),
                fieldName: fieldInfo.name,
                parameter: creator.createParameter(
                    getChannelType(fieldInfo.type),
                    primitiveConvertMethod:
                        _getPrimitiveConvertMethod(fieldInfo.type),
                    parameterType:
                        _convertType(fieldInfo.type, classes: allClasses),
                    parameterName: fieldInfo.name),
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
          ...allClasses.expand<String>(
            (ClassInfo classInfo) => classInfo.constructors.map<String>(
              (ConstructorInfo constructorInfo) => creator.createStaticRedirect(
                ClassMemberType.constructor,
                constructorName: constructorInfo.name,
                api: classInfo.aClass.androidApi != null
                    ? classInfo.aClass.androidApi.api.toString()
                    : null,
                wrapperName: (classInfo.aClass.platform as AndroidPlatform)
                    .type
                    .names
                    .join(),
              ),
            ),
          ),
          ...allClasses.expand<String>(
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
          ...allClasses.expand<String>(
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

  String _convertType(TypeInfo info,
      {List<ClassInfo> classes, bool ignorePrimitives = true}) {
    if (info.isVoid) {
      return 'void';
    } else if (info.isDynamic || info.isObject) {
      return 'Object';
    } else if (info.isString) {
      return 'String';
    } else if (!ignorePrimitives && info.isNativeInt64) {
      return 'Long';
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
              .firstWhere((ClassInfo classInfo) =>
                  removeBounds(classInfo.name) == removeBounds(info.name))
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

  String _getPrimitiveConvertMethod(TypeInfo info) {
    if (info.isNativeInt32) {
      return 'intValue';
    } else if (info.isNativeInt64) {
      return 'longValue';
    }

    return null;
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
