import 'package:penguin/penguin.dart';
import 'package:penguin_generator/src/info.dart';

import '../templates.dart';
import 'platform_builder.dart';

class FlutterBuilder extends PlatformBuilder {
  @override
  String build(List<ClassInfo> classes) {
    final MethodChannelTemplateCreator creator = MethodChannelTemplateCreator();
    return creator.createFile(
      classes: classes.map<String>(
        (ClassInfo classInfo) => creator.createClass(
          constructors: classInfo.constructors.map<String>(
            (ConstructorInfo constructorInfo) => creator.createConstructor(
              className: classInfo.name,
              platformClassName:
                  (classInfo.aClass.platform as AndroidPlatform).type.name,
            ),
          ),
          methods: classInfo.methods.map<String>(
            (MethodInfo methodInfo) => creator.createMethod(
              parameters: methodInfo.parameters.map<String>(
                (ParameterInfo parameterInfo) => creator.createParameter(
                  parameterType: parameterInfo.type.name,
                  parameterName: parameterInfo.name,
                ),
              ),
              methodCallParams: methodInfo.parameters.map<String>(
                (ParameterInfo parameterInfo) => creator.createMethodCallParam(
                  parameterName: parameterInfo.name,
                ),
              ),
              platformClassName:
                  (classInfo.aClass.platform as AndroidPlatform).type.name,
              methodName: methodInfo.name,
            ),
          ),
          className: classInfo.name,
          platformClassName:
              (classInfo.aClass.platform as AndroidPlatform).type.name,
        ),
      ),
    );
  }

  @override
  String get directory => 'lib';

  @override
  String get filename => 'penguin.g.dart';
}
