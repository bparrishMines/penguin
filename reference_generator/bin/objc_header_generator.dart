import 'package:recase/recase.dart';
import 'package:reference_generator/src/ast.dart';

import 'common.dart';

String generateObjcHeader({
  String template,
  LibraryNode libraryNode,
  String prefix,
}) {
  final Library library = Library(template: template, templatePrefix: prefix);
  return template
      .replaceAll(
        library.aClassDirective.exp,
        libraryNode.classes.map<String>(
          (ClassNode classNode) {
            final ClassDirective classDirective = library.aClassDirective;
            return classDirective
                .stringMatch()
                .replaceAll(classDirective.className, classNode.name)
                .replaceAll(
                  classDirective.classPrefix,
                  classDirective.templatePrefix,
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
                .replaceAll(protocol.prefix, protocol.templatePrefix)
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
                            getTrueTypeName(
                              fieldNode.type,
                              field.templatePrefix,
                            ),
                          );
                    },
                  ).join('\n'),
                )
                .replaceAll(
                  protocol.aMethod.exp,
                  classNode.methods.map<String>(
                    (MethodNode methodNode) {
                      final ProtocolMethod method = protocol.aMethod;
                      //return method.stringMatch().replaceAll(method.name, methodNode.name).replaceAll(method.aParameter.exp, methodNode.parameters.map<String>().join(' '))
                    },
                  ).join('\n'),
                );
          },
        ).join('\n'),
      );
}

String getTrueTypeName(ReferenceType type, String prefix) {
  final String javaName = objcTypeNameConversion(type.name);

  final Iterable<String> typeArguments = type.typeArguments.map<String>(
    (ReferenceType type) => getTrueTypeName(type, prefix),
  );

  if (type.codeGeneratedClass && typeArguments.isEmpty) {
    return '$prefix$javaName';
  } else if (type.codeGeneratedClass && typeArguments.isNotEmpty) {
    return '$prefix$javaName<${typeArguments.join(' *,')} *>';
  } else if (!type.codeGeneratedClass && typeArguments.isNotEmpty) {
    return '$javaName<${typeArguments.join(' *,')} *>';
  }

  return '$javaName';
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

mixin PrefixTemplate implements TemplateRegExp {
  String get templatePrefix => (parent as PrefixTemplate).templatePrefix;
}

class Library with TemplateRegExp, PrefixTemplate {
  Library({this.template, this.templatePrefix});

  @override
  final RegExp exp = null;

  @override
  final Library parent = null;

  @override
  final String template;

  @override
  final String templatePrefix;

  ClassDirective get aClassDirective => ClassDirective(this);

  Protocol get aProtocol => Protocol(this);

  CreationArgsClass get aCreationArgsClass => CreationArgsClass(this);

  Channel get aChannel => Channel(this);

  Handler get aHandler => Handler(this);
}

class ClassDirective with TemplateRegExp, PrefixTemplate {
  ClassDirective(this.parent);

  final RegExp classPrefix = TemplateRegExp.regExp(r'(?<=@class )REF');
  final RegExp className = TemplateRegExp.regExp(r'ClassTemplate(?=;)');

  @override
  final RegExp exp = TemplateRegExp.regExp(r'@class REFClassTemplate;');

  @override
  final Library parent;
}

class Protocol with TemplateRegExp, PrefixTemplate {
  Protocol(this.parent);

  final RegExp name = TemplateRegExp.regExp(
    r'(?<=@interface REF)ClassTemplate(?= <NSObject>)',
  );

  final RegExp prefix = TemplateRegExp.regExp(r'(?<=@interface )REF');

  ProtocolMethod get aMethod => ProtocolMethod(this);

  ProtocolField get aField => ProtocolField(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'@interface REFClassTemplate[^@]*@end',
  );

  @override
  final Library parent;
}

class ProtocolField with TemplateRegExp, PrefixTemplate {
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

class ProtocolMethod with TemplateRegExp, PrefixTemplate {
  ProtocolMethod(this.parent);

  final RegExp name = TemplateRegExp.regExp(
    r'(?<=- \(NSObject \*_Nullable\))methodTemplate',
  );

  LeadingParameter get aLeadingParameter => LeadingParameter(this);

  //FollowingParameter get aFollowingParameter => FollowingParameter(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'- \(NSObject \*_Nullable\)methodTemplate:\(NSString \*_Nullable\)parameterTemplate;',
  );

  @override
  final Protocol parent;
}

class ProtocolMethodFollowingParameter extends FollowingParameter
    with PrefixTemplate {
  ProtocolMethodFollowingParameter(TemplateRegExp parent) : super(parent);

  @override
  RegExp exp = TemplateRegExp.regExp(r';');

  @override
  String stringMatch() {
    return 'parameterTemplate:(NSString *_Nullable)parameterTemplate';
  }
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

class CreationArgsClass with TemplateRegExp, PrefixTemplate {
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

class CreationArgsClassField with TemplateRegExp, PrefixTemplate {
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

class Channel with TemplateRegExp, PrefixTemplate {
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

class ChannelStaticMethod with TemplateRegExp, PrefixTemplate {
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

  LeadingParameter get aParameter => LeadingParameter(this);

  ChannelStaticMethodFollowingParameter get aFollowingParameter =>
      ChannelStaticMethodFollowingParameter(this);
}

class ChannelStaticMethodFollowingParameter extends FollowingParameter {
  ChannelStaticMethodFollowingParameter(TemplateRegExp parent) : super(parent);

  @override
  RegExp exp = TemplateRegExp.regExp(
    r'(?<=parameterTemplate\s)\s+(?=\scompletion:)',
  );

  @override
  String stringMatch() {
    return 'parameterTemplate:(NSString *_Nullable)parameterTemplate';
  }
}

class ChannelMethod with TemplateRegExp, PrefixTemplate {
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

class Handler with TemplateRegExp, PrefixTemplate {
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

class HandlerOnCreateMethod with TemplateRegExp, PrefixTemplate {
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

class HandlerStaticMethod with TemplateRegExp, PrefixTemplate {
  HandlerStaticMethod(this.parent);

  @override
  final Handler parent;

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'- \(NSObject \*_Nullable\)on_staticMethodTemplate:[^;]+;',
  );

  FollowingParameter get aFollowingParameter => FollowingParameter(this);
}

// class Library with TemplateRegExp, PrefixTemplate {
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
// class Class with TemplateRegExp, PrefixTemplate {
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
// class ClassField with TemplateRegExp, PrefixTemplate {
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
// class ClassMethod with TemplateRegExp, PrefixTemplate {
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
// class Parameter with TemplateRegExp, PrefixTemplate {
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
// class CreationArgsClass with TemplateRegExp, PrefixTemplate {
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
// class CreationArgsClassField with TemplateRegExp, PrefixTemplate {
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
// class ClassProtectedStaticMethod with TemplateRegExp, PrefixTemplate {
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
// class ClassProtectedMethod with TemplateRegExp, PrefixTemplate {
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
// class LocalHandler with TemplateRegExp, PrefixTemplate {
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
//     r'- \(id _Nullable\)classTemplate_staticMethodTemplate[^;]+;',
//   );
//
//   @override
//   final LocalHandler parent;
// }
//
// class LocalHandlerCreatorAbstractMethod with TemplateRegExp, PrefixTemplate {
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
