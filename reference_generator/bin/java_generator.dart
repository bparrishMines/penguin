import 'package:recase/recase.dart';
import 'package:reference_generator/src/ast.dart';

import 'common.dart';

String generateJava({
  String template,
  LibraryNode libraryNode,
  String libraryName,
  String package,
}) {
  final Library library = Library(template);
  return library
      .stringMatch()
      .replaceAll(library.name, libraryName)
      .replaceAll(library.package, package)
      .replaceAll(
        library.anInterface.exp,
        libraryNode.classes.map<String>((ClassNode classNode) {
          final Interface anInterface = library.anInterface;
          return anInterface
              .stringMatch()
              .replaceAll(anInterface.name, classNode.name)
              .replaceAll(
                anInterface.aField.exp,
                classNode.fields.map<String>((FieldNode fieldNode) {
                  final InterfaceField aField = anInterface.aField;
                  return aField
                      .stringMatch()
                      .replaceAll(aField.name, fieldNode.name.pascalCase)
                      .replaceAll(
                        aField.type,
                        getTrueTypeName(fieldNode.type),
                      );
                }).join('\n'),
              )
              .replaceAll(
                anInterface.aMethod.exp,
                classNode.methods.map<String>((MethodNode methodNode) {
                  final InterfaceMethod aMethod = anInterface.aMethod;
                  return aMethod
                      .stringMatch()
                      .replaceAll(aMethod.name, methodNode.name)
                      .replaceAll(
                        aMethod.aParameter.exp,
                        methodNode.parameters
                            .map<String>((ParameterNode parameterNode) {
                          final Parameter aParameter = aMethod.aParameter;
                          return aParameter
                              .stringMatch()
                              .replaceAll(aParameter.name, parameterNode.name)
                              .replaceAll(
                                aParameter.type,
                                getTrueTypeName(parameterNode.type),
                              );
                        }).join(','),
                      );
                }).join('\n'),
              );
        }).join('\n'),
      )
      .replaceAll(
        library.aCreationArgsClass.exp,
        libraryNode.classes.map<String>((ClassNode classNode) {
          final CreationArgsClass aCreationArgsClass =
              library.aCreationArgsClass;
          return aCreationArgsClass
              .stringMatch()
              .replaceAll(
                aCreationArgsClass.className,
                classNode.name,
              )
              .replaceAll(
                aCreationArgsClass.aField.exp,
                classNode.fields.map<String>((FieldNode fieldNode) {
                  final CreationArgsClassField aField =
                      aCreationArgsClass.aField;
                  return aField
                      .stringMatch()
                      .replaceAll(aField.name, fieldNode.name)
                      .replaceAll(
                        aField.type,
                        getTrueTypeName(fieldNode.type),
                      );
                }).join('\n'),
              );
        }).join('\n\n'),
      )
      .replaceAll(
        library.aChannel.exp,
        libraryNode.classes
            .map<String>(
              (ClassNode classNode) => library.aChannel
                  .stringMatch()
                  .replaceAll(
                    library.aChannel.className,
                    classNode.name,
                  )
                  .replaceAll(
                    library.aChannel.typeArgumentClassName,
                    classNode.name,
                  )
                  .replaceAll(
                    library.aChannel.constructorClassName,
                    classNode.name,
                  )
                  .replaceAll(
                    library.aChannel.channel,
                    classNode.channelName,
                  )
                  .replaceAll(
                    library.aChannel.aStaticMethod.exp,
                    classNode.staticMethods
                        .map<String>(
                          (MethodNode methodNode) => library
                              .aChannel.aStaticMethod
                              .stringMatch()
                              .replaceAll(
                                library.aChannel.aStaticMethod.name,
                                methodNode.name.pascalCase,
                              )
                              .replaceAll(
                                library.aChannel.aStaticMethod.nameAsParameter,
                                methodNode.name,
                              )
                              .replaceAll(
                                library.aChannel.aStaticMethod.aParameter.exp,
                                methodNode.parameters
                                    .map<String>(
                                      (ParameterNode parameterNode) => library
                                          .aChannel.aStaticMethod.aParameter
                                          .stringMatch()
                                          .replaceAll(
                                            library.aChannel.aStaticMethod
                                                .aParameter.name,
                                            parameterNode.name,
                                          )
                                          .replaceAll(
                                            library.aChannel.aStaticMethod
                                                .aParameter.type,
                                            getTrueTypeName(parameterNode.type),
                                          ),
                                    )
                                    .join(', '),
                              )
                              .replaceAll(
                                library
                                    .aChannel.aStaticMethod.aParameterName.exp,
                                methodNode.parameters
                                    .map<String>(
                                      (ParameterNode parameterNode) => library
                                          .aChannel.aStaticMethod.aParameterName
                                          .stringMatch()
                                          .replaceAll(
                                            library.aChannel.aStaticMethod
                                                .aParameterName.name,
                                            parameterNode.name,
                                          ),
                                    )
                                    .join(', '),
                              ),
                        )
                        .join('\n\n'),
                  )
                  .replaceAll(
                    library.aChannel.aMethod.exp,
                    classNode.methods
                        .map<String>(
                          (MethodNode methodNode) => library.aChannel.aMethod
                              .stringMatch()
                              .replaceAll(
                                library.aChannel.aMethod.name,
                                methodNode.name.pascalCase,
                              )
                              .replaceAll(
                                library.aChannel.aMethod.channelMethodName,
                                methodNode.name,
                              )
                              .replaceAll(
                                library.aChannel.aMethod.instanceClassName,
                                classNode.name,
                              )
                              .replaceAll(
                                library.aChannel.aMethod.aParameter.exp,
                                methodNode.parameters
                                    .map<String>(
                                      (ParameterNode parameterNode) => library
                                          .aChannel.aMethod.aParameter
                                          .stringMatch()
                                          .replaceAll(
                                            library.aChannel.aMethod.aParameter
                                                .name,
                                            parameterNode.name,
                                          )
                                          .replaceAll(
                                            library.aChannel.aMethod.aParameter
                                                .type,
                                            getTrueTypeName(parameterNode.type),
                                          ),
                                    )
                                    .join(' '),
                              )
                              .replaceAll(
                                library.aChannel.aMethod.aParameterName.exp,
                                methodNode.parameters
                                    .map<String>(
                                      (ParameterNode parameterNode) => library
                                          .aChannel.aMethod.aParameterName
                                          .stringMatch()
                                          .replaceAll(
                                            library.aChannel.aMethod
                                                .aParameterName.name,
                                            parameterNode.name,
                                          ),
                                    )
                                    .join(', '),
                              ),
                        )
                        .join('\n\n'),
                  ),
            )
            .join('\n\n'),
      )
      .replaceAll(
          library.aHandler.exp,
          libraryNode.classes.map<String>((ClassNode classNode) {
            final Handler handler = library.aHandler;
            return handler
                .stringMatch()
                .replaceAll(handler.className, classNode.name)
                .replaceAll(handler.typeArgClassName, classNode.name)
                .replaceAll(
                  handler.onInstanceDisposedClassName,
                  classNode.name,
                )
                .replaceAll(handler.onInstanceDisposedClassName, classNode.name)
                .replaceAll(
                  handler.theOnCreateMethod.exp,
                  handler.theOnCreateMethod
                      .stringMatch()
                      .replaceAll(
                        handler.theOnCreateMethod.returnType,
                        classNode.name,
                      )
                      .replaceAll(
                        handler.theOnCreateMethod.creationArgsClassName,
                        classNode.name,
                      ),
                )
                .replaceAll(
                  handler.aStaticMethod.exp,
                  classNode.staticMethods.map<String>((MethodNode methodNode) {
                    final HandlerStaticMethod staticMethod =
                        handler.aStaticMethod;
                    return staticMethod
                        .stringMatch()
                        .replaceAll(
                          staticMethod.name,
                          methodNode.name.pascalCase,
                        )
                        .replaceAll(
                          staticMethod.aParameter.exp,
                          methodNode.parameters
                              .map<String>((ParameterNode parameterNode) {
                            final FollowingParameter parameter =
                                staticMethod.aParameter;
                            return parameter
                                .stringMatch()
                                .replaceAll(parameter.name, parameterNode.name)
                                .replaceAll(
                                  parameter.type,
                                  getTrueTypeName(parameterNode.type),
                                );
                          }).join(' '),
                        );
                  }).join('\n'),
                )
                .replaceAll(
                    handler.aStaticMethodInvoker.exp,
                    classNode.staticMethods
                        .map<String>((MethodNode methodNode) {
                      final HandlerStaticMethodInvoker staticMethodInvoker =
                          handler.aStaticMethodInvoker;
                      return staticMethodInvoker
                          .stringMatch()
                          .replaceAll(
                            staticMethodInvoker.methodName,
                            methodNode.name,
                          )
                          .replaceAll(
                            staticMethodInvoker.methodHandler,
                            methodNode.name.pascalCase,
                          )
                          .replaceAll(
                            staticMethodInvoker.anArgument.exp,
                            incrementingList(
                              methodNode.parameters.length,
                            ).map<String>(
                              (int index) {
                                final HandlerStaticMethodInvokerArgument
                                    argument = staticMethodInvoker.anArgument;
                                return argument
                                    .stringMatch()
                                    .replaceAll(
                                      argument.type,
                                      getTrueTypeName(
                                        methodNode.parameters[index].type,
                                      ),
                                    )
                                    .replaceAll(
                                      argument.index,
                                      index.toString(),
                                    );
                              },
                            ).join(','),
                          );
                    }).join('\n'))
                .replaceAll(
                  handler.theCreationArguments.exp,
                  handler.theCreationArguments
                      .stringMatch()
                      .replaceAll(handler.theCreationArguments.className,
                          classNode.name)
                      .replaceAll(
                        handler.theCreationArguments.aFieldName.exp,
                        classNode.fields.map<String>((FieldNode fieldNode) {
                          final HandlerCreationArguments arguments =
                              handler.theCreationArguments;
                          return arguments.aFieldName.stringMatch().replaceAll(
                                arguments.aFieldName.name,
                                fieldNode.name.pascalCase,
                              );
                        }).join(','),
                      ),
                )
                .replaceAll(
                  handler.theCreateInstance.exp,
                  handler.theCreateInstance
                      .stringMatch()
                      .replaceAll(
                        handler.theCreateInstance.className,
                        classNode.name,
                      )
                      .replaceAll(handler.theCreateInstance.returnTypeClassName,
                          classNode.name)
                      .replaceAll(
                        handler.theCreateInstance.argsClassName,
                        classNode.name,
                      )
                      .replaceAll(
                        handler.theCreateInstance.aField.exp,
                        incrementingList(classNode.fields.length)
                            .map<String>((int index) {
                          final HandlerCreateInstanceField field =
                              handler.theCreateInstance.aField;
                          return field
                              .stringMatch()
                              .replaceAll(
                                field.name,
                                classNode.fields[index].name,
                              )
                              .replaceAll(
                                field.type,
                                getTrueTypeName(
                                  classNode.fields[index].type,
                                ),
                              )
                              .replaceAll(
                                field.index,
                                index.toString(),
                              );
                        }).join('\n'),
                      ),
                )
                .replaceAll(
                  handler.theInvokeMethod.exp,
                  handler.theInvokeMethod
                      .stringMatch()
                      .replaceAll(
                        handler.theInvokeMethod.instanceClassName,
                        classNode.name,
                      )
                      .replaceAll(
                        handler.theInvokeMethod.forLoopClassName,
                        classNode.name,
                      ),
                );
          }).join('\n'));
}

String getTrueTypeName(ReferenceType type) {
  final String javaName = javaTypeNameConversion(type.name);

  final Iterable<String> typeArguments = type.typeArguments.map<String>(
    (ReferenceType type) => getTrueTypeName(type),
  );

  if (type.codeGeneratedClass && typeArguments.isEmpty) {
    return '\$$javaName';
  } else if (type.codeGeneratedClass && typeArguments.isNotEmpty) {
    return '\$$javaName<${typeArguments.join(',')}>';
  } else if (!type.codeGeneratedClass && typeArguments.isNotEmpty) {
    return '$javaName<${typeArguments.join(',')}>';
  }

  return javaName;
}

String javaTypeNameConversion(String type) {
  switch (type) {
    case 'int':
      return 'Integer';
    case 'double':
      return 'Double';
    case 'bool':
      return 'Boolean';
    case 'num':
      return 'Number';
  }

  return type;
}

class Library with TemplateRegExp {
  Library(this.template);

  @override
  final String template;

  @override
  final TemplateRegExp parent = null;

  @override
  final RegExp exp = null;

  final RegExp name = TemplateRegExp.regExp(
    r'(?<=^class )LibraryTemplate(?= \{)',
  );

  final RegExp package = TemplateRegExp.regExp(
    r'(?<=package )github.penguin.reference.templates(?=;)',
  );

  // final RegExp interfaces = TemplateRegExp.regExp(
  //   r'interface \$ClassTemplate \{.+}(?=\s+static class \$ClassTemplateCreationArgs \{)',
  // );
  //
  // final RegExp creationArgs = TemplateRegExp.regExp(
  //   r'static class \$ClassTemplateCreationArgs.*}(?=\s*static class \$ClassTemplateChannel)',
  // );
  //
  // final RegExp channels = TemplateRegExp.regExp(
  //   r'static class \$ClassTemplateChannel.*}(?=\s*static class \$ClassTemplateHandler)',
  // );
  //
  // final RegExp handlers = TemplateRegExp.regExp(
  //   r'static class \$ClassTemplateHandler.*}(?=\s+\}\s+$)',
  // );

  Interface get anInterface => Interface(this);

  CreationArgsClass get aCreationArgsClass => CreationArgsClass(this);

  Channel get aChannel => Channel(this);

  Handler get aHandler => Handler(this);
}

class Interface with TemplateRegExp {
  Interface(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'(?<=interface \$)ClassTemplate');

  // final RegExp fields =
  //     TemplateRegExp.regExp(r'Integer getFieldTemplate[^;]+;[^;]+;');

  InterfaceField get aField => InterfaceField(this);

  InterfaceMethod get aMethod => InterfaceMethod(this);

  @override
  final RegExp exp =
      TemplateRegExp.regExp(r'interface \$ClassTemplate \{[^\}]+\}');

  @override
  final Library parent;
}

class InterfaceField with TemplateRegExp {
  InterfaceField(this.parent);

  final RegExp type = TemplateRegExp.regExp(r'Integer');

  final RegExp name = TemplateRegExp.regExp(r'(?<=get)FieldTemplate');

  @override
  final RegExp exp = TemplateRegExp.regExp(r'Integer getFieldTemplate\(\);');

  @override
  final Interface parent;
}

class InterfaceMethod with TemplateRegExp {
  InterfaceMethod(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'methodTemplate(?=\()');

  // final RegExp parameters = TemplateRegExp.regExp(
  //   r'String parameterTemplate, \$ClassTemplate2 referenceParameterTemplate',
  // );

  Parameter get aParameter => Parameter(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(r'Object methodTemplate\([^;]+;');

  @override
  final Interface parent;
}

class Parameter with TemplateRegExp {
  Parameter(this.parent);

  final RegExp type = TemplateRegExp.regExp(r'String(?= )');

  final RegExp name = TemplateRegExp.regExp(r'parameterTemplate$');

  @override
  final RegExp exp = TemplateRegExp.regExp(r'String parameterTemplate');

  @override
  final TemplateRegExp parent;
}

class FollowingParameter with TemplateRegExp {
  FollowingParameter(this.parent);

  final RegExp type = TemplateRegExp.regExp(r'String(?= )');

  final RegExp name = TemplateRegExp.regExp(r'parameterTemplate$');

  @override
  final RegExp exp = TemplateRegExp.regExp(r',\s*String parameterTemplate');

  @override
  final TemplateRegExp parent;
}

class CreationArgsClass with TemplateRegExp {
  CreationArgsClass(this.parent);

  final RegExp className = TemplateRegExp.regExp(r'(?<=class \$)ClassTemplate');

  // final RegExp fields = TemplateRegExp.regExp(r'Integer fieldTemplate;[^;]+;');

  CreationArgsClassField get aField => CreationArgsClassField(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'static class \$ClassTemplateCreationArgs[^\}]+\}',
  );

  @override
  final Library parent;
}

class CreationArgsClassField with TemplateRegExp {
  CreationArgsClassField(this.parent);

  final RegExp type = TemplateRegExp.regExp(r'^Integer');
  final RegExp name = TemplateRegExp.regExp(r'fieldTemplate(?=;)');

  @override
  final RegExp exp = TemplateRegExp.regExp(r'Integer fieldTemplate;');

  @override
  final CreationArgsClass parent;
}

class Channel with TemplateRegExp {
  Channel(this.parent);

  final RegExp className = TemplateRegExp.regExp(
    r'(?<=class \$)ClassTemplate',
  );

  final RegExp typeArgumentClassName = TemplateRegExp.regExp(
    r'(?<=extends ReferenceChannel<\$)ClassTemplate',
  );

  final RegExp constructorClassName = TemplateRegExp.regExp(
    r'(?<=\$)ClassTemplate(?=Channel\()',
  );

  final RegExp channel = TemplateRegExp.regExp(
    r'(?<=super\(manager, ")github\.penguin/template/template/ClassTemplate',
  );

  ChannelStaticMethod get aStaticMethod => ChannelStaticMethod(this);

  ChannelMethod get aMethod => ChannelMethod(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'static class \$ClassTemplateChannel.*}(?=\s*static class \$ClassTemplateHandler)',
  );

  @override
  final Library parent;
}

class ChannelStaticMethod with TemplateRegExp {
  ChannelStaticMethod(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'StaticMethodTemplate');

  final RegExp nameAsParameter = TemplateRegExp.regExp(r'staticMethodTemplate');

  // final RegExp parameters = TemplateRegExp.regExp(
  //   r'String parameterTemplate, \$ClassTemplate2 referenceParameterTemplate',
  // );

  // final RegExp channelParameters = TemplateRegExp.regExp(
  //   r'(?<=asList\(\s*)parameterTemplate[^\)]+\)',
  // );

  Parameter get aParameter => Parameter(this);

  ParameterName get aParameterName => ParameterName(this);

  // ParameterReference get aParameterReference => ParameterReference(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'Completable<Object> \$invokeStaticMethodTemplate[^\}]+\}',
  );

  @override
  final Channel parent;
}

class ChannelMethod with TemplateRegExp {
  ChannelMethod(this.parent);

  final RegExp name = TemplateRegExp.regExp(
    r'(?<=Completable<Object>\s\$invoke)MethodTemplate',
  );

  final RegExp instanceClassName = TemplateRegExp.regExp(
    r'(?<=\$)ClassTemplate(?= instance)',
  );

  final RegExp channelMethodName = TemplateRegExp.regExp(
    r'(?<=")methodTemplate(?=")',
  );

  // final RegExp parameters = TemplateRegExp.regExp(
  //   r',\s*String parameterTemplate,\s*\$ClassTemplate2 referenceParameterTemplate',
  // );
  //
  // final RegExp channelParameters = TemplateRegExp.regExp(
  //   r'(?<=asList\(\s*)parameterTemplate[^\)]+\)',
  // );

  FollowingParameter get aParameter => FollowingParameter(this);

  ParameterName get aParameterName => ParameterName(this);

  // ParameterReference get aParameterReference => ParameterReference(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'Completable<Object>\s\$invokeMethodTemplate[^\}]+\}',
  );

  @override
  final Channel parent;
}

class ParameterName with TemplateRegExp {
  ParameterName(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'parameterTemplate');

  @override
  final RegExp exp =
      TemplateRegExp.regExp(r'(?<=asList\(\s*)parameterTemplate');

  @override
  final TemplateRegExp parent;
}

// class ParameterReference with TemplateRegExp {
//   ParameterReference(this.parent);
//
//   final RegExp name = TemplateRegExp.regExp(r'referenceParameterTemplate');
//
//   final RegExp channel = TemplateRegExp.regExp(
//     r'github\.penguin/template/template/ClassTemplate2',
//   );
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(r'replaceIfUnpaired\([^\)]+\)');
//
//   @override
//   final TemplateRegExp parent;
// }

class Handler with TemplateRegExp {
  Handler(this.parent);

  final RegExp className = TemplateRegExp.regExp(
    r'(?<=static class \$)ClassTemplate(?=Handler)',
  );

  final RegExp typeArgClassName = TemplateRegExp.regExp(
    r'(?<=ReferenceChannelHandler<\$)ClassTemplate',
  );

  HandlerOnCreateMethod get theOnCreateMethod => HandlerOnCreateMethod(this);

  HandlerStaticMethod get aStaticMethod => HandlerStaticMethod(this);

  HandlerStaticMethodInvoker get aStaticMethodInvoker =>
      HandlerStaticMethodInvoker(this);

  HandlerCreationArguments get theCreationArguments =>
      HandlerCreationArguments(this);

  HandlerCreateInstance get theCreateInstance => HandlerCreateInstance(this);

  HandlerInvokeMethod get theInvokeMethod => HandlerInvokeMethod(this);

  final RegExp onInstanceDisposedClassName = TemplateRegExp.regExp(
    r'(?<=void onInstanceDisposed\([^\$]+\$)ClassTemplate',
  );

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'static class \$ClassTemplateHandler.*}(?=\s+\}\s+$)',
  );

  @override
  final Library parent;
}

class HandlerOnCreateMethod with TemplateRegExp {
  HandlerOnCreateMethod(this.parent);

  final RegExp returnType = TemplateRegExp.regExp(
    r'ClassTemplate(?= onCreate\()',
  );

  final RegExp creationArgsClassName = TemplateRegExp.regExp(
    r'(?<=\$)ClassTemplate(?=CreationArgs args)',
  );

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'\$ClassTemplate onCreate\([^\}]+\}',
  );

  @override
  final Handler parent;
}

class HandlerStaticMethod with TemplateRegExp {
  HandlerStaticMethod(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'StaticMethodTemplate(?=\()');

  // final RegExp parameters = TemplateRegExp.regExp(
  //   r',\s*String parameterTemplate,\s+\$ClassTemplate2 referenceParameterTemplate',
  // );

  FollowingParameter get aParameter => FollowingParameter(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'public Object \$onStaticMethodTemplate[^\}]+\}',
  );

  @override
  final Handler parent;
}

class HandlerStaticMethodInvoker with TemplateRegExp {
  HandlerStaticMethodInvoker(this.parent);

  final RegExp methodName = TemplateRegExp.regExp(
    r'(?<=")staticMethodTemplate(?=")',
  );

  final RegExp methodHandler = TemplateRegExp.regExp(
    r'(?<=\$on)StaticMethodTemplate',
  );

  // final RegExp arguments = TemplateRegExp.regExp(
  //   r', \(String\) arguments.get\(0\), \(\$ClassTemplate2\) arguments.get\(1\)',
  // );

  HandlerStaticMethodInvokerArgument get anArgument =>
      HandlerStaticMethodInvokerArgument(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'case "staticMethodTemplate"[^;]+;',
  );

  @override
  final Handler parent;
}

class HandlerStaticMethodInvokerArgument with TemplateRegExp {
  HandlerStaticMethodInvokerArgument(this.parent);

  final RegExp type = TemplateRegExp.regExp(r'(?<=\()String(?=\))');

  final RegExp index = TemplateRegExp.regExp(r'(?<=arguments\.get\()0');

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r', \(String\) arguments.get\(0\)',
  );

  @override
  final HandlerStaticMethodInvoker parent;
}

class HandlerCreationArguments with TemplateRegExp {
  HandlerCreationArguments(this.parent);

  final RegExp className = TemplateRegExp.regExp(
    r'(?<=\$)ClassTemplate(?= instance\))',
  );

  // final RegExp fields = TemplateRegExp.regExp(
  //   r'(?<=\(\s*)instance\.getFieldTemplate([^\)]*\)){3}',
  // );

  HandlerCreationArgumentsFieldName get aFieldName =>
      HandlerCreationArgumentsFieldName(this);

  // HandlerCreationArgumentsFieldReference get aFieldReference =>
  //     HandlerCreationArgumentsFieldReference(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'getCreationArguments[^\}]+\}',
  );

  @override
  final Handler parent;
}

class HandlerCreationArgumentsFieldName with TemplateRegExp {
  HandlerCreationArgumentsFieldName(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'FieldTemplate');

  @override
  final RegExp exp =
      TemplateRegExp.regExp(r'(?<=\(\s*)instance\.getFieldTemplate\(\)');

  @override
  final HandlerCreationArguments parent;
}

class HandlerCreationArgumentsFieldReference with TemplateRegExp {
  HandlerCreationArgumentsFieldReference(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'ReferenceParameterTemplate');

  final RegExp channel = TemplateRegExp.regExp(
    r'github\.penguin/template/template/ClassTemplate2',
  );

  @override
  final RegExp exp = TemplateRegExp.regExp(r'replaceIfUnpaired[^\)]+\)\)');

  @override
  final HandlerCreationArguments parent;
}

class HandlerCreateInstance with TemplateRegExp {
  HandlerCreateInstance(this.parent);

  final RegExp className = TemplateRegExp.regExp(
    r'ClassTemplate(?= createInstance\()',
  );

  final RegExp returnTypeClassName = TemplateRegExp.regExp(
    r'(?<=^\$)ClassTemplate',
  );

  final RegExp argsClassName = TemplateRegExp.regExp(
      r'ClassTemplate(?=CreationArgs\(|CreationArgs args)');

  // final RegExp fields = TemplateRegExp.regExp(
  //   r'args\.fieldTemplate([^;]+;){2}',
  // );

  HandlerCreateInstanceField get aField => HandlerCreateInstanceField(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'\$ClassTemplate createInstance\([^\}]+\}',
  );

  @override
  final Handler parent;
}

class HandlerCreateInstanceField with TemplateRegExp {
  HandlerCreateInstanceField(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'fieldTemplate');

  final RegExp type = TemplateRegExp.regExp(r'(?<=\()Integer(?=\))');

  final RegExp index = TemplateRegExp.regExp(r'(?<=\.get\()0');

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'args\.fieldTemplate = \(Integer\) arguments.get\(0\);',
  );

  @override
  final HandlerCreateInstance parent;
}

class HandlerInvokeMethod with TemplateRegExp {
  HandlerInvokeMethod(this.parent);

  final RegExp instanceClassName = TemplateRegExp.regExp(
    r'ClassTemplate(?= instance,)',
  );

  final RegExp forLoopClassName = TemplateRegExp.regExp(
    r'ClassTemplate(?=\.class)',
  );

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'Object invokeMethod\([^\}]+\}',
  );

  @override
  final Handler parent;
}
