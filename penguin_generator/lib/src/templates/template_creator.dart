import 'package:meta/meta.dart';
import 'package:penguin_generator/src/templates/templates.dart';

abstract class TemplateCreator {
  Template get template;

  String _replace(String value, Map<Pattern, String> replacements) {
    for (MapEntry<Pattern, String> entry in replacements.entries) {
      value = value.replaceAll(entry.key, entry.value);
    }
    return value;
  }
}

class MethodChannelTemplateCreator extends TemplateCreator {
  @override
  Template get template => Template.dartMethodChannel;

  String createMethod(
    bool isStatic, {
    Iterable<String> parameters,
    Iterable<String> methodCallParams,
    String platformClassName,
    String methodName,
  }) {
    return _replace(
      Block.method.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        if (!isStatic) 'static': '',
        if (isStatic) r"r'$uniqueId': $uniqueId,": '',
        Block.parameters.exp: parameters.join(),
        MethodChannelBlock.methodCallParams.exp: methodCallParams.join(),
        Replacement.platformClassName.name: platformClassName,
        Replacement.methodName.name: methodName,
      },
    );
  }

  String createField(
    bool isStatic, {
    String platformClassName,
    String fieldName,
    String fieldType,
    String fieldSetterParam,
    String fieldSetter,
  }) {
    return _replace(
      Block.field.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        if (!isStatic) 'static': '',
        if (isStatic) r"r'$uniqueId': $uniqueId,": '',
        Replacement.platformClassName.name: platformClassName,
        Replacement.fieldName.name: fieldName,
        Replacement.fieldType.name: fieldType,
        Block.fieldSetterParams.exp: fieldSetterParam,
        Block.fieldSetters.exp: fieldSetter,
      },
    );
  }

  String createFieldSetter(
    MethodChannelType channelType, {
    String fieldType,
    String fieldName,
  }) {
    return _replace(
      MethodChannelBlock.fieldSetter(channelType)
          .exp
          .firstMatch(template.value)
          .group(1),
      <Pattern, String>{
        Replacement.fieldType.name: fieldType,
        Replacement.fieldName.name: fieldName,
      },
    );
  }

  String createParameter(
    MethodChannelType channelType, {
    String parameterType,
    String parameterName,
  }) {
    return _replace(
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

  String createFieldSetterParam(MethodChannelType channelType,
      {String fieldName}) {
    return _replace(
      MethodChannelBlock.fieldSetterParam(channelType)
          .exp
          .firstMatch(template.value)
          .group(1),
      <Pattern, String>{
        Replacement.fieldName.name: fieldName,
      },
    );
  }

  String createMethodCallParam(
    MethodChannelType channelType, {
    String parameterName,
  }) {
    return _replace(
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
    Iterable<String> typeParameters,
    Iterable<String> constructors,
    Iterable<String> methods,
    Iterable<String> fields,
    String className,
    String platformClassName,
  }) {
    return _replace(
      Block.aClass.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        Replacement.typeParameters.name:
            typeParameters.isEmpty ? '' : '<${typeParameters.join(', ')}>',
        Block.constructors.exp: constructors.join(),
        Block.methods.exp: methods.join(),
        Replacement.className.name: className,
        Block.fields.exp: fields.join(),
        Replacement.platformClassName.name: platformClassName,
      },
    );
  }

  String createFile({Iterable<String> classes}) {
    return _replace(
      template.value,
      <Pattern, String>{Block.classes.exp: classes.join()},
    );
  }

  String createConstructor({
    String platformClassName,
    String className,
    @required String constructorName,
    @required Iterable<String> parameters,
    @required Iterable<String> methodCallParams,
  }) {
    return _replace(
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

  String createField(
    MethodChannelType channelType, {
    bool isStatic,
    bool isMutable,
    String fieldType,
    String fieldName,
    String package,
    String platformClassName,
    String fieldSetter,
  }) {
    return _replace(
      Block.field.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        if (!isStatic) 'static': '',
        if (!isStatic) r'ChannelGenerated $channelGenerated,': '',
        if (!isMutable)
          RegExp(r'if\s*(.*?)\s*{.*?}', multiLine: true, dotAll: true): '',
        Replacement.methodCallerName.name:
            isStatic ? platformClassName : r'$value',
        Block.preFieldAccesses.exp:
            MethodChannelBlock.preFieldAccess(channelType)
                .exp
                .firstMatch(template.value)
                .group(1),
        Block.postFieldAccesses.exp:
            MethodChannelBlock.postFieldAccess(channelType)
                .exp
                .firstMatch(template.value)
                .group(1),
        Block.fieldSetters.exp: MethodChannelBlock.fieldSetter(channelType)
            .exp
            .firstMatch(template.value)
            .group(1),
        Replacement.fieldType.name: fieldType,
        Replacement.fieldName.name: fieldName,
        Replacement.package.name: package,
      },
    );
  }

  String createMethod(
    MethodChannelType returnTypeChannelType,
    bool isStatic, {
    bool isMutable,
    Iterable<String> parameters,
    String returnType,
    String methodName,
    String platformClassName,
    String package,
  }) {
    return _replace(
      Block.method.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        if (!isStatic) 'static': '',
        if (!isStatic) r'ChannelGenerated $channelGenerated,': '',
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
    String parameterType,
    String parameterName,
  }) {
    return _replace(
      MethodChannelBlock.parameter(methodChannel)
          .exp
          .firstMatch(template.value)
          .group(1),
      <Pattern, String>{
        Replacement.parameterType.name: parameterType,
        Replacement.parameterName.name: parameterName,
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
    return _replace(
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
    return _replace(
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
    String methodName,
    String fieldName,
  }) {
    return _replace(
      MethodChannelBlock.staticRedirect(classMember)
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

  String createFile({
    Iterable<String> imports,
    Iterable<String> classes,
    Iterable<String> staticRedirects,
    String package,
  }) {
    return _replace(
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
  }) {
    return _replace(
      Block.constructor.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        Replacement.platformClassName.name: platformClassName,
        Replacement.wrapperName.name: wrapperName,
        Replacement.constructorName.name: constructorName,
        Block.parameters.exp: parameters.join(','),
      },
    );
  }

  String createMethodCall(
    ClassMemberType classMember, {
    @required String wrapperName,
    String methodName,
    String fieldName,
  }) {
    return _replace(
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

  String createStaticMethodCall(
    ClassMemberType classMember, {
    @required String wrapperName,
    String constructorName,
    String methodName,
    String fieldName,
  }) {
    return _replace(
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
  String createFile({
    Iterable<String> imports,
    Iterable<String> classes,
    Iterable<String> staticRedirects,
  }) {
    return _replace(
      template.value,
      <Pattern, String>{
        Block.imports.exp: imports.join(),
        Block.classes.exp: classes.join(),
        Block.staticRedirects.exp: staticRedirects.join(),
      },
    );
  }

  String createStaticRedirect(
    ClassMemberType classMember, {
    String platformClassName,
    String methodName,
    String fieldName,
  }) {
    return _replace(
      MethodChannelBlock.staticRedirect(classMember)
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

  String createConstructor({String platformClassName}) {
    return _replace(
      Block.constructor.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        Replacement.platformClassName.name: platformClassName,
      },
    );
  }

  String createClass({
    Iterable<String> constructors,
    Iterable<String> methods,
    Iterable<String> methodCalls,
    Iterable<String> staticMethodCalls,
    //Iterable<String> fields,
    String platformClassName,
  }) {
    return _replace(
      Block.aClass.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        Block.constructors.exp: constructors.join(),
        Block.methods.exp: methods.join(),
        MethodChannelBlock.methodCalls.exp: methodCalls.join(),
        MethodChannelBlock.staticMethodCalls.exp:
            staticMethodCalls.join('else'),
        //Block.fields.exp: fields.join(),
        Replacement.platformClassName.name: platformClassName,
      },
    );
  }

  String createParameter(
    MethodChannelType methodChannel, {
    @required String parameterName,
    @required String primitiveConvertMethod,
  }) {
    return _replace(
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
    return _replace(
      Block.method.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        if (!isStatic) '+': '-',
        if (!isStatic) r':(ChannelHandler *)$handler call': '',
        Replacement.methodCallerName.name:
            isStatic ? platformClassName : r'_$value',
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

  String createMethodCall(
    ClassMemberType classMember, {
    String platformClassName,
    String methodName,
    String fieldName,
  }) {
    return _replace(
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
    return _replace(
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

  String createImport({String classPackage}) {
    return _replace(
      Block.import.exp.firstMatch(template.value).group(1),
      <Pattern, String>{
        Replacement.classPackage.name: classPackage,
      },
    );
  }

  @override
  Template get template => Template.ios;
}
