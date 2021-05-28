import 'dart:io';

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
              .replaceAll(anInterface.name, classNode.name);
        }).join('\n'),
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
                    library.aChannel.theCreateMethod.exp,
                    library.aChannel.theCreateMethod
                        .stringMatch()
                        .replaceAll(
                          library.aChannel.theCreateMethod.instanceClassName,
                          classNode.name,
                        )
                        .replaceAll(
                          library.aChannel.theCreateMethod.aParameter.exp,
                          classNode.fields.map<String>(
                            (FieldNode fieldNode) {
                              final FieldParameter parameter =
                                  library.aChannel.theCreateMethod.aParameter;
                              return parameter
                                  .stringMatch()
                                  .replaceAll(parameter.name, fieldNode.name)
                                  .replaceAll(
                                    parameter.type,
                                    getTrueTypeName(fieldNode.type),
                                  );
                            },
                          ).join(' '),
                        )
                        .replaceAll(
                          library.aChannel.theCreateMethod.aFieldName,
                          classNode.fields
                              .map<String>(
                                (FieldNode fieldNode) => fieldNode.name,
                              )
                              .join(', '),
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
                    classNode.methods.map<String>((MethodNode methodNode) {
                      final ChannelMethod method = library.aChannel.aMethod;
                      return method
                          .stringMatch()
                          .replaceAll(
                            method.name,
                            methodNode.name.pascalCase,
                          )
                          .replaceAll(
                            method.channelMethodName,
                            methodNode.name,
                          )
                          .replaceAll(
                            method.instanceClassName,
                            classNode.name,
                          )
                          .replaceAll(
                            method.aParameter.exp,
                            methodNode.parameters
                                .map<String>(
                                  (ParameterNode parameterNode) =>
                                      method.aParameter
                                          .stringMatch()
                                          .replaceAll(
                                            method.aParameter.name,
                                            parameterNode.name,
                                          )
                                          .replaceAll(
                                            method.aParameter.type,
                                            getTrueTypeName(parameterNode.type),
                                          ),
                                )
                                .join(' '),
                          )
                          .replaceAll(
                            method.aParameterName.exp,
                            methodNode.parameters
                                .map<String>(
                                  (ParameterNode parameterNode) => method
                                      .aParameterName
                                      .stringMatch()
                                      .replaceAll(
                                        method.aParameterName.name,
                                        parameterNode.name,
                                      ),
                                )
                                .join(', '),
                          );
                    }).join('\n\n'),
                  ),
            )
            .join('\n\n'),
      )
      .replaceAll(
        library.aHandler.exp,
        libraryNode.classes.map<String>(
          (ClassNode classNode) {
            final Handler handler = library.aHandler;
            return handler
                .stringMatch()
                .replaceAll(handler.className, classNode.name)
                .replaceAll(handler.typeArgClassName, classNode.name)
                .replaceAll(
                  handler.theCreateMethod.exp,
                  handler.theCreateMethod
                      .stringMatch()
                      .replaceAll(
                        handler.theCreateMethod.returnType,
                        classNode.name,
                      )
                      .replaceAll(
                        handler.theCreateMethod.aFieldParameter.exp,
                        classNode.fields.map<String>(
                          (FieldNode fieldNode) {
                            final FieldParameter parameter =
                                handler.theCreateMethod.aFieldParameter;
                            return parameter
                                .stringMatch()
                                .replaceAll(parameter.name, fieldNode.name)
                                .replaceAll(
                                  parameter.type,
                                  getTrueTypeName(fieldNode.type),
                                );
                          },
                        ).join(' '),
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
          },
        ).join('\n'),
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
                        classNode.name,
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
                        classNode.name,
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
                        classNode.name,
                      )
                      .replaceAll(
                        setter.handlerClassName,
                        classNode.name,
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
                        classNode.name,
                      );
                },
              ).join('\n'),
            ),
      );
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
    case 'Uint8List':
    case 'Uint8List?':
      return 'byte[]';
    case 'int':
    case 'int?':
      return 'Integer';
    case 'double':
    case 'double?':
      return 'Double';
    case 'bool':
    case 'bool?':
      return 'Boolean';
    case 'num':
    case 'num?':
      return 'Number';
    case 'String':
    case 'String?':
      return 'String';
  }

  return type.replaceAll('?', '');
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
    r'(?<=^public class )LibraryTemplate(?= \{)',
  );

  final RegExp package = TemplateRegExp.regExp(
    r'(?<=package )com.example.reference_example(?=;)',
  );

  Interface get anInterface => Interface(this);

  Channel get aChannel => Channel(this);

  Handler get aHandler => Handler(this);

  LibraryImplementations get theImplementations => LibraryImplementations(this);

  ChannelRegistrar get theChannelRegistrar => ChannelRegistrar(this);
}

class Interface with TemplateRegExp {
  Interface(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'(?<=interface \$)ClassTemplate');

  @override
  final RegExp exp =
      TemplateRegExp.regExp(r'public interface \$ClassTemplate \{[^\}]+\}');

  @override
  final Library parent;
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
    r'(?<=super\(messenger, ")github\.penguin/template/template/ClassTemplate',
  );

  ChannelCreateMethod get theCreateMethod => ChannelCreateMethod(this);

  ChannelStaticMethod get aStaticMethod => ChannelStaticMethod(this);

  ChannelMethod get aMethod => ChannelMethod(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'public static class \$ClassTemplateChannel.*}(?=\s*public static class \$ClassTemplateHandler)',
  );

  @override
  final Library parent;
}

class FieldParameter with TemplateRegExp {
  FieldParameter(this.parent);

  final RegExp type = TemplateRegExp.regExp(r'(?<=, )Integer');
  final RegExp name = TemplateRegExp.regExp(r'fieldTemplate$');

  @override
  final RegExp exp = TemplateRegExp.regExp(r',\s*Integer fieldTemplate');

  @override
  final TemplateRegExp parent;
}

class ChannelCreateMethod with TemplateRegExp {
  ChannelCreateMethod(this.parent);

  final RegExp instanceClassName = TemplateRegExp.regExp(
    r'(?<=\$)ClassTemplate(?= \$instance)',
  );

  FieldParameter get aParameter => FieldParameter(this);

  final RegExp aFieldName =
      TemplateRegExp.regExp(r'(?<=asList\(\s*)fieldTemplate');

  @override
  final RegExp exp = TemplateRegExp.regExp(r'\$create[^\}]+\}');

  @override
  final Channel parent;
}

class ChannelStaticMethod with TemplateRegExp {
  ChannelStaticMethod(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'StaticMethodTemplate');

  final RegExp nameAsParameter = TemplateRegExp.regExp(r'staticMethodTemplate');

  Parameter get aParameter => Parameter(this);

  ParameterName get aParameterName => ParameterName(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'public Completable<Object> \$invokeStaticMethodTemplate[^\}]+\}',
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

  FollowingParameter get aParameter => FollowingParameter(this);

  ParameterName get aParameterName => ParameterName(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'public Completable<Object>\s\$invokeMethodTemplate[^\}]+\}',
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

class Handler with TemplateRegExp {
  Handler(this.parent);

  final RegExp className = TemplateRegExp.regExp(
    r'(?<=static class \$)ClassTemplate(?=Handler)',
  );

  final RegExp typeArgClassName = TemplateRegExp.regExp(
    r'(?<=TypeChannelHandler<\$)ClassTemplate',
  );

  HandlerCreateMethod get theCreateMethod => HandlerCreateMethod(this);

  HandlerStaticMethod get aStaticMethod => HandlerStaticMethod(this);

  HandlerStaticMethodInvoker get aStaticMethodInvoker =>
      HandlerStaticMethodInvoker(this);

  HandlerCreationArguments get theCreationArguments =>
      HandlerCreationArguments(this);

  HandlerCreateInstance get theCreateInstance => HandlerCreateInstance(this);

  HandlerInvokeMethod get theInvokeMethod => HandlerInvokeMethod(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'public static class \$ClassTemplateHandler.*}(?=\s*public static class \$LibraryImplementations)',
  );

  @override
  final Library parent;
}

class HandlerCreateMethod with TemplateRegExp {
  HandlerCreateMethod(this.parent);

  final RegExp returnType = TemplateRegExp.regExp(
    r'ClassTemplate(?= \$create\()',
  );

  FieldParameter get aFieldParameter => FieldParameter(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'\$ClassTemplate \$create\([^\}]+\}',
  );

  @override
  final Handler parent;
}

class HandlerStaticMethod with TemplateRegExp {
  HandlerStaticMethod(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'StaticMethodTemplate(?=\()');

  FollowingParameter get aParameter => FollowingParameter(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'public Object \$onStaticMethodTemplate[^\}]+\}',
  );

  @override
  final Handler parent;
}

class HandlerMethod with TemplateRegExp {
  HandlerMethod(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'MethodTemplate(?=\()');

  FollowingParameter get aParameter => FollowingParameter(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'public Object \$onMethodTemplate[^\}]+\}',
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

  final RegExp name = TemplateRegExp.regExp(r'FieldTemplate');

  @override
  final RegExp exp =
      TemplateRegExp.regExp(r'(?<=\(\s*)instance\.getFieldTemplate\(\)');

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

class LibraryImplementations with TemplateRegExp {
  LibraryImplementations(this.parent);

  @override
  final RegExp exp = TemplateRegExp.regExp(
      r'public static class \$LibraryImplementations.+\}(?=\s+public static class \$ChannelRegistrar)');

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
    r'public \$ClassTemplateChannel getClassTemplateChannel[^\}]+\}',
  );

  @override
  final LibraryImplementations parent;

  final RegExp channelClassName = TemplateRegExp.regExp(
    r'(?<=\$)ClassTemplate',
  );

  final RegExp variableClassName = TemplateRegExp.regExp(
    r'(?<=get)ClassTemplate',
  );
}

class LibraryImplementationsHandler with TemplateRegExp {
  LibraryImplementationsHandler(this.parent);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'public \$ClassTemplateHandler getClassTemplateHandler[^\}]+\}',
  );

  @override
  final LibraryImplementations parent;

  final RegExp channelClassName = TemplateRegExp.regExp(
    r'(?<=\$)ClassTemplate',
  );

  final RegExp variableClassName = TemplateRegExp.regExp(
    r'(?<=get)ClassTemplate',
  );
}

class ChannelRegistrar with TemplateRegExp {
  ChannelRegistrar(this.parent);

  @override
  final RegExp exp = TemplateRegExp.regExp(
      r'public static class \$ChannelRegistrar .+(?=\s+}\s+$)');

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
    r'implementations.getClassTemplateChannel\(\).setHandler[^;]+;',
  );

  final RegExp channelClassName = TemplateRegExp.regExp(
    r'(?<=implementations\.get)ClassTemplate(?=Channel)',
  );

  final RegExp handlerClassName = TemplateRegExp.regExp(
    r'(?<=implementations\.get)ClassTemplate(?=Handler)',
  );
}

class ChannelRegistrarRemover with TemplateRegExp {
  ChannelRegistrarRemover(this.parent);

  @override
  final ChannelRegistrar parent;

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'implementations.getClassTemplateChannel\(\).removeHandler[^;]+;',
  );

  final RegExp channelClassName = TemplateRegExp.regExp(
    r'(?<=implementations\.get)ClassTemplate(?=Channel)',
  );
}
