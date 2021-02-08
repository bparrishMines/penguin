import 'package:reference_generator/src/ast.dart';

import 'common.dart';

String generateObjcHeader({
  String template,
  LibraryNode libraryNode,
  String prefix,
}) {
  final Library library = Library(template);
  return template
      .replaceAll(
        library.aProtocolDirective.exp,
        libraryNode.classes.map<String>(
          (ClassNode classNode) {
            final ProtocolDirective classDirective = library.aProtocolDirective;
            return classDirective
                .stringMatch()
                .replaceAll(classDirective.className, classNode.name)
                .replaceAll(
                  classDirective.classPrefix,
                  prefix,
                );
          },
        ).join('\n'),
      )
      .replaceAll(
        library.aProtocol.exp,
        libraryNode.classes.map<String>(
          (ClassNode classNode) {
            final Protocol protocol = library.aProtocol;
            return protocol
                .stringMatch()
                .replaceAll(protocol.name, classNode.name)
                .replaceAll(protocol.prefix, prefix)
                .replaceAll(
                  protocol.aField.exp,
                  classNode.fields.map<String>(
                    (FieldNode fieldNode) {
                      final ProtocolField field = protocol.aField;
                      return field
                          .stringMatch()
                          .replaceAll(field.name, fieldNode.name)
                          .replaceAll(
                            field.type,
                            getTrueTypeName(fieldNode.type, prefix),
                          );
                    },
                  ).join('\n'),
                )
                .replaceAll(
                  protocol.aMethod.exp,
                  classNode.methods.map<String>(
                    (MethodNode methodNode) {
                      final ProtocolMethod method = protocol.aMethod;
                      return method
                          .stringMatch()
                          .replaceAll(method.name, methodNode.name)
                          .replaceAll(
                            method.theLeadingParameter.exp,
                            methodNode.parameters.isEmpty
                                ? ''
                                : method.theLeadingParameter
                                    .stringMatch()
                                    .replaceAll(method.theLeadingParameter.name,
                                        methodNode.parameters[0].name)
                                    .replaceAll(
                                      method.theLeadingParameter.type,
                                      getTrueTypeName(
                                        methodNode.parameters[0].type,
                                        prefix,
                                      ),
                                    ),
                          )
                          .replaceAll(
                            method.aFollowingParameterComment.exp,
                            methodNode.parameters.skip(1).map<String>(
                              (ParameterNode parameterNode) {
                                final FollowingParameterComment comment =
                                    method.aFollowingParameterComment;
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
                            ).join(' '),
                          );
                    },
                  ).join('\n'),
                );
          },
        ).join('\n'),
      )
      .replaceAll(
        library.aCreationArgsClass.exp,
        libraryNode.classes.map<String>(
          (ClassNode classNode) {
            final CreationArgsClass argsClass = library.aCreationArgsClass;
            return argsClass
                .stringMatch()
                .replaceAll(argsClass.className, classNode.name)
                .replaceAll(argsClass.classPrefix, prefix)
                .replaceAll(
                    argsClass.aField.exp,
                    classNode.fields.map<String>(
                      (FieldNode fieldNode) {
                        final CreationArgsClassField field = argsClass.aField;
                        return field
                            .stringMatch()
                            .replaceAll(field.name, fieldNode.name)
                            .replaceAll(
                              field.type,
                              getTrueTypeName(
                                fieldNode.type,
                                prefix,
                              ),
                            );
                      },
                    ).join('\n'));
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
                          );
                    },
                  ).join('\n'),
                )
                .replaceAll(
                    channel.aMethod.exp,
                    classNode.methods.map<String>((MethodNode methodNode) {
                      final ChannelMethod method = channel.aMethod;
                      return method
                          .stringMatch()
                          .replaceAll(method.name, methodNode.name)
                          .replaceAll(method.instanceType, classNode.name)
                          .replaceAll(method.instanceTypePrefix, prefix)
                          .replaceAll(
                            method.aFollowingParameter.exp,
                            methodNode.parameters
                                .map<String>((ParameterNode parameterNode) {
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
                            }).join('\n'),
                          );
                    }).join('\n'));
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
                );
          },
        ).join('\n'),
      );
}

String getTrueTypeName(ReferenceType type, String prefix) {
  final String objcName = objcTypeNameConversion(type.name);

  final Iterable<String> typeArguments = type.typeArguments.map<String>(
    (ReferenceType type) => getTrueTypeName(type, prefix),
  );

  if (type.codeGeneratedClass && typeArguments.isEmpty) {
    return 'NSObject<$prefix$objcName>';
  } else if (type.codeGeneratedClass && typeArguments.isNotEmpty) {
    return 'NSObject<$prefix$objcName<${typeArguments.join(' *,')} *>>';
  } else if (!type.codeGeneratedClass && typeArguments.isNotEmpty) {
    return '$objcName<${typeArguments.join(' *,')} *>';
  }

  return '$objcName';
}

// TODO: A user could extend a list/map so we want a boolean flag to check.
String objcTypeNameConversion(String type) {
  switch (type) {
    case 'int':
    case 'int?':
    case 'double':
    case 'double?':
    case 'num':
    case 'num?':
    case 'bool':
    case 'bool?':
      return 'NSNumber';
    case 'String':
    case 'String?':
      return 'NSString';
    case 'Object':
    case 'Object?':
      return 'NSObject';
    case 'List':
    case 'List?':
      return 'NSArray';
    case 'Map':
    case 'Map?':
      return 'NSDictionary';
  }

  return type;
}

class Library with TemplateRegExp {
  Library(this.template);

  @override
  final RegExp exp = null;

  @override
  final Library parent = null;

  @override
  final String template;

  ProtocolDirective get aProtocolDirective => ProtocolDirective(this);

  Protocol get aProtocol => Protocol(this);

  CreationArgsClass get aCreationArgsClass => CreationArgsClass(this);

  Channel get aChannel => Channel(this);

  Handler get aHandler => Handler(this);
}

class ProtocolDirective with TemplateRegExp {
  ProtocolDirective(this.parent);

  final RegExp classPrefix = TemplateRegExp.regExp(r'(?<=@protocol )REF');
  final RegExp className = TemplateRegExp.regExp(r'ClassTemplate(?=;)');

  @override
  final RegExp exp = TemplateRegExp.regExp(r'@protocol REFClassTemplate;');

  @override
  final Library parent;
}

class Protocol with TemplateRegExp {
  Protocol(this.parent);

  final RegExp name = TemplateRegExp.regExp(
    r'(?<=@protocol REF)ClassTemplate(?= <NSObject>)',
  );

  final RegExp prefix = TemplateRegExp.regExp(r'(?<=@protocol )REF');

  ProtocolMethod get aMethod => ProtocolMethod(this);

  ProtocolField get aField => ProtocolField(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'@protocol REFClassTemplate[^@]*@end',
  );

  @override
  final Library parent;
}

class ProtocolField with TemplateRegExp {
  ProtocolField(this.parent);

  final RegExp type = TemplateRegExp.regExp(r'NSNumber(?= \*)');
  final RegExp name = TemplateRegExp.regExp(r'fieldTemplate(?=;)');

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'- \(NSNumber \*_Nullable\)fieldTemplate;',
  );

  @override
  final Protocol parent;
}

class ProtocolMethod with TemplateRegExp {
  ProtocolMethod(this.parent);

  final RegExp name = TemplateRegExp.regExp(
    r'(?<=- \(NSObject \*_Nullable\))methodTemplate',
  );

  LeadingParameter get theLeadingParameter => LeadingParameter(this);

  FollowingParameterComment get aFollowingParameterComment =>
      FollowingParameterComment(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'- \(NSObject \*_Nullable\)methodTemplate:[^;]+;',
  );

  @override
  final Protocol parent;
}

class LeadingParameter with TemplateRegExp {
  LeadingParameter(this.parent);

  final RegExp type = TemplateRegExp.regExp(r'NSString(?= \*)');

  final RegExp name = TemplateRegExp.regExp(r'parameterTemplate$');

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r':\(NSString \*_Nullable\)parameterTemplate',
  );

  @override
  final TemplateRegExp parent;
}

class FollowingParameter with TemplateRegExp {
  FollowingParameter(this.parent);

  final RegExp type = TemplateRegExp.regExp(r'NSString(?= \*)');

  final RegExp name = TemplateRegExp.regExp(r'^parameterTemplate');

  final RegExp name2 = TemplateRegExp.regExp(r'parameterTemplate$');

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'parameterTemplate:\(NSString \*_Nullable\)parameterTemplate',
  );

  @override
  final TemplateRegExp parent;
}

class FollowingParameterComment with TemplateRegExp {
  FollowingParameterComment(this.parent);

  @override
  final TemplateRegExp parent;

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'\/\*following_parameters\*\/',
  );

  final RegExp type = TemplateRegExp.regExp(r'NSString(?= \*)');

  final RegExp name = TemplateRegExp.regExp(r'^parameterTemplate');

  final RegExp name2 = TemplateRegExp.regExp(r'parameterTemplate$');

  @override
  String stringMatch() {
    return 'parameterTemplate:(NSString *_Nullable)parameterTemplate';
  }
}

class CreationArgsClass with TemplateRegExp {
  CreationArgsClass(this.parent);

  final RegExp className = TemplateRegExp.regExp(
    r'(?<=@interface REF)ClassTemplate',
  );

  final RegExp classPrefix = TemplateRegExp.regExp(r'(?<=@interface )REF');

  CreationArgsClassField get aField => CreationArgsClassField(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'@interface REFClassTemplateCreationArgs.*@end(?=\s*@interface REFClassTemplateChannel)',
  );

  @override
  final Library parent;
}

class CreationArgsClassField with TemplateRegExp {
  CreationArgsClassField(this.parent);

  final RegExp type = TemplateRegExp.regExp(r'(?<=@property )NSNumber');
  final RegExp name = TemplateRegExp.regExp(r'fieldTemplate(?=;)');

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'@property NSNumber \*_Nullable fieldTemplate;',
  );

  @override
  final CreationArgsClass parent;
}

class Channel with TemplateRegExp {
  Channel(this.parent);

  @override
  final Library parent;

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'@interface REFClassTemplateChannel.*@end(?=\s*@interface REFClassTemplateHandler)',
  );

  final RegExp className =
      TemplateRegExp.regExp('(?<=@interface REF)ClassTemplate');

  final RegExp prefix = TemplateRegExp.regExp('(?<=@interface )REF');

  ChannelStaticMethod get aStaticMethod => ChannelStaticMethod(this);

  ChannelMethod get aMethod => ChannelMethod(this);
}

class ChannelStaticMethod with TemplateRegExp {
  ChannelStaticMethod(this.parent);

  @override
  final Channel parent;

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'- \(void\)invoke_staticMethodTemplate[^;]+;',
  );

  final RegExp name = TemplateRegExp.regExp(
    r'(?<=invoke_)staticMethodTemplate',
  );

  final RegExp completion = TemplateRegExp.regExp(r'completion(?=:)');

  LeadingParameter get theLeadingParameter => LeadingParameter(this);

  FollowingParameterComment get aFollowingParameterComment =>
      FollowingParameterComment(this);
}

class ChannelMethod with TemplateRegExp {
  ChannelMethod(this.parent);

  @override
  final RegExp exp =
      TemplateRegExp.regExp(r'- \(void\)invoke_methodTemplate[^;]+;');

  @override
  final Channel parent;

  final RegExp name = TemplateRegExp.regExp(
    r'(?<=invoke_)methodTemplate',
  );

  final RegExp instanceType = TemplateRegExp.regExp(
    r'(?<=NSObject<REF)ClassTemplate',
  );

  final RegExp instanceTypePrefix = TemplateRegExp.regExp(r'(?<=NSObject<)REF');

  FollowingParameter get aFollowingParameter => FollowingParameter(this);
}

class Handler with TemplateRegExp {
  Handler(this.parent);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'@interface REFClassTemplateHandler[^@]*@end',
  );

  @override
  final Library parent;

  final RegExp className = TemplateRegExp.regExp(
    r'ClassTemplate(?=Handler : NSObject<REFTypeChannelHandler>)',
  );

  final RegExp prefix = TemplateRegExp.regExp(r'(?<=@interface )REF');

  HandlerOnCreateMethod get theOnCreateMethod => HandlerOnCreateMethod(this);

  HandlerStaticMethod get aStaticMethod => HandlerStaticMethod(this);
}

class HandlerOnCreateMethod with TemplateRegExp {
  HandlerOnCreateMethod(this.parent);

  @override
  final Handler parent;

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'- \(NSObject<REFClassTemplate> \*\)onCreate:[^;]+;',
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
    r'- \(NSObject \*_Nullable\)on_staticMethodTemplate:[^;]+;',
  );

  final RegExp name = TemplateRegExp.regExp(r'(?<=on_)staticMethodTemplate');

  FollowingParameter get aFollowingParameter => FollowingParameter(this);
}

// class Library with TemplateRegExp {
//   Library({this.template, this.templatePrefix});
//
//   @override
//   final String template;
//
//   @override
//   final String templatePrefix;
//
//   final RegExp managerPrefix = TemplateRegExp.regExp(
//     r'(?<=@interface )_p_(?=ReferencePairManager)',
//   );
//
//   final RegExp remoteHandlerPrefix = TemplateRegExp.regExp(
//     r'(?<=@interface )_p_(?=RemoteHandler)',
//   );
//
//   ClassDirective get aClassDirective => ClassDirective(this);
//
//   Class get aClass => Class(this);
//
//   CreationArgsClass get aCreationArgsClass => CreationArgsClass(this);
//
//   LocalHandler get aLocalHandler => LocalHandler(this);
//
//   @override
//   final TemplateRegExp parent = null;
//
//   @override
//   final RegExp exp = null;
// }
//
// class ClassDirective with TemplateRegExp {
//   ClassDirective(this.parent);
//
//   final RegExp classPrefix = TemplateRegExp.regExp(r'(?<=@class )_p_');
//   final RegExp className = TemplateRegExp.regExp(r'ClassTemplate(?=;)');
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(r'@class _p_ClassTemplate;');
//
//   @override
//   final Library parent;
// }
//
// class Class with TemplateRegExp {
//   Class(this.parent);
//
//   final RegExp name = TemplateRegExp.regExp(
//     r'(?<=@interface _p_)ClassTemplate(?= :)',
//   );
//
//   final RegExp prefix = TemplateRegExp.regExp(r'(?<=@interface )_p_');
//
//   ClassMethod get aMethod => ClassMethod(this);
//   ClassField get aField => ClassField(this);
//
//   ClassProtectedStaticMethod get aProtectedStaticMethod =>
//       ClassProtectedStaticMethod(this);
//
//   ClassProtectedMethod get aProtectedMethod => ClassProtectedMethod(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'@interface _p_ClassTemplate[^@]*@end',
//   );
//
//   @override
//   final Library parent;
// }
//
// class ClassField with TemplateRegExp {
//   ClassField(this.parent);
//
//   final RegExp type = TemplateRegExp.regExp(r'NSNumber');
//   final RegExp name = TemplateRegExp.regExp(r'fieldTemplate');
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'- \(NSNumber \*_Nullable\)fieldTemplate;',
//   );
//
//   @override
//   final Class parent;
// }
//
// class ClassMethod with TemplateRegExp {
//   ClassMethod(this.parent);
//
//   final RegExp name = TemplateRegExp.regExp(r'methodTemplate');
//
//   Parameter get aParameter => Parameter(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'- \(NSObject \*_Nullable\)methodTemplate:\(NSString \*_Nullable\)parameterTemplate;',
//   );
//
//   @override
//   final Class parent;
// }
//
// class Parameter with TemplateRegExp {
//   Parameter(this.parent);
//
//   static const String firstParameter =
//       r':(NSString *_Nullable)parameterTemplate';
//   static const String followingParameter =
//       r'parameterTemplate:(NSString *_Nullable)parameterTemplate';
//
//   final RegExp type = TemplateRegExp.regExp(r'NSString(?= \*)');
//
//   final RegExp name = TemplateRegExp.regExp(r'parameterTemplate(?=:|\s|$)');
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'(parameterTemplate)*:*\(NSString \*_Nullable\)parameterTemplate',
//   );
//
//   @override
//   final PrefixTemplate parent;
//
//   String replaceWithFirst(Iterable<ParameterNode> parameterNodes) {
//     if (parameterNodes.isEmpty) return '';
//
//     final String first = Parameter.firstParameter
//         .replaceAll(
//           name,
//           parameterNodes.first.name,
//         )
//         .replaceAll(
//             type, getTrueTypeName(parameterNodes.first.type, templatePrefix));
//
//     return '$first ${replace(parameterNodes.skip(1))}';
//   }
//
//   String replace(Iterable<ParameterNode> parameterNodes) {
//     if (parameterNodes.isEmpty) return '';
//
//     final String parameters = parameterNodes
//         .map<String>((ParameterNode parameterNode) => Parameter
//             .followingParameter
//             .replaceAll(
//               name,
//               parameterNode.name,
//             )
//             .replaceAll(
//                 type, getTrueTypeName(parameterNode.type, templatePrefix)))
//         .join(' ');
//
//     return parameters;
//   }
// }
//
// class CreationArgsClass with TemplateRegExp {
//   CreationArgsClass(this.parent);
//
//   final RegExp className =
//       TemplateRegExp.regExp(r'(?<=@interface _p_)ClassTemplate');
//
//   final RegExp classPrefix = TemplateRegExp.regExp(r'(?<=@interface )_p_');
//
//   CreationArgsClassField get aField => CreationArgsClassField(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'@interface _p_ClassTemplateCreationArgs(.*?@end){1}',
//   );
//
//   @override
//   final Library parent;
// }
//
// class CreationArgsClassField with TemplateRegExp {
//   CreationArgsClassField(this.parent);
//
//   final RegExp type = TemplateRegExp.regExp(r'(?<=@property )NSNumber');
//   final RegExp name = TemplateRegExp.regExp(r'fieldTemplate(?=;)');
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'@property NSNumber \*_Nullable fieldTemplate;',
//   );
//
//   @override
//   final CreationArgsClass parent;
// }
//
// class ClassProtectedStaticMethod with TemplateRegExp {
//   ClassProtectedStaticMethod(this.parent);
//
//   final RegExp name = TemplateRegExp.regExp(r'staticMethodTemplate(?=:)');
//
//   final RegExp managerPrefix = TemplateRegExp.regExp(
//     r'_p_(?=ReferencePairManager \*)',
//   );
//
//   Parameter get aParameter => Parameter(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'\+ \(void\)_staticMethodTemplate[^;]+;',
//   );
//
//   @override
//   final Class parent;
// }
//
// class ClassProtectedMethod with TemplateRegExp {
//   ClassProtectedMethod(this.parent);
//
//   final RegExp name = TemplateRegExp.regExp(
//     r'methodTemplate(?=:)',
//   );
//
//   final RegExp managerPrefix = TemplateRegExp.regExp(
//     r'_p_(?=ReferencePairManager \*)',
//   );
//
//   Parameter get aParameter => Parameter(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'- \(void\)_methodTemplate[^;]+;',
//   );
//
//   @override
//   final Class parent;
// }
//
// class LocalHandler with TemplateRegExp {
//   LocalHandler(this.parent);
//
//   final RegExp prefix = TemplateRegExp.regExp(r'(?<=@interface )_p_');
//
//   LocalHandlerStaticMethodAbstractMethod get aStaticMethodAbstractMethod =>
//       LocalHandlerStaticMethodAbstractMethod(this);
//
//   LocalHandlerCreatorAbstractMethod get aCreatorAbstractMethod =>
//       LocalHandlerCreatorAbstractMethod(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'@interface _p_LocalHandler[^@]+@end',
//   );
//
//   @override
//   final Library parent;
// }
//
// class LocalHandlerStaticMethodAbstractMethod
//     with TemplateRegExp {
//   LocalHandlerStaticMethodAbstractMethod(this.parent);
//
//   final RegExp className = TemplateRegExp.regExp(r'classTemplate(?=_)');
//   final RegExp name = TemplateRegExp.regExp(r'(?<=_)staticMethodTemplate');
//
//   Parameter get aParameter => Parameter(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'- \(id _Nullable\)classTemplate_staticMethodTemplate[^;]+;',
//   );
//
//   @override
//   final LocalHandler parent;
// }
//
// class LocalHandlerCreatorAbstractMethod with TemplateRegExp {
//   LocalHandlerCreatorAbstractMethod(this.parent);
//
//   final RegExp classPrefix = TemplateRegExp.regExp(r'(?<=- \(|args:\()_p_');
//
//   final RegExp className =
//       TemplateRegExp.regExp(r'(?<=- \(\w*|\)create)ClassTemplate');
//
//   final RegExp creationArgsClassName = TemplateRegExp.regExp(
//     r'ClassTemplate(?=CreationArgs )',
//   );
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'- \(_p_ClassTemplate \*\)createClassTemplate[^;]+;',
//   );
//
//   @override
//   final LocalHandler parent;
// }
