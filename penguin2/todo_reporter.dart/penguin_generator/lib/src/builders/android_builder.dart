import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:penguin/penguin.dart';
import 'package:penguin_generator/src/info.dart';
import 'package:pubspec_parse/pubspec_parse.dart';
import 'package:recase/recase.dart';

import '../templates.dart';
import 'platform_builder.dart';

class AndroidBuilder extends PlatformBuilder {
  @override
  String build(List<ClassInfo> classes) {
    final AndroidTemplateCreator creator = AndroidTemplateCreator();
    return creator.createFile(
      imports: classes
          .map<String>(
            (ClassInfo classInfo) => creator.createImport(
              classPackage:
                  (classInfo.aClass.platform as AndroidPlatform).type.package,
              platformClassName:
                  (classInfo.aClass.platform as AndroidPlatform).type.name,
            ),
          )
          .toSet(),
      classes: classes.map<String>(
        (ClassInfo classInfo) => creator.createClass(
          constructors: classInfo.constructors.map<String>(
            (ConstructorInfo constructorInfo) => creator.createConstructor(
              platformClassName:
                  (classInfo.aClass.platform as AndroidPlatform).type.name,
              variableName: ReCase(
                (classInfo.aClass.platform as AndroidPlatform).type.name,
              ).camelCase,
            ),
          ),
          methods: classInfo.methods.map<String>(
            (MethodInfo methodInfo) => creator.createMethod(
              _getChannelType(methodInfo.returnType),
              parameters: methodInfo.parameters.map<String>(
                (ParameterInfo parameterInfo) => creator.createParameter(
                  _getChannelType(parameterInfo.type),
                  parameterType: _convertType(parameterInfo.type, classes),
                  parameterName: parameterInfo.name,
                  variableName:
                      ReCase(_convertType(parameterInfo.type, classes))
                          .camelCase,
                ),
              ),
              methodName: methodInfo.name,
              variableName: ReCase(
                (classInfo.aClass.platform as AndroidPlatform).type.name,
              ).camelCase,
            ),
          ),
          methodCalls: classInfo.methods.map<String>(
            (MethodInfo methodInfo) => creator.createMethodCall(
              platformClassName:
                  (classInfo.aClass.platform as AndroidPlatform).type.name,
              methodName: methodInfo.name,
            ),
          ),
          platformClassName:
              (classInfo.aClass.platform as AndroidPlatform).type.name,
          variableName: ReCase(
            (classInfo.aClass.platform as AndroidPlatform).type.name,
          ).camelCase,
        ),
      ),
      staticMethodCalls: classes.expand<String>(
        (ClassInfo classInfo) => classInfo.constructors.map<String>(
          (ConstructorInfo constructorInfo) => creator.createStaticMethodCall(
            platformClassName:
                (classInfo.aClass.platform as AndroidPlatform).type.name,
          ),
        ),
      ),
      package: _androidPackage,
    );
  }

  // TODO: handle longs (Actually,... this should be an override)
  String _convertType(TypeInfo info, [List<ClassInfo> classes]) {
    if (info.isDynamic || info.isObject) {
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
        _getChannelType(info) == MethodChannelType.supported) {
      return 'ArrayList<${_convertType(info.typeArguments.first)}>';
    } else if (info.isMap &&
        _getChannelType(info) == MethodChannelType.supported) {
      final List<TypeInfo> infos = info.typeArguments.toList();
      return 'HashMap<${_convertType(infos[0])}, ${_convertType(infos[1])}>';
    } else if (info.isWrapper) {
      return (classes
              .firstWhere((ClassInfo classInfo) => classInfo.name == info.name)
              .aClass
              .platform as AndroidPlatform)
          .type.name;
    }

    throw ArgumentError();
  }

  MethodChannelType _getChannelType(TypeInfo info) {
    if (info.isMap ||
        info.isList &&
            info.typeArguments.every(
              (_) => _getChannelType(_) == MethodChannelType.supported,
            )) {
      return MethodChannelType.supported;
    } else if (info.isDynamic ||
        info.isObject ||
        info.isString ||
        info.isNum ||
        info.isInt ||
        info.isDouble ||
        info.isBool) {
      return MethodChannelType.supported;
    } else if (info.isVoid) {
      return MethodChannelType.$void;
    } else if (info.isWrapper) {
      return MethodChannelType.wrapper;
    }

    throw ArgumentError();
  }

  static String get _androidPackage {
    final File pubspecFile = File('pubspec.yaml');
    final Pubspec pubspec = Pubspec.parse(pubspecFile.readAsStringSync());
    return pubspec.flutter['plugin']['androidPackage'];
  }

  @override
  String get directory => p.joinAll(
        <String>['android', 'src', 'main', 'java']..addAll(
            _androidPackage.split('.'),
          ),
      );

  @override
  String get filename => 'ChannelGenerated.java';
}
