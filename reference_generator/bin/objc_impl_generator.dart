import 'package:recase/recase.dart';
import 'package:reference_generator/src/ast.dart';

import 'common.dart';
import 'objc_header_generator.dart'
    show getTrueTypeName, Parameter, PrefixTemplate;

String generateObjcImpl({
  String template,
  LibraryNode libraryNode,
  String prefix,
}) {
  final Library library = Library(template: template, templatePrefix: prefix);
  return template
      .replaceAll(library.handlerPrefix, prefix)
      .replaceAll(
        library.aClass.exp,
        libraryNode.classes
            .map<String>(
              (ClassNode classNode) => library.aClass
                  .stringMatch()
                  .replaceAll(library.aClass.name, classNode.name)
                  .replaceAll(library.aClass.referenceClass, classNode.name)
                  .replaceAll(library.aClass.prefix, prefix)
                  .replaceAll(library.aClass.referenceClassPrefix, prefix)
                  .replaceAll(
                    library.aClass.aField.exp,
                    classNode.fields
                        .map<String>(
                          (FieldNode fieldNode) => library.aClass.aField
                              .stringMatch()
                              .replaceAll(
                                  library.aClass.aField.name, fieldNode.name)
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
                                    .replaceWithFirst(methodNode.parameters),
                              ),
                        )
                        .join('\n\n'),
                  )
                  .replaceAll(
                    library.aClass.aProtectedStaticMethod.exp,
                    classNode.staticMethods
                        .map<String>(
                          (MethodNode methodNode) => library
                              .aClass.aProtectedStaticMethod
                              .stringMatch()
                              .replaceAll(
                                library.aClass.aProtectedStaticMethod.className,
                                classNode.name,
                              )
                              .replaceAll(
                                library.aClass.aProtectedStaticMethod.name,
                                methodNode.name,
                              )
                              .replaceAll(
                                library.aClass.aProtectedStaticMethod
                                    .managerPrefix,
                                prefix,
                              )
                              .replaceAll(
                                library
                                    .aClass.aProtectedStaticMethod.classPrefix,
                                prefix,
                              )
                              .replaceAll(
                                library.aClass.aMethod.aParameter.exp,
                                library.aClass.aMethod.aParameter
                                    .replace(methodNode.parameters),
                              )
                              .replaceAll(
                                library.aClass.aProtectedStaticMethod
                                    .aParameterName.exp,
                                methodNode.parameters
                                    .map<String>(
                                      (ParameterNode parameterNode) => library
                                          .aClass
                                          .aProtectedStaticMethod
                                          .aParameterName
                                          .stringMatch()
                                          .replaceAll(
                                            library
                                                .aClass
                                                .aProtectedStaticMethod
                                                .aParameterName
                                                .name,
                                            parameterNode.name,
                                          ),
                                    )
                                    .join(', '),
                              ),
                        )
                        .join('\n\n'),
                  )
                  .replaceAll(
                    library.aClass.aProtectedMethod.exp,
                    classNode.methods
                        .map<String>(
                          (MethodNode methodNode) => library
                              .aClass.aProtectedMethod
                              .stringMatch()
                              .replaceAll(
                                library.aClass.aProtectedMethod.name,
                                methodNode.name,
                              )
                              .replaceAll(
                                library.aClass.aProtectedMethod.managerPrefix,
                                prefix,
                              )
                              .replaceAll(
                                library.aClass.aMethod.aParameter.exp,
                                library.aClass.aMethod.aParameter
                                    .replace(methodNode.parameters),
                              )
                              .replaceAll(
                                library.aClass.aProtectedMethod
                                    .anUnpairedReference.exp,
                                library
                                    .aClass.aProtectedMethod.anUnpairedReference
                                    .stringMatch()
                                    .replaceAll(
                                        library.aClass.aProtectedMethod
                                            .anUnpairedReference.name,
                                        methodNode.name)
                                    .replaceAll(
                                      library
                                          .aClass
                                          .aProtectedMethod
                                          .anUnpairedReference
                                          .aParameterName
                                          .exp,
                                      methodNode.parameters
                                          .map<String>(
                                            (ParameterNode parameterNode) =>
                                                library
                                                    .aClass
                                                    .aProtectedMethod
                                                    .anUnpairedReference
                                                    .aParameterName
                                                    .stringMatch()
                                                    .replaceAll(
                                                      library
                                                          .aClass
                                                          .aProtectedMethod
                                                          .anUnpairedReference
                                                          .aParameterName
                                                          .name,
                                                      parameterNode.name,
                                                    ),
                                          )
                                          .join(', '),
                                    ),
                              )
                              .replaceAll(
                                library.aClass.aProtectedMethod.aPairedReference
                                    .exp,
                                library.aClass.aProtectedMethod.aPairedReference
                                    .stringMatch()
                                    .replaceAll(
                                      library.aClass.aProtectedMethod
                                          .aPairedReference.name,
                                      methodNode.name,
                                    )
                                    .replaceAll(
                                      library.aClass.aProtectedMethod
                                          .aPairedReference.aParameterName.exp,
                                      methodNode.parameters
                                          .map<String>(
                                            (ParameterNode parameterNode) =>
                                                library
                                                    .aClass
                                                    .aProtectedMethod
                                                    .aPairedReference
                                                    .aParameterName
                                                    .stringMatch()
                                                    .replaceAll(
                                                      library
                                                          .aClass
                                                          .aProtectedMethod
                                                          .aPairedReference
                                                          .aParameterName
                                                          .name,
                                                      parameterNode.name,
                                                    ),
                                          )
                                          .join(', '),
                                    ),
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
            .map<String>((ClassNode classNode) => library.aCreationArgsClass
                .stringMatch()
                .replaceAll(library.aCreationArgsClass.classPrefix, prefix)
                .replaceAll(
                  library.aCreationArgsClass.className,
                  classNode.name,
                ))
            .join('\n\n'),
      )
      .replaceAll(
        library.aManager.exp,
        library.aManager
            .stringMatch()
            .replaceAll(library.aManager.prefix, prefix)
            .replaceAll(library.aManager.remoteHandlerPrefix, prefix)
            .replaceAll(
              library.aManager.aClass.exp,
              libraryNode.classes
                  .map<String>(
                    (ClassNode classNode) => library.aManager.aClass
                        .stringMatch()
                        .replaceAll(
                          library.aManager.aClass.prefix,
                          prefix,
                        )
                        .replaceAll(
                          library.aManager.aClass.name,
                          classNode.name,
                        ),
                  )
                  .join(', '),
            ),
      )
      .replaceAll(
        library.aLocalHandler.exp,
        library.aLocalHandler.exp
            .stringMatch(template)
            .replaceAll(library.aLocalHandler.prefix, prefix)
            .replaceAll(
              library.aLocalHandler.aCreator.exp,
              libraryNode.classes
                  .map<String>(
                    (ClassNode classNode) => library.aLocalHandler.aCreator
                        .stringMatch()
                        .replaceAll(
                          library.aLocalHandler.aCreator.className,
                          classNode.name,
                        )
                        .replaceAll(
                            library.aLocalHandler.aCreator.classPrefix, prefix)
                        .replaceAll(
                            library.aLocalHandler.aCreator.localHandlerPrefix,
                            prefix)
                        .replaceAll(
                          library.aLocalHandler.aCreator.argument.exp,
                          List<int>.generate(
                                  classNode.fields.length, (int index) => index)
                              .map<String>(
                                (int index) =>
                                    library.aLocalHandler.aCreator.argument
                                        .stringMatch()
                                        .replaceAll(
                                          library.aLocalHandler.aCreator
                                              .argument.fieldName,
                                          classNode.fields[index].name,
                                        )
                                        .replaceAll(
                                          library.aLocalHandler.aCreator
                                              .argument.argumentIndex,
                                          '$index',
                                        ),
                              )
                              .join('\n'),
                        ),
                  )
                  .join(',\n'),
            )
            .replaceAll(
              library.aLocalHandler.aStaticMethod.exp,
              libraryNode.classes
                  .map<String>(
                    (ClassNode classNode) => library.aLocalHandler.aStaticMethod
                        .stringMatch()
                        .replaceAll(
                          library.aLocalHandler.aStaticMethod.classPrefix,
                          prefix,
                        )
                        .replaceAll(
                          library.aLocalHandler.aStaticMethod.className,
                          classNode.name,
                        )
                        .replaceAll(
                          library.aLocalHandler.aStaticMethod.aMethod.exp,
                          classNode.staticMethods
                              .map<String>(
                                (MethodNode methodNode) =>
                                    library.aLocalHandler.aStaticMethod.aMethod
                                        .stringMatch()
                                        .replaceAll(
                                          library.aLocalHandler.aStaticMethod
                                              .aMethod.localHandlerPrefix,
                                          prefix,
                                        )
                                        .replaceAll(
                                          library.aLocalHandler.aStaticMethod
                                              .aMethod.classNamePart,
                                          ReCase(classNode.name).camelCase,
                                        )
                                        .replaceAll(
                                          library.aLocalHandler.aStaticMethod
                                              .aMethod.methodName,
                                          methodNode.name,
                                        )
                                        .replaceAll(
                                          library.aLocalHandler.aStaticMethod
                                              .aMethod.anArgument.exp,
                                          library.aLocalHandler.aStaticMethod
                                              .aMethod.anArgument
                                              .replace(methodNode.parameters),
                                        ),
                              )
                              .join(',\n'),
                        ),
                  )
                  .join(',\n'),
            )
            .replaceAll(
              library.aLocalHandler.aMethod.exp,
              libraryNode.classes
                  .map<String>(
                    (ClassNode classNode) => library.aLocalHandler.aMethod
                        .stringMatch()
                        .replaceAll(
                          library.aLocalHandler.aMethod.className,
                          classNode.name,
                        )
                        .replaceAll(
                          library.aLocalHandler.aMethod.classPrefix,
                          prefix,
                        )
                        .replaceAll(
                          library.aLocalHandler.aMethod.aMethod.exp,
                          classNode.methods
                              .map<String>(
                                (MethodNode methodNode) =>
                                    library.aLocalHandler.aMethod.aMethod
                                        .stringMatch()
                                        .replaceAll(
                                          library.aLocalHandler.aMethod.aMethod
                                              .className,
                                          classNode.name,
                                        )
                                        .replaceAll(
                                          library.aLocalHandler.aMethod.aMethod
                                              .classPrefix,
                                          prefix,
                                        )
                                        .replaceAll(
                                          library.aLocalHandler.aMethod.aMethod
                                              .methodName,
                                          methodNode.name,
                                        )
                                        .replaceAll(
                                          library.aLocalHandler.aMethod.aMethod
                                              .anArgument.exp,
                                          library.aLocalHandler.aMethod.aMethod
                                              .anArgument
                                              .replaceWithFirst(
                                            methodNode.parameters,
                                          ),
                                        ),
                              )
                              .join('\n'),
                        ),
                  )
                  .join('\n'),
            )
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
                  .join('\n\n'),
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
                                  .classPrefix,
                              prefix,
                            )
                            .replaceAll(
                              library.aLocalHandler.aCreatorAbstractMethod
                                  .className,
                              classNode.name,
                            ),
                  )
                  .join('\n\n'),
            )
            .replaceAll(
              library.aLocalHandler.anInvokeMethodCondition.exp,
              libraryNode.classes
                  .map<String>(
                    (ClassNode classNode) =>
                        library.aLocalHandler.anInvokeMethodCondition
                            .stringMatch()
                            .replaceAll(
                              library.aLocalHandler.anInvokeMethodCondition
                                  .className,
                              classNode.name,
                            )
                            .replaceAll(
                              library.aLocalHandler.anInvokeMethodCondition
                                  .classPrefix,
                              prefix,
                            )
                            .replaceAll(
                              library.aLocalHandler.anInvokeMethodCondition
                                  .aMethod.exp,
                              classNode.methods
                                  .map<String>(
                                    (MethodNode methodNode) => library
                                        .aLocalHandler
                                        .anInvokeMethodCondition
                                        .aMethod
                                        .stringMatch()
                                        .replaceAll(
                                          library
                                              .aLocalHandler
                                              .anInvokeMethodCondition
                                              .aMethod
                                              .name,
                                          methodNode.name,
                                        )
                                        .replaceAll(
                                          library
                                              .aLocalHandler
                                              .anInvokeMethodCondition
                                              .aMethod
                                              .className,
                                          classNode.name,
                                        )
                                        .replaceAll(
                                          library
                                              .aLocalHandler
                                              .anInvokeMethodCondition
                                              .aMethod
                                              .classPrefix,
                                          prefix,
                                        )
                                        .replaceAll(
                                          library
                                              .aLocalHandler
                                              .anInvokeMethodCondition
                                              .aMethod
                                              .anArgument
                                              .exp,
                                          library
                                              .aLocalHandler
                                              .anInvokeMethodCondition
                                              .aMethod
                                              .anArgument
                                              .replaceWithFirst(
                                            methodNode.parameters,
                                          ),
                                        ),
                                  )
                                  .join('else'),
                            ),
                  )
                  .join(' else '),
            ),
      )
      .replaceAll(
        library.aCreationArgument.exp,
        libraryNode.classes
            .map<String>(
              (ClassNode classNode) => library.aCreationArgument
                  .stringMatch()
                  .replaceAll(
                    library.aCreationArgument.className,
                    classNode.name,
                  )
                  .replaceAll(library.aCreationArgument.classPrefix, prefix)
                  .replaceAll(
                    library.aCreationArgument.aField.exp,
                    classNode.fields
                        .map<String>(
                          (FieldNode fieldNode) => library
                              .aCreationArgument.aField
                              .stringMatch()
                              .replaceAll(
                                library.aCreationArgument.aField.name,
                                fieldNode.name,
                              ),
                        )
                        .join(','),
                  ),
            )
            .join(',\n'),
      );
}

class Library with TemplateRegExp, PrefixTemplate {
  Library({this.template, this.templatePrefix});

  @override
  final String template;

  @override
  final String templatePrefix;

  final RegExp handlerPrefix = TemplateRegExp.regExp(
    r'(?<=_LocalStaticMethodHandler\)\(|_LocalCreatorHandler\)\()_p_',
  );

  Class get aClass => Class(this);

  CreationArgsClass get aCreationArgsClass => CreationArgsClass(this);

  Manager get aManager => Manager(this);

  LocalHandler get aLocalHandler => LocalHandler(this);

  CreationArgument get aCreationArgument => CreationArgument(this);

  @override
  final TemplateRegExp parent = null;

  @override
  final RegExp exp = null;
}

class Class with TemplateRegExp, PrefixTemplate {
  Class(this.parent);

  final RegExp name = TemplateRegExp.regExp(
    r'(?<=@implementation \w*)ClassTemplate',
  );

  final RegExp prefix = TemplateRegExp.regExp(
    r'(?<=@implementation )_p_',
  );

  final RegExp referenceClass = TemplateRegExp.regExp(
    r'(?<=\[REFClass fromClass:\[\w*)ClassTemplate',
  );

  final RegExp referenceClassPrefix = TemplateRegExp.regExp(
    r'(?<=\[REFClass fromClass:\[)_p_',
  );

  ClassField get aField => ClassField(this);
  ClassMethod get aMethod => ClassMethod(this);

  ClassProtectedStaticMethod get aProtectedStaticMethod =>
      ClassProtectedStaticMethod(this);

  ClassProtectedMethod get aProtectedMethod => ClassProtectedMethod(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'@implementation _p_ClassTemplate([^\}]+\}){6}\s*@end',
  );

  @override
  final Library parent;
}

class ClassField with TemplateRegExp {
  ClassField(this.parent);

  final RegExp type = TemplateRegExp.regExp(r'NSNumber(?= \*)');
  final RegExp name = TemplateRegExp.regExp(r'fieldTemplate(?= \{)');

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'- \(NSNumber \*\)fieldTemplate[^\}]+\}',
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
    r'- \(NSString \*_Nullable\)methodTemplate:[^\}]+\}',
  );

  @override
  final Class parent;
}

class CreationArgsClass with TemplateRegExp {
  CreationArgsClass(this.parent);

  final RegExp className = TemplateRegExp.regExp(
    r'ClassTemplate(?=CreationArgs)',
  );

  final RegExp classPrefix = TemplateRegExp.regExp(
    r'_p_(?=ClassTemplate)',
  );

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'@implementation _p_ClassTemplateCreationArgs[^@]@end',
  );

  @override
  final Library parent;
}

class ClassProtectedStaticMethod with TemplateRegExp, PrefixTemplate {
  ClassProtectedStaticMethod(this.parent);

  final RegExp className = TemplateRegExp.regExp(
    r'ClassTemplate(?= class)',
  );

  final RegExp classPrefix = TemplateRegExp.regExp(
    r'(?<=invokeRemoteStaticMethod:\[)_p_',
  );

  final RegExp name = TemplateRegExp.regExp(
    r'(?<="|_)staticMethodTemplate(?="|:)',
  );

  final RegExp managerPrefix = TemplateRegExp.regExp(
    r'_p_(?=ReferencePairManager \*)',
  );

  Parameter get aParameter => Parameter(this);

  ParameterName get aParameterName => ParameterName(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'\+ \(void\)_staticMethodTemplate:[^\}]+\}',
  );

  @override
  final Class parent;
}

class ClassProtectedMethod with TemplateRegExp, PrefixTemplate {
  ClassProtectedMethod(this.parent);

  final RegExp name = TemplateRegExp.regExp(
    r'(?<=_)methodTemplate(?=:)',
  );

  final RegExp managerPrefix = TemplateRegExp.regExp(
    r'_p_(?=ReferencePairManager \*)',
  );

  Parameter get aParameter => Parameter(this);

  ClassProtectedMethodUnpairedReference get anUnpairedReference =>
      ClassProtectedMethodUnpairedReference(this);

  ClassProtectedMethodPairedReference get aPairedReference =>
      ClassProtectedMethodPairedReference(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'\- \(void\)_methodTemplate:[^\}]+\}[^\}]+\}',
  );

  @override
  final Class parent;
}

class ParameterName with TemplateRegExp {
  ParameterName(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'parameterTemplate');

  @override
  final RegExp exp = TemplateRegExp.regExp(r'(?<=@\[ )parameterTemplate');

  @override
  final TemplateRegExp parent;
}

class ClassProtectedMethodUnpairedReference with TemplateRegExp {
  ClassProtectedMethodUnpairedReference(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'methodTemplate(?=")');

  ParameterName get aParameterName => ParameterName(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'invokeRemoteMethodOnUnpairedReference[^\}]+\}',
  );

  @override
  final ClassProtectedMethod parent;
}

class ClassProtectedMethodPairedReference with TemplateRegExp {
  ClassProtectedMethodPairedReference(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'methodTemplate(?=")');

  ParameterName get aParameterName => ParameterName(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'invokeRemoteMethod[^\}]+\}',
  );

  @override
  final ClassProtectedMethod parent;
}

class Manager with TemplateRegExp {
  Manager(this.parent);

  final RegExp prefix = TemplateRegExp.regExp(r'(?<=@implementation )_p_');

  final RegExp remoteHandlerPrefix =
      TemplateRegExp.regExp(r'_p_(?=RemoteHandler alloc)');

  ManagerClass get aClass => ManagerClass(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'@implementation _p_ReferencePairManager[^\}]+\}[^\}]+\}',
  );

  @override
  final Library parent;
}

class ManagerClass with TemplateRegExp {
  ManagerClass(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'ClassTemplate');
  final RegExp prefix = TemplateRegExp.regExp(r'_p_');

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'\[REFClass fromClass:\[_p_ClassTemplate class\]\]',
  );

  @override
  final Manager parent;
}

class LocalHandler with TemplateRegExp, PrefixTemplate {
  LocalHandler(this.parent);

  final RegExp prefix = TemplateRegExp.regExp(r'(?<=@implementation )_p_');

  LocalHandlerCreator get aCreator => LocalHandlerCreator(this);

  LocalHandlerStaticMethod get aStaticMethod => LocalHandlerStaticMethod(this);

  LocalHandlerMethod get aMethod => LocalHandlerMethod(this);

  LocalHandlerStaticMethodAbstractMethod get aStaticMethodAbstractMethod =>
      LocalHandlerStaticMethodAbstractMethod(this);

  LocalHandlerCreatorAbstractMethod get aCreatorAbstractMethod =>
      LocalHandlerCreatorAbstractMethod(this);

  LocalHandlerInvokeMethodCondition get anInvokeMethodCondition =>
      LocalHandlerInvokeMethodCondition(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'@implementation _p_LocalHandler.+(?<!.*@end).*@end',
  );

  @override
  final Library parent;
}

class LocalHandlerCreator with TemplateRegExp {
  LocalHandlerCreator(this.parent);

  final RegExp className = TemplateRegExp.regExp(
    r'ClassTemplate(?=CreationArgs|\.class|:manager)',
  );

  final RegExp localHandlerPrefix =
      TemplateRegExp.regExp(r'_p_(?=LocalHandler \*)');
  final RegExp classPrefix = TemplateRegExp.regExp(r'(?<=:|\s|\[)_p_');

  LocalHandlerCreatorCreationArgs get argument =>
      LocalHandlerCreatorCreationArgs(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(r'(?<=creators = @\{)\[[^\}]+\}');

  @override
  final LocalHandler parent;
}

class LocalHandlerCreatorCreationArgs with TemplateRegExp {
  LocalHandlerCreatorCreationArgs(this.parent);

  final RegExp fieldName = TemplateRegExp.regExp(r'fieldTemplate');
  final RegExp argumentIndex = TemplateRegExp.regExp(r'(?<=\[)\d');

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'args\.fieldTemplate = arguments\[0\];',
  );

  @override
  final LocalHandlerCreator parent;
}

class LocalHandlerStaticMethod with TemplateRegExp {
  LocalHandlerStaticMethod(this.parent);

  final RegExp classPrefix = TemplateRegExp.regExp(r'(?<=:)_p_');

  final RegExp className = TemplateRegExp.regExp(r'ClassTemplate(?=\.class)');

  LocalHandlerStaticMethodMethod get aMethod =>
      LocalHandlerStaticMethodMethod(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'(?<=staticMethods =\s*@{)\[[^\}]+\}[^\}]+\}',
  );

  @override
  final LocalHandler parent;
}

class LocalHandlerStaticMethodMethod with TemplateRegExp {
  LocalHandlerStaticMethodMethod(this.parent);

  final RegExp localHandlerPrefix =
      TemplateRegExp.regExp(r'_p_(?=LocalHandler \*)');

  final RegExp methodName = TemplateRegExp.regExp(
    r'(?<=_|")staticMethodTemplate',
  );

  final RegExp classNamePart = TemplateRegExp.regExp(r'classTemplate(?=_)');

  Argument get anArgument => Argument(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'@"staticMethodTemplate"[^\}]+\}',
  );

  @override
  final LocalHandlerStaticMethod parent;
}

class LocalHandlerMethod with TemplateRegExp {
  LocalHandlerMethod(this.parent);

  final RegExp classPrefix = TemplateRegExp.regExp(r'(?<=:)_p_');

  final RegExp className = TemplateRegExp.regExp(r'ClassTemplate(?=\.class)');

  LocalHandlerMethodMethod get aMethod => LocalHandlerMethodMethod(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'(?<=methods =\s*@{)\[[^\}]+\}[^\}]+\}',
  );

  @override
  final LocalHandler parent;
}

class LocalHandlerMethodMethod with TemplateRegExp {
  LocalHandlerMethodMethod(this.parent);

  final RegExp methodName = TemplateRegExp.regExp(r'methodTemplate(?=:)');
  final RegExp className = TemplateRegExp.regExp(r'ClassTemplate(?= *value)');
  final RegExp classPrefix = TemplateRegExp.regExp(r'(?<=\s)_p_');

  Argument get anArgument => Argument(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'@"methodTemplate"[^\}]+\}',
  );

  @override
  final LocalHandlerMethod parent;
}

// TODO: handle zero param method
class Argument with TemplateRegExp {
  Argument(this.parent);

  static const String firstParameter = r'arguments[0]';
  static const String followingParameter = r'parameterTemplate:arguments[0]';

  final RegExp name = TemplateRegExp.regExp(r'parameterTemplate(?=:)');
  final RegExp index = TemplateRegExp.regExp(r'(?<=\[)\d');

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'(parameterTemplate:)*arguments[0]',
  );

  @override
  final TemplateRegExp parent;

  String replaceWithFirst(Iterable<ParameterNode> parameterNodes) {
    if (parameterNodes.isEmpty) return '';

    final String first = Parameter.firstParameter
        .replaceAll(name, parameterNodes.first.name)
        .replaceAll(index, '0');

    return '$first ${replace(parameterNodes.skip(1).toList())}';
  }

  String replace(List<ParameterNode> parameterNodes) {
    if (parameterNodes.isEmpty) return '';

    final String parameters =
        List<int>.generate(parameterNodes.length, (int index) => index)
            .map<String>((int parameterIndex) => Parameter.followingParameter
                .replaceAll(name, parameterNodes[parameterIndex].name)
                .replaceAll(index, '$parameterIndex'))
            .join(' ');

    return parameters;
  }
}

class LocalHandlerStaticMethodAbstractMethod
    with TemplateRegExp, PrefixTemplate {
  LocalHandlerStaticMethodAbstractMethod(this.parent);

  final RegExp className = TemplateRegExp.regExp(r'classTemplate(?=_)');
  final RegExp name = TemplateRegExp.regExp(r'(?<=_)staticMethodTemplate');

  Parameter get aParameter => Parameter(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'- \(id _Nullable\)classTemplate_staticMethodTemplate[^\}]+}',
  );

  @override
  final LocalHandler parent;
}

class LocalHandlerCreatorAbstractMethod with TemplateRegExp {
  LocalHandlerCreatorAbstractMethod(this.parent);

  final RegExp className = TemplateRegExp.regExp(
    r'ClassTemplate(?= \*|CreationArgs \*|:\(REF)',
  );

  final RegExp classPrefix = TemplateRegExp.regExp(r'(?<=\()_p_');

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'- \(_p_ClassTemplate \*\)createClassTemplate:[^\}]+}',
  );

  @override
  final LocalHandler parent;
}

class LocalHandlerInvokeMethodCondition with TemplateRegExp {
  LocalHandlerInvokeMethodCondition(this.parent);

  final RegExp className = TemplateRegExp.regExp(r'=ClassTemplate(?=\.class)');
  final RegExp classPrefix = TemplateRegExp.regExp(
    r'(?<=isKindOfClass:)_p_',
  );

  LocalHandlerInvokeMethodConditionMethod get aMethod =>
      LocalHandlerInvokeMethodConditionMethod(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'if \(\[localReference isKindOfClass:_p_ClassTemplate\.class[^\}]*}[^\}]*}',
  );

  @override
  final LocalHandler parent;
}

class LocalHandlerInvokeMethodConditionMethod with TemplateRegExp {
  LocalHandlerInvokeMethodConditionMethod(this.parent);

  final RegExp className = TemplateRegExp.regExp(r'ClassTemplate(?= *value)');

  final RegExp name = TemplateRegExp.regExp(r'methodTemplate(?="|:)');

  final RegExp classPrefix = TemplateRegExp.regExp(r'(?<=\s)_p_');

  Argument get anArgument => Argument(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'if \(\[@"methodTemplate" isEqualToString:methodName[^\}]*}',
  );

  @override
  final LocalHandlerInvokeMethodCondition parent;
}

class CreationArgument with TemplateRegExp {
  CreationArgument(this.parent);

  CreationArgumentField get aField => CreationArgumentField(this);

  final RegExp className = TemplateRegExp.regExp(
    r'ClassTemplate(?=\.class| \*value)',
  );

  final RegExp classPrefix = TemplateRegExp.regExp(
    r'(?<=:|\s)_p_',
  );

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'(?<=creationArguments =\s*@\{)\[[^\}]+\}',
  );

  @override
  final Library parent;
}

class CreationArgumentField with TemplateRegExp {
  CreationArgumentField(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'(?<=\.)fieldTemplate');

  @override
  final CreationArgument parent;

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'value\.fieldTemplate',
  );
}
