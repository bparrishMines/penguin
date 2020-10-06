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
        Library.aManager,
        Library.aManager.stringMatch(template).replaceAll(
              Manager.aClass,
              libraryNode.classes
                  .map<String>(
                    (ClassNode classNode) => Manager.aClass
                        .stringMatch(
                          Library.aManager.stringMatch(template),
                        )
                        .replaceAll(ManagerClass.name, classNode.name),
                  )
                  .join(', '),
            ),
      )
      .replaceAll(
        Library.aLocalHandler,
        Library.aLocalHandler
            .stringMatch(template)
            .replaceAll(
              LocalHandler.aCreatorName,
              libraryNode.classes
                  .map<String>(
                    (ClassNode classNode) => LocalHandler.aCreatorName
                        .stringMatch(
                          Library.aLocalHandler.stringMatch(template),
                        )
                        .replaceAll(
                          LocalHandlerCreatorName.name,
                          classNode.name,
                        ),
                  )
                  .join(', '),
            )
            .replaceAll(
              LocalHandler.aStaticMethodName,
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
                    (MapEntry<MethodNode, ClassNode> entry) => LocalHandler
                        .aStaticMethodName
                        .stringMatch(
                          Library.aLocalHandler.stringMatch(template),
                        )
                        .replaceAll(LocalHandlerStaticMethodName.className,
                            ReCase(entry.value.name).camelCase)
                        .replaceAll(
                            LocalHandlerStaticMethodName.name, entry.key.name),
                  )
                  .join(','),
            )
            .replaceAll(
              LocalHandler.aCreator,
              libraryNode.classes
                  .map<String>(
                    (ClassNode classNode) => LocalHandler.aCreator
                        .stringMatch(
                          Library.aLocalHandler.stringMatch(template),
                        )
                        .replaceAll(
                          LocalHandlerCreator.className,
                          classNode.name,
                        )
                        .replaceAll(
                          LocalHandlerCreator.argument,
                          List<int>.generate(
                                  classNode.fields.length, (int index) => index)
                              .map<String>((int index) => 'arguments[$index]')
                              .join(','),
                        ),
                  )
                  .join(', '),
            )
            .replaceAll(
              LocalHandler.aStaticMethod,
              libraryNode.classes
                  .map<String>(
                    (ClassNode classNode) => LocalHandler.aStaticMethod
                        .stringMatch(
                          Library.aLocalHandler.stringMatch(template),
                        )
                        .replaceAll(
                          LocalHandlerStaticMethod.className,
                          classNode.name,
                        )
                        .replaceAll(
                          LocalHandlerStaticMethod.aMethod,
                          classNode.staticMethods
                              .map<String>(
                                (MethodNode methodNode) =>
                                    LocalHandlerStaticMethod.aMethod
                                        .stringMatch(
                                          LocalHandler.aStaticMethod
                                              .stringMatch(
                                            Library.aLocalHandler.stringMatch(
                                              template,
                                            ),
                                          ),
                                        )
                                        .replaceAll(
                                          LocalHandlerStaticMethodMethod
                                              .classNamePart,
                                          ReCase(classNode.name).camelCase,
                                        )
                                        .replaceAll(
                                          LocalHandlerStaticMethodMethod
                                              .methodName,
                                          methodNode.name,
                                        )
                                        .replaceAll(
                                          LocalHandlerStaticMethodMethod
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
              LocalHandler.aMethod,
              libraryNode.classes
                  .map<String>(
                    (ClassNode classNode) => LocalHandler.aMethod
                        .stringMatch(
                          Library.aLocalHandler.stringMatch(template),
                        )
                        .replaceAll(
                          LocalHandlerMethod.className,
                          classNode.name,
                        )
                        .replaceAll(
                          LocalHandlerMethod.aMethod,
                          classNode.methods
                              .map<String>(
                                (MethodNode methodNode) =>
                                    LocalHandlerMethod.aMethod
                                        .stringMatch(
                                          LocalHandler.aMethod.stringMatch(
                                            Library.aLocalHandler.stringMatch(
                                              template,
                                            ),
                                          ),
                                        )
                                        .replaceAll(
                                          LocalHandlerMethodMethod.className,
                                          classNode.name,
                                        )
                                        .replaceAll(
                                          LocalHandlerMethodMethod.methodName,
                                          methodNode.name,
                                        )
                                        .replaceAll(
                                          LocalHandlerMethodMethod.argument,
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
              LocalHandler.aStaticMethodField,
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
                    (MapEntry<MethodNode, ClassNode> entry) => LocalHandler
                        .aStaticMethodField
                        .stringMatch(
                          Library.aLocalHandler.stringMatch(template),
                        )
                        .replaceAll(
                          LocalHandlerStaticMethodField.className,
                          ReCase(entry.value.name).camelCase,
                        )
                        .replaceAll(
                          LocalHandlerStaticMethodField.name,
                          entry.key.name,
                        )
                        .replaceAll(
                          LocalHandlerStaticMethodField.aParameter,
                          entry.key.parameters
                              .map<String>(
                                (ParameterNode parameterNode) =>
                                    LocalHandlerStaticMethodField.aParameter
                                        .stringMatch(
                                          LocalHandler.aStaticMethodField
                                              .stringMatch(
                                            Library.aLocalHandler.stringMatch(
                                              template,
                                            ),
                                          ),
                                        )
                                        .replaceAll(
                                          Parameter(null).name,
                                          parameterNode.name,
                                        )
                                        .replaceAll(
                                          Parameter(null).type,
                                          getTrueTypeName(parameterNode.type),
                                        ),
                              )
                              .join(', '),
                        ),
                  )
                  .join('\n\n'),
            )
            .replaceAll(
              LocalHandler.aCreatorField,
              libraryNode.classes
                  .map<String>(
                    (ClassNode classNode) => LocalHandler.aCreatorField
                        .stringMatch(
                          Library.aLocalHandler.stringMatch(template),
                        )
                        .replaceAll(
                          LocalHandlerCreatorField.className,
                          classNode.name,
                        )
                        .replaceAll(
                          LocalHandlerCreatorField.aField,
                          classNode.fields
                              .map<String>(
                                (FieldNode fieldNode) =>
                                    LocalHandlerCreatorField.aField
                                        .stringMatch(
                                          LocalHandler.aCreatorField
                                              .stringMatch(
                                            Library.aLocalHandler.stringMatch(
                                              template,
                                            ),
                                          ),
                                        )
                                        .replaceAll(
                                          LocalHandlerCreatorFieldField.name,
                                          fieldNode.name,
                                        )
                                        .replaceAll(
                                          LocalHandlerCreatorFieldField.type,
                                          getTrueTypeName(fieldNode.type),
                                        ),
                              )
                              .join(','),
                        ),
                  )
                  .join('\n\n'),
            )
            .replaceAll(
              LocalHandler.anInvokeMethodCondition,
              libraryNode.classes
                  .map<String>(
                    (ClassNode classNode) => LocalHandler
                        .anInvokeMethodCondition
                        .stringMatch(
                          Library.aLocalHandler.stringMatch(template),
                        )
                        .replaceAll(
                          LocalHandlerInvokeMethodCondition.className,
                          classNode.name,
                        )
                        .replaceAll(
                          LocalHandlerInvokeMethodCondition.aMethod,
                          classNode.methods
                              .map<String>(
                                (MethodNode methodNode) =>
                                    LocalHandlerInvokeMethodCondition.aMethod
                                        .stringMatch(
                                          LocalHandler.anInvokeMethodCondition
                                              .stringMatch(
                                            Library.aLocalHandler
                                                .stringMatch(template),
                                          ),
                                        )
                                        .replaceAll(
                                          LocalHandlerInvokeMethodConditionMethod
                                              .name,
                                          methodNode.name,
                                        )
                                        .replaceAll(
                                          LocalHandlerInvokeMethodConditionMethod
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

  static final RegExp aManager = RegExp(
    r'(?<=abstract\sclass\s\$)ReferencePairManager[^\}]+\}[^\}]+\}',
    multiLine: true,
    dotAll: true,
  );

  static final RegExp aLocalHandler = RegExp(
    r'class\s\$LocalHandler[^{]+{([^}]+}){15}',
    multiLine: true,
    dotAll: true,
  );

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

class Manager {
  static final RegExp aClass = RegExp(
    r'\$ClassTemplate',
    multiLine: true,
    dotAll: true,
  );
}

class ManagerClass {
  static final RegExp name = RegExp(
    r'ClassTemplate',
    multiLine: true,
    dotAll: true,
  );
}

class LocalHandler {
  static final RegExp aCreatorName = RegExp(
    r'this.createClassTemplate',
    multiLine: true,
    dotAll: true,
  );

  static final RegExp aStaticMethodName = RegExp(
    r'this.classTemplate\$staticMethodTemplate',
    multiLine: true,
    dotAll: true,
  );

  static final RegExp aCreator = RegExp(
    r'\$ClassTemplate[^\}]+createClassTemplate\([^\}]+}',
    multiLine: true,
    dotAll: true,
  );

  static final RegExp aStaticMethod = RegExp(
    r'\$ClassTemplate[^\}]+classTemplate\$staticMethodTemplate\([^\}]+}[^\}]+}',
    multiLine: true,
    dotAll: true,
  );

  static final RegExp aMethod = RegExp(
    r'\$ClassTemplate[^<]+<String, _\$LocalMethodHandler>[^\}]+}[^\}]+}',
    multiLine: true,
    dotAll: true,
  );

  static final RegExp aStaticMethodField = RegExp(
    r'final[^;]+classTemplate\$staticMethodTemplate;',
    multiLine: true,
    dotAll: true,
  );

  static final RegExp aCreatorField = RegExp(
    r'final[^;]+createClassTemplate;',
    multiLine: true,
    dotAll: true,
  );

  static final RegExp anInvokeMethodCondition = RegExp(
    r'if\s\(localReference\sis\s\$ClassTemplate\)[^\}]+}[^\}]+}',
    multiLine: true,
    dotAll: true,
  );
}

class LocalHandlerCreatorName {
  static final RegExp name = RegExp(
    r'ClassTemplate',
    multiLine: true,
    dotAll: true,
  );
}

class LocalHandlerStaticMethodName {
  static final RegExp className = RegExp(
    r'classTemplate',
    multiLine: true,
    dotAll: true,
  );

  static final RegExp name = RegExp(
    r'staticMethodTemplate',
    multiLine: true,
    dotAll: true,
  );
}

class LocalHandlerCreator {
  static final RegExp className = RegExp(
    r'ClassTemplate',
    multiLine: true,
    dotAll: true,
  );

  static final RegExp argument = RegExp(
    r'arguments\[0\]',
    multiLine: true,
    dotAll: true,
  );
}

class LocalHandlerStaticMethod {
  static final RegExp className = RegExp(
    r'ClassTemplate',
    multiLine: true,
    dotAll: true,
  );

  static final RegExp aMethod = RegExp(
    r"'staticMethodTemplate'[^\}]+}",
    multiLine: true,
    dotAll: true,
  );
}

class LocalHandlerStaticMethodMethod {
  static final RegExp methodName = RegExp(
    r'staticMethodTemplate',
    multiLine: true,
    dotAll: true,
  );

  static final RegExp classNamePart = RegExp(
    r'classTemplate',
    multiLine: true,
    dotAll: true,
  );

  static final RegExp argument = RegExp(
    r'arguments\[0\]',
    multiLine: true,
    dotAll: true,
  );
}

class LocalHandlerMethod {
  static final RegExp className = RegExp(
    r'ClassTemplate(?=:)',
    multiLine: true,
    dotAll: true,
  );

  static final RegExp aMethod = RegExp(
    r"'methodTemplate'[^\}]+}",
    multiLine: true,
    dotAll: true,
  );
}

class LocalHandlerMethodMethod {
  static final RegExp methodName = RegExp(
    r'methodTemplate',
    multiLine: true,
    dotAll: true,
  );

  static final RegExp className = RegExp(
    r'ClassTemplate(?=\))',
    multiLine: true,
    dotAll: true,
  );

  static final RegExp argument = RegExp(
    r'arguments\[0\]',
    multiLine: true,
    dotAll: true,
  );
}

class LocalHandlerStaticMethodField {
  static final RegExp className = RegExp(
    r'classTemplate',
    multiLine: true,
    dotAll: true,
  );

  static final RegExp name = RegExp(
    r'staticMethodTemplate',
    multiLine: true,
    dotAll: true,
  );

  static final RegExp aParameter = RegExp(
    r'String parameterTemplate',
    multiLine: true,
    dotAll: true,
  );
}

class LocalHandlerCreatorField {
  static final RegExp className = RegExp(
    r'ClassTemplate',
    multiLine: true,
    dotAll: true,
  );

  static final RegExp aField = RegExp(
    r'int fieldTemplate',
    multiLine: true,
    dotAll: true,
  );
}

class LocalHandlerCreatorFieldField {
  static final RegExp name = RegExp(
    r'fieldTemplate$',
    multiLine: true,
    dotAll: true,
  );

  static final RegExp type = RegExp(
    r'^int',
    multiLine: true,
    dotAll: true,
  );
}

class LocalHandlerInvokeMethodCondition {
  static final RegExp className = RegExp(
    r'ClassTemplate',
    multiLine: true,
    dotAll: true,
  );

  static final RegExp aMethod = RegExp(
    r"case\s'methodTemplate'[^\)]+\);",
    multiLine: true,
    dotAll: true,
  );
}

class LocalHandlerInvokeMethodConditionMethod {
  static final RegExp name = RegExp(
    r'methodTemplate',
    multiLine: true,
    dotAll: true,
  );

  static final RegExp argument = RegExp(
    r'arguments\[0\]',
    multiLine: true,
    dotAll: true,
  );
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
