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
      .replaceAll(library.managerPrefix, prefix)
      .replaceAll(library.remoteHandlerPrefix, prefix)
      .replaceAll(
        library.aClass.exp,
        libraryNode.classes
            .map<String>(
              (ClassNode classNode) => library.aClass
                  .stringMatch()
                  .replaceAll(library.aClass.name, classNode.name)
                  .replaceAll(library.aClass.prefix, prefix)
                  .replaceAll(
                    library.aClass.aField.exp,
                    classNode.fields
                        .map<String>(
                          (FieldNode fieldNode) => library.aClass.aField
                              .stringMatch()
                              .replaceAll(
                                library.aClass.aField.name,
                                fieldNode.name,
                              )
                              .replaceAll(
                                library.aClass.aField.type,
                                getTrueTypeName(fieldNode.type, prefix),
                              ),
                        )
                        .join('\n'),
                  )
                  .replaceAll(
                    library.aClass.aMethod.exp,
                    classNode.methods
                        .map<String>(
                          (MethodNode methodNode) => library.aClass.aMethod
                              .stringMatch()
                              .replaceAll(
                                library.aClass.aMethod.name,
                                methodNode.name,
                              )
                              .replaceAll(
                                library.aClass.aMethod.aParameter.exp,
                                library.aClass.aMethod.aParameter
                                    .replaceWithFirst(
                                  methodNode.parameters,
                                ),
                              ),
                        )
                        .join('\n'),
                  )
                  .replaceAll(
                    library.aClass.aProtectedStaticMethod.exp,
                    classNode.staticMethods
                        .map<String>(
                          (MethodNode methodNode) =>
                              library.aClass.aProtectedStaticMethod
                                  .stringMatch()
                                  .replaceAll(
                                    library.aClass.aProtectedStaticMethod
                                        .managerPrefix,
                                    prefix,
                                  )
                                  .replaceAll(
                                    library.aClass.aProtectedStaticMethod.name,
                                    methodNode.name,
                                  )
                                  .replaceAll(
                                    library.aClass.aProtectedStaticMethod
                                        .aParameter.exp,
                                    library.aClass.aProtectedStaticMethod
                                        .aParameter
                                        .replace(
                                      methodNode.parameters,
                                    ),
                                  ),
                        )
                        .join('\n'),
                  )
                  .replaceAll(
                    library.aClass.aProtectedMethod.exp,
                    classNode.methods
                        .map<String>(
                          (MethodNode methodNode) => library
                              .aClass.aProtectedMethod
                              .stringMatch()
                              .replaceAll(
                                library.aClass.aProtectedMethod.managerPrefix,
                                prefix,
                              )
                              .replaceAll(
                                library.aClass.aProtectedMethod.name,
                                methodNode.name,
                              )
                              .replaceAll(
                                library.aClass.aProtectedMethod.aParameter.exp,
                                library.aClass.aProtectedMethod.aParameter
                                    .replace(
                                  methodNode.parameters,
                                ),
                              ),
                        )
                        .join('\n'),
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
                  .replaceAll(library.aCreationArgsClass.classPrefix, prefix)
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
                                    getTrueTypeName(fieldNode.type, prefix),
                                  ),
                        )
                        .join('\n'),
                  ),
            )
            .join('\n\n'),
      )
      .replaceAll(
        library.aLocalHandler.exp,
        library.aLocalHandler.exp
            .stringMatch(template)
            .replaceAll(library.aLocalHandler.prefix, prefix)
            .replaceAll(
              library.aLocalHandler.aStaticMethodAbstractMethod.exp,
              libraryNode.classes
                  .fold<Map<MethodNode, ClassNode>>(
                    <MethodNode, ClassNode>{},
                    (Map<MethodNode, ClassNode> map, ClassNode classNode) {
                      classNode.staticMethods.forEach(
                        (MethodNode methodNode) => map[methodNode] = classNode,
                      );
                      return map;
                    },
                  )
                  .entries
                  .map<String>(
                    (MapEntry<MethodNode, ClassNode> entry) =>
                        library.aLocalHandler.aStaticMethodAbstractMethod
                            .stringMatch()
                            .replaceAll(
                              library.aLocalHandler.aStaticMethodAbstractMethod
                                  .className,
                              ReCase(entry.value.name).camelCase,
                            )
                            .replaceAll(
                              library.aLocalHandler.aStaticMethodAbstractMethod
                                  .name,
                              entry.key.name,
                            )
                            .replaceAll(
                              library.aLocalHandler.aStaticMethodAbstractMethod
                                  .aParameter.exp,
                              library.aLocalHandler.aStaticMethodAbstractMethod
                                  .aParameter
                                  .replace(entry.key.parameters),
                            ),
                  )
                  .join('\n'),
            )
            .replaceAll(
              library.aLocalHandler.aCreatorAbstractMethod.exp,
              libraryNode.classes
                  .map<String>(
                    (ClassNode classNode) =>
                        library.aLocalHandler.aCreatorAbstractMethod
                            .stringMatch()
                            .replaceAll(
                              library.aLocalHandler.aCreatorAbstractMethod
                                  .className,
                              classNode.name,
                            )
                            .replaceAll(
                              library.aLocalHandler.aCreatorAbstractMethod
                                  .classPrefix,
                              prefix,
                            )
                            .replaceAll(
                              library.aLocalHandler.aCreatorAbstractMethod
                                  .creationArgsClassName,
                              classNode.name,
                            ),
                  )
                  .join('\n\n'),
            ),
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
    case 'double':
      return 'NSNumber';
    case 'String':
      return 'NSString';
    case 'Object':
      return 'NSObject';
    case 'List':
      return 'NSArray';
    case 'Map':
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
  final String template;

  @override
  final String templatePrefix;

  final RegExp managerPrefix = TemplateRegExp.regExp(
    r'(?<=@interface )_p_(?=ReferencePairManager)',
  );

  final RegExp remoteHandlerPrefix = TemplateRegExp.regExp(
    r'(?<=@interface )_p_(?=RemoteHandler)',
  );

  Class get aClass => Class(this);

  CreationArgsClass get aCreationArgsClass => CreationArgsClass(this);

  LocalHandler get aLocalHandler => LocalHandler(this);

  @override
  final TemplateRegExp parent = null;

  @override
  final RegExp exp = null;
}

class Class with TemplateRegExp, PrefixTemplate {
  Class(this.parent);

  final RegExp name = TemplateRegExp.regExp(
    r'(?<=@interface _p_)ClassTemplate(?= :)',
  );

  final RegExp prefix = TemplateRegExp.regExp(r'(?<=@interface )_p_');

  ClassMethod get aMethod => ClassMethod(this);
  ClassField get aField => ClassField(this);

  ClassProtectedStaticMethod get aProtectedStaticMethod =>
      ClassProtectedStaticMethod(this);

  ClassProtectedMethod get aProtectedMethod => ClassProtectedMethod(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'@interface _p_ClassTemplate[^@]*@end',
  );

  @override
  final Library parent;
}

class ClassField with TemplateRegExp, PrefixTemplate {
  ClassField(this.parent);

  final RegExp type = TemplateRegExp.regExp(r'NSNumber');
  final RegExp name = TemplateRegExp.regExp(r'fieldTemplate');

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'- \(NSNumber \*_Nullable\)fieldTemplate;',
  );

  @override
  final Class parent;
}

class ClassMethod with TemplateRegExp, PrefixTemplate {
  ClassMethod(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'methodTemplate');

  Parameter get aParameter => Parameter(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'- \(NSObject \*_Nullable\)methodTemplate:\(NSString \*_Nullable\)parameterTemplate;',
  );

  @override
  final Class parent;
}

class Parameter with TemplateRegExp, PrefixTemplate {
  Parameter(this.parent);

  static const String firstParameter =
      r':(NSString *_Nullable)parameterTemplate';
  static const String followingParameter =
      r'parameterTemplate:(NSString *_Nullable)parameterTemplate';

  final RegExp type = TemplateRegExp.regExp(r'NSString(?= \*)');

  final RegExp name = TemplateRegExp.regExp(r'parameterTemplate(?=:|\s|$)');

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'(parameterTemplate)*:*\(NSString \*_Nullable\)parameterTemplate',
  );

  @override
  final PrefixTemplate parent;

  String replaceWithFirst(Iterable<ParameterNode> parameterNodes) {
    if (parameterNodes.isEmpty) return '';

    final String first = Parameter.firstParameter
        .replaceAll(
          name,
          parameterNodes.first.name,
        )
        .replaceAll(
            type, getTrueTypeName(parameterNodes.first.type, templatePrefix));

    return '$first ${replace(parameterNodes.skip(1))}';
  }

  String replace(Iterable<ParameterNode> parameterNodes) {
    if (parameterNodes.isEmpty) return '';

    final String parameters = parameterNodes
        .map<String>((ParameterNode parameterNode) => Parameter
            .followingParameter
            .replaceAll(
              name,
              parameterNode.name,
            )
            .replaceAll(
                type, getTrueTypeName(parameterNode.type, templatePrefix)))
        .join(' ');

    return parameters;
  }
}

class CreationArgsClass with TemplateRegExp, PrefixTemplate {
  CreationArgsClass(this.parent);

  final RegExp className =
      TemplateRegExp.regExp(r'(?<=@interface _p_)ClassTemplate');

  final RegExp classPrefix = TemplateRegExp.regExp(r'(?<=@interface )_p_');

  CreationArgsClassField get aField => CreationArgsClassField(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'@interface _p_ClassTemplateCreationArgs(.*?@end){1}',
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

class ClassProtectedStaticMethod with TemplateRegExp, PrefixTemplate {
  ClassProtectedStaticMethod(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'staticMethodTemplate(?=:)');

  final RegExp managerPrefix = TemplateRegExp.regExp(
    r'_p_(?=ReferencePairManager \*)',
  );

  Parameter get aParameter => Parameter(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'\+ \(void\)_staticMethodTemplate[^;]+;',
  );

  @override
  final Class parent;
}

class ClassProtectedMethod with TemplateRegExp, PrefixTemplate {
  ClassProtectedMethod(this.parent);

  final RegExp name = TemplateRegExp.regExp(
    r'methodTemplate(?=:)',
  );

  final RegExp managerPrefix = TemplateRegExp.regExp(
    r'_p_(?=ReferencePairManager \*)',
  );

  Parameter get aParameter => Parameter(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'- \(void\)_methodTemplate[^;]+;',
  );

  @override
  final Class parent;
}

class LocalHandler with TemplateRegExp, PrefixTemplate {
  LocalHandler(this.parent);

  final RegExp prefix = TemplateRegExp.regExp(r'(?<=@interface )_p_');

  LocalHandlerStaticMethodAbstractMethod get aStaticMethodAbstractMethod =>
      LocalHandlerStaticMethodAbstractMethod(this);

  LocalHandlerCreatorAbstractMethod get aCreatorAbstractMethod =>
      LocalHandlerCreatorAbstractMethod(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'@interface _p_LocalHandler[^@]+@end',
  );

  @override
  final Library parent;
}

class LocalHandlerStaticMethodAbstractMethod
    with TemplateRegExp, PrefixTemplate {
  LocalHandlerStaticMethodAbstractMethod(this.parent);

  final RegExp className = TemplateRegExp.regExp(r'classTemplate(?=_)');
  final RegExp name = TemplateRegExp.regExp(r'(?<=_)staticMethodTemplate');

  Parameter get aParameter => Parameter(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'- \(id _Nullable\)classTemplate_staticMethodTemplate[^;]+;',
  );

  @override
  final LocalHandler parent;
}

class LocalHandlerCreatorAbstractMethod with TemplateRegExp, PrefixTemplate {
  LocalHandlerCreatorAbstractMethod(this.parent);

  final RegExp classPrefix = TemplateRegExp.regExp(r'(?<=- \(|args:\()_p_');

  final RegExp className = TemplateRegExp.regExp(r'(?<=\)create)ClassTemplate');

  final RegExp creationArgsClassName = TemplateRegExp.regExp(
    r'ClassTemplate(?=CreationArgs )',
  );

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'- \(_p_ClassTemplate \*\)createClassTemplate[^;]+;',
  );

  @override
  final LocalHandler parent;
}
