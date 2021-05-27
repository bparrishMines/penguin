import 'package:recase/recase.dart';
import 'package:reference_generator/src/ast.dart';

import 'common.dart';

String generateDart(String template, LibraryNode libraryNode) {
  final Library library = Library(template);
  return template
      .replaceAll(
        library.aMixin.exp,
        libraryNode.classes
            .map<String>((ClassNode classNode) => library.aMixin
                .stringMatch()
                .replaceAll(library.aMixin.name, classNode.name))
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
                    library.aChannel.theChannelCreateMethod.exp,
                    library.aChannel.theChannelCreateMethod
                        .stringMatch()
                        .replaceAll(
                          library.aChannel.theChannelCreateMethod
                              .instanceClassName,
                          classNode.name,
                        )
                        .replaceAll(
                          library.aChannel.theChannelCreateMethod.aFieldName,
                          classNode.fields
                              .map<String>(
                                (FieldNode fieldNode) => fieldNode.name,
                              )
                              .join(', '),
                        )
                        .replaceAll(
                          library
                              .aChannel.theChannelCreateMethod.aParameter.exp,
                          classNode.fields.map<String>(
                            (FieldNode fieldNode) {
                              final ChannelCreateMethodParameter parameter =
                                  library.aChannel.theChannelCreateMethod
                                      .aParameter;
                              return parameter
                                  .stringMatch()
                                  .replaceAll(parameter.name, fieldNode.name)
                                  .replaceAll(
                                    parameter.type,
                                    getTrueTypeName(fieldNode.type),
                                  );
                            },
                          ).join(),
                        ),
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
                    library.aHandler.theOnCreateMethod.exp,
                    library.aHandler.theOnCreateMethod
                        .stringMatch()
                        .replaceAll(
                          library.aHandler.theOnCreateMethod.returnType,
                          classNode.name,
                        )
                        .replaceAll(
                          library.aHandler.theOnCreateMethod.aField.exp,
                          classNode.fields.map<String>((FieldNode fieldNode) {
                            final HandlerOnCreateMethodField field =
                                library.aHandler.theOnCreateMethod.aField;
                            return field
                                .stringMatch()
                                .replaceAll(field.name, fieldNode.name)
                                .replaceAll(
                                  field.type,
                                  getTrueTypeName(fieldNode.type),
                                );
                          }).join(','),
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
                    library.aHandler.aMethod.exp,
                    classNode.methods
                        .map<String>(
                          (MethodNode methodNode) => library.aHandler.aMethod
                              .stringMatch()
                              .replaceAll(
                                library.aHandler.aMethod.name,
                                methodNode.name.pascalCase,
                              )
                              .replaceAll(
                                library.aHandler.aMethod.aParameter.exp,
                                methodNode.parameters
                                    .map<String>(
                                      (ParameterNode parameterNode) => library
                                          .aHandler.aMethod.aParameter
                                          .stringMatch()
                                          .replaceAll(
                                            library.aHandler.aMethod.aParameter
                                                .name,
                                            parameterNode.name,
                                          )
                                          .replaceAll(
                                            library.aHandler.aMethod.aParameter
                                                .type,
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
                    library.aHandler.theCreateInstance.exp,
                    library.aHandler.theCreateInstance
                        .stringMatch()
                        .replaceAll(
                          library.aHandler.theCreateInstance.className,
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
                                    methodNode.name.pascalCase,
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
        library.theImplementations.exp,
        library.theImplementations
            .stringMatch()
            .replaceAll(
              library.theImplementations.aChannel.exp,
              libraryNode.classes.map<String>(
                (ClassNode classNode) {
                  final LibraryImplementationsChannel channel =
                      library.theImplementations.aChannel;
                  return channel
                      .stringMatch()
                      .replaceAll(channel.channelClassName, classNode.name)
                      .replaceAll(
                        channel.variableClassName,
                        ReCase(classNode.name).camelCase,
                      );
                },
              ).join('\n'),
            )
            .replaceAll(
              library.theImplementations.aHandler.exp,
              libraryNode.classes.map<String>(
                (ClassNode classNode) {
                  final LibraryImplementationsHandler handler =
                      library.theImplementations.aHandler;
                  return handler
                      .stringMatch()
                      .replaceAll(handler.channelClassName, classNode.name)
                      .replaceAll(
                        handler.variableClassName,
                        ReCase(classNode.name).camelCase,
                      );
                },
              ).join('\n'),
            ),
      )
      .replaceAll(
        library.theChannelRegistrar.exp,
        library.theChannelRegistrar
            .stringMatch()
            .replaceAll(
              library.theChannelRegistrar.aSetter.exp,
              libraryNode.classes.map<String>(
                (ClassNode classNode) {
                  final ChannelRegistrarSetter setter =
                      library.theChannelRegistrar.aSetter;
                  return setter
                      .stringMatch()
                      .replaceAll(
                        setter.channelClassName,
                        ReCase(classNode.name).camelCase,
                      )
                      .replaceAll(
                        setter.handlerClassName,
                        ReCase(classNode.name).camelCase,
                      );
                },
              ).join('\n'),
            )
            .replaceAll(
              library.theChannelRegistrar.aRemover.exp,
              libraryNode.classes.map<String>(
                (ClassNode classNode) {
                  final ChannelRegistrarRemover remover =
                      library.theChannelRegistrar.aRemover;
                  return remover.stringMatch().replaceAll(
                        remover.channelClassName,
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

  Channel get aChannel => Channel(this);

  Handler get aHandler => Handler(this);

  LibraryImplementations get theImplementations => LibraryImplementations(this);

  ChannelRegistrar get theChannelRegistrar => ChannelRegistrar(this);
}

class Mixin with TemplateRegExp {
  Mixin(this.parent);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'mixin \$ClassTemplate \{\}',
  );

  @override
  final Library parent;

  final RegExp name = TemplateRegExp.regExp(r'(?<=mixin \$)ClassTemplate');
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

  ChannelCreateMethod get theChannelCreateMethod => ChannelCreateMethod(this);

  ChannelStaticMethod get aStaticMethod => ChannelStaticMethod(this);

  ChannelMethod get aMethod => ChannelMethod(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'class \$ClassTemplateChannel.*}(?=\s*class \$ClassTemplateHandler)',
  );

  @override
  final Library parent;
}

class ChannelCreateMethod with TemplateRegExp {
  ChannelCreateMethod(this.parent);

  final RegExp instanceClassName = TemplateRegExp.regExp(
    r'(?<=\$)ClassTemplate(?= \$instance)',
  );

  ChannelCreateMethodParameter get aParameter =>
      ChannelCreateMethodParameter(this);

  final RegExp aFieldName =
      TemplateRegExp.regExp(r'(?<=<Object\?>\[)fieldTemplate(?=\])');

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'Future<PairedInstance\?> \$create[^\}]+\}[^\}]+\}',
  );

  @override
  final Channel parent;
}

class ChannelCreateMethodParameter with TemplateRegExp {
  ChannelCreateMethodParameter(this.parent);

  final RegExp type = TemplateRegExp.regExp(r'(?<=required )int');
  final RegExp name = TemplateRegExp.regExp(r'fieldTemplate(?=,)');

  @override
  final RegExp exp = TemplateRegExp.regExp('required int fieldTemplate,');

  @override
  final ChannelCreateMethod parent;
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

  HandlerOnCreateMethod get theOnCreateMethod => HandlerOnCreateMethod(this);

  HandlerStaticMethod get aStaticMethod => HandlerStaticMethod(this);

  HandlerMethod get aMethod => HandlerMethod(this);

  HandlerStaticMethodInvoker get aStaticMethodInvoker =>
      HandlerStaticMethodInvoker(this);

  HandlerCreateInstance get theCreateInstance => HandlerCreateInstance(this);

  HandlerInvokeMethod get theHandlerInvokeMethod => HandlerInvokeMethod(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'class \$ClassTemplateHandler.*}(?=\s*class \$LibraryImplementations)',
  );

  @override
  final Library parent;
}

class HandlerOnCreateMethod with TemplateRegExp {
  HandlerOnCreateMethod(this.parent);

  final RegExp returnType =
      TemplateRegExp.regExp(r'(?<=\$)ClassTemplate(?= onCreate)');

  HandlerOnCreateMethodField get aField => HandlerOnCreateMethodField(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'\$ClassTemplate \$create\([^\}]+\}',
  );

  @override
  final Handler parent;
}

class HandlerOnCreateMethodField with TemplateRegExp {
  HandlerOnCreateMethodField(this.parent);

  final RegExp type = TemplateRegExp.regExp(r'^int');
  final RegExp name = TemplateRegExp.regExp(r'fieldTemplate$');

  @override
  final RegExp exp = TemplateRegExp.regExp('int fieldTemplate');

  @override
  final HandlerOnCreateMethod parent;
}

class HandlerStaticMethod with TemplateRegExp {
  HandlerStaticMethod(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'StaticMethodTemplate(?=\()');

  Parameter get aParameter => Parameter(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'Object\? \$onStaticMethodTemplate\([^\}]+\}',
  );

  @override
  final Handler parent;
}

class HandlerMethod with TemplateRegExp {
  HandlerMethod(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'MethodTemplate(?=\()');

  Parameter get aParameter => Parameter(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'Object\? \$onMethodTemplate\([^\}]+\}',
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

class HandlerCreateInstance with TemplateRegExp {
  HandlerCreateInstance(this.parent);

  final RegExp className = TemplateRegExp.regExp(
    r'ClassTemplate(?= createInstance\()',
  );

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

  final RegExp index = TemplateRegExp.regExp(r'0(?=\])');

  final RegExp type = TemplateRegExp.regExp(r'int$');

  @override
  final RegExp exp = TemplateRegExp.regExp(r'arguments\[0\] as int');

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
    r'(?<=\$on)MethodTemplate',
  );

  MethodArgument get anArgument => MethodArgument(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r"case 'methodTemplate'[^;]+;[^;]+;",
  );

  @override
  final HandlerInvokeMethod parent;
}

class LibraryImplementations with TemplateRegExp {
  LibraryImplementations(this.parent);

  @override
  final RegExp exp =
      TemplateRegExp.regExp(r'class \$LibraryImplementations \{[^\}]+\}');

  @override
  final Library parent;

  LibraryImplementationsChannel get aChannel =>
      LibraryImplementationsChannel(this);

  LibraryImplementationsHandler get aHandler =>
      LibraryImplementationsHandler(this);
}

class LibraryImplementationsChannel with TemplateRegExp {
  LibraryImplementationsChannel(this.parent);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'\$ClassTemplateChannel get classTemplateChannel[^;]+;',
  );

  @override
  final LibraryImplementations parent;

  final RegExp channelClassName = TemplateRegExp.regExp(
    r'(?<=\$)ClassTemplate',
  );

  final RegExp variableClassName = TemplateRegExp.regExp(
    r'(?<=get\s+)classTemplate',
  );
}

class LibraryImplementationsHandler with TemplateRegExp {
  LibraryImplementationsHandler(this.parent);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'\$ClassTemplateHandler get classTemplateHandler[^;]+;',
  );

  @override
  final LibraryImplementations parent;

  final RegExp channelClassName = TemplateRegExp.regExp(
    r'(?<=\$)ClassTemplate',
  );

  final RegExp variableClassName = TemplateRegExp.regExp(
    r'(?<=get\s+)classTemplate',
  );
}

class ChannelRegistrar with TemplateRegExp {
  ChannelRegistrar(this.parent);

  @override
  final RegExp exp = TemplateRegExp.regExp(r'class \$ChannelRegistrar .+$');

  ChannelRegistrarSetter get aSetter => ChannelRegistrarSetter(this);

  ChannelRegistrarRemover get aRemover => ChannelRegistrarRemover(this);

  @override
  final Library parent;
}

class ChannelRegistrarSetter with TemplateRegExp {
  ChannelRegistrarSetter(this.parent);

  @override
  final ChannelRegistrar parent;

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'implementations.classTemplateChannel.setHandler[^\)]+\);',
  );

  final RegExp channelClassName = TemplateRegExp.regExp(
    r'(?<=implementations\.)classTemplate(?=Channel)',
  );

  final RegExp handlerClassName = TemplateRegExp.regExp(
    r'(?<=implementations\.)classTemplate(?=Handler)',
  );
}

class ChannelRegistrarRemover with TemplateRegExp {
  ChannelRegistrarRemover(this.parent);

  @override
  final ChannelRegistrar parent;

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'implementations.classTemplateChannel.removeHandler\(\);',
  );

  final RegExp channelClassName = TemplateRegExp.regExp(
    r'(?<=implementations\.)classTemplate(?=Channel)',
  );
}
