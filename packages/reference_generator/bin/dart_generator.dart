import 'package:recase/recase.dart';
import 'package:reference_generator/src/ast.dart';

import 'common.dart';

String generateDart(String template, LibraryNode libraryNode) {
  final Library library = Library(template);
  return template
      .replaceAll(
        library.aMixin.exp,
        libraryNode.classes
            .map<String>(
              (ClassNode classNode) => library.aMixin
                  .stringMatch()
                  .replaceAll(library.aMixin.name, classNode.name)
                  .replaceAll(
                    library.aMixin.aField.exp,
                    classNode.fields
                        .map<String>(
                          (FieldNode fieldNode) => library.aMixin.aField
                              .stringMatch()
                              .replaceAll(
                                  library.aMixin.aField.name, fieldNode.name)
                              .replaceAll(
                                library.aMixin.aField.type,
                                getTrueTypeName(fieldNode.type),
                              ),
                        )
                        .join('\n'),
                  )
                  .replaceAll(
                    library.aMixin.aMethod.exp,
                    classNode.methods
                        .map<String>(
                          (MethodNode methodNode) => library.aMixin.aMethod
                              .stringMatch()
                              .replaceAll(
                                library.aMixin.aMethod.returnType,
                                getTrueTypeName(methodNode.returnType),
                              )
                              .replaceAll(
                                library.aMixin.aMethod.name,
                                methodNode.name,
                              )
                              .replaceAll(
                                library.aMixin.aMethod.aParameter.exp,
                                methodNode.parameters
                                    .map<String>(
                                      (ParameterNode parameterNode) =>
                                          library.aMixin.aMethod.aParameter
                                              .stringMatch()
                                              .replaceAll(
                                                library.aMixin.aMethod
                                                    .aParameter.type,
                                                getTrueTypeName(
                                                  parameterNode.type,
                                                ),
                                              )
                                              .replaceAll(
                                                library.aMixin.aMethod
                                                    .aParameter.name,
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
        library.aCreationArgsClass.exp,
        libraryNode.classes
            .map<String>(
              (ClassNode classNode) => library.aCreationArgsClass
                  .stringMatch()
                  .replaceAll(
                    library.aCreationArgsClass.className,
                    classNode.name,
                  )
                  .replaceAll(
                    library.aCreationArgsClass.aField.exp,
                    classNode.fields
                        .map<String>(
                          (FieldNode fieldNode) =>
                              library.aCreationArgsClass.aField
                                  .stringMatch()
                                  .replaceAll(
                                    library.aCreationArgsClass.aField.name,
                                    fieldNode.name,
                                  )
                                  .replaceAll(
                                    library.aCreationArgsClass.aField.type,
                                    getTrueTypeName(fieldNode.type),
                                  ),
                        )
                        .join('\n'),
                  ),
            )
            .join('\n\n'),
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
                                ReCase(methodNode.name).pascalCase,
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
                                    .join(', '),
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
        libraryNode.classes
            .map<String>(
              (ClassNode classNode) => library.aHandler
                  .stringMatch()
                  .replaceAll(library.aHandler.className, classNode.name)
                  .replaceAll(library.aHandler.typeArgClassName, classNode.name)
                  .replaceAll(
                    library.aHandler.constructorClassName,
                    classNode.name,
                  )
                  .replaceAll(
                    library.aHandler.aStaticMethodName.exp,
                    classNode.staticMethods
                        .map<String>(
                          (MethodNode methodNode) => library
                              .aHandler.aStaticMethodName
                              .stringMatch()
                              .replaceAll(
                                library.aHandler.aStaticMethodName.name,
                                methodNode.name.pascalCase,
                              ),
                        )
                        .join(' '),
                  )
                  .replaceAll(
                    library.aHandler.aOnCreateMethod.exp,
                    library.aHandler.aOnCreateMethod
                        .stringMatch()
                        .replaceAll(
                          library.aHandler.aOnCreateMethod.returnType,
                          classNode.name,
                        )
                        .replaceAll(
                          library
                              .aHandler.aOnCreateMethod.creationArgsClassName,
                          classNode.name,
                        ),
                  )
                  .replaceAll(
                    library.aHandler.aStaticMethod.exp,
                    classNode.staticMethods
                        .map<String>(
                          (MethodNode methodNode) => library
                              .aHandler.aStaticMethod
                              .stringMatch()
                              .replaceAll(
                                library.aHandler.aStaticMethod.name,
                                methodNode.name.pascalCase,
                              )
                              .replaceAll(
                                library.aHandler.aStaticMethod.returnType,
                                getTrueTypeName(methodNode.returnType),
                              )
                              .replaceAll(
                                library.aHandler.aStaticMethod.aParameter.exp,
                                methodNode.parameters
                                    .map<String>(
                                      (ParameterNode parameterNode) => library
                                          .aHandler.aStaticMethod.aParameter
                                          .stringMatch()
                                          .replaceAll(
                                            library.aHandler.aStaticMethod
                                                .aParameter.name,
                                            parameterNode.name,
                                          )
                                          .replaceAll(
                                            library.aHandler.aStaticMethod
                                                .aParameter.type,
                                            getTrueTypeName(parameterNode.type),
                                          ),
                                    )
                                    .join(', '),
                              ),
                        )
                        .join('\n'),
                  )
                  .replaceAll(
                    library.aHandler.aStaticMethodInvoker.exp,
                    classNode.staticMethods.map<String>(
                      (MethodNode methodNode) {
                        final HandlerStaticMethodInvoker invoker =
                            library.aHandler.aStaticMethodInvoker;
                        return invoker
                            .stringMatch()
                            .replaceAll(invoker.methodName, methodNode.name)
                            .replaceAll(
                                invoker.anArgument.exp,
                                incrementingList(methodNode.parameters.length)
                                    .map<String>(
                                  (int index) {
                                    final MethodArgument argument = library
                                        .aHandler
                                        .aStaticMethodInvoker
                                        .anArgument;
                                    return argument
                                        .stringMatch()
                                        .replaceAll(argument.index, '$index')
                                        .replaceAll(
                                          argument.type,
                                          getTrueTypeName(methodNode
                                              .parameters[index].type),
                                        );
                                  },
                                ).join(','))
                            .replaceAll(
                              invoker.methodHandler,
                              methodNode.name.pascalCase,
                            );
                      },
                    ).join('\n'),
                  )
                  .replaceAll(
                    library.aHandler.theCreationArguments.exp,
                    library.aHandler.theCreationArguments
                        .stringMatch()
                        .replaceAll(
                          library.aHandler.theCreationArguments.className,
                          classNode.name,
                        )
                        .replaceAll(
                          library.aHandler.theCreationArguments.aFieldName.exp,
                          classNode.fields
                              .map<String>(
                                (FieldNode fieldNode) => library
                                    .aHandler.theCreationArguments.aFieldName
                                    .stringMatch()
                                    .replaceAll(
                                      library.aHandler.theCreationArguments
                                          .aFieldName.name,
                                      fieldNode.name,
                                    ),
                              )
                              .join(', '),
                        ),
                  )
                  .replaceAll(
                    library.aHandler.theCreateInstance.exp,
                    library.aHandler.theCreateInstance
                        .stringMatch()
                        .replaceAll(
                          library.aHandler.theCreateInstance.className,
                          classNode.name,
                        )
                        .replaceAll(
                          library.aHandler.theCreateInstance.argsClassName,
                          classNode.name,
                        )
                        .replaceAll(
                          library.aHandler.theCreateInstance.aField.exp,
                          incrementingList(classNode.fields.length).map<String>(
                            (int index) {
                              final HandlerCreateInstanceField field =
                                  library.aHandler.theCreateInstance.aField;
                              return field
                                  .stringMatch()
                                  .replaceAll(
                                    field.type,
                                    getTrueTypeName(
                                      classNode.fields[index].type,
                                    ),
                                  )
                                  .replaceAll(
                                    field.name,
                                    classNode.fields[index].name,
                                  )
                                  .replaceAll(field.index, index.toString());
                            },
                          ).join('\n'),
                        ),
                  )
                  .replaceAll(
                    library.aHandler.theHandlerInvokeMethod.exp,
                    library.aHandler.theHandlerInvokeMethod
                        .stringMatch()
                        .replaceAll(
                          library.aHandler.theHandlerInvokeMethod
                              .instanceClassName,
                          classNode.name,
                        )
                        .replaceAll(
                          library.aHandler.theHandlerInvokeMethod.anInvoker.exp,
                          classNode.methods.map<String>(
                            (MethodNode methodNode) {
                              final HandlerInvokeMethodInvoker invoker = library
                                  .aHandler.theHandlerInvokeMethod.anInvoker;
                              return invoker
                                  .stringMatch()
                                  .replaceAll(
                                    invoker.methodName,
                                    methodNode.name,
                                  )
                                  .replaceAll(
                                    invoker.instanceMethodName,
                                    methodNode.name,
                                  )
                                  .replaceAll(
                                    invoker.anArgument.exp,
                                    incrementingList(
                                            methodNode.parameters.length)
                                        .map<String>(
                                      (int index) {
                                        final MethodArgument argument = library
                                            .aHandler
                                            .theHandlerInvokeMethod
                                            .anInvoker
                                            .anArgument;
                                        return argument
                                            .stringMatch()
                                            .replaceAll(
                                              argument.index,
                                              '$index',
                                            )
                                            .replaceAll(
                                              argument.type,
                                              getTrueTypeName(
                                                methodNode
                                                    .parameters[index].type,
                                              ),
                                            );
                                      },
                                    ).join(','),
                                  );
                            },
                          ).join('\n'),
                        ),
                  ),
            )
            .join(''),
      )
      .replaceAll(
        library.theChannels.exp,
        library.theChannels.stringMatch().replaceAll(
              library.theChannels.aVariable.exp,
              libraryNode.classes.map<String>(
                (ClassNode classNode) {
                  final ChannelsVariable variable =
                      library.theChannels.aVariable;
                  return variable
                      .stringMatch()
                      .replaceAll(variable.channelClassName, classNode.name)
                      .replaceAll(
                        variable.variableClassName,
                        ReCase(classNode.name).camelCase,
                      );
                },
              ).join('\n'),
            ),
      );
}

String getTrueTypeName(ReferenceType type) {
  final Iterable<String> typeArguments = type.typeArguments.map<String>(
    (ReferenceType type) => getTrueTypeName(type),
  );

  if (type.codeGeneratedClass && typeArguments.isEmpty) {
    return '\$${type.name}';
  } else if (type.codeGeneratedClass && typeArguments.isNotEmpty) {
    return '\$${type.name}<${typeArguments.join(',')}>';
  } else if (!type.codeGeneratedClass && typeArguments.isNotEmpty) {
    return '${type.name}<${typeArguments.join(',')}>';
  }

  return type.name;
}

class Library with TemplateRegExp {
  Library(this.template);

  @override
  final String template;

  @override
  RegExp get exp => null;

  @override
  TemplateRegExp get parent => null;

  Mixin get aMixin => Mixin(this);

  CreationArgsClass get aCreationArgsClass => CreationArgsClass(this);

  Channel get aChannel => Channel(this);

  Handler get aHandler => Handler(this);

  Channels get theChannels => Channels(this);
}

class Mixin with TemplateRegExp {
  Mixin(this.parent);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'mixin \$ClassTemplate \{[^\}]+\}',
  );

  @override
  final Library parent;

  final RegExp name = TemplateRegExp.regExp(r'(?<=mixin \$)ClassTemplate');

  ClassMethod get aMethod => ClassMethod(this);
  ClassField get aField => ClassField(this);
}

class ClassField with TemplateRegExp {
  ClassField(this.parent);

  final RegExp type = TemplateRegExp.regExp(r'^int');
  final RegExp name = TemplateRegExp.regExp(r'fieldTemplate(?=;)');

  @override
  final RegExp exp = TemplateRegExp.regExp('int get fieldTemplate;');

  @override
  final Mixin parent;
}

class ClassMethod with TemplateRegExp {
  ClassMethod(this.parent);

  final RegExp returnType = TemplateRegExp.regExp(r'^Future<String>');

  final RegExp name = TemplateRegExp.regExp(r'methodTemplate');

  Parameter get aParameter => Parameter(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'Future<String> methodTemplate\([^;]+;',
  );

  @override
  final Mixin parent;
}

class Parameter with TemplateRegExp {
  Parameter(this.parent);

  final RegExp type = TemplateRegExp.regExp(r'^String');

  final RegExp name = TemplateRegExp.regExp(r'parameterTemplate$');

  @override
  final RegExp exp = TemplateRegExp.regExp(r'String parameterTemplate');

  @override
  final TemplateRegExp parent;
}

class CreationArgsClass with TemplateRegExp {
  CreationArgsClass(this.parent);

  final RegExp className = TemplateRegExp.regExp(r'(?<=class \$)ClassTemplate');

  CreationArgsClassField get aField => CreationArgsClassField(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'class \$ClassTemplateCreationArgs[^\}]+\}',
  );

  @override
  final Library parent;
}

class CreationArgsClassField with TemplateRegExp {
  CreationArgsClassField(this.parent);

  final RegExp type = TemplateRegExp.regExp(r'(?<=late )int');
  final RegExp name = TemplateRegExp.regExp(r'fieldTemplate(?=;)');

  @override
  final RegExp exp = TemplateRegExp.regExp(r'late int fieldTemplate;');

  @override
  final CreationArgsClass parent;
}

class Channel with TemplateRegExp {
  Channel(this.parent);

  final RegExp className = TemplateRegExp.regExp(
    r'(?<=class \$)ClassTemplate',
  );

  final RegExp typeArgumentClassName = TemplateRegExp.regExp(
    r'(?<=extends TypeChannel<\$)ClassTemplate',
  );

  final RegExp constructorClassName = TemplateRegExp.regExp(
    r'(?<=\$)ClassTemplate(?=Channel\()',
  );

  final RegExp channel = TemplateRegExp.regExp(
    r"(?<=super\(messenger, ')github\.penguin/template/template/ClassTemplate",
  );

  ChannelStaticMethod get aStaticMethod => ChannelStaticMethod(this);

  ChannelMethod get aMethod => ChannelMethod(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'class \$ClassTemplateChannel.*}(?=\s*class \$ClassTemplateHandler)',
  );

  @override
  final Library parent;
}

class ChannelStaticMethod with TemplateRegExp {
  ChannelStaticMethod(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'StaticMethodTemplate');

  final RegExp nameAsParameter = TemplateRegExp.regExp(r'staticMethodTemplate');

  Parameter get aParameter => Parameter(this);

  ParameterName get aParameterName => ParameterName(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'Future<Object\?> \$invokeStaticMethodTemplate[^\}]+\}',
  );

  @override
  final Channel parent;
}

class ChannelMethod with TemplateRegExp {
  ChannelMethod(this.parent);

  final RegExp name = TemplateRegExp.regExp(
    r'(?<=Future<Object\?>\s\$invoke)MethodTemplate',
  );

  final RegExp instanceClassName = TemplateRegExp.regExp(
    r'(?<=\$)ClassTemplate(?= instance)',
  );

  final RegExp channelMethodName = TemplateRegExp.regExp(
    r"(?<=')methodTemplate(?=')",
  );

  Parameter get aParameter => Parameter(this);

  ParameterName get aParameterName => ParameterName(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'Future<Object\?>\s\$invokeMethodTemplate[^\}]+\}',
  );

  @override
  final Channel parent;
}

class ParameterName with TemplateRegExp {
  ParameterName(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'parameterTemplate');

  @override
  final RegExp exp =
      TemplateRegExp.regExp(r'(?<=<Object\?>\[\s*)parameterTemplate');

  @override
  final TemplateRegExp parent;
}

class Handler with TemplateRegExp {
  Handler(this.parent);

  final RegExp className = TemplateRegExp.regExp(
    r'(?<=class \$)ClassTemplate(?=Handler)',
  );

  final RegExp typeArgClassName = TemplateRegExp.regExp(
    r'(?<=TypeChannelHandler<\$)ClassTemplate',
  );

  final RegExp constructorClassName = TemplateRegExp.regExp(
    r'(?<=\$)ClassTemplate(?=Handler\()',
  );

  HandlerStaticMethodName get aStaticMethodName =>
      HandlerStaticMethodName(this);

  HandlerOnCreateMethod get aOnCreateMethod => HandlerOnCreateMethod(this);

  HandlerStaticMethod get aStaticMethod => HandlerStaticMethod(this);

  HandlerStaticMethodInvoker get aStaticMethodInvoker =>
      HandlerStaticMethodInvoker(this);

  HandlerCreationArguments get theCreationArguments =>
      HandlerCreationArguments(this);

  HandlerCreateInstance get theCreateInstance => HandlerCreateInstance(this);

  HandlerInvokeMethod get theHandlerInvokeMethod => HandlerInvokeMethod(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'class \$ClassTemplateHandler.*}(?=\s*mixin \$Channels)',
  );

  @override
  final Library parent;
}

class HandlerStaticMethodName with TemplateRegExp {
  HandlerStaticMethodName(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'StaticMethodTemplate');

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'this\.\$onStaticMethodTemplate,',
  );

  @override
  final Handler parent;
}

class HandlerOnCreateMethod with TemplateRegExp {
  HandlerOnCreateMethod(this.parent);

  final RegExp returnType =
      TemplateRegExp.regExp(r'(?<=final \$)ClassTemplate');

  final RegExp creationArgsClassName =
      TemplateRegExp.regExp(r'(?<=\$)ClassTemplate(?=CreationArgs args)');

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'final \$ClassTemplate Function.*onCreate;',
  );

  @override
  final Handler parent;
}

class HandlerStaticMethod with TemplateRegExp {
  HandlerStaticMethod(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'StaticMethodTemplate(?=;)');

  final RegExp returnType = TemplateRegExp.regExp(r'(?<=final )double');

  Parameter get aParameter => Parameter(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'final double Function.*\$onStaticMethodTemplate;',
  );

  @override
  final Handler parent;
}

class HandlerStaticMethodInvoker with TemplateRegExp {
  HandlerStaticMethodInvoker(this.parent);

  final RegExp methodName = TemplateRegExp.regExp(
    r"(?<=')staticMethodTemplate(?=')",
  );

  final RegExp methodHandler = TemplateRegExp.regExp(
    r'(?<=\$on)StaticMethodTemplate',
  );

  MethodArgument get anArgument => MethodArgument(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r"case 'staticMethodTemplate'[^;]+;[^;]+;",
  );

  @override
  final Handler parent;
}

class MethodArgument with TemplateRegExp {
  MethodArgument(this.parent);

  final RegExp type = TemplateRegExp.regExp(r'(?<=as )String');

  final RegExp index = TemplateRegExp.regExp(r'(?<=\[)0');

  @override
  final RegExp exp = TemplateRegExp.regExp(r'arguments\[0\] as String');

  @override
  final TemplateRegExp parent;
}

class HandlerCreationArguments with TemplateRegExp {
  HandlerCreationArguments(this.parent);

  final RegExp className = TemplateRegExp.regExp(
    r'(?<=\$)ClassTemplate(?= instance,)',
  );

  HandlerCreationArgumentsFieldName get aFieldName =>
      HandlerCreationArgumentsFieldName(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'getCreationArguments[^\}]+\}',
  );

  @override
  final Handler parent;
}

class HandlerCreationArgumentsFieldName with TemplateRegExp {
  HandlerCreationArgumentsFieldName(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'fieldTemplate');

  @override
  final RegExp exp =
      TemplateRegExp.regExp(r'(?<=<Object\?>\[\s*)instance\.fieldTemplate');

  @override
  final HandlerCreationArguments parent;
}

class HandlerCreateInstance with TemplateRegExp {
  HandlerCreateInstance(this.parent);

  final RegExp className = TemplateRegExp.regExp(
    r'ClassTemplate(?= createInstance\()',
  );

  final RegExp argsClassName =
      TemplateRegExp.regExp(r'ClassTemplate(?=CreationArgs\()');

  HandlerCreateInstanceField get aField => HandlerCreateInstanceField(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'\$ClassTemplate createInstance[^\}]+\}',
  );

  @override
  final Handler parent;
}

class HandlerCreateInstanceField with TemplateRegExp {
  HandlerCreateInstanceField(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'fieldTemplate');

  final RegExp index = TemplateRegExp.regExp(r'0(?=\])');

  final RegExp type = TemplateRegExp.regExp(r'int$');

  @override
  final RegExp exp =
      TemplateRegExp.regExp(r'\.\.fieldTemplate = arguments\[0\] as int');

  @override
  final HandlerCreateInstance parent;
}

class HandlerInvokeMethod with TemplateRegExp {
  HandlerInvokeMethod(this.parent);

  final RegExp instanceClassName = TemplateRegExp.regExp(
    r'ClassTemplate(?= instance,)',
  );

  HandlerInvokeMethodInvoker get anInvoker => HandlerInvokeMethodInvoker(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'Object\? invokeMethod\(.+return method\(\);\s+\}(?=\s+\})',
  );

  @override
  final Handler parent;
}

class HandlerInvokeMethodInvoker with TemplateRegExp {
  HandlerInvokeMethodInvoker(this.parent);

  final RegExp methodName = TemplateRegExp.regExp(
    r"(?<=')methodTemplate(?=')",
  );

  final RegExp instanceMethodName = TemplateRegExp.regExp(
    r'(?<=instance\.)methodTemplate',
  );

  MethodArgument get anArgument => MethodArgument(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r"case 'methodTemplate'[^;]+;[^;]+;",
  );

  @override
  final HandlerInvokeMethod parent;
}

class Channels with TemplateRegExp {
  Channels(this.parent);

  @override
  final RegExp exp = TemplateRegExp.regExp(r'mixin \$Channels {[^\}]+}');

  @override
  final Library parent;

  ChannelsVariable get aVariable => ChannelsVariable(this);
}

class ChannelsVariable with TemplateRegExp {
  ChannelsVariable(this.parent);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'\$ClassTemplateChannel get classTemplateChannel;',
  );

  @override
  final Channels parent;

  final RegExp channelClassName = TemplateRegExp.regExp(
    r'(?<=\$)ClassTemplate',
  );

  final RegExp variableClassName = TemplateRegExp.regExp(
    r'(?<=get\s+)classTemplate',
  );
}
