import 'package:recase/recase.dart';
import 'package:reference_generator/src/ast.dart';

String generateJava(String template, LibraryNode libraryNode) {
  final Library library = Library(template);
  return template
      .replaceAll(
        library.aClass.exp,
        libraryNode.classes
            .map<String>(
              (ClassNode classNode) => library.aClass
                  .stringMatch()
                  .replaceAll(library.aClass.name, classNode.name)
                  .replaceAll(library.aClass.referenceClass, classNode.name)
                  .replaceAll(
                    library.aClass.aField.exp,
                    classNode.fields
                        .map<String>(
                          (FieldNode fieldNode) => library.aClass.aField
                              .stringMatch()
                              .replaceAll(library.aClass.aField.name,
                                  ReCase(fieldNode.name).pascalCase)
                              .replaceAll(
                                library.aClass.aField.type,
                                getTrueTypeName(fieldNode.type),
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
                                methodNode.parameters
                                    .map<String>(
                                      (ParameterNode parameterNode) => library
                                          .aClass.aMethod.aParameter
                                          .stringMatch()
                                          .replaceAll(
                                            library
                                                .aClass.aMethod.aParameter.type,
                                            getTrueTypeName(parameterNode.type),
                                          )
                                          .replaceAll(
                                            library
                                                .aClass.aMethod.aParameter.name,
                                            parameterNode.name,
                                          ),
                                    )
                                    .join(', '),
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
                                library.aClass.aProtectedStaticMethod.aParameter
                                    .exp,
                                methodNode.parameters
                                    .map<String>(
                                      (ParameterNode parameterNode) => library
                                          .aClass
                                          .aProtectedStaticMethod
                                          .aParameter
                                          .stringMatch()
                                          .replaceAll(
                                            library
                                                .aClass
                                                .aProtectedStaticMethod
                                                .aParameter
                                                .name,
                                            parameterNode.name,
                                          )
                                          .replaceAll(
                                            library
                                                .aClass
                                                .aProtectedStaticMethod
                                                .aParameter
                                                .type,
                                            getTrueTypeName(parameterNode.type),
                                          ),
                                    )
                                    .join(', '),
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
                                library.aClass.aProtectedMethod.aParameter.exp,
                                methodNode.parameters
                                    .map<String>(
                                      (ParameterNode parameterNode) => library
                                          .aClass.aProtectedMethod.aParameter
                                          .stringMatch()
                                          .replaceAll(
                                            library.aClass.aProtectedMethod
                                                .aParameter.name,
                                            parameterNode.name,
                                          )
                                          .replaceAll(
                                            library.aClass.aProtectedMethod
                                                .aParameter.type,
                                            getTrueTypeName(parameterNode.type),
                                          ),
                                    )
                                    .join(', '),
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
        library.aManager.exp,
        library.aManager.stringMatch().replaceAll(
              library.aManager.aClass.exp,
              libraryNode.classes
                  .map<String>(
                    (ClassNode classNode) =>
                        library.aManager.aClass.stringMatch().replaceAll(
                              library.aManager.aClass.name,
                              classNode.name,
                            ),
                  )
                  .join(', '),
            ),
      )
      .replaceAll(
          library.aLocalHandler.exp,
          library.aLocalHandler.exp.stringMatch(template).replaceAll(
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
                            library.aLocalHandler.aCreator.argument.exp,
                            List<int>.generate(classNode.fields.length,
                                    (int index) => index)
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
                                                .argument.fieldType,
                                            getTrueTypeName(
                                                classNode.fields[index].type),
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
                    .join('\n'),
              )
          //       .replaceAll(
          //         library.aLocalHandler.aStaticMethod.exp,
          //         libraryNode.classes
          //             .map<String>(
          //               (ClassNode classNode) => library.aLocalHandler.aStaticMethod
          //                   .stringMatch()
          //                   .replaceAll(
          //                     library.aLocalHandler.aStaticMethod.className,
          //                     classNode.name,
          //                   )
          //                   .replaceAll(
          //                     library.aLocalHandler.aStaticMethod.aMethod.exp,
          //                     classNode.staticMethods
          //                         .map<String>(
          //                           (MethodNode methodNode) =>
          //                               library.aLocalHandler.aStaticMethod.aMethod
          //                                   .stringMatch()
          //                                   .replaceAll(
          //                                     library.aLocalHandler.aStaticMethod
          //                                         .aMethod.classNamePart,
          //                                     ReCase(classNode.name).camelCase,
          //                                   )
          //                                   .replaceAll(
          //                                     library.aLocalHandler.aStaticMethod
          //                                         .aMethod.methodName,
          //                                     methodNode.name,
          //                                   )
          //                                   .replaceAll(
          //                                     library.aLocalHandler.aStaticMethod
          //                                         .aMethod.argument,
          //                                     List<int>.generate(
          //                                       methodNode.parameters.length,
          //                                       (int index) => index,
          //                                     )
          //                                         .map<String>(
          //                                           (int index) =>
          //                                               'arguments[$index]',
          //                                         )
          //                                         .join(','),
          //                                   ),
          //                         )
          //                         .join(','),
          //                   ),
          //             )
          //             .join(','),
          //       )
          //       .replaceAll(
          //         library.aLocalHandler.aMethod.exp,
          //         libraryNode.classes
          //             .map<String>(
          //               (ClassNode classNode) => library.aLocalHandler.aMethod
          //                   .stringMatch()
          //                   .replaceAll(
          //                     library.aLocalHandler.aMethod.className,
          //                     classNode.name,
          //                   )
          //                   .replaceAll(
          //                     library.aLocalHandler.aMethod.aMethod.exp,
          //                     classNode.methods
          //                         .map<String>(
          //                           (MethodNode methodNode) =>
          //                               library.aLocalHandler.aMethod.aMethod
          //                                   .stringMatch()
          //                                   .replaceAll(
          //                                     library.aLocalHandler.aMethod.aMethod
          //                                         .className,
          //                                     classNode.name,
          //                                   )
          //                                   .replaceAll(
          //                                     library.aLocalHandler.aMethod.aMethod
          //                                         .methodName,
          //                                     methodNode.name,
          //                                   )
          //                                   .replaceAll(
          //                                     library.aLocalHandler.aMethod.aMethod
          //                                         .argument,
          //                                     List<int>.generate(
          //                                       methodNode.parameters.length,
          //                                       (int index) => index,
          //                                     )
          //                                         .map<String>(
          //                                           (int index) =>
          //                                               'arguments[$index]',
          //                                         )
          //                                         .join(','),
          //                                   ),
          //                         )
          //                         .join(','),
          //                   ),
          //             )
          //             .join(','),
          //       )
          //       .replaceAll(
          //         library.aLocalHandler.aStaticMethodField.exp,
          //         libraryNode.classes
          //             .fold<Map<MethodNode, ClassNode>>(
          //               <MethodNode, ClassNode>{},
          //               (Map<MethodNode, ClassNode> map, ClassNode classNode) {
          //                 classNode.staticMethods.forEach(
          //                   (MethodNode methodNode) => map[methodNode] = classNode,
          //                 );
          //                 return map;
          //               },
          //             )
          //             .entries
          //             .map<String>(
          //               (MapEntry<MethodNode, ClassNode> entry) => library
          //                   .aLocalHandler.aStaticMethodField
          //                   .stringMatch()
          //                   .replaceAll(
          //                     library.aLocalHandler.aStaticMethodField.className,
          //                     ReCase(entry.value.name).camelCase,
          //                   )
          //                   .replaceAll(
          //                     library.aLocalHandler.aStaticMethodField.name,
          //                     entry.key.name,
          //                   )
          //                   .replaceAll(
          //                     library
          //                         .aLocalHandler.aStaticMethodField.aParameter.exp,
          //                     entry.key.parameters
          //                         .map<String>(
          //                           (ParameterNode parameterNode) => library
          //                               .aLocalHandler.aStaticMethodField.aParameter
          //                               .stringMatch()
          //                               .replaceAll(
          //                                 library.aLocalHandler.aStaticMethodField
          //                                     .aParameter.name,
          //                                 parameterNode.name,
          //                               )
          //                               .replaceAll(
          //                                 library.aLocalHandler.aStaticMethodField
          //                                     .aParameter.type,
          //                                 getTrueTypeName(parameterNode.type),
          //                               ),
          //                         )
          //                         .join(', '),
          //                   ),
          //             )
          //             .join('\n\n'),
          //       )
          //       .replaceAll(
          //         library.aLocalHandler.aCreatorField.exp,
          //         libraryNode.classes
          //             .map<String>(
          //               (ClassNode classNode) => library.aLocalHandler.aCreatorField
          //                   .stringMatch()
          //                   .replaceAll(
          //                     library.aLocalHandler.aCreatorField.className,
          //                     classNode.name,
          //                   ),
          //             )
          //             .join('\n\n'),
          //       )
          //       .replaceAll(
          //         library.aLocalHandler.anInvokeMethodCondition.exp,
          //         libraryNode.classes
          //             .map<String>(
          //               (ClassNode classNode) =>
          //                   library.aLocalHandler.anInvokeMethodCondition
          //                       .stringMatch()
          //                       .replaceAll(
          //                         library.aLocalHandler.anInvokeMethodCondition
          //                             .className,
          //                         classNode.name,
          //                       )
          //                       .replaceAll(
          //                         library.aLocalHandler.anInvokeMethodCondition
          //                             .aMethod.exp,
          //                         classNode.methods
          //                             .map<String>(
          //                               (MethodNode methodNode) => library
          //                                   .aLocalHandler
          //                                   .anInvokeMethodCondition
          //                                   .aMethod
          //                                   .stringMatch()
          //                                   .replaceAll(
          //                                     library
          //                                         .aLocalHandler
          //                                         .anInvokeMethodCondition
          //                                         .aMethod
          //                                         .name,
          //                                     methodNode.name,
          //                                   )
          //                                   .replaceAll(
          //                                     library
          //                                         .aLocalHandler
          //                                         .anInvokeMethodCondition
          //                                         .aMethod
          //                                         .argument,
          //                                     List<int>.generate(
          //                                       methodNode.parameters.length,
          //                                       (int index) => index,
          //                                     )
          //                                         .map<String>(
          //                                           (int index) =>
          //                                               'arguments[$index]',
          //                                         )
          //                                         .join(','),
          //                                   ),
          //                             )
          //                             .join('\n'),
          //                       ),
          //             )
          //             .join('else '),
          //       ),
          );
  // .replaceAll(
  //   library.aCreationArgument.exp,
  //   libraryNode.classes
  //       .map<String>(
  //         (ClassNode classNode) => library.aCreationArgument
  //             .stringMatch()
  //             .replaceAll(
  //               library.aCreationArgument.className,
  //               classNode.name,
  //             )
  //             .replaceAll(
  //               library.aCreationArgument.aField.exp,
  //               classNode.fields
  //                   .map<String>(
  //                     (FieldNode fieldNode) =>
  //                         library.aCreationArgument.aField
  //                             .stringMatch()
  //                             .replaceAll(
  //                               library.aCreationArgument.aField.className,
  //                               classNode.name,
  //                             )
  //                             .replaceAll(
  //                               library.aCreationArgument.aField.name,
  //                               fieldNode.name,
  //                             )
  //                             .replaceAll(
  //                               library.aCreationArgument.aField.className,
  //                               classNode.name,
  //                             ),
  //                   )
  //                   .join(','),
  //             ),
  //       )
  //       .join(','),
  // );
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
  }

  return type;
}

mixin TemplateRegExp {
  static RegExp regExp(String pattern) {
    return RegExp(pattern, multiLine: true, dotAll: true);
  }

  RegExp get exp;

  TemplateRegExp get parent;

  String get template => parent.template;

  String stringMatch() {
    final List<TemplateRegExp> expressions = <TemplateRegExp>[];

    TemplateRegExp currentExp = this;
    while (currentExp.parent != null) {
      expressions.add(currentExp);
      currentExp = currentExp.parent;
    }

    String result = template;
    for (TemplateRegExp expression in expressions.reversed) {
      result = expression.exp.stringMatch(result);
    }

    return result;
  }
}

class Library with TemplateRegExp {
  Library(this.template);

  @override
  final String template;

  @override
  RegExp get exp => null;

  @override
  TemplateRegExp get parent => null;

  Class get aClass => Class(this);

  CreationArgsClass get aCreationArgsClass => CreationArgsClass(this);

  Manager get aManager => Manager(this);

  LocalHandler get aLocalHandler => LocalHandler(this);

  CreationArgument get aCreationArgument => CreationArgument(this);
}

class Class with TemplateRegExp {
  Class(this.parent);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'static abstract class \$ClassTemplate.+?getReferenceClass[^\}]+\}[^\}]+\}',
  );

  @override
  final Library parent;

  final RegExp name = TemplateRegExp.regExp(
    r'(?<=class \$)ClassTemplate(?= implements)',
  );

  final RegExp referenceClass = TemplateRegExp.regExp(
    r'(?<=return \$)ClassTemplate(?=\.class;)',
  );

  ClassMethod get aMethod => ClassMethod(this);
  ClassField get aField => ClassField(this);

  ClassProtectedStaticMethod get aProtectedStaticMethod =>
      ClassProtectedStaticMethod(this);

  ClassProtectedMethod get aProtectedMethod => ClassProtectedMethod(this);
}

class ClassField with TemplateRegExp {
  ClassField(this.parent);

  final RegExp type = TemplateRegExp.regExp(r'Integer');
  final RegExp name = TemplateRegExp.regExp(r'FieldTemplate');

  @override
  final RegExp exp =
      TemplateRegExp.regExp(r'abstract Integer getFieldTemplate\(\);');

  @override
  final Class parent;
}

class ClassMethod with TemplateRegExp {
  ClassMethod(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'methodTemplate');

  Parameter get aParameter => Parameter(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'abstract Object methodTemplate\(String parameterTemplate\) throws Exception;',
  );

  @override
  final Class parent;
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

class ClassProtectedStaticMethod with TemplateRegExp {
  ClassProtectedStaticMethod(this.parent);

  final RegExp className = TemplateRegExp.regExp(
    r'(?<=invokeRemoteStaticMethod.*?\$)ClassTemplate(?=\.class)',
  );

  final RegExp name = TemplateRegExp.regExp(
    r'(?<="|\$)staticMethodTemplate(?="|\()',
  );

  Parameter get aParameter => Parameter(this);

  ParameterName get aParameterName => ParameterName(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'protected static.+\$staticMethodTemplate\([^\}]+\}',
  );

  @override
  final Class parent;
}

class ClassProtectedMethod with TemplateRegExp {
  ClassProtectedMethod(this.parent);

  final RegExp name = TemplateRegExp.regExp(
    r'methodTemplate(?=\(\$ReferencePairManager)',
  );

  Parameter get aParameter => Parameter(this);

  ClassProtectedMethodUnpairedReference get anUnpairedReference =>
      ClassProtectedMethodUnpairedReference(this);

  ClassProtectedMethodPairedReference get aPairedReference =>
      ClassProtectedMethodPairedReference(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'protected Completable<Object> \$methodTemplate[^\}]+\}[^\}]+\}',
  );

  @override
  final Class parent;
}

class ParameterName with TemplateRegExp {
  ParameterName(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'parameterTemplate');

  @override
  final RegExp exp = TemplateRegExp.regExp(r'\(Object\) parameterTemplate');

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
    r'invokeRemoteMethod\([^\}]+\}',
  );

  @override
  final ClassProtectedMethod parent;
}

class Manager with TemplateRegExp {
  Manager(this.parent);

  ManagerClass get aClass => ManagerClass(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'(?<=static abstract class \$)ReferencePairManager([^\}]+\}){4}',
  );

  @override
  final Library parent;
}

class ManagerClass with TemplateRegExp {
  ManagerClass(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'ClassTemplate');

  @override
  final RegExp exp = TemplateRegExp.regExp(r'\$ClassTemplate.class');

  @override
  final Manager parent;
}

class LocalHandler with TemplateRegExp {
  LocalHandler(this.parent);

  LocalHandlerCreator get aCreator => LocalHandlerCreator(this);

  LocalHandlerStaticMethod get aStaticMethod => LocalHandlerStaticMethod(this);

  LocalHandlerMethod get aMethod => LocalHandlerMethod(this);

  LocalHandlerStaticMethodField get aStaticMethodField =>
      LocalHandlerStaticMethodField(this);

  LocalHandlerCreatorField get aCreatorField => LocalHandlerCreatorField(this);

  LocalHandlerInvokeMethodCondition get anInvokeMethodCondition =>
      LocalHandlerInvokeMethodCondition(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'static abstract class \$LocalHandler.+?public void dispose\(([^\}]+\}){2}',
  );

  @override
  final Library parent;
}

class LocalHandlerCreator with TemplateRegExp {
  LocalHandlerCreator(this.parent);

  final RegExp className = TemplateRegExp.regExp(
    r'(?<=put\(\$|final \$|new \$|localHandler\.create)ClassTemplate',
  );

  LocalHandlerCreatorCreationArgs get argument =>
      LocalHandlerCreatorCreationArgs(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'put\(\$ClassTemplate\.class, new \$LocalCreatorHandler([^\}]*\}){2}\);',
  );

  @override
  final LocalHandler parent;
}

class LocalHandlerCreatorCreationArgs with TemplateRegExp {
  LocalHandlerCreatorCreationArgs(this.parent);

  final RegExp fieldName = TemplateRegExp.regExp(r'fieldTemplate');
  final RegExp argumentIndex = TemplateRegExp.regExp(r'(?<=get\()\d');
  final RegExp fieldType = TemplateRegExp.regExp(r'(?<=\()Integer(?=\))');

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'args\.fieldTemplate = \(Integer\) arguments.get\(0\);',
  );

  @override
  final LocalHandlerCreator parent;
}

class LocalHandlerStaticMethod with TemplateRegExp {
  LocalHandlerStaticMethod(this.parent);

  final RegExp className = TemplateRegExp.regExp(r'ClassTemplate');

  LocalHandlerStaticMethodMethod get aMethod =>
      LocalHandlerStaticMethodMethod(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'\$ClassTemplate[^\}]+classTemplate\$staticMethodTemplate\([^\}]+}[^\}]+}',
  );

  @override
  final LocalHandler parent;
}

class LocalHandlerStaticMethodMethod with TemplateRegExp {
  LocalHandlerStaticMethodMethod(this.parent);

  final RegExp methodName = TemplateRegExp.regExp(r'staticMethodTemplate');
  final RegExp classNamePart = TemplateRegExp.regExp(r'classTemplate');
  final RegExp argument = TemplateRegExp.regExp(r'arguments\[0\]');

  @override
  final RegExp exp = TemplateRegExp.regExp(r"'staticMethodTemplate'[^\}]+}");

  @override
  final LocalHandlerStaticMethod parent;
}

class LocalHandlerMethod with TemplateRegExp {
  LocalHandlerMethod(this.parent);

  final RegExp className = TemplateRegExp.regExp(r'ClassTemplate(?=:)');

  LocalHandlerMethodMethod get aMethod => LocalHandlerMethodMethod(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'\$ClassTemplate[^<]+<String, _\$LocalMethodHandler>[^\}]+}[^\}]+}',
  );

  @override
  final LocalHandler parent;
}

class LocalHandlerMethodMethod with TemplateRegExp {
  LocalHandlerMethodMethod(this.parent);

  final RegExp methodName = TemplateRegExp.regExp(r'methodTemplate');
  final RegExp className = TemplateRegExp.regExp(r'ClassTemplate(?=\))');
  final RegExp argument = TemplateRegExp.regExp(r'arguments\[0\]');

  @override
  final RegExp exp = TemplateRegExp.regExp(r"'methodTemplate'[^\}]+}");

  @override
  final LocalHandlerMethod parent;
}

class LocalHandlerStaticMethodField with TemplateRegExp {
  LocalHandlerStaticMethodField(this.parent);

  final RegExp className = TemplateRegExp.regExp(r'classTemplate');
  final RegExp name = TemplateRegExp.regExp(r'staticMethodTemplate');

  Parameter get aParameter => Parameter(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'final[^;]+classTemplate\$staticMethodTemplate;',
  );

  @override
  final LocalHandler parent;
}

class LocalHandlerCreatorField with TemplateRegExp {
  LocalHandlerCreatorField(this.parent);

  final RegExp className = TemplateRegExp.regExp(r'ClassTemplate');

  @override
  final RegExp exp = TemplateRegExp.regExp(r'final[^;]+createClassTemplate;');

  @override
  final LocalHandler parent;
}

class LocalHandlerInvokeMethodCondition with TemplateRegExp {
  LocalHandlerInvokeMethodCondition(this.parent);

  final RegExp className = TemplateRegExp.regExp(r'ClassTemplate');

  LocalHandlerInvokeMethodConditionMethod get aMethod =>
      LocalHandlerInvokeMethodConditionMethod(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'if\s\(localReference\sis\s\$ClassTemplate\)[^\}]+}[^\}]+}',
  );

  @override
  final LocalHandler parent;
}

class LocalHandlerInvokeMethodConditionMethod with TemplateRegExp {
  LocalHandlerInvokeMethodConditionMethod(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'methodTemplate');
  final RegExp argument = TemplateRegExp.regExp(r'arguments\[0\]');

  @override
  final RegExp exp = TemplateRegExp.regExp(r"case\s'methodTemplate'[^\)]+\);");

  @override
  final LocalHandlerInvokeMethodCondition parent;
}

class CreationArgument with TemplateRegExp {
  CreationArgument(this.parent);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'\$ClassTemplate: \(LocalReference localReference\)[^\}]+\}',
  );

  @override
  final Library parent;

  CreationArgumentField get aField => CreationArgumentField(this);

  final RegExp className = TemplateRegExp.regExp(
    r'(?<=\$)ClassTemplate(?=:)',
  );
}

class CreationArgumentField with TemplateRegExp {
  CreationArgumentField(this.parent);

  final RegExp className = TemplateRegExp.regExp(r'ClassTemplate');
  final RegExp name = TemplateRegExp.regExp(r'(?<=\.)fieldTemplate');

  @override
  final CreationArgument parent;

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'\(localReference as \$ClassTemplate\).fieldTemplate',
  );
}
