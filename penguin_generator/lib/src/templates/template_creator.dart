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
    bool isStatic,
    MethodChannelType returnChannelType, {
    @required Iterable<String> parameters,
    @required Iterable<String> methodCallParams,
    @required String platformClassName,
    @required String methodName,
    @required String returnType,
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
        Replacement.returnType.name:
            returnChannelType == MethodChannelType.typeParameter
                ? returnType
                : 'void',
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
    @required String wrapperInterface,
  }) {
    return TemplateCreator._replace(
      Block.aClass.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        Replacement.typeParameters.name:
            typeParameters.isEmpty ? '' : '<${typeParameters.join(', ')}>',
        Block.constructors.exp: constructors.join(),
        Block.methods.exp: methods.join(),
        Block.fields.exp: fields.join(),
        Replacement.platformClassName.name: platformClassName,
        Block.callbacks.exp: callbacks.join(),
        MethodChannelBlock.callbackVariables().exp: callbackVariables.join(),
        MethodChannelBlock.callbackInitializers().exp:
            callbackInitializers.isNotEmpty ? callbackInitializers.join() : '',
        Replacement.platformViewClass.name: platformViewClass,
        Replacement.platformViewVariable.name: platformViewVariable,
        Replacement.wrapperInterface.name: wrapperInterface,
        Replacement.className.name: className,
      },
    );
  }

  String createFile({
    @required Iterable<String> classes,
    @required Iterable<String> genericHelpers,
    @required String filename,
  }) {
    return TemplateCreator._replace(
      template.value,
      <Pattern, String>{
        Block.classes.exp: classes.join(),
        Replacement.filename.name: filename,
        Block.genericHelpers.exp: genericHelpers.join('else'),
      },
    );
  }

  String createGenericHelper({@required String className}) {
    return TemplateCreator._replace(
      Block.genericHelper.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        Replacement.className.name: className,
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
        Replacement.returnType.name: fieldType,
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
  @override
  Template get template => Template.ios;

  static String createHeaderFile({
    @required String headerTemplate,
    @required Iterable<String> classPackages,
    @required Iterable<String> classes,
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
        Block.classes.exp: classes.join(),
      },
    );
  }

  static String createHeaderClass(
    Structure structure, {
    @required String headerTemplate,
    @required String platformClassName,
  }) {
    return TemplateCreator._replace(
      Block.aClass.exp.firstMatch(headerTemplate).group(1),
      <Pattern, String>{
        MethodChannelBlock.valueTypes().exp:
            MethodChannelBlock.valueType(structure)
                .exp
                .firstMatch(headerTemplate)
                .group(1),
        Replacement.platformClassName.name: platformClassName,
      },
    );
  }

  String createCallback({
    @required String platformClassName,
    @required String methodName,
  }) {
    return TemplateCreator._replace(
      Block.callback.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        Replacement.platformClassName.name: platformClassName,
        Replacement.methodName.name: methodName,
      },
    );
  }

  String createCallbackSwizzle({
    @required String methodName,
  }) {
    return TemplateCreator._replace(
      Block.callbackSwizzle.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        Replacement.methodName.name: methodName,
      },
    );
  }

  String createFile({
    @required Iterable<String> classes,
    @required Iterable<String> staticRedirects,
    @required Iterable<String> structs,
  }) {
    return TemplateCreator._replace(
      template.value,
      <Pattern, String>{
        Block.classes.exp: classes.join(),
        Block.staticRedirects.exp: staticRedirects.join(),
        Block.structs.exp: structs.join(),
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

  String createConstructor(
    Structure structure, {
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
        if (structure == Structure.$class)
          Replacement.implementationName.name: platformClassName,
        if (structure == Structure.protocol)
          Replacement.implementationName.name: '\$${platformClassName}Impl',
        if (structure == Structure.struct)
          RegExp(r'_value.*?;', multiLine: true, dotAll: true): '',
      },
    );
  }

  String createClass(
    Structure structure, {
    @required Iterable<String> constructors,
    @required Iterable<String> methods,
    @required Iterable<String> methodCalls,
    @required Iterable<String> staticMethodCalls,
    @required Iterable<String> fields,
    @required Iterable<String> callbacks,
    @required Iterable<String> callbackSwizzles,
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
        Block.callbacks.exp: callbacks.join(),
        Block.callbackSwizzles.exp: callbackSwizzles.join(),
        MethodChannelBlock.valueTypes().exp:
            MethodChannelBlock.valueType(structure)
                .exp
                .firstMatch(template.value)
                .group(1),
        if (structure != Structure.protocol)
          RegExp(r'@interface.*?@end.*?@implementation.*?@end',
              multiLine: true, dotAll: true): '',
        Replacement.platformClassName.name: platformClassName,
      },
    );
  }

  String createStruct({@required platformClassName}) {
    return TemplateCreator._replace(
      Block.struct.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        Replacement.platformClassName.name: platformClassName,
      },
    );
  }

  String createParameter(
    MethodChannelType methodChannel, {
    @required String parameterName,
    @required String parameterType,
    @required String primitiveConvertMethod,
  }) {
    return TemplateCreator._replace(
      MethodChannelBlock.parameter(methodChannel)
          .exp
          .firstMatch(template.value)
          .group(1),
      <Pattern, String>{
        Replacement.parameterName.name: parameterName,
        Replacement.parameterType.name: parameterType,
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
        if (isStatic) Replacement.methodCallerName.name: platformClassName,
        if (!isStatic) Replacement.methodCallerName.name: r'_value',
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
        Replacement.platformClassName.name: platformClassName,
      },
    );
  }

  String createField(
    MethodChannelType channelType,
    Structure structure, {
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
        if (structure == Structure.struct)
          Replacement.methodCallerName.name:
              '[NSValue get__platformClassName__:_value]',
        if (isStatic) Replacement.methodCallerName.name: platformClassName,
        if (!isStatic && structure != Structure.struct)
          Replacement.methodCallerName.name: r'_value',
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
