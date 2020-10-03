import 'package:reference_generator/src/ast.dart';

String generateDart(String template, LibraryNode libraryNode) {
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
      );
}

String getTrueTypeName(ReferenceType type) {
  if (type.codeGeneratedClass) return '\$${type.name}';
  return type.name;
}

class Library {
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
