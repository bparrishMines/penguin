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
                      .replaceAll(handler.className, classNode.name)
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
                                            '${index}',
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
    r'@implementation REFClassTemplateHandler.+$',
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
    r'- \(id _Nullable\)invokeMethod:.*(?=- \(void\)onInstanceDisposed:)',
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

// import 'package:recase/recase.dart';
// import 'package:reference_generator/src/ast.dart';
//
// import 'common.dart';
// import 'objc_header_generator.dart'
//     show getTrueTypeName, Parameter, PrefixTemplate;
//
// String generateObjcImpl({
//   String template,
//   LibraryNode libraryNode,
//   String prefix,
//   String headerFilename,
// }) {
//   final Library library = Library(template: template, templatePrefix: prefix);
//   return template
//       .replaceAll(library.handlerPrefix, prefix)
//   .replaceAll(library.headerFilename, headerFilename)
//       .replaceAll(
//         library.aClass.exp,
//         libraryNode.classes
//             .map<String>(
//               (ClassNode classNode) => library.aClass
//                   .stringMatch()
//                   .replaceAll(library.aClass.name, classNode.name)
//                   .replaceAll(library.aClass.referenceClass, classNode.name)
//                   .replaceAll(library.aClass.prefix, prefix)
//                   .replaceAll(library.aClass.referenceClassPrefix, prefix)
//
//                   .replaceAll(
//                     library.aClass.aField.exp,
//                     classNode.fields
//                         .map<String>(
//                           (FieldNode fieldNode) => library.aClass.aField
//                               .stringMatch()
//                               .replaceAll(
//                                   library.aClass.aField.name, fieldNode.name)
//                               .replaceAll(
//                                 library.aClass.aField.type,
//                                 getTrueTypeName(fieldNode.type, prefix),
//                               ),
//                         )
//                         .join('\n'),
//                   )
//                   .replaceAll(
//                     library.aClass.aMethod.exp,
//                     classNode.methods
//                         .map<String>(
//                           (MethodNode methodNode) => library.aClass.aMethod
//                               .stringMatch()
//                               .replaceAll(
//                                 library.aClass.aMethod.name,
//                                 methodNode.name,
//                               )
//                               .replaceAll(
//                                 library.aClass.aMethod.aParameter.exp,
//                                 library.aClass.aMethod.aParameter
//                                     .replaceWithFirst(methodNode.parameters),
//                               ),
//                         )
//                         .join('\n\n'),
//                   )
//                   .replaceAll(
//                     library.aClass.aProtectedStaticMethod.exp,
//                     classNode.staticMethods
//                         .map<String>(
//                           (MethodNode methodNode) => library
//                               .aClass.aProtectedStaticMethod
//                               .stringMatch()
//                               .replaceAll(
//                                 library.aClass.aProtectedStaticMethod.className,
//                                 classNode.name,
//                               )
//                               .replaceAll(
//                                 library.aClass.aProtectedStaticMethod.name,
//                                 methodNode.name,
//                               )
//                               .replaceAll(
//                                 library.aClass.aProtectedStaticMethod
//                                     .managerPrefix,
//                                 prefix,
//                               )
//                               .replaceAll(
//                                 library
//                                     .aClass.aProtectedStaticMethod.classPrefix,
//                                 prefix,
//                               )
//                               .replaceAll(
//                                 library.aClass.aMethod.aParameter.exp,
//                                 library.aClass.aMethod.aParameter
//                                     .replace(methodNode.parameters),
//                               )
//                               .replaceAll(
//                                 library.aClass.aProtectedStaticMethod
//                                     .aParameterName.exp,
//                                 methodNode.parameters
//                                     .map<String>(
//                                       (ParameterNode parameterNode) => library
//                                           .aClass
//                                           .aProtectedStaticMethod
//                                           .aParameterName
//                                           .stringMatch()
//                                           .replaceAll(
//                                             library
//                                                 .aClass
//                                                 .aProtectedStaticMethod
//                                                 .aParameterName
//                                                 .name,
//                                             parameterNode.name,
//                                           ),
//                                     )
//                                     .join(', '),
//                               ),
//                         )
//                         .join('\n\n'),
//                   )
//                   .replaceAll(
//                     library.aClass.aProtectedMethod.exp,
//                     classNode.methods
//                         .map<String>(
//                           (MethodNode methodNode) => library
//                               .aClass.aProtectedMethod
//                               .stringMatch()
//                               .replaceAll(
//                                 library.aClass.aProtectedMethod.name,
//                                 methodNode.name,
//                               )
//                               .replaceAll(
//                                 library.aClass.aProtectedMethod.managerPrefix,
//                                 prefix,
//                               )
//                               .replaceAll(
//                                 library.aClass.aMethod.aParameter.exp,
//                                 library.aClass.aMethod.aParameter
//                                     .replace(methodNode.parameters),
//                               )
//                               .replaceAll(
//                                 library.aClass.aProtectedMethod
//                                     .anUnpairedReference.exp,
//                                 library
//                                     .aClass.aProtectedMethod.anUnpairedReference
//                                     .stringMatch()
//                                     .replaceAll(
//                                         library.aClass.aProtectedMethod
//                                             .anUnpairedReference.name,
//                                         methodNode.name)
//                                     .replaceAll(
//                                       library
//                                           .aClass
//                                           .aProtectedMethod
//                                           .anUnpairedReference
//                                           .aParameterName
//                                           .exp,
//                                       methodNode.parameters
//                                           .map<String>(
//                                             (ParameterNode parameterNode) =>
//                                                 library
//                                                     .aClass
//                                                     .aProtectedMethod
//                                                     .anUnpairedReference
//                                                     .aParameterName
//                                                     .stringMatch()
//                                                     .replaceAll(
//                                                       library
//                                                           .aClass
//                                                           .aProtectedMethod
//                                                           .anUnpairedReference
//                                                           .aParameterName
//                                                           .name,
//                                                       parameterNode.name,
//                                                     ),
//                                           )
//                                           .join(', '),
//                                     ),
//                               )
//                               .replaceAll(
//                                 library.aClass.aProtectedMethod.aPairedReference
//                                     .exp,
//                                 library.aClass.aProtectedMethod.aPairedReference
//                                     .stringMatch()
//                                     .replaceAll(
//                                       library.aClass.aProtectedMethod
//                                           .aPairedReference.name,
//                                       methodNode.name,
//                                     )
//                                     .replaceAll(
//                                       library.aClass.aProtectedMethod
//                                           .aPairedReference.aParameterName.exp,
//                                       methodNode.parameters
//                                           .map<String>(
//                                             (ParameterNode parameterNode) =>
//                                                 library
//                                                     .aClass
//                                                     .aProtectedMethod
//                                                     .aPairedReference
//                                                     .aParameterName
//                                                     .stringMatch()
//                                                     .replaceAll(
//                                                       library
//                                                           .aClass
//                                                           .aProtectedMethod
//                                                           .aPairedReference
//                                                           .aParameterName
//                                                           .name,
//                                                       parameterNode.name,
//                                                     ),
//                                           )
//                                           .join(', '),
//                                     ),
//                               ),
//                         )
//                         .join('\n\n'),
//                   ),
//             )
//             .join('\n\n'),
//       )
//       .replaceAll(
//         library.aCreationArgsClass.exp,
//         libraryNode.classes
//             .map<String>((ClassNode classNode) => library.aCreationArgsClass
//                 .stringMatch()
//                 .replaceAll(library.aCreationArgsClass.classPrefix, prefix)
//                 .replaceAll(
//                   library.aCreationArgsClass.className,
//                   classNode.name,
//                 ))
//             .join('\n\n'),
//       )
//       .replaceAll(
//         library.aManager.exp,
//         library.aManager
//             .stringMatch()
//             .replaceAll(library.aManager.prefix, prefix)
//             .replaceAll(library.aManager.remoteHandlerPrefix, prefix)
//             .replaceAll(
//               library.aManager.aClass.exp,
//               libraryNode.classes
//                   .map<String>(
//                     (ClassNode classNode) => library.aManager.aClass
//                         .stringMatch()
//                         .replaceAll(
//                           library.aManager.aClass.prefix,
//                           prefix,
//                         )
//                         .replaceAll(
//                           library.aManager.aClass.name,
//                           classNode.name,
//                         ),
//                   )
//                   .join(', '),
//             ),
//       )
//       .replaceAll(
//         library.aLocalHandler.exp,
//         library.aLocalHandler.exp
//             .stringMatch(template)
//             .replaceAll(library.aLocalHandler.prefix, prefix)
//             .replaceAll(
//               library.aLocalHandler.aCreator.exp,
//               libraryNode.classes
//                   .map<String>(
//                     (ClassNode classNode) => library.aLocalHandler.aCreator
//                         .stringMatch()
//                         .replaceAll(
//                           library.aLocalHandler.aCreator.className,
//                           classNode.name,
//                         )
//                         .replaceAll(
//                             library.aLocalHandler.aCreator.classPrefix, prefix)
//                         .replaceAll(
//                             library.aLocalHandler.aCreator.localHandlerPrefix,
//                             prefix)
//                         .replaceAll(
//                           library.aLocalHandler.aCreator.argument.exp,
//                           List<int>.generate(
//                                   classNode.fields.length, (int index) => index)
//                               .map<String>(
//                                 (int index) =>
//                                     library.aLocalHandler.aCreator.argument
//                                         .stringMatch()
//                                         .replaceAll(
//                                           library.aLocalHandler.aCreator
//                                               .argument.fieldName,
//                                           classNode.fields[index].name,
//                                         )
//                                         .replaceAll(
//                                           library.aLocalHandler.aCreator
//                                               .argument.argumentIndex,
//                                           '$index',
//                                         ),
//                               )
//                               .join('\n'),
//                         ),
//                   )
//                   .join(',\n'),
//             )
//             .replaceAll(
//               library.aLocalHandler.aStaticMethod.exp,
//               libraryNode.classes
//                   .map<String>(
//                     (ClassNode classNode) => library.aLocalHandler.aStaticMethod
//                         .stringMatch()
//                         .replaceAll(
//                           library.aLocalHandler.aStaticMethod.classPrefix,
//                           prefix,
//                         )
//                         .replaceAll(
//                           library.aLocalHandler.aStaticMethod.className,
//                           classNode.name,
//                         )
//                         .replaceAll(
//                           library.aLocalHandler.aStaticMethod.aMethod.exp,
//                           classNode.staticMethods
//                               .map<String>(
//                                 (MethodNode methodNode) =>
//                                     library.aLocalHandler.aStaticMethod.aMethod
//                                         .stringMatch()
//                                         .replaceAll(
//                                           library.aLocalHandler.aStaticMethod
//                                               .aMethod.localHandlerPrefix,
//                                           prefix,
//                                         )
//                                         .replaceAll(
//                                           library.aLocalHandler.aStaticMethod
//                                               .aMethod.classNamePart,
//                                           ReCase(classNode.name).camelCase,
//                                         )
//                                         .replaceAll(
//                                           library.aLocalHandler.aStaticMethod
//                                               .aMethod.methodName,
//                                           methodNode.name,
//                                         )
//                                         .replaceAll(
//                                           library.aLocalHandler.aStaticMethod
//                                               .aMethod.anArgument.exp,
//                                           library.aLocalHandler.aStaticMethod
//                                               .aMethod.anArgument
//                                               .replace(methodNode.parameters),
//                                         ),
//                               )
//                               .join(',\n'),
//                         ),
//                   )
//                   .join(',\n'),
//             )
//             .replaceAll(
//               library.aLocalHandler.aMethod.exp,
//               libraryNode.classes
//                   .map<String>(
//                     (ClassNode classNode) => library.aLocalHandler.aMethod
//                         .stringMatch()
//                         .replaceAll(
//                           library.aLocalHandler.aMethod.className,
//                           classNode.name,
//                         )
//                         .replaceAll(
//                           library.aLocalHandler.aMethod.classPrefix,
//                           prefix,
//                         )
//                         .replaceAll(
//                           library.aLocalHandler.aMethod.aMethod.exp,
//                           classNode.methods
//                               .map<String>(
//                                 (MethodNode methodNode) =>
//                                     library.aLocalHandler.aMethod.aMethod
//                                         .stringMatch()
//                                         .replaceAll(
//                                           library.aLocalHandler.aMethod.aMethod
//                                               .className,
//                                           classNode.name,
//                                         )
//                                         .replaceAll(
//                                           library.aLocalHandler.aMethod.aMethod
//                                               .classPrefix,
//                                           prefix,
//                                         )
//                                         .replaceAll(
//                                           library.aLocalHandler.aMethod.aMethod
//                                               .methodName,
//                                           methodNode.name,
//                                         )
//                                         .replaceAll(
//                                           library.aLocalHandler.aMethod.aMethod
//                                               .anArgument.exp,
//                                           library.aLocalHandler.aMethod.aMethod
//                                               .anArgument
//                                               .replaceWithFirst(
//                                             methodNode.parameters,
//                                           ),
//                                         ),
//                               )
//                               .join(',\n'),
//                         ),
//                   )
//                   .join(',\n'),
//             )
//             .replaceAll(
//               library.aLocalHandler.aStaticMethodAbstractMethod.exp,
//               libraryNode.classes
//                   .fold<Map<MethodNode, ClassNode>>(
//                     <MethodNode, ClassNode>{},
//                     (Map<MethodNode, ClassNode> map, ClassNode classNode) {
//                       classNode.staticMethods.forEach(
//                         (MethodNode methodNode) => map[methodNode] = classNode,
//                       );
//                       return map;
//                     },
//                   )
//                   .entries
//                   .map<String>(
//                     (MapEntry<MethodNode, ClassNode> entry) =>
//                         library.aLocalHandler.aStaticMethodAbstractMethod
//                             .stringMatch()
//                             .replaceAll(
//                               library.aLocalHandler.aStaticMethodAbstractMethod
//                                   .className,
//                               ReCase(entry.value.name).camelCase,
//                             )
//                             .replaceAll(
//                               library.aLocalHandler.aStaticMethodAbstractMethod
//                                   .name,
//                               entry.key.name,
//                             )
//                             .replaceAll(
//                               library.aLocalHandler.aStaticMethodAbstractMethod
//                                   .aParameter.exp,
//                               library.aLocalHandler.aStaticMethodAbstractMethod
//                                   .aParameter
//                                   .replace(entry.key.parameters),
//                             ),
//                   )
//                   .join('\n\n'),
//             )
//             .replaceAll(
//               library.aLocalHandler.aCreatorAbstractMethod.exp,
//               libraryNode.classes
//                   .map<String>(
//                     (ClassNode classNode) =>
//                         library.aLocalHandler.aCreatorAbstractMethod
//                             .stringMatch()
//                             .replaceAll(
//                               library.aLocalHandler.aCreatorAbstractMethod
//                                   .classPrefix,
//                               prefix,
//                             )
//                             .replaceAll(
//                               library.aLocalHandler.aCreatorAbstractMethod
//                                   .className,
//                               classNode.name,
//                             ),
//                   )
//                   .join('\n\n'),
//             )
//             .replaceAll(
//               library.aLocalHandler.anInvokeMethodCondition.exp,
//               libraryNode.classes
//                   .map<String>(
//                     (ClassNode classNode) =>
//                         library.aLocalHandler.anInvokeMethodCondition
//                             .stringMatch()
//                             .replaceAll(
//                               library.aLocalHandler.anInvokeMethodCondition
//                                   .className,
//                               classNode.name,
//                             )
//                             .replaceAll(
//                               library.aLocalHandler.anInvokeMethodCondition
//                                   .classPrefix,
//                               prefix,
//                             )
//                             .replaceAll(
//                               library.aLocalHandler.anInvokeMethodCondition
//                                   .aMethod.exp,
//                               classNode.methods
//                                   .map<String>(
//                                     (MethodNode methodNode) => library
//                                         .aLocalHandler
//                                         .anInvokeMethodCondition
//                                         .aMethod
//                                         .stringMatch()
//                                         .replaceAll(
//                                           library
//                                               .aLocalHandler
//                                               .anInvokeMethodCondition
//                                               .aMethod
//                                               .name,
//                                           methodNode.name,
//                                         )
//                                         .replaceAll(
//                                           library
//                                               .aLocalHandler
//                                               .anInvokeMethodCondition
//                                               .aMethod
//                                               .className,
//                                           classNode.name,
//                                         )
//                                         .replaceAll(
//                                           library
//                                               .aLocalHandler
//                                               .anInvokeMethodCondition
//                                               .aMethod
//                                               .classPrefix,
//                                           prefix,
//                                         )
//                                         .replaceAll(
//                                           library
//                                               .aLocalHandler
//                                               .anInvokeMethodCondition
//                                               .aMethod
//                                               .anArgument
//                                               .exp,
//                                           library
//                                               .aLocalHandler
//                                               .anInvokeMethodCondition
//                                               .aMethod
//                                               .anArgument
//                                               .replaceWithFirst(
//                                             methodNode.parameters,
//                                           ),
//                                         ),
//                                   )
//                                   .join('else'),
//                             ),
//                   )
//                   .join(' else '),
//             ),
//       )
//       .replaceAll(
//         library.aCreationArgument.exp,
//         libraryNode.classes
//             .map<String>(
//               (ClassNode classNode) => library.aCreationArgument
//                   .stringMatch()
//                   .replaceAll(
//                     library.aCreationArgument.className,
//                     classNode.name,
//                   )
//                   .replaceAll(library.aCreationArgument.classPrefix, prefix)
//                   .replaceAll(
//                     library.aCreationArgument.aField.exp,
//                     classNode.fields
//                         .map<String>(
//                           (FieldNode fieldNode) => library
//                               .aCreationArgument.aField
//                               .stringMatch()
//                               .replaceAll(
//                                 library.aCreationArgument.aField.name,
//                                 fieldNode.name,
//                               ),
//                         )
//                         .join(','),
//                   ),
//             )
//             .join(',\n'),
//       );
// }
//
// class Library with TemplateRegExp, PrefixTemplate {
//   Library({this.template, this.templatePrefix});
//
//   @override
//   final String template;
//
//   @override
//   final String templatePrefix;
//
//   final RegExp handlerPrefix = TemplateRegExp.regExp(
//     r'(?<=_LocalStaticMethodHandler\)\(|_LocalCreatorHandler\)\()_p_',
//   );
//
//   final RegExp headerFilename = TemplateRegExp.regExp(
//     r'(?<=#import ")REFLibraryTemplate_Internal\.h',
//   );
//
//   Class get aClass => Class(this);
//
//   CreationArgsClass get aCreationArgsClass => CreationArgsClass(this);
//
//   Manager get aManager => Manager(this);
//
//   LocalHandler get aLocalHandler => LocalHandler(this);
//
//   CreationArgument get aCreationArgument => CreationArgument(this);
//
//   @override
//   final TemplateRegExp parent = null;
//
//   @override
//   final RegExp exp = null;
// }
//
// class Class with TemplateRegExp, PrefixTemplate {
//   Class(this.parent);
//
//   final RegExp name = TemplateRegExp.regExp(
//     r'(?<=@implementation \w*)ClassTemplate',
//   );
//
//   final RegExp prefix = TemplateRegExp.regExp(
//     r'(?<=@implementation )_p_',
//   );
//
//   final RegExp referenceClass = TemplateRegExp.regExp(
//     r'(?<=\[REFClass fromClass:\[\w*)ClassTemplate',
//   );
//
//   final RegExp referenceClassPrefix = TemplateRegExp.regExp(
//     r'(?<=\[REFClass fromClass:\[)_p_',
//   );
//
//   ClassField get aField => ClassField(this);
//   ClassMethod get aMethod => ClassMethod(this);
//
//   ClassProtectedStaticMethod get aProtectedStaticMethod =>
//       ClassProtectedStaticMethod(this);
//
//   ClassProtectedMethod get aProtectedMethod => ClassProtectedMethod(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'@implementation _p_ClassTemplate([^\}]+\}){6}\s*@end',
//   );
//
//   @override
//   final Library parent;
// }
//
// class ClassField with TemplateRegExp {
//   ClassField(this.parent);
//
//   final RegExp type = TemplateRegExp.regExp(r'NSNumber(?= \*)');
//   final RegExp name = TemplateRegExp.regExp(r'fieldTemplate(?= \{)');
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'- \(NSNumber \*\)fieldTemplate[^\}]+\}',
//   );
//
//   @override
//   final Class parent;
// }
//
// class ClassMethod with TemplateRegExp, PrefixTemplate {
//   ClassMethod(this.parent);
//
//   final RegExp name = TemplateRegExp.regExp(r'methodTemplate');
//
//   Parameter get aParameter => Parameter(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'- \(NSObject \*_Nullable\)methodTemplate:[^\}]+\}',
//   );
//
//   @override
//   final Class parent;
// }
//
// class CreationArgsClass with TemplateRegExp {
//   CreationArgsClass(this.parent);
//
//   final RegExp className = TemplateRegExp.regExp(
//     r'ClassTemplate(?=CreationArgs)',
//   );
//
//   final RegExp classPrefix = TemplateRegExp.regExp(
//     r'_p_(?=ClassTemplate)',
//   );
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'@implementation _p_ClassTemplateCreationArgs[^@]@end',
//   );
//
//   @override
//   final Library parent;
// }
//
// class ClassProtectedStaticMethod with TemplateRegExp, PrefixTemplate {
//   ClassProtectedStaticMethod(this.parent);
//
//   final RegExp className = TemplateRegExp.regExp(
//     r'ClassTemplate(?= class)',
//   );
//
//   final RegExp classPrefix = TemplateRegExp.regExp(
//     r'(?<=invokeRemoteStaticMethod:\[)_p_',
//   );
//
//   final RegExp name = TemplateRegExp.regExp(
//     r'(?<="|_)staticMethodTemplate(?="|:)',
//   );
//
//   final RegExp managerPrefix = TemplateRegExp.regExp(
//     r'_p_(?=ReferencePairManager \*)',
//   );
//
//   Parameter get aParameter => Parameter(this);
//
//   ParameterName get aParameterName => ParameterName(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'\+ \(void\)_staticMethodTemplate:[^\}]+\}',
//   );
//
//   @override
//   final Class parent;
// }
//
// class ClassProtectedMethod with TemplateRegExp, PrefixTemplate {
//   ClassProtectedMethod(this.parent);
//
//   final RegExp name = TemplateRegExp.regExp(
//     r'(?<=_)methodTemplate(?=:)',
//   );
//
//   final RegExp managerPrefix = TemplateRegExp.regExp(
//     r'_p_(?=ReferencePairManager \*)',
//   );
//
//   Parameter get aParameter => Parameter(this);
//
//   ClassProtectedMethodUnpairedReference get anUnpairedReference =>
//       ClassProtectedMethodUnpairedReference(this);
//
//   ClassProtectedMethodPairedReference get aPairedReference =>
//       ClassProtectedMethodPairedReference(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'\- \(void\)_methodTemplate:[^\}]+\}[^\}]+\}',
//   );
//
//   @override
//   final Class parent;
// }
//
// class ParameterName with TemplateRegExp {
//   ParameterName(this.parent);
//
//   final RegExp name = TemplateRegExp.regExp(r'parameterTemplate');
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(r'(?<=@\[ )parameterTemplate');
//
//   @override
//   final TemplateRegExp parent;
// }
//
// class ClassProtectedMethodUnpairedReference with TemplateRegExp {
//   ClassProtectedMethodUnpairedReference(this.parent);
//
//   final RegExp name = TemplateRegExp.regExp(r'methodTemplate(?=")');
//
//   ParameterName get aParameterName => ParameterName(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'invokeRemoteMethodOnUnpairedReference[^\}]+\}',
//   );
//
//   @override
//   final ClassProtectedMethod parent;
// }
//
// class ClassProtectedMethodPairedReference with TemplateRegExp {
//   ClassProtectedMethodPairedReference(this.parent);
//
//   final RegExp name = TemplateRegExp.regExp(r'methodTemplate(?=")');
//
//   ParameterName get aParameterName => ParameterName(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'invokeRemoteMethod[^\}]+\}',
//   );
//
//   @override
//   final ClassProtectedMethod parent;
// }
//
// class Manager with TemplateRegExp {
//   Manager(this.parent);
//
//   final RegExp prefix = TemplateRegExp.regExp(r'(?<=@implementation )_p_');
//
//   final RegExp remoteHandlerPrefix =
//       TemplateRegExp.regExp(r'_p_(?=RemoteHandler alloc)');
//
//   ManagerClass get aClass => ManagerClass(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'@implementation _p_ReferencePairManager[^\}]+\}[^\}]+\}',
//   );
//
//   @override
//   final Library parent;
// }
//
// class ManagerClass with TemplateRegExp {
//   ManagerClass(this.parent);
//
//   final RegExp name = TemplateRegExp.regExp(r'ClassTemplate');
//   final RegExp prefix = TemplateRegExp.regExp(r'_p_');
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'\[REFClass fromClass:\[_p_ClassTemplate class\]\]',
//   );
//
//   @override
//   final Manager parent;
// }
//
// class LocalHandler with TemplateRegExp, PrefixTemplate {
//   LocalHandler(this.parent);
//
//   final RegExp prefix = TemplateRegExp.regExp(r'(?<=@implementation )_p_');
//
//   LocalHandlerCreator get aCreator => LocalHandlerCreator(this);
//
//   LocalHandlerStaticMethod get aStaticMethod => LocalHandlerStaticMethod(this);
//
//   LocalHandlerMethod get aMethod => LocalHandlerMethod(this);
//
//   LocalHandlerStaticMethodAbstractMethod get aStaticMethodAbstractMethod =>
//       LocalHandlerStaticMethodAbstractMethod(this);
//
//   LocalHandlerCreatorAbstractMethod get aCreatorAbstractMethod =>
//       LocalHandlerCreatorAbstractMethod(this);
//
//   LocalHandlerInvokeMethodCondition get anInvokeMethodCondition =>
//       LocalHandlerInvokeMethodCondition(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'@implementation _p_LocalHandler.+(?<!.*@end).*@end',
//   );
//
//   @override
//   final Library parent;
// }
//
// class LocalHandlerCreator with TemplateRegExp {
//   LocalHandlerCreator(this.parent);
//
//   final RegExp className = TemplateRegExp.regExp(
//     r'ClassTemplate(?=CreationArgs|\.class|:manager)',
//   );
//
//   final RegExp localHandlerPrefix =
//       TemplateRegExp.regExp(r'_p_(?=LocalHandler \*)');
//   final RegExp classPrefix = TemplateRegExp.regExp(r'(?<=:|\s|\[)_p_');
//
//   LocalHandlerCreatorCreationArgs get argument =>
//       LocalHandlerCreatorCreationArgs(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(r'(?<=creators = @\{)\[[^\}]+\}');
//
//   @override
//   final LocalHandler parent;
// }
//
// class LocalHandlerCreatorCreationArgs with TemplateRegExp {
//   LocalHandlerCreatorCreationArgs(this.parent);
//
//   final RegExp fieldName = TemplateRegExp.regExp(r'fieldTemplate');
//   final RegExp argumentIndex = TemplateRegExp.regExp(r'(?<=\[)\d');
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'args\.fieldTemplate = arguments\[0\];',
//   );
//
//   @override
//   final LocalHandlerCreator parent;
// }
//
// class LocalHandlerStaticMethod with TemplateRegExp {
//   LocalHandlerStaticMethod(this.parent);
//
//   final RegExp classPrefix = TemplateRegExp.regExp(r'(?<=:)_p_');
//
//   final RegExp className = TemplateRegExp.regExp(r'ClassTemplate(?=\.class)');
//
//   LocalHandlerStaticMethodMethod get aMethod =>
//       LocalHandlerStaticMethodMethod(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'(?<=staticMethods =\s*@{)\[[^\}]+\}[^\}]+\}',
//   );
//
//   @override
//   final LocalHandler parent;
// }
//
// class LocalHandlerStaticMethodMethod with TemplateRegExp {
//   LocalHandlerStaticMethodMethod(this.parent);
//
//   final RegExp localHandlerPrefix =
//       TemplateRegExp.regExp(r'_p_(?=LocalHandler \*)');
//
//   final RegExp methodName = TemplateRegExp.regExp(
//     r'(?<=_|")staticMethodTemplate',
//   );
//
//   final RegExp classNamePart = TemplateRegExp.regExp(r'classTemplate(?=_)');
//
//   Argument get anArgument => Argument(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'@"staticMethodTemplate"[^\}]+\}',
//   );
//
//   @override
//   final LocalHandlerStaticMethod parent;
// }
//
// class LocalHandlerMethod with TemplateRegExp {
//   LocalHandlerMethod(this.parent);
//
//   final RegExp classPrefix = TemplateRegExp.regExp(r'(?<=:)_p_');
//
//   final RegExp className = TemplateRegExp.regExp(r'ClassTemplate(?=\.class)');
//
//   LocalHandlerMethodMethod get aMethod => LocalHandlerMethodMethod(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'(?<=methods =\s*@{)\[[^\}]+\}[^\}]+\}',
//   );
//
//   @override
//   final LocalHandler parent;
// }
//
// class LocalHandlerMethodMethod with TemplateRegExp {
//   LocalHandlerMethodMethod(this.parent);
//
//   final RegExp methodName = TemplateRegExp.regExp(r'methodTemplate(?=:|")');
//   final RegExp className = TemplateRegExp.regExp(r'ClassTemplate(?= \*value)');
//   final RegExp classPrefix = TemplateRegExp.regExp(r'(?<=\s)_p_');
//
//   Argument get anArgument => Argument(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'@"methodTemplate"[^\}]+\}',
//   );
//
//   @override
//   final LocalHandlerMethod parent;
// }
//
// class Argument with TemplateRegExp {
//   Argument(this.parent);
//
//   static const String firstArgument = r':arguments[0]';
//   static const String followingArgument = r'parameterTemplate:arguments[0]';
//
//   final RegExp name = TemplateRegExp.regExp(r'parameterTemplate(?=:)');
//   final RegExp index = TemplateRegExp.regExp(r'(?<=\[)\d');
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'(parameterTemplate)*:*arguments\[0\]',
//   );
//
//   @override
//   final TemplateRegExp parent;
//
//   String replaceWithFirst(Iterable<ParameterNode> parameterNodes) {
//     if (parameterNodes.isEmpty) return '';
//
//     final String first = Argument.firstArgument.replaceAll(index, '0');
//
//     return '$first ${replace(parameterNodes.skip(1).toList(), 1)}';
//   }
//
//   String replace(List<ParameterNode> parameterNodes, [int startIndex = 0]) {
//     if (parameterNodes.isEmpty) return '';
//
//     final String parameters =
//         List<int>.generate(parameterNodes.length, (int index) => index)
//             .map<String>((int parameterIndex) => Argument.followingArgument
//                 .replaceAll(name, parameterNodes[parameterIndex].name)
//                 .replaceAll(index, '${parameterIndex + startIndex}'))
//             .join(' ');
//
//     return parameters;
//   }
// }
//
// class LocalHandlerStaticMethodAbstractMethod
//     with TemplateRegExp, PrefixTemplate {
//   LocalHandlerStaticMethodAbstractMethod(this.parent);
//
//   final RegExp className = TemplateRegExp.regExp(r'classTemplate(?=_)');
//   final RegExp name = TemplateRegExp.regExp(r'(?<=_)staticMethodTemplate');
//
//   Parameter get aParameter => Parameter(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'- \(id _Nullable\)classTemplate_staticMethodTemplate[^\}]+}',
//   );
//
//   @override
//   final LocalHandler parent;
// }
//
// class LocalHandlerCreatorAbstractMethod with TemplateRegExp {
//   LocalHandlerCreatorAbstractMethod(this.parent);
//
//   final RegExp className = TemplateRegExp.regExp(
//     r'ClassTemplate(?= \*|CreationArgs \*|:\(REF)',
//   );
//
//   final RegExp classPrefix = TemplateRegExp.regExp(r'(?<=\()_p_');
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'- \(_p_ClassTemplate \*\)createClassTemplate:[^\}]+}',
//   );
//
//   @override
//   final LocalHandler parent;
// }
//
// class LocalHandlerInvokeMethodCondition with TemplateRegExp {
//   LocalHandlerInvokeMethodCondition(this.parent);
//
//   final RegExp className = TemplateRegExp.regExp(r'ClassTemplate(?=\.class)');
//   final RegExp classPrefix = TemplateRegExp.regExp(
//     r'(?<=isKindOfClass:)_p_',
//   );
//
//   LocalHandlerInvokeMethodConditionMethod get aMethod =>
//       LocalHandlerInvokeMethodConditionMethod(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'if \(\[localReference isKindOfClass:_p_ClassTemplate\.class[^\}]*}[^\}]*}',
//   );
//
//   @override
//   final LocalHandler parent;
// }
//
// class LocalHandlerInvokeMethodConditionMethod with TemplateRegExp {
//   LocalHandlerInvokeMethodConditionMethod(this.parent);
//
//   final RegExp className = TemplateRegExp.regExp(r'ClassTemplate(?= \*value)');
//
//   final RegExp name = TemplateRegExp.regExp(r'methodTemplate(?="|:)');
//
//   final RegExp classPrefix = TemplateRegExp.regExp(r'(?<=\s)_p_');
//
//   Argument get anArgument => Argument(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'if \(\[@"methodTemplate" isEqualToString:methodName[^\}]*}',
//   );
//
//   @override
//   final LocalHandlerInvokeMethodCondition parent;
// }
//
// class CreationArgument with TemplateRegExp {
//   CreationArgument(this.parent);
//
//   CreationArgumentField get aField => CreationArgumentField(this);
//
//   final RegExp className = TemplateRegExp.regExp(
//     r'ClassTemplate(?=\.class| \*value)',
//   );
//
//   final RegExp classPrefix = TemplateRegExp.regExp(
//     r'(?<=:|\s)_p_',
//   );
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'(?<=creationArguments =\s*@\{)\[[^\}]+\}',
//   );
//
//   @override
//   final Library parent;
// }
//
// class CreationArgumentField with TemplateRegExp {
//   CreationArgumentField(this.parent);
//
//   final RegExp name = TemplateRegExp.regExp(r'(?<=\.)fieldTemplate');
//
//   @override
//   final CreationArgument parent;
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'value\.fieldTemplate',
//   );
// }
