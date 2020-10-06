import 'package:recase/recase.dart';
import 'package:reference_generator/src/ast.dart';

String generateDart(String template, LibraryNode libraryNode) {
  final Library library = Library(template);
  return template
      .replaceAll(
        library.aClass.exp,
        libraryNode.classes
            .map<String>(
              (ClassNode classNode) => library.aClass
                  .stringMatch()
                  .replaceAll(library.aClass.name, classNode.name)
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
                                library.aClass.aMethod.returnType,
                                getTrueTypeName(methodNode.returnType),
                              )
                              .replaceAll(
                                library.aClass.aMethod.name,
                                methodNode.name,
                              )
                              .replaceAll(
                                library.aClass.aMethod.aParameter.exp,
                                methodNode.parameters
                                    .map<String>(
                                      (ParameterNode parameterNode) =>
                                          library.aClass.aMethod.aParameter
                                              .stringMatch()
                                              .replaceAll(
                                                library.aClass.aMethod
                                                    .aParameter.type,
                                                getTrueTypeName(
                                                  parameterNode.type,
                                                ),
                                              )
                                              .replaceAll(
                                                library.aClass.aMethod
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
        library.aClassExtension.exp,
        libraryNode.classes
            .map<String>(
              (ClassNode classNode) => library.aClassExtension
                  .stringMatch()
                  .replaceAll(
                    library.aClassExtension.extensionName,
                    classNode.name,
                  )
                  .replaceAll(
                    library.aClassExtension.className,
                    classNode.name,
                  )
                  .replaceAll(
                    library.aClassExtension.aStaticMethod.exp,
                    classNode.staticMethods
                        .map<String>(
                          (MethodNode methodNode) => library
                              .aClassExtension.aStaticMethod
                              .stringMatch()
                              .replaceAll(
                                library.aClassExtension.aStaticMethod.className,
                                classNode.name,
                              )
                              .replaceAll(
                                library.aClassExtension.aStaticMethod.name,
                                methodNode.name,
                              )
                              .replaceAll(
                                library.aClassExtension.aStaticMethod.aParameter
                                    .exp,
                                methodNode.parameters
                                    .map<String>(
                                      (ParameterNode parameterNode) => library
                                          .aClassExtension
                                          .aStaticMethod
                                          .aParameter
                                          .stringMatch()
                                          .replaceAll(
                                            library.aClassExtension
                                                .aStaticMethod.aParameter.name,
                                            parameterNode.name,
                                          )
                                          .replaceAll(
                                            library.aClassExtension
                                                .aStaticMethod.aParameter.type,
                                            getTrueTypeName(parameterNode.type),
                                          ),
                                    )
                                    .join(', '),
                              )
                              .replaceAll(
                                library.aClassExtension.aStaticMethod
                                    .aParameterName.exp,
                                methodNode.parameters
                                    .map<String>(
                                      (ParameterNode parameterNode) => library
                                          .aClassExtension
                                          .aStaticMethod
                                          .aParameterName
                                          .stringMatch()
                                          .replaceAll(
                                            library
                                                .aClassExtension
                                                .aStaticMethod
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
                    library.aClassExtension.aMethod.exp,
                    classNode.methods
                        .map<String>(
                          (MethodNode methodNode) => library
                              .aClassExtension.aMethod
                              .stringMatch()
                              .replaceAll(
                                library.aClassExtension.aMethod.name,
                                methodNode.name,
                              )
                              .replaceAll(
                                library.aClassExtension.aMethod.aParameter.exp,
                                methodNode.parameters
                                    .map<String>(
                                      (ParameterNode parameterNode) => library
                                          .aClassExtension.aMethod.aParameter
                                          .stringMatch()
                                          .replaceAll(
                                            library.aClassExtension.aMethod
                                                .aParameter.name,
                                            parameterNode.name,
                                          )
                                          .replaceAll(
                                            library.aClassExtension.aMethod
                                                .aParameter.type,
                                            getTrueTypeName(parameterNode.type),
                                          ),
                                    )
                                    .join(', '),
                              )
                              .replaceAll(
                                library.aClassExtension.aMethod
                                    .anUnpairedReference.exp,
                                library
                                    .aClassExtension.aMethod.anUnpairedReference
                                    .stringMatch()
                                    .replaceAll(
                                        library.aClassExtension.aMethod
                                            .anUnpairedReference.name,
                                        methodNode.name)
                                    .replaceAll(
                                      library
                                          .aClassExtension
                                          .aMethod
                                          .anUnpairedReference
                                          .aParameterName
                                          .exp,
                                      methodNode.parameters
                                          .map<String>(
                                            (ParameterNode parameterNode) =>
                                                library
                                                    .aClassExtension
                                                    .aMethod
                                                    .anUnpairedReference
                                                    .aParameterName
                                                    .stringMatch()
                                                    .replaceAll(
                                                      library
                                                          .aClassExtension
                                                          .aMethod
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
                                library.aClassExtension.aMethod.aPairedReference
                                    .exp,
                                library.aClassExtension.aMethod.aPairedReference
                                    .stringMatch()
                                    .replaceAll(
                                      library.aClassExtension.aMethod
                                          .aPairedReference.name,
                                      methodNode.name,
                                    )
                                    .replaceAll(
                                      library.aClassExtension.aMethod
                                          .aPairedReference.aParameterName.exp,
                                      methodNode.parameters
                                          .map<String>(
                                            (ParameterNode parameterNode) =>
                                                library
                                                    .aClassExtension
                                                    .aMethod
                                                    .aPairedReference
                                                    .aParameterName
                                                    .stringMatch()
                                                    .replaceAll(
                                                      library
                                                          .aClassExtension
                                                          .aMethod
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
        library.aLocalHandler.exp
            .stringMatch(template)
            .replaceAll(
              library.aLocalHandler.aCreatorName.exp,
              libraryNode.classes
                  .map<String>(
                    (ClassNode classNode) => library.aLocalHandler.aCreatorName
                        .stringMatch()
                        .replaceAll(
                          library.aLocalHandler.aCreatorName.name,
                          classNode.name,
                        ),
                  )
                  .join(', '),
            )
            .replaceAll(
              library.aLocalHandler.aStaticMethodName.exp,
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
                        library.aLocalHandler.aStaticMethodName
                            .stringMatch()
                            .replaceAll(
                              library.aLocalHandler.aStaticMethodName.className,
                              ReCase(entry.value.name).camelCase,
                            )
                            .replaceAll(
                              library.aLocalHandler.aStaticMethodName.name,
                              entry.key.name,
                            ),
                  )
                  .join(','),
            )
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
                          library.aLocalHandler.aCreator.argument,
                          List<int>.generate(
                                  classNode.fields.length, (int index) => index)
                              .map<String>((int index) => 'arguments[$index]')
                              .join(','),
                        ),
                  )
                  .join(', '),
            )
            .replaceAll(
              library.aLocalHandler.aStaticMethod.exp,
              libraryNode.classes
                  .map<String>(
                    (ClassNode classNode) => library.aLocalHandler.aStaticMethod
                        .stringMatch()
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
                                              .aMethod.argument,
                                          List<int>.generate(
                                            methodNode.parameters.length,
                                            (int index) => index,
                                          )
                                              .map<String>(
                                                (int index) =>
                                                    'arguments[$index]',
                                              )
                                              .join(','),
                                        ),
                              )
                              .join(','),
                        ),
                  )
                  .join(','),
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
                                              .methodName,
                                          methodNode.name,
                                        )
                                        .replaceAll(
                                          library.aLocalHandler.aMethod.aMethod
                                              .argument,
                                          List<int>.generate(
                                            methodNode.parameters.length,
                                            (int index) => index,
                                          )
                                              .map<String>(
                                                (int index) =>
                                                    'arguments[$index]',
                                              )
                                              .join(','),
                                        ),
                              )
                              .join(','),
                        ),
                  )
                  .join(','),
            )
            .replaceAll(
              library.aLocalHandler.aStaticMethodField.exp,
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
                    (MapEntry<MethodNode, ClassNode> entry) => library
                        .aLocalHandler.aStaticMethodField
                        .stringMatch()
                        .replaceAll(
                          library.aLocalHandler.aStaticMethodField.className,
                          ReCase(entry.value.name).camelCase,
                        )
                        .replaceAll(
                          library.aLocalHandler.aStaticMethodField.name,
                          entry.key.name,
                        )
                        .replaceAll(
                          library
                              .aLocalHandler.aStaticMethodField.aParameter.exp,
                          entry.key.parameters
                              .map<String>(
                                (ParameterNode parameterNode) => library
                                    .aLocalHandler.aStaticMethodField.aParameter
                                    .stringMatch()
                                    .replaceAll(
                                      library.aLocalHandler.aStaticMethodField
                                          .aParameter.name,
                                      parameterNode.name,
                                    )
                                    .replaceAll(
                                      library.aLocalHandler.aStaticMethodField
                                          .aParameter.type,
                                      getTrueTypeName(parameterNode.type),
                                    ),
                              )
                              .join(', '),
                        ),
                  )
                  .join('\n\n'),
            )
            .replaceAll(
              library.aLocalHandler.aCreatorField.exp,
              libraryNode.classes
                  .map<String>(
                    (ClassNode classNode) => library.aLocalHandler.aCreatorField
                        .stringMatch()
                        .replaceAll(
                          library.aLocalHandler.aCreatorField.className,
                          classNode.name,
                        )
                        .replaceAll(
                          library.aLocalHandler.aCreatorField.aField.exp,
                          classNode.fields
                              .map<String>(
                                (FieldNode fieldNode) =>
                                    library.aLocalHandler.aCreatorField.aField
                                        .stringMatch()
                                        .replaceAll(
                                          library.aLocalHandler.aCreatorField
                                              .aField.name,
                                          fieldNode.name,
                                        )
                                        .replaceAll(
                                          library.aLocalHandler.aCreatorField
                                              .aField.type,
                                          getTrueTypeName(fieldNode.type),
                                        ),
                              )
                              .join(','),
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
                                              .argument,
                                          List<int>.generate(
                                            methodNode.parameters.length,
                                            (int index) => index,
                                          )
                                              .map<String>(
                                                (int index) =>
                                                    'arguments[$index]',
                                              )
                                              .join(','),
                                        ),
                                  )
                                  .join('\n'),
                            ),
                  )
                  .join('else '),
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
                  .replaceAll(
                    library.aCreationArgument.aField.exp,
                    classNode.fields
                        .map<String>(
                          (FieldNode fieldNode) =>
                              library.aCreationArgument.aField
                                  .stringMatch()
                                  .replaceAll(
                                    library.aCreationArgument.aField.className,
                                    classNode.name,
                                  )
                                  .replaceAll(
                                    library.aCreationArgument.aField.name,
                                    fieldNode.name,
                                  )
                                  .replaceAll(
                                    library.aCreationArgument.aField.className,
                                    classNode.name,
                                  ),
                        )
                        .join(','),
                  ),
            )
            .join(','),
      );
}

// TODO: handle type parameters
String getTrueTypeName(ReferenceType type) {
  if (type.codeGeneratedClass) return '\$${type.name}';
  return type.name;
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

    if (expressions.isEmpty) return template;

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

  ClassExtension get aClassExtension => ClassExtension(this);

  Manager get aManager => Manager(this);

  LocalHandler get aLocalHandler => LocalHandler(this);

  CreationArgument get aCreationArgument => CreationArgument(this);
}

class Class with TemplateRegExp {
  Class(this.parent);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'abstract\sclass\s\$ClassTemplate.+?Type\sget\sreferenceType\s=>\s\$ClassTemplate;.+?}',
  );

  @override
  final Library parent;

  final RegExp name = TemplateRegExp.regExp(
    r'ClassTemplate(?=.+?implements|;.*?\})',
  );

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
  final Class parent;
}

class ClassMethod with TemplateRegExp {
  ClassMethod(this.parent);

  final RegExp returnType = TemplateRegExp.regExp(r'^Future<String>');

  final RegExp name = TemplateRegExp.regExp(
    r'methodTemplate(?=\(String parameterTemplate\);)',
  );

  Parameter get aParameter => Parameter(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'Future<String> methodTemplate\(String parameterTemplate\);',
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

class ClassExtension with TemplateRegExp {
  ClassExtension(this.parent);

  final RegExp extensionName = TemplateRegExp.regExp(
    r'ClassTemplate(?=Methods\son)',
  );

  final RegExp className = TemplateRegExp.regExp(
    r'ClassTemplate(?<=on\s\$ClassTemplate)',
  );

  ClassExtensionStaticMethod get aStaticMethod =>
      ClassExtensionStaticMethod(this);

  ClassExtensionMethod get aMethod => ClassExtensionMethod(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'extension\s\$ClassTemplateMethods[^\}]+\}[^\}]+\}[^\}]+\}[^\}]*\}',
  );

  @override
  final Library parent;
}

class ClassExtensionStaticMethod with TemplateRegExp {
  ClassExtensionStaticMethod(this.parent);

  final RegExp className = TemplateRegExp.regExp(
    r'ClassTemplate(?<=invokeRemoteStaticMethod.*?\$ClassTemplate)',
  );

  final RegExp name = TemplateRegExp.regExp(
    r'staticMethodTemplate(?=.*?<Object>)',
  );

  Parameter get aParameter => Parameter(this);

  ParameterName get aParameterName => ParameterName(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'static\sFuture<Object>\s\$staticMethodTemplate[^\}]+\}',
  );

  @override
  final ClassExtension parent;
}

class ClassExtensionMethod with TemplateRegExp {
  ClassExtensionMethod(this.parent);

  final RegExp name = TemplateRegExp.regExp(
    r'methodTemplate(?<=Future<Object>\s\$methodTemplate)',
  );

  Parameter get aParameter => Parameter(this);

  ClassExtensionMethodUnpairedReference get anUnpairedReference =>
      ClassExtensionMethodUnpairedReference(this);

  ClassExtensionMethodPairedReference get aPairedReference =>
      ClassExtensionMethodPairedReference(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'Future<Object>\s\$methodTemplate[^\}]+\}[^\}]+\}',
  );

  @override
  final ClassExtension parent;
}

class ParameterName with TemplateRegExp {
  ParameterName(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'parameterTemplate');

  @override
  final RegExp exp = TemplateRegExp.regExp(r'(?<=<Object>\[)parameterTemplate');

  @override
  final TemplateRegExp parent;
}

class ClassExtensionMethodUnpairedReference with TemplateRegExp {
  ClassExtensionMethodUnpairedReference(this.parent);

  final RegExp name = TemplateRegExp.regExp(r"methodTemplate(?=')");

  ParameterName get aParameterName => ParameterName(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'return.+?invokeRemoteMethodOnUnpairedReference.+;',
  );

  @override
  final ClassExtensionMethod parent;
}

class ClassExtensionMethodPairedReference with TemplateRegExp {
  ClassExtensionMethodPairedReference(this.parent);

  final RegExp name = TemplateRegExp.regExp(r"methodTemplate(?=')");

  ParameterName get aParameterName => ParameterName(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'return.+?invokeRemoteMethod[^\}]+\}',
  );

  @override
  final ClassExtensionMethod parent;
}

class Manager with TemplateRegExp {
  Manager(this.parent);

  ManagerClass get aClass => ManagerClass(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'(?<=abstract\sclass\s\$)ReferencePairManager[^\}]+\}[^\}]+\}',
  );

  @override
  final Library parent;
}

class ManagerClass with TemplateRegExp {
  ManagerClass(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'ClassTemplate');

  @override
  final RegExp exp = TemplateRegExp.regExp(r'\$ClassTemplate');

  @override
  final Manager parent;
}

class LocalHandler with TemplateRegExp {
  LocalHandler(this.parent);

  LocalHandlerCreatorName get aCreatorName => LocalHandlerCreatorName(this);

  LocalHandlerStaticMethodName get aStaticMethodName =>
      LocalHandlerStaticMethodName(this);

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
    r'class\s\$LocalHandler[^{]+{([^}]+}){15}',
  );

  @override
  final Library parent;
}

class LocalHandlerCreatorName with TemplateRegExp {
  LocalHandlerCreatorName(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'ClassTemplate');

  @override
  final RegExp exp = TemplateRegExp.regExp(r'this.createClassTemplate');

  @override
  final LocalHandler parent;
}

class LocalHandlerStaticMethodName with TemplateRegExp {
  LocalHandlerStaticMethodName(this.parent);

  final RegExp className = TemplateRegExp.regExp(r'classTemplate');

  final RegExp name = TemplateRegExp.regExp(r'staticMethodTemplate');

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'this.classTemplate\$staticMethodTemplate',
  );

  @override
  final LocalHandler parent;
}

class LocalHandlerCreator with TemplateRegExp {
  LocalHandlerCreator(this.parent);

  final RegExp className = RegExp(r'ClassTemplate');
  final RegExp argument = RegExp(r'arguments\[0\]');

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'\$ClassTemplate[^\}]+createClassTemplate\([^\}]+}',
  );

  @override
  final LocalHandler parent;
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

  LocalHandlerCreatorFieldField get aField =>
      LocalHandlerCreatorFieldField(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(r'final[^;]+createClassTemplate;');

  @override
  final LocalHandler parent;
}

class LocalHandlerCreatorFieldField with TemplateRegExp {
  LocalHandlerCreatorFieldField(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'fieldTemplate$');
  final RegExp type = TemplateRegExp.regExp(r'^int');

  @override
  final RegExp exp = TemplateRegExp.regExp(r'int fieldTemplate');

  @override
  final LocalHandlerCreatorField parent;
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
