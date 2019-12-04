import 'package:meta/meta.dart';
import 'package:penguin_generator/src/templates/templates.dart';

abstract class TemplateCreator {
  Template get template;

  static String _replace(String value, Map<Pattern, String> replacements) {
    for (MapEntry<Pattern, String> entry in replacements.entries) {
      value = value.replaceAll(entry.key, entry.value);
    }
    return value;
  }
}

class MethodChannelTemplateCreator extends TemplateCreator {
  @override
  Template get template => Template.dartMethodChannel;

  String createCallbackVariable({
    @required String methodName,
    @required Iterable<String> callbackVariableParams,
  }) {
    return TemplateCreator._replace(
      MethodChannelBlock.callbackVariable()
          .exp
          .firstMatch(template.value)
          .group(1),
      <Pattern, String>{
        Replacement.methodName.name: methodName,
        MethodChannelBlock.callbackVariableParams().exp:
            callbackVariableParams.join(),
      },
    );
  }

  String createCallbackVariableParam(
    MethodChannelType methodChannel, {
    @required String parameterType,
    @required String parameterName,
  }) {
    return TemplateCreator._replace(
      MethodChannelBlock.callbackVariableParam(methodChannel)
          .exp
          .firstMatch(template.value)
          .group(1),
      <Pattern, String>{
        Replacement.parameterType.name: parameterType,
        Replacement.parameterName.name: parameterName,
      },
    );
  }

  String createCallbackInitializer({@required String methodName}) {
    return TemplateCreator._replace(
      MethodChannelBlock.callbackInitializer()
          .exp
          .firstMatch(template.value)
          .group(1),
      <Pattern, String>{
        Replacement.methodName.name: methodName,
      },
    );
  }

  String createCallback({
    @required String methodName,
    @required Iterable<String> callbackChannelParams,
    @required String wrapperName,
  }) {
    return TemplateCreator._replace(
      Block.callback.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        Replacement.methodName.name: methodName,
        Replacement.wrapperName.name: wrapperName,
        MethodChannelBlock.callbackChannelParams().exp:
            callbackChannelParams.join(),
      },
    );
  }

  String createCallbackChannelParam(
    MethodChannelType methodChannelType, {
    @required String parameterName,
    String className,
  }) {
    return TemplateCreator._replace(
      MethodChannelBlock.callbackChannelParam(methodChannelType)
          .exp
          .firstMatch(template.value)
          .group(1),
      <Pattern, String>{
        Replacement.parameterName.name: parameterName,
        if (className != null) Replacement.className.name: className,
      },
    );
  }

  String createMethod(
    bool isStatic, {
    @required Iterable<String> parameters,
    @required Iterable<String> methodCallParams,
    @required String platformClassName,
    @required String methodName,
  }) {
    return TemplateCreator._replace(
      Block.method.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        if (!isStatic) 'static': '',
        if (isStatic) r"r'$uniqueId': uniqueId,": '',
        Block.parameters.exp: parameters.join(),
        MethodChannelBlock.methodCallParams.exp: methodCallParams.join(),
        Replacement.platformClassName.name: platformClassName,
        Replacement.methodName.name: methodName,
      },
    );
  }

  String createField(
    bool isStatic, {
    @required String platformClassName,
    @required String fieldName,
    @required String fieldType,
    @required String methodCallParam,
    @required String parameter,
  }) {
    return TemplateCreator._replace(
      Block.field.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        if (!isStatic) 'static': '',
        if (isStatic) r"r'$uniqueId': uniqueId,": '',
        Replacement.platformClassName.name: platformClassName,
        Replacement.fieldName.name: fieldName,
        Replacement.fieldType.name: fieldType,
        Block.parameters.exp: parameter,
        MethodChannelBlock.methodCallParams.exp: methodCallParam,
      },
    );
  }

  String createParameter(
    MethodChannelType channelType, {
    @required String parameterType,
    @required String parameterName,
  }) {
    return TemplateCreator._replace(
      MethodChannelBlock.parameter(channelType)
          .exp
          .firstMatch(template.value)
          .group(1),
      <Pattern, String>{
        Replacement.parameterType.name: parameterType,
        Replacement.parameterName.name: parameterName,
      },
    );
  }

  String createMethodCallParam(
    MethodChannelType channelType, {
    @required String parameterName,
  }) {
    return TemplateCreator._replace(
      MethodChannelBlock.methodCallParam(channelType)
          .exp
          .firstMatch(template.value)
          .group(1),
      <Pattern, String>{
        Replacement.parameterName.name: parameterName,
      },
    );
  }

  String createClass({
    @required Iterable<String> typeParameters,
    @required Iterable<String> constructors,
    @required Iterable<String> methods,
    @required Iterable<String> fields,
    @required Iterable<String> callbacks,
    @required Iterable<String> callbackInitializers,
    @required Iterable<String> callbackVariables,
    @required String className,
    @required String platformClassName,
    @required String platformViewClass,
    @required String platformViewVariable,
  }) {
    return TemplateCreator._replace(
      Block.aClass.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        Replacement.typeParameters.name:
            typeParameters.isEmpty ? '' : '<${typeParameters.join(', ')}>',
        Block.constructors.exp: constructors.join(),
        Block.methods.exp: methods.join(),
        Replacement.className.name: className,
        Block.fields.exp: fields.join(),
        Replacement.platformClassName.name: platformClassName,
        Block.callbacks.exp: callbacks.join(),
        MethodChannelBlock.callbackVariables().exp: callbackVariables.join(),
        MethodChannelBlock.callbackInitializers().exp:
            callbackInitializers.isNotEmpty
                ? '{' + callbackInitializers.join() + '}'
                : '',
        Replacement.platformViewClass.name: platformViewClass,
        Replacement.platformViewVariable.name: platformViewVariable,
      },
    );
  }

  String createFile({
    @required Iterable<String> classes,
    @required String platformViewClass,
    @required String platformViewVariable,
  }) {
    return TemplateCreator._replace(
      template.value,
      <Pattern, String>{
        Block.classes.exp: classes.join(),
        Replacement.platformViewClass.name: platformViewClass,
        Replacement.platformViewVariable.name: platformViewVariable,
      },
    );
  }

  String createConstructor({
    String platformClassName,
    String className,
    @required String constructorName,
    @required Iterable<String> parameters,
    @required Iterable<String> methodCallParams,
  }) {
    return TemplateCreator._replace(
      Block.constructor.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        Replacement.platformClassName.name: platformClassName,
        Replacement.className.name: className,
        Replacement.constructorName.name: constructorName,
        Replacement.dartConstructorName.name:
            constructorName.isEmpty ? r'$Default' : constructorName,
        Block.parameters.exp: parameters.join(),
        MethodChannelBlock.methodCallParams.exp: methodCallParams.join(),
      },
    );
  }
}

class AndroidTemplateCreator extends TemplateCreator {
  @override
  Template get template => Template.android;

  String createCallback({
    @required String methodName,
    @required Iterable<String> callbackChannelParams,
    @required Iterable<String> callbackParams,
    @required String wrapperName,
  }) {
    return TemplateCreator._replace(
      Block.callback.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        Replacement.methodName.name: methodName,
        Replacement.wrapperName.name: wrapperName,
        MethodChannelBlock.callbackChannelParams().exp:
            callbackChannelParams.join(),
        Block.callbackParams.exp: callbackParams.join(','),
      },
    );
  }

  String createCallbackParam({
    @required String parameterName,
    @required String parameterType,
  }) {
    return TemplateCreator._replace(
      Block.callbackParam.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        Replacement.parameterType.name: parameterType,
        Replacement.parameterName.name: parameterName,
      },
    );
  }

  String createField(
    MethodChannelType channelType, {
    @required bool isStatic,
    @required bool isMutable,
    @required String fieldType,
    @required String fieldName,
    @required String parameter,
    @required String package,
    @required String platformClassName,
  }) {
    return TemplateCreator._replace(
      Block.field.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        if (!isStatic) 'static': '',
        if (!isMutable)
          RegExp(r'if\s*(.*?)\s*{.*?}', multiLine: true, dotAll: true): '',
        Replacement.methodCallerName.name:
            isStatic ? platformClassName : r'$value',
        Block.preMethodCalls.exp: MethodChannelBlock.preMethodCall(channelType)
            .exp
            .firstMatch(template.value)
            .group(1),
        Block.postMethodCalls.exp:
            MethodChannelBlock.postMethodCall(channelType)
                .exp
                .firstMatch(template.value)
                .group(1),
        Block.parameters.exp: parameter,
        Replacement.parameterType.name: fieldType,
        Replacement.parameterName.name: fieldName,
        Replacement.fieldName.name: fieldName,
        Replacement.package.name: package,
      },
    );
  }

  String createMethod(
    MethodChannelType returnTypeChannelType,
    bool isStatic, {
    @required Iterable<String> parameters,
    @required String returnType,
    @required String methodName,
    @required String platformClassName,
    @required String package,
  }) {
    return TemplateCreator._replace(
      Block.method.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        if (!isStatic) 'static': '',
        Replacement.methodCallerName.name:
            isStatic ? platformClassName : r'$value',
        Block.preMethodCalls.exp:
            MethodChannelBlock.preMethodCall(returnTypeChannelType)
                .exp
                .firstMatch(template.value)
                .group(1),
        Block.postMethodCalls.exp:
            MethodChannelBlock.postMethodCall(returnTypeChannelType)
                .exp
                .firstMatch(template.value)
                .group(1),
        Block.parameters.exp: parameters.join(','),
        Replacement.returnType.name: returnType,
        Replacement.methodName.name: methodName,
        Replacement.package.name: package,
      },
    );
  }

  String createParameter(
    MethodChannelType methodChannel, {
    @required String primitiveConvertMethod,
    @required String parameterType,
    @required String parameterName,
  }) {
    return TemplateCreator._replace(
      MethodChannelBlock.parameter(methodChannel)
          .exp
          .firstMatch(template.value)
          .group(1),
      <Pattern, String>{
        Replacement.parameterType.name: parameterType,
        Replacement.parameterName.name: parameterName,
        if (primitiveConvertMethod != null)
          Replacement.primitiveConvertMethod.name: primitiveConvertMethod,
      },
    );
  }

  String createClass({
    @required Iterable<String> constructors,
    @required Iterable<String> methods,
    @required Iterable<String> methodCalls,
    @required Iterable<String> staticMethodCalls,
    @required Iterable<String> fields,
    @required String platformClassName,
    @required String wrapperName,
    String api,
  }) {
    return TemplateCreator._replace(
      Block.aClass.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        Block.constructors.exp: constructors.join(),
        Block.methods.exp: methods.join(),
        MethodChannelBlock.methodCalls.exp: methodCalls.join(),
        MethodChannelBlock.staticMethodCalls.exp: staticMethodCalls.join(),
        Block.fields.exp: fields.join(),
        Replacement.platformClassName.name: platformClassName,
        Replacement.wrapperName.name: wrapperName,
        if (api == null) r'@RequiresApi(api = __api__)': '',
        if (api != null) Replacement.api.name: api,
      },
    );
  }

  String createImport({String classPackage, String platformClassName}) {
    return TemplateCreator._replace(
      Block.import.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        Replacement.classPackage.name: classPackage,
        Replacement.platformClassName.name: platformClassName,
      },
    );
  }

  String createStaticRedirect(
    ClassMemberType classMember, {
    @required String wrapperName,
    String constructorName,
    String api,
    String methodName,
    String fieldName,
  }) {
    return TemplateCreator._replace(
      MethodChannelBlock.staticRedirect(classMember)
          .exp
          .firstMatch(template.value)
          .group(1),
      <Pattern, String>{
        Replacement.wrapperName.name: wrapperName,
        Replacement.api.name: api != null ? api : '16',
        if (constructorName != null)
          Replacement.constructorName.name: constructorName,
        if (methodName != null) Replacement.methodName.name: methodName,
        if (fieldName != null) Replacement.fieldName.name: fieldName,
      },
    );
  }

  String createFile({
    Iterable<String> imports,
    Iterable<String> classes,
    Iterable<String> staticRedirects,
    String package,
  }) {
    return TemplateCreator._replace(
      template.value,
      <Pattern, String>{
        Block.imports.exp: imports.join(),
        Block.classes.exp: classes.join(),
        Block.staticRedirects.exp: staticRedirects.join(),
        Replacement.package.name: package,
      },
    );
  }

  String createConstructor({
    @required String platformClassName,
    @required String wrapperName,
    @required String constructorName,
    @required Iterable<String> parameters,
    @required Iterable<String> callbacks,
  }) {
    return TemplateCreator._replace(
      Block.constructor.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        Replacement.platformClassName.name: platformClassName,
        Replacement.wrapperName.name: wrapperName,
        Replacement.constructorName.name: constructorName,
        Block.parameters.exp: parameters.join(','),
        Block.callbacks.exp: callbacks.join(),
        if (callbacks.isEmpty)
          RegExp(
            r'{.*}',
            multiLine: true,
            dotAll: true,
          ): '',
      },
    );
  }

  String createMethodCall(
    ClassMemberType classMember, {
    @required String wrapperName,
    String methodName,
    String fieldName,
  }) {
    return TemplateCreator._replace(
      MethodChannelBlock.methodCall(classMember)
          .exp
          .firstMatch(template.value)
          .group(1),
      <Pattern, String>{
        Replacement.wrapperName.name: wrapperName,
        if (methodName != null) Replacement.methodName.name: methodName,
        if (fieldName != null) Replacement.fieldName.name: fieldName,
      },
    );
  }

  String createCallbackChannelParam(
    MethodChannelType methodChannelType, {
    @required String parameterName,
    String wrapperName,
  }) {
    return TemplateCreator._replace(
        MethodChannelBlock.callbackChannelParam(methodChannelType)
            .exp
            .firstMatch(template.value)
            .group(1),
        <Pattern, String>{
          Replacement.parameterName.name: parameterName,
          if (wrapperName != null) Replacement.wrapperName.name: wrapperName,
        });
  }

  String createStaticMethodCall(
    ClassMemberType classMember, {
    @required String wrapperName,
    String constructorName,
    String methodName,
    String fieldName,
  }) {
    return TemplateCreator._replace(
      MethodChannelBlock.staticMethodCall(classMember)
          .exp
          .firstMatch(template.value)
          .group(1),
      <Pattern, String>{
        Replacement.wrapperName.name: wrapperName,
        if (constructorName != null)
          Replacement.constructorName.name: constructorName,
        if (methodName != null) Replacement.methodName.name: methodName,
        if (fieldName != null) Replacement.fieldName.name: fieldName,
      },
    );
  }
}

class IosTemplateCreator extends TemplateCreator {
  static String createHeaderFile({
    @required String headerTemplate,
    @required Iterable<String> classPackages,
    @required Iterable<String> platformClassNames,
  }) {
    return TemplateCreator._replace(
      headerTemplate,
      <Pattern, String>{
        Block.imports.exp: classPackages
            .map<String>(
              (String classPackage) => TemplateCreator._replace(
                Block.import.exp.firstMatch(headerTemplate).group(1),
                <Pattern, String>{
                  Replacement.classPackage.name: classPackage,
                },
              ),
            )
            .join(),
        Block.classes.exp: platformClassNames
            .map<String>(
              (String platformClassName) => TemplateCreator._replace(
                Block.aClass.exp.firstMatch(headerTemplate).group(1),
                <Pattern, String>{
                  Replacement.platformClassName.name: platformClassName,
                },
              ),
            )
            .join(),
      },
    );
  }

  @override
  Template get template => Template.ios;

  String createFile({
    @required Iterable<String> classes,
    @required Iterable<String> staticRedirects,
  }) {
    return TemplateCreator._replace(
      template.value,
      <Pattern, String>{
        Block.classes.exp: classes.join(),
        Block.staticRedirects.exp: staticRedirects.join(),
      },
    );
  }

  String createStaticRedirect(
    ClassMemberType classMember, {
    @required String platformClassName,
    String constructorName,
    String methodName,
    String fieldName,
  }) {
    return TemplateCreator._replace(
      MethodChannelBlock.staticRedirect(classMember)
          .exp
          .firstMatch(template.value)
          .group(1),
      <Pattern, String>{
        Replacement.platformClassName.name: platformClassName,
        if (constructorName != null)
          Replacement.constructorName.name: constructorName,
        if (methodName != null) Replacement.methodName.name: methodName,
        if (fieldName != null) Replacement.fieldName.name: fieldName,
      },
    );
  }

  String createConstructor({
    @required String platformClassName,
    @required String constructorName,
    @required String constructorSignature,
    @required Iterable<String> parameters,
  }) {
    return TemplateCreator._replace(
      Block.constructor.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        Replacement.platformClassName.name: platformClassName,
        Replacement.constructorSignature.name: constructorSignature,
        Replacement.constructorName.name:
            constructorName.isNotEmpty ? constructorName : 'init',
        Block.parameters.exp: parameters.join().replaceFirst(
              RegExp('.+?:'),
              ':',
            ),
      },
    );
  }

  String createClass({
    @required Iterable<String> constructors,
    @required Iterable<String> methods,
    @required Iterable<String> methodCalls,
    @required Iterable<String> staticMethodCalls,
    @required Iterable<String> fields,
    @required String platformClassName,
  }) {
    return TemplateCreator._replace(
      Block.aClass.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        Block.constructors.exp: constructors.join('else'),
        Block.methods.exp: methods.join(),
        MethodChannelBlock.methodCalls.exp: methodCalls.join(),
        MethodChannelBlock.staticMethodCalls.exp:
            staticMethodCalls.join('else'),
        Block.fields.exp: fields.join(),
        Replacement.platformClassName.name: platformClassName,
      },
    );
  }

  String createParameter(
    MethodChannelType methodChannel, {
    @required String parameterName,
    @required String primitiveConvertMethod,
  }) {
    return TemplateCreator._replace(
      MethodChannelBlock.parameter(methodChannel)
          .exp
          .firstMatch(template.value)
          .group(1),
      <Pattern, String>{
        Replacement.parameterName.name: parameterName,
        if (primitiveConvertMethod != null)
          Replacement.primitiveConvertMethod.name: primitiveConvertMethod,
      },
    );
  }

  String createMethod(
    MethodChannelType returnTypeChannelType,
    bool isStatic, {
    @required Iterable<String> parameters,
    @required String returnType,
    @required String methodName,
    @required String platformClassName,
  }) {
    return TemplateCreator._replace(
      Block.method.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        if (!isStatic) '+': '-',
        Replacement.methodCallerName.name:
            isStatic ? platformClassName : r'_value',
        Block.preMethodCalls.exp:
            MethodChannelBlock.preMethodCall(returnTypeChannelType)
                .exp
                .firstMatch(template.value)
                .group(1),
        Block.postMethodCalls.exp:
            MethodChannelBlock.postMethodCall(returnTypeChannelType)
                .exp
                .firstMatch(template.value)
                .group(1),
        Block.parameters.exp: parameters.join().replaceFirst(
              RegExp('.+?:'),
              ':',
            ),
        Replacement.returnType.name: returnType,
        Replacement.methodName.name: methodName,
      },
    );
  }

  String createField(
    MethodChannelType channelType, {
    @required bool isStatic,
    @required bool isMutable,
    @required String parameter,
    @required String fieldName,
    @required String platformClassName,
  }) {
    return TemplateCreator._replace(
      Block.field.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        if (!isStatic) '+': '-',
        if (!isMutable)
          RegExp(r'if\s*(.*?)\s*{.*?}', multiLine: true, dotAll: true): '',
        Replacement.methodCallerName.name:
            isStatic ? platformClassName : r'_value',
        Block.preMethodCalls.exp: MethodChannelBlock.preMethodCall(channelType)
            .exp
            .firstMatch(template.value)
            .group(1),
        Block.postMethodCalls.exp:
            MethodChannelBlock.postMethodCall(channelType)
                .exp
                .firstMatch(template.value)
                .group(1),
        Block.parameters.exp: parameter.replaceFirst(
          RegExp('.+?:'),
          '',
        ),
        Replacement.methodName.name: fieldName,
        Replacement.fieldName.name: fieldName,
      },
    );
  }

  String createMethodCall(
    ClassMemberType classMember, {
    String platformClassName,
    String methodName,
    String fieldName,
  }) {
    return TemplateCreator._replace(
      MethodChannelBlock.methodCall(classMember)
          .exp
          .firstMatch(template.value)
          .group(1),
      <Pattern, String>{
        Replacement.platformClassName.name: platformClassName,
        if (methodName != null) Replacement.methodName.name: methodName,
        if (fieldName != null) Replacement.fieldName.name: fieldName,
      },
    );
  }

  String createStaticMethodCall(
    ClassMemberType classMember, {
    String platformClassName,
    String methodName,
    String fieldName,
  }) {
    return TemplateCreator._replace(
      MethodChannelBlock.staticMethodCall(classMember)
          .exp
          .firstMatch(template.value)
          .group(1),
      <Pattern, String>{
        Replacement.platformClassName.name: platformClassName,
        if (methodName != null) Replacement.methodName.name: methodName,
        if (fieldName != null) Replacement.fieldName.name: fieldName,
      },
    );
  }
}
