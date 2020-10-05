import 'package:recase/recase.dart';
import 'package:reference_generator/src/ast.dart';

String generateDart(String template, LibraryNode libraryNode) {
  final Library library = Library(template);
  return template
      .replaceAll(
        Library.aClass,
        libraryNode.classes
            .map<String>(
              (ClassNode classNode) => Library.aClass
                  .stringMatch(template)
                  .replaceAll(Class.name, classNode.name)
                  .replaceAll(
                    Class.aField,
                    classNode.fields
                        .map<String>(
                          (FieldNode fieldNode) => Class.aField
                              .replaceAll(Field.name, fieldNode.name)
                              .replaceAll(
                                Field.type,
                                getTrueTypeName(fieldNode.type),
                              ),
                        )
                        .join('\n'),
                  )
                  .replaceAll(
                    Class.aMethod,
                    classNode.methods
                        .map<String>(
                          (MethodNode methodNode) => Class.aMethod
                              .replaceAll(
                                Method.returnType,
                                getTrueTypeName(methodNode.returnType),
                              )
                              .replaceAll(
                                Method.name,
                                methodNode.name,
                              )
                              .replaceAll(
                                Method.aParameter,
                                methodNode.parameters
                                    .map<String>(
                                      (ParameterNode parameterNode) =>
                                          Method.aParameter
                                              .replaceAll(
                                                Parameter.type,
                                                getTrueTypeName(
                                                  parameterNode.type,
                                                ),
                                              )
                                              .replaceAll(
                                                Parameter.name,
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
        Library.aClassExtension,
        libraryNode.classes
            .map<String>(
              (ClassNode classNode) => Library.aClassExtension
                  .stringMatch(template)
                  .replaceAll(
                    ClassExtension.extensionName,
                    classNode.name,
                  )
                  .replaceAll(
                    ClassExtension.className,
                    classNode.name,
                  )
                  .replaceAll(
                    ClassExtension.aStaticMethod,
                    classNode.staticMethods
                        .map<String>(
                          (MethodNode methodNode) => ClassExtension
                              .aStaticMethod
                              .stringMatch(
                                Library.aClassExtension.stringMatch(template),
                              )
                              .replaceAll(
                                ClassExtensionStaticMethod.className,
                                classNode.name,
                              )
                              .replaceAll(
                                ClassExtensionStaticMethod.name,
                                methodNode.name,
                              )
                              .replaceAll(
                                ClassExtensionStaticMethod.aParameter,
                                methodNode.parameters
                                    .map<String>(
                                      (ParameterNode parameterNode) =>
                                          ClassExtensionStaticMethod.aParameter
                                              .replaceAll(
                                                Parameter.name,
                                                parameterNode.name,
                                              )
                                              .replaceAll(
                                                Parameter.type,
                                                getTrueTypeName(
                                                    parameterNode.type),
                                              ),
                                    )
                                    .join(', '),
                              )
                              .replaceAll(
                                ClassExtensionStaticMethod.aParameterName,
                                methodNode.parameters
                                    .map<String>(
                                      (ParameterNode parameterNode) =>
                                          ClassExtensionStaticMethod
                                              .aParameterName
                                              .stringMatch(
                                                ClassExtension.aStaticMethod
                                                    .stringMatch(
                                                  Library.aClassExtension
                                                      .stringMatch(template),
                                                ),
                                              )
                                              .replaceAll(
                                                Parameter.name,
                                                parameterNode.name,
                                              ),
                                    )
                                    .join(', '),
                              ),
                        )
                        .join('\n\n'),
                  )
                  .replaceAll(
                    ClassExtension.aMethod,
                    classNode.methods
                        .map<String>(
                          (MethodNode methodNode) => ClassExtension.aMethod
                              .stringMatch(
                                Library.aClassExtension.stringMatch(template),
                              )
                              .replaceAll(
                                ClassExtensionMethod.name,
                                methodNode.name,
                              )
                              .replaceAll(
                                ClassExtensionMethod.aParameter,
                                methodNode.parameters
                                    .map<String>(
                                      (ParameterNode parameterNode) =>
                                          ClassExtensionStaticMethod.aParameter
                                              .replaceAll(
                                                Parameter.name,
                                                parameterNode.name,
                                              )
                                              .replaceAll(
                                                Parameter.type,
                                                getTrueTypeName(
                                                    parameterNode.type),
                                              ),
                                    )
                                    .join(', '),
                              )
                              .replaceAll(
                                ClassExtensionMethod.anUnpairedReference,
                                ClassExtensionMethod.anUnpairedReference
                                    .stringMatch(
                                      ClassExtension.aMethod.stringMatch(
                                        Library.aClassExtension
                                            .stringMatch(template),
                                      ),
                                    )
                                    .replaceAll(
                                        ClassExtensionMethodUnpairedReference
                                            .name,
                                        methodNode.name)
                                    .replaceAll(
                                      ClassExtensionMethodUnpairedReference
                                          .aParameterName,
                                      methodNode.parameters
                                          .map<String>(
                                            (ParameterNode parameterNode) =>
                                                ClassExtensionStaticMethod
                                                    .aParameterName
                                                    .stringMatch(
                                                      ClassExtension
                                                          .aStaticMethod
                                                          .stringMatch(
                                                        Library.aClassExtension
                                                            .stringMatch(
                                                          template,
                                                        ),
                                                      ),
                                                    )
                                                    .replaceAll(
                                                      Parameter.name,
                                                      parameterNode.name,
                                                    ),
                                          )
                                          .join(', '),
                                    ),
                              )
                              .replaceAll(
                                ClassExtensionMethod.aPairedReference,
                                ClassExtensionMethod.aPairedReference
                                    .stringMatch(
                                      ClassExtension.aMethod.stringMatch(
                                        Library.aClassExtension
                                            .stringMatch(template),
                                      ),
                                    )
                                    .replaceAll(
                                        ClassExtensionMethodPairedReference
                                            .name,
                                        methodNode.name)
                                    .replaceAll(
                                      ClassExtensionMethodPairedReference
                                          .aParameterName,
                                      methodNode.parameters
                                          .map<String>(
                                            (ParameterNode parameterNode) =>
                                                ClassExtensionStaticMethod
                                                    .aParameterName
                                                    .stringMatch(
                                                      ClassExtension
                                                          .aStaticMethod
                                                          .stringMatch(
                                                        Library.aClassExtension
                                                            .stringMatch(
                                                          template,
                                                        ),
                                                      ),
                                                    )
                                                    .replaceAll(
                                                      Parameter.name,
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
                                          Parameter.name,
                                          parameterNode.name,
                                        )
                                        .replaceAll(
                                          Parameter.type,
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

  static final RegExp aClass = RegExp(
    r'abstract\sclass\s\$ClassTemplate.+?Type\sget\sreferenceType\s=>\s\$ClassTemplate;.+?}',
    multiLine: true,
    dotAll: true,
  );

  static final RegExp aClassExtension = RegExp(
    r'extension\s\$ClassTemplateMethods[^\}]+\}[^\}]+\}[^\}]+\}[^\}]*\}',
    multiLine: true,
    dotAll: true,
  );

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

  // static final RegExp aCreationArgument = RegExp(
  //   r'\$ClassTemplate: \(LocalReference localReference\)[^\}]+\}',
  //   multiLine: true,
  //   dotAll: true,
  // );
}

class Class {
  static final RegExp name = RegExp(
    r'ClassTemplate(?=.+?implements|;.*?\})',
    multiLine: true,
    dotAll: true,
  );

  static final String aField = 'int get fieldTemplate;';

  static final String aMethod =
      r'Future<String> methodTemplate(String parameterTemplate);';
}

class Field {
  static final RegExp type = RegExp(
    r'^int',
    multiLine: true,
    dotAll: true,
  );

  static final RegExp name = RegExp(
    r'fieldTemplate(?=;)',
    multiLine: true,
    dotAll: true,
  );
}

class Method {
  static final RegExp returnType = RegExp(
    r'^Future<String>',
    multiLine: true,
    dotAll: true,
  );

  static final RegExp name = RegExp(
    'methodTemplate(?=\\($aParameter\\);)',
    multiLine: true,
    dotAll: true,
  );

  static final String aParameter = 'String parameterTemplate';
}

class Parameter {
  static final RegExp type = RegExp(
    r'^String',
    multiLine: true,
    dotAll: true,
  );

  static final RegExp name = RegExp(
    r'parameterTemplate$',
    multiLine: true,
    dotAll: true,
  );
}

class ClassExtension {
  static final RegExp extensionName = RegExp(
    r'ClassTemplate(?=Methods\son)',
    multiLine: true,
    dotAll: true,
  );

  static final RegExp className = RegExp(
    r'ClassTemplate(?<=on\s\$ClassTemplate)',
    multiLine: true,
    dotAll: true,
  );

  static final RegExp aStaticMethod = RegExp(
    r'static\sFuture<Object>\s\$staticMethodTemplate[^\}]+\}',
    multiLine: true,
    dotAll: true,
  );

  static final RegExp aMethod = RegExp(
    r'Future<Object>\s\$methodTemplate[^\}]+\}[^\}]+\}',
    multiLine: true,
    dotAll: true,
  );
}

class ClassExtensionStaticMethod {
  static final RegExp className = RegExp(
    r'ClassTemplate(?<=invokeRemoteStaticMethod.*?\$ClassTemplate)',
    multiLine: true,
    dotAll: true,
  );

  static final RegExp name = RegExp(
    r'staticMethodTemplate(?=.*?<Object>)',
    multiLine: true,
    dotAll: true,
  );

  static final String aParameter = 'String parameterTemplate';

  static final RegExp aParameterName = RegExp(
    r'parameterTemplate(?<=<Object>\[parameterTemplate)',
    multiLine: true,
    dotAll: true,
  );
}

class ClassExtensionMethod {
  static final RegExp name = RegExp(
    r'methodTemplate(?<=Future<Object>\s\$methodTemplate)',
    multiLine: true,
    dotAll: true,
  );

  static final String aParameter = 'String parameterTemplate';

  static final RegExp anUnpairedReference = RegExp(
    r'return.+?invokeRemoteMethod[^\}]+\}',
    multiLine: true,
    dotAll: true,
  );

  static final RegExp aPairedReference = RegExp(
    r'return.+?invokeRemoteMethodOnUnpairedReference.+;',
    multiLine: true,
    dotAll: true,
  );
}

class ClassExtensionMethodUnpairedReference {
  static final RegExp name = RegExp(
    r'methodTemplate(?=.*?<Object>)',
    multiLine: true,
    dotAll: true,
  );

  static final RegExp aParameterName = RegExp(
    r'parameterTemplate(?<=<Object>\[parameterTemplate)',
    multiLine: true,
    dotAll: true,
  );
}

class ClassExtensionMethodPairedReference {
  static final RegExp name = RegExp(
    r'methodTemplate(?=.*?<Object>)',
    multiLine: true,
    dotAll: true,
  );

  static final RegExp aParameterName = RegExp(
    r'parameterTemplate(?<=<Object>\[parameterTemplate)',
    multiLine: true,
    dotAll: true,
  );
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
  // final RegExp exp = RegExp(
  //   r'\$ClassTemplate: \(LocalReference localReference\)[^\}]+\}',
  //   multiLine: true,
  //   dotAll: true,
  // );

  CreationArgumentField get aField => CreationArgumentField(this);

  final RegExp className = TemplateRegExp.regExp(
    r'(?<=\$)ClassTemplate(?=:)',
  );

  // static final RegExp aField = RegExp(
  //   r'\(localReference as \$ClassTemplate\).fieldTemplate',
  //   multiLine: true,
  //   dotAll: true,
  // );
}

class CreationArgumentField with TemplateRegExp {
  CreationArgumentField(this.parent);

  @override
  final CreationArgument parent;

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'\(localReference as \$ClassTemplate\).fieldTemplate',
  );

  // final RegExp exp = RegExp(
  //   r'\(localReference as \$ClassTemplate\).fieldTemplate',
  //   multiLine: true,
  //   dotAll: true,
  // );

  final RegExp className = RegExp(
    r'ClassTemplate',
    multiLine: true,
    dotAll: true,
  );

  final RegExp name = RegExp(
    r'(?<=\.)fieldTemplate',
    multiLine: true,
    dotAll: true,
  );
}
