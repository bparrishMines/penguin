import 'package:recase/recase.dart';
import 'package:reference_generator/src/ast.dart';

import 'common.dart';
import 'objc_header_generator.dart'
    show
        getTrueTypeName,
        LeadingParameter,
        FollowingParameter,
        FollowingParameterComment;

String generateObjcImpl({
  String template,
  LibraryNode libraryNode,
  String prefix,
  String headerFilename,
}) {
  final Library library = Library(template);
  return template
      .replaceAll(library.headerFilename, headerFilename)
      .replaceAll(
        library.aCreationArgsClass.exp,
        libraryNode.classes.map<String>(
          (ClassNode classNode) {
            final CreationArgsClass argsClass = library.aCreationArgsClass;
            return argsClass
                .stringMatch()
                .replaceAll(argsClass.className, classNode.name)
                .replaceAll(argsClass.prefix, prefix);
          },
        ).join('\n'),
      )
      .replaceAll(
        library.aChannel.exp,
        libraryNode.classes.map<String>(
          (ClassNode classNode) {
            final Channel channel = library.aChannel;
            return channel
                .stringMatch()
                .replaceAll(channel.className, classNode.name)
                .replaceAll(channel.prefix, prefix)
                .replaceAll(channel.channelName, classNode.channelName)
                .replaceAll(
                  channel.aStaticMethod.exp,
                  classNode.staticMethods.map<String>(
                    (MethodNode methodNode) {
                      final ChannelStaticMethod staticMethod =
                          channel.aStaticMethod;
                      return staticMethod
                          .stringMatch()
                          .replaceAll(staticMethod.name, methodNode.name)
                          .replaceAll(
                              staticMethod.methodNameParameter, methodNode.name)
                          .replaceAll(
                            staticMethod.completion,
                            methodNode.parameters.isEmpty ? '' : 'completion',
                          )
                          .replaceAll(
                            staticMethod.theLeadingParameter.exp,
                            methodNode.parameters.isEmpty
                                ? ''
                                : staticMethod.theLeadingParameter
                                    .stringMatch()
                                    .replaceAll(
                                      staticMethod.theLeadingParameter.name,
                                      methodNode.parameters[0].name,
                                    )
                                    .replaceAll(
                                      staticMethod.theLeadingParameter.type,
                                      getTrueTypeName(
                                        methodNode.parameters[0].type,
                                        prefix,
                                      ),
                                    ),
                          )
                          .replaceAll(
                            staticMethod.aFollowingParameterComment.exp,
                            methodNode.parameters.skip(1).map<String>(
                              (ParameterNode parameterNode) {
                                final FollowingParameterComment comment =
                                    staticMethod.aFollowingParameterComment;
                                return comment
                                    .stringMatch()
                                    .replaceAll(
                                      comment.name,
                                      parameterNode.name,
                                    )
                                    .replaceAll(
                                      comment.name2,
                                      parameterNode.name,
                                    )
                                    .replaceAll(
                                      comment.type,
                                      getTrueTypeName(
                                        parameterNode.type,
                                        prefix,
                                      ),
                                    );
                              },
                            ).join('/n'),
                          )
                          .replaceAll(
                            staticMethod.aParameterName.exp,
                            methodNode.parameters.map<String>(
                              (ParameterNode parameterNode) {
                                final ParameterName parameterName =
                                    staticMethod.aParameterName;
                                return parameterName.stringMatch().replaceAll(
                                      parameterName.name,
                                      parameterNode.name,
                                    );
                              },
                            ).join(','),
                          );
                    },
                  ).join('\n'),
                )
                .replaceAll(
                  channel.aMethod.exp,
                  classNode.methods.map<String>(
                    (MethodNode methodNode) {
                      final ChannelMethod method = channel.aMethod;
                      return method
                          .stringMatch()
                          .replaceAll(method.name, methodNode.name)
                          .replaceAll(method.instanceType, classNode.name)
                          .replaceAll(method.instanceTypePrefix, prefix)
                          .replaceAll(
                            method.methodNameParameter,
                            methodNode.name,
                          )
                          .replaceAll(
                            method.aParameter.exp,
                            methodNode.parameters.map<String>(
                              (ParameterNode parameterNode) {
                                final FollowingParameter parameter =
                                    method.aParameter;
                                return parameter
                                    .stringMatch()
                                    .replaceAll(
                                      parameter.name,
                                      parameterNode.name,
                                    )
                                    .replaceAll(
                                      parameter.name2,
                                      parameterNode.name,
                                    )
                                    .replaceAll(
                                      parameter.type,
                                      getTrueTypeName(
                                        parameterNode.type,
                                        prefix,
                                      ),
                                    );
                              },
                            ).join('\n'),
                          )
                          .replaceAll(
                            method.aParameterName.exp,
                            methodNode.parameters.map<String>(
                              (ParameterNode parameterNode) {
                                final ParameterName parameterName =
                                    method.aParameterName;
                                return parameterName.stringMatch().replaceAll(
                                      parameterName.name,
                                      parameterNode.name,
                                    );
                              },
                            ).join(','),
                          );
                    },
                  ).join('\n'),
                );
          },
        ).join('\n'),
      )
      .replaceAll(
        library.aHandler.exp,
        libraryNode.classes.map<String>(
          (ClassNode classNode) {
            final Handler handler = library.aHandler;
            return handler
                .stringMatch()
                .replaceAll(handler.prefix, prefix)
                .replaceAll(handler.className, classNode.name)
                .replaceAll(
                  handler.theOnCreateMethod.exp,
                  handler.theOnCreateMethod
                      .stringMatch()
                      .replaceAll(
                        handler.theOnCreateMethod.className,
                        classNode.name,
                      )
                      .replaceAll(
                        handler.theOnCreateMethod.classPrefix,
                        prefix,
                      )
                      .replaceAll(
                        handler.theOnCreateMethod.creationArgsClassName,
                        classNode.name,
                      )
                      .replaceAll(
                        handler.theOnCreateMethod.creationArgsPrefix,
                        prefix,
                      ),
                )
                .replaceAll(
                  handler.aStaticMethod.exp,
                  classNode.staticMethods.map<String>(
                    (MethodNode methodNode) {
                      final HandlerStaticMethod method = handler.aStaticMethod;
                      return method
                          .stringMatch()
                          .replaceAll(method.name, methodNode.name)
                          .replaceAll(
                            method.aFollowingParameter.exp,
                            methodNode.parameters.map<String>(
                              (ParameterNode parameterNode) {
                                final FollowingParameter parameter =
                                    method.aFollowingParameter;
                                return parameter
                                    .stringMatch()
                                    .replaceAll(
                                      parameter.name,
                                      parameterNode.name,
                                    )
                                    .replaceAll(
                                      parameter.name2,
                                      parameterNode.name,
                                    )
                                    .replaceAll(
                                      parameter.type,
                                      getTrueTypeName(
                                        parameterNode.type,
                                        prefix,
                                      ),
                                    );
                              },
                            ).join('\n'),
                          );
                    },
                  ).join('\n'),
                )
                .replaceAll(
                  handler.aStaticMethodInvoker.exp,
                  classNode.staticMethods.map<String>(
                    (MethodNode methodNode) {
                      final HandlerStaticMethodInvoker invoker =
                          handler.aStaticMethodInvoker;
                      return invoker
                          .stringMatch()
                          .replaceAll(invoker.implMethodName, methodNode.name)
                          .replaceAll(invoker.methodNameString, methodNode.name)
                          .replaceAll(
                            invoker.anArgument.exp,
                            incrementingList(methodNode.parameters.length)
                                .map<String>(
                              (int index) {
                                final FollowingArgument argument =
                                    invoker.anArgument;
                                return argument
                                    .stringMatch()
                                    .replaceAll(
                                      argument.name,
                                      methodNode.parameters[index].name,
                                    )
                                    .replaceAll(argument.index, '$index');
                              },
                            ).join(' else '),
                          );
                    },
                  ).join(' else '),
                )
                .replaceAll(
                  handler.theCreationArguments.exp,
                  handler.theCreationArguments
                      .stringMatch()
                      .replaceAll(handler.theCreationArguments.prefix, prefix)
                      .replaceAll(handler.theCreationArguments.className,
                          classNode.name)
                      .replaceAll(
                        handler.theCreationArguments.fieldName.exp,
                        classNode.fields.map<String>(
                          (FieldNode fieldNode) {
                            final HandlerCreationArgsFieldName field =
                                handler.theCreationArguments.fieldName;
                            return field.stringMatch().replaceAll(
                                  field.name,
                                  fieldNode.name,
                                );
                          },
                        ).join(','),
                      ),
                )
                .replaceAll(
                  handler.theCreateInstance.exp,
                  handler.theCreateInstance
                      .stringMatch()
                      .replaceAll(
                          handler.theCreateInstance.className, classNode.name)
                      .replaceAll(handler.theCreateInstance.prefix, prefix)
                      .replaceAll(
                        handler.theCreateInstance.field.exp,
                        incrementingList(classNode.fields.length).map<String>(
                          (int index) {
                            final HandlerCreateInstanceField field =
                                handler.theCreateInstance.field;
                            return field
                                .stringMatch()
                                .replaceAll(
                                  field.name,
                                  classNode.fields[index].name,
                                )
                                .replaceAll(field.index, '$index');
                          },
                        ).join('\n'),
                      ),
                )
                .replaceAll(
                  handler.theMethodInvoker.exp,
                  handler.theMethodInvoker
                      .stringMatch()
                      .replaceAll(
                        handler.theMethodInvoker.className,
                        classNode.name,
                      )
                      .replaceAll(handler.theMethodInvoker.prefix, prefix)
                      .replaceAll(
                        handler.theMethodInvoker.aMethod.exp,
                        classNode.methods.map<String>(
                          (MethodNode methodNode) {
                            final HandlerMethodInvokerMethod method =
                                handler.theMethodInvoker.aMethod;
                            return method
                                .stringMatch()
                                .replaceAll(
                                  method.methodNameString,
                                  methodNode.name,
                                )
                                .replaceAll(
                                  method.implMethodName,
                                  methodNode.name,
                                )
                                .replaceAll(
                                  method.theLeadingArgument,
                                  methodNode.parameters.isEmpty
                                      ? ''
                                      : ':arguments[0]',
                                )
                                .replaceAll(
                                  method.aFollowingArgument.exp,
                                  incrementingList(methodNode.parameters.length)
                                      .skip(1)
                                      .map<String>(
                                    (int index) {
                                      final FollowingArgumentComment argument =
                                          method.aFollowingArgument;
                                      return argument
                                          .stringMatch()
                                          .replaceAll(
                                            argument.name,
                                            methodNode.parameters[index].name,
                                          )
                                          .replaceAll(
                                            argument.index,
                                            'index',
                                          );
                                    },
                                  ).join(' '),
                                );
                          },
                        ).join(' else '),
                      ),
                );
          },
        ).join('\n'),
      )
      .replaceAll(
        library.theChannelRegistrar.exp,
        library.theChannelRegistrar
            .stringMatch()
            .replaceAll(library.theChannelRegistrar.prefix, prefix)
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

class Library with TemplateRegExp {
  Library(this.template);

  @override
  final String template;

  @override
  final TemplateRegExp parent = null;

  @override
  final RegExp exp = null;

  final RegExp headerFilename = TemplateRegExp.regExp(
    r'(?<=#import ")REFLibraryTemplate_Internal\.h',
  );

  CreationArgsClass get aCreationArgsClass => CreationArgsClass(this);

  Channel get aChannel => Channel(this);

  Handler get aHandler => Handler(this);

  ChannelRegistrar get theChannelRegistrar => ChannelRegistrar(this);
}

class CreationArgsClass with TemplateRegExp {
  CreationArgsClass(this.parent);

  @override
  final Library parent;

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'@implementation REFClassTemplateCreationArgs[^@]+@end',
  );

  final RegExp prefix = TemplateRegExp.regExp(r'(?<=@implementation )REF');

  final RegExp className = TemplateRegExp.regExp(
    r'(?<=@implementation \w*)ClassTemplate(?=CreationArgs)',
  );
}

class Channel with TemplateRegExp {
  Channel(this.parent);

  @override
  final Library parent;

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'@implementation REFClassTemplateChannel.+(?=@implementation REFClassTemplateHandler)',
  );

  final RegExp prefix = TemplateRegExp.regExp(r'(?<=@implementation )REF');

  final RegExp className = TemplateRegExp.regExp(
    r'(?<=@implementation \w*)ClassTemplate(?=Channel)',
  );

  final RegExp channelName = TemplateRegExp.regExp(
    r'(?<=@")github.penguin/template/template/ClassTemplate(?=")',
  );

  ChannelStaticMethod get aStaticMethod => ChannelStaticMethod(this);

  ChannelMethod get aMethod => ChannelMethod(this);
}

class ChannelStaticMethod with TemplateRegExp {
  ChannelStaticMethod(this.parent);

  @override
  final Channel parent;

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'- \(void\)invoke_staticMethodTemplate[^\}]+\}',
  );

  final RegExp name = TemplateRegExp.regExp(
    r'(?<=invoke_)staticMethodTemplate',
  );

  final RegExp completion = TemplateRegExp.regExp(r'completion(?=:\(void)');

  final RegExp methodNameParameter = TemplateRegExp.regExp(
    r'(?<=@")staticMethodTemplate(?=")',
  );

  ParameterName get aParameterName => ParameterName(this);

  LeadingParameter get theLeadingParameter => LeadingParameter(this);

  FollowingParameterComment get aFollowingParameterComment =>
      FollowingParameterComment(this);
}

class ParameterName with TemplateRegExp {
  ParameterName(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'parameterTemplate');

  @override
  final RegExp exp =
      TemplateRegExp.regExp(r'(?<=arguments:@\[)parameterTemplate(?=\])');

  @override
  final TemplateRegExp parent;
}

class ChannelMethod with TemplateRegExp {
  ChannelMethod(this.parent);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'- \(void\)invoke_methodTemplate[^\}]+\}',
  );

  @override
  final Channel parent;

  final RegExp name = TemplateRegExp.regExp(
    r'(?<=invoke_)methodTemplate',
  );

  final RegExp instanceType = TemplateRegExp.regExp(
    r'(?<=NSObject<\w*)ClassTemplate',
  );

  final RegExp instanceTypePrefix = TemplateRegExp.regExp(r'(?<=NSObject<)REF');

  final RegExp methodNameParameter = TemplateRegExp.regExp(
    r'(?<=@")methodTemplate(?=")',
  );

  ParameterName get aParameterName => ParameterName(this);

  FollowingParameter get aParameter => FollowingParameter(this);
}

class Handler with TemplateRegExp {
  Handler(this.parent);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'@implementation REFClassTemplateHandler.+@end\s+(?=@implementation)',
  );

  @override
  final Library parent;

  final RegExp className = TemplateRegExp.regExp(
    r'(?<=@implementation \w*)ClassTemplate(?=Handler)',
  );

  final RegExp prefix = TemplateRegExp.regExp(r'(?<=@implementation )REF');

  HandlerOnCreateMethod get theOnCreateMethod => HandlerOnCreateMethod(this);

  HandlerStaticMethod get aStaticMethod => HandlerStaticMethod(this);

  HandlerStaticMethodInvoker get aStaticMethodInvoker =>
      HandlerStaticMethodInvoker(this);

  HandlerCreationArgs get theCreationArguments => HandlerCreationArgs(this);

  HandlerCreateInstance get theCreateInstance => HandlerCreateInstance(this);

  HandlerMethodInvoker get theMethodInvoker => HandlerMethodInvoker(this);
}

class HandlerOnCreateMethod with TemplateRegExp {
  HandlerOnCreateMethod(this.parent);

  @override
  final Handler parent;

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'- \(NSObject<REFClassTemplate> \*\)onCreate:[^\}]+\}',
  );

  final RegExp classPrefix = TemplateRegExp.regExp(r'(?<=NSObject<)REF');

  final RegExp creationArgsPrefix = TemplateRegExp.regExp(r'(?<=args:\()REF');

  final RegExp className =
      TemplateRegExp.regExp(r'ClassTemplate(?=> \*\)onCreate)');

  final RegExp creationArgsClassName =
      TemplateRegExp.regExp(r'ClassTemplate(?=CreationArgs \*)');
}

class HandlerStaticMethod with TemplateRegExp {
  HandlerStaticMethod(this.parent);

  @override
  final Handler parent;

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'- \(NSObject \*_Nullable\)on_staticMethodTemplate:[^\}]+\}',
  );

  final RegExp name = TemplateRegExp.regExp(r'(?<=on_)staticMethodTemplate');

  FollowingParameter get aFollowingParameter => FollowingParameter(this);
}

class HandlerStaticMethodInvoker with TemplateRegExp {
  HandlerStaticMethodInvoker(this.parent);

  @override
  final Handler parent;

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'(?<=- \(id _Nullable\)invokeStaticMethod:[^\}]+)if \(\[@"staticMethodTemplate"[^\}]+\}',
  );

  final RegExp methodNameString = TemplateRegExp.regExp(
    r'(?<=@")staticMethodTemplate(?=")',
  );

  final RegExp implMethodName = TemplateRegExp.regExp(
    r'(?<=self on_)staticMethodTemplate',
  );

  FollowingArgument get anArgument => FollowingArgument(this);
}

class FollowingArgument with TemplateRegExp {
  FollowingArgument(this.parent);

  @override
  final TemplateRegExp parent;

  @override
  final RegExp exp = TemplateRegExp.regExp(r'parameterTemplate:arguments\[0\]');

  final RegExp name = TemplateRegExp.regExp(r'^parameterTemplate');

  final RegExp index = TemplateRegExp.regExp(r'0(?=\])');
}

class HandlerCreationArgs with TemplateRegExp {
  HandlerCreationArgs(this.parent);

  @override
  final Handler parent;

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'- \(nonnull NSArray \*\)getCreationArguments:[^\}]+\}',
  );

  final RegExp className = TemplateRegExp.regExp(
    r'(?<=NSObject<\w*)ClassTemplate',
  );

  final RegExp prefix = TemplateRegExp.regExp(r'(?<=NSObject<)REF');

  HandlerCreationArgsFieldName get fieldName =>
      HandlerCreationArgsFieldName(this);
}

class HandlerCreationArgsFieldName with TemplateRegExp {
  HandlerCreationArgsFieldName(this.parent);

  @override
  final HandlerCreationArgs parent;

  @override
  final RegExp exp = TemplateRegExp.regExp(r'value\.fieldTemplate');

  final RegExp name = TemplateRegExp.regExp(r'fieldTemplate');
}

class HandlerCreateInstance with TemplateRegExp {
  HandlerCreateInstance(this.parent);

  @override
  final Handler parent;

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'- \(nonnull id\)createInstance:[^\}]+\}',
  );

  final RegExp className = TemplateRegExp.regExp(
    r'(?<=\w*)ClassTemplate(?=CreationArgs)',
  );

  final RegExp prefix = TemplateRegExp.regExp(r'REF(?=\w+CreationArgs)');

  HandlerCreateInstanceField get field => HandlerCreateInstanceField(this);
}

class HandlerCreateInstanceField with TemplateRegExp {
  HandlerCreateInstanceField(this.parent);

  @override
  final HandlerCreateInstance parent;

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'args\.fieldTemplate = arguments\[0\];',
  );

  final RegExp name = TemplateRegExp.regExp(r'fieldTemplate');

  final RegExp index = TemplateRegExp.regExp(r'0(?=\])');
}

class HandlerMethodInvoker with TemplateRegExp {
  HandlerMethodInvoker(this.parent);

  @override
  final Handler parent;

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'- \(id _Nullable\)invokeMethod:.*[^@]+(?=@end)',
  );

  final RegExp className = TemplateRegExp.regExp(
    r'(?<=NSObject<\w*)ClassTemplate',
  );

  final RegExp prefix = TemplateRegExp.regExp(r'(?<=NSObject<)REF');

  HandlerMethodInvokerMethod get aMethod => HandlerMethodInvokerMethod(this);
}

class HandlerMethodInvokerMethod with TemplateRegExp {
  HandlerMethodInvokerMethod(this.parent);

  @override
  final HandlerMethodInvoker parent;

  @override
  final RegExp exp = TemplateRegExp.regExp(r'if \(\[@"methodTemplate"[^\}]+\}');

  final RegExp methodNameString = TemplateRegExp.regExp(
    r'(?<=@")methodTemplate(?=")',
  );

  final RegExp implMethodName = TemplateRegExp.regExp(
    r'(?<=value )methodTemplate',
  );

  final RegExp theLeadingArgument = TemplateRegExp.regExp(r':arguments\[0\]');

  FollowingArgumentComment get aFollowingArgument =>
      FollowingArgumentComment(this);
}

class FollowingArgumentComment with TemplateRegExp {
  FollowingArgumentComment(this.parent);

  @override
  final TemplateRegExp parent;

  @override
  final RegExp exp = TemplateRegExp.regExp(r'\/\*following_arguments\*\/');

  final RegExp name = TemplateRegExp.regExp(r'^parameterTemplate');

  final RegExp index = TemplateRegExp.regExp(r'0(?=\])');

  @override
  String stringMatch() {
    return 'parameterTemplate:arguments[0]';
  }
}

class ChannelRegistrar with TemplateRegExp {
  ChannelRegistrar(this.parent);

  @override
  final RegExp exp =
      TemplateRegExp.regExp(r'@implementation REFChannelRegistrar[^@]+@end');

  final RegExp prefix = TemplateRegExp.regExp(r'(?<=@implementation )REF');

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
    r'\[_implementations\.classTemplateChannel setHandler[^;]+;',
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
    r'\[_implementations\.classTemplateChannel removeHandler\];',
  );

  final RegExp channelClassName = TemplateRegExp.regExp(
    r'(?<=implementations\.)classTemplate(?=Channel)',
  );
}
