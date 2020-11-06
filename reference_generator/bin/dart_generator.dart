import 'package:recase/recase.dart';
import 'package:reference_generator/src/ast.dart';

import 'common.dart';

String generateDart(String template, LibraryNode libraryNode) {
  final Library library = Library(template);
  return template
      .replaceAll(
        library.mixins,
        libraryNode.classes
            .map<String>(
              (ClassNode classNode) => library.aMixin
                  .stringMatch()
                  .replaceAll(library.aMixin.name, classNode.name)
                  .replaceAll(
                    library.aMixin.fields,
                    classNode.fields
                        .map<String>(
                          (FieldNode fieldNode) => library.aMixin.aField
                              .stringMatch()
                              .replaceAll(
                                  library.aMixin.aField.name, fieldNode.name)
                              .replaceAll(
                                library.aMixin.aField.type,
                                getTrueTypeName(fieldNode.type),
                              ),
                        )
                        .join('\n'),
                  )
                  .replaceAll(
                    library.aMixin.aMethod.exp,
                    classNode.methods
                        .map<String>(
                          (MethodNode methodNode) => library.aMixin.aMethod
                              .stringMatch()
                              .replaceAll(
                                library.aMixin.aMethod.returnType,
                                getTrueTypeName(methodNode.returnType),
                              )
                              .replaceAll(
                                library.aMixin.aMethod.name,
                                methodNode.name,
                              )
                              .replaceAll(
                                library.aMixin.aMethod.parameters,
                                methodNode.parameters
                                    .map<String>(
                                      (ParameterNode parameterNode) =>
                                          library.aMixin.aMethod.aParameter
                                              .stringMatch()
                                              .replaceAll(
                                                library.aMixin.aMethod
                                                    .aParameter.type,
                                                getTrueTypeName(
                                                  parameterNode.type,
                                                ),
                                              )
                                              .replaceAll(
                                                library.aMixin.aMethod
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
        library.creationArgs,
        libraryNode.classes
            .map<String>(
              (ClassNode classNode) => library.aCreationArgsClass
                  .stringMatch()
                  .replaceAll(
                    library.aCreationArgsClass.className,
                    classNode.name,
                  )
                  .replaceAll(
                    library.aCreationArgsClass.fields,
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
        library.channels,
        libraryNode.classes
            .map<String>(
              (ClassNode classNode) => library.aChannel
                  .stringMatch()
                  .replaceAll(
                    library.aChannel.className,
                    classNode.name,
                  )
                  .replaceAll(
                    library.aChannel.typeArgumentClassName,
                    classNode.name,
                  )
                  .replaceAll(
                    library.aChannel.constructorClassName,
                    classNode.name,
                  )
                  .replaceAll(
                    library.aChannel.channel,
                    classNode.channelName,
                  )
                  .replaceAll(
                    library.aChannel.aStaticMethod.exp,
                    classNode.staticMethods
                        .map<String>(
                          (MethodNode methodNode) => library
                              .aChannel.aStaticMethod
                              .stringMatch()
                              .replaceAll(
                                library.aChannel.aStaticMethod.name,
                                ReCase(methodNode.name).pascalCase,
                              )
                              .replaceAll(
                                library.aChannel.aStaticMethod.nameAsParameter,
                                methodNode.name,
                              )
                              .replaceAll(
                                library.aChannel.aStaticMethod.parameters,
                                methodNode.parameters
                                    .map<String>(
                                      (ParameterNode parameterNode) => library
                                          .aChannel.aStaticMethod.aParameter
                                          .stringMatch()
                                          .replaceAll(
                                            library.aChannel.aStaticMethod
                                                .aParameter.name,
                                            parameterNode.name,
                                          )
                                          .replaceAll(
                                            library.aChannel.aStaticMethod
                                                .aParameter.type,
                                            getTrueTypeName(parameterNode.type),
                                          ),
                                    )
                                    .join(', '),
                              )
                              .replaceAll(
                                library
                                    .aChannel.aStaticMethod.channelParameters,
                                methodNode.parameters
                                    .map<String>(
                                      (ParameterNode parameterNode) =>
                                          parameterNode.type.hasReferenceChannel
                                              ? library.aChannel.aStaticMethod
                                                  .aParameterReference
                                                  .stringMatch()
                                                  .replaceAll(
                                                    library
                                                        .aChannel
                                                        .aStaticMethod
                                                        .aParameterReference
                                                        .name,
                                                    parameterNode.name,
                                                  )
                                                  .replaceAll(
                                                    library
                                                        .aChannel
                                                        .aStaticMethod
                                                        .aParameterReference
                                                        .channel,
                                                    parameterNode
                                                        .type.referenceChannel,
                                                  )
                                              : library.aChannel.aStaticMethod
                                                  .aParameterName
                                                  .stringMatch()
                                                  .replaceAll(
                                                    library
                                                        .aChannel
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
                    library.aChannel.aMethod.exp,
                    classNode.methods
                        .map<String>(
                          (MethodNode methodNode) => library.aChannel.aMethod
                              .stringMatch()
                              .replaceAll(
                                library.aChannel.aMethod.name,
                                ReCase(methodNode.name).pascalCase,
                              )
                              .replaceAll(
                                library.aChannel.aMethod.channelMethodName,
                                methodNode.name,
                              )
                              .replaceAll(
                                library.aChannel.aMethod.instanceClassName,
                                classNode.name,
                              )
                              .replaceAll(
                                library.aChannel.aMethod.parameters,
                                methodNode.parameters
                                    .map<String>(
                                      (ParameterNode parameterNode) => library
                                          .aChannel.aMethod.aParameter
                                          .stringMatch()
                                          .replaceAll(
                                            library.aChannel.aMethod.aParameter
                                                .name,
                                            parameterNode.name,
                                          )
                                          .replaceAll(
                                            library.aChannel.aMethod.aParameter
                                                .type,
                                            getTrueTypeName(parameterNode.type),
                                          ),
                                    )
                                    .join(', '),
                              )
                              .replaceAll(
                                library.aChannel.aMethod.channelParameters,
                                methodNode.parameters
                                    .map<String>(
                                      (ParameterNode parameterNode) =>
                                          parameterNode.type.hasReferenceChannel
                                              ? library.aChannel.aMethod
                                                  .aParameterReference
                                                  .stringMatch()
                                                  .replaceAll(
                                                    library
                                                        .aChannel
                                                        .aMethod
                                                        .aParameterReference
                                                        .name,
                                                    parameterNode.name,
                                                  )
                                                  .replaceAll(
                                                    library
                                                        .aChannel
                                                        .aMethod
                                                        .aParameterReference
                                                        .channel,
                                                    parameterNode
                                                        .type.referenceChannel,
                                                  )
                                              : library.aChannel.aMethod
                                                  .aParameterName
                                                  .stringMatch()
                                                  .replaceAll(
                                                    library.aChannel.aMethod
                                                        .aParameterName.name,
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
        library.handlers,
        libraryNode.classes
            .map<String>(
              (ClassNode classNode) => library.aHandler
                  .stringMatch()
                  .replaceAll(library.aHandler.className, classNode.name)
                  .replaceAll(library.aHandler.typeArgClassName, classNode.name)
                  .replaceAll(
                    library.aHandler.constructorClassName,
                    classNode.name,
                  )
                  .replaceAll(
                    library.aHandler.onDisposeClassName,
                    classNode.name,
                  )
                  .replaceAll(
                    library.aHandler.aStaticMethodName.exp,
                    classNode.staticMethods
                        .map<String>(
                          (MethodNode methodNode) => library
                              .aHandler.aStaticMethodName
                              .stringMatch()
                              .replaceAll(
                                library.aHandler.aStaticMethodName.name,
                                methodNode.name,
                              ),
                        )
                        .join(','),
                  )
                  .replaceAll(
                    library.aHandler.aOnCreateMethod.exp,
                    library.aHandler.aOnCreateMethod
                        .stringMatch()
                        .replaceAll(
                          library.aHandler.aOnCreateMethod.returnType,
                          classNode.name,
                        )
                        .replaceAll(
                          library
                              .aHandler.aOnCreateMethod.creationArgsClassName,
                          classNode.name,
                        ),
                  )
                  .replaceAll(
                    library.aHandler.aStaticMethod.exp,
                    classNode.staticMethods
                        .map<String>(
                          (MethodNode methodNode) => library
                              .aHandler.aStaticMethod
                              .stringMatch()
                              .replaceAll(
                                library.aHandler.aStaticMethod.name,
                                ReCase(methodNode.name).pascalCase,
                              )
                              .replaceAll(
                                library.aHandler.aStaticMethod.returnType,
                                getTrueTypeName(methodNode.returnType),
                              )
                              .replaceAll(
                                library.aHandler.aStaticMethod.parameters,
                                methodNode.parameters
                                    .map<String>(
                                      (ParameterNode parameterNode) => library
                                          .aHandler.aStaticMethod.aParameter
                                          .stringMatch()
                                          .replaceAll(
                                            library.aHandler.aStaticMethod
                                                .aParameter.name,
                                            parameterNode.name,
                                          )
                                          .replaceAll(
                                            library.aHandler.aStaticMethod
                                                .aParameter.type,
                                            getTrueTypeName(parameterNode.type),
                                          ),
                                    )
                                    .join(', '),
                              ),
                        )
                        .join(','),
                  )
                  .replaceAll(
                    library.aHandler.aStaticMethodInvoker.exp,
                    classNode.staticMethods.map<String>(
                      (MethodNode methodNode) {
                        final HandlerStaticMethodInvoker invoker =
                            library.aHandler.aStaticMethodInvoker;
                        return invoker
                            .stringMatch()
                            .replaceAll(invoker.methodName, methodNode.name)
                            .replaceAll(
                              invoker.methodHandler,
                              ReCase(methodNode.name).pascalCase,
                            );
                      },
                    ).join('\n'),
                  )
                  .replaceAll(
                    library.aHandler.theCreationArguments.exp,
                    library.aHandler.theCreationArguments
                        .stringMatch()
                        .replaceAll(
                          library.aHandler.theCreationArguments.className,
                          classNode.name,
                        )
                        .replaceAll(
                          library.aHandler.theCreationArguments.fields,
                          classNode.fields
                              .map<String>(
                                (FieldNode fieldNode) =>
                                    fieldNode.type.hasReferenceChannel
                                        ? library.aHandler.theCreationArguments
                                            .aFieldReference
                                            .stringMatch()
                                            .replaceAll(
                                              library
                                                  .aHandler
                                                  .theCreationArguments
                                                  .aFieldReference
                                                  .name,
                                              fieldNode.name,
                                            )
                                            .replaceAll(
                                              library
                                                  .aHandler
                                                  .theCreationArguments
                                                  .aFieldReference
                                                  .channel,
                                              fieldNode.type.referenceChannel,
                                            )
                                        : library.aHandler.theCreationArguments
                                            .aFieldName
                                            .stringMatch()
                                            .replaceAll(
                                              library
                                                  .aHandler
                                                  .theCreationArguments
                                                  .aFieldName
                                                  .name,
                                              fieldNode.name,
                                            ),
                              )
                              .join(', '),
                        ),
                  ),
            )
            .join(''),
      );
  // .replaceAll(
  //   library.handlers,
  //   library.aHandler.exp
  //       .stringMatch(template)
  //       .replaceAll(
  //         library.aHandler.aCreatorName.exp,
  //         libraryNode.classes
  //             .map<String>(
  //               (ClassNode classNode) => library.aLocalHandler.aCreatorName
  //                   .stringMatch()
  //                   .replaceAll(
  //                     library.aLocalHandler.aCreatorName.name,
  //                     classNode.name,
  //                   ),
  //             )
  //             .join(', '),
  //       )
  //       .replaceAll(
  //         library.aLocalHandler.aStaticMethodName.exp,
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
  //               (MapEntry<MethodNode, ClassNode> entry) =>
  //                   library.aLocalHandler.aStaticMethodName
  //                       .stringMatch()
  //                       .replaceAll(
  //                         library.aLocalHandler.aStaticMethodName.className,
  //                         ReCase(entry.value.name).camelCase,
  //                       )
  //                       .replaceAll(
  //                         library.aLocalHandler.aStaticMethodName.name,
  //                         entry.key.name,
  //                       ),
  //             )
  //             .join(','),
  //       )
  //       .replaceAll(
  //         library.aLocalHandler.aCreator.exp,
  //         libraryNode.classes
  //             .map<String>(
  //               (ClassNode classNode) => library.aLocalHandler.aCreator
  //                   .stringMatch()
  //                   .replaceAll(
  //                     library.aLocalHandler.aCreator.className,
  //                     classNode.name,
  //                   )
  //                   .replaceAll(
  //                     library.aLocalHandler.aCreator.argument.exp,
  //                     List<int>.generate(
  //                             classNode.fields.length, (int index) => index)
  //                         .map<String>(
  //                           (int index) =>
  //                               library.aLocalHandler.aCreator.argument
  //                                   .stringMatch()
  //                                   .replaceAll(
  //                                     library.aLocalHandler.aCreator
  //                                         .argument.fieldName,
  //                                     classNode.fields[index].name,
  //                                   )
  //                                   .replaceAll(
  //                                     library.aLocalHandler.aCreator
  //                                         .argument.argumentIndex,
  //                                     '$index',
  //                                   ),
  //                         )
  //                         .join(),
  //                   ),
  //             )
  //             .join(', '),
  //       )
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
  //                                       library
  //                                           .aLocalHandler
  //                                           .anInvokeMethodCondition
  //                                           .aMethod
  //                                           .returnValue,
  //                                       methodNode.returnType.name == 'void'
  //                                           ? ''
  //                                           : 'return ')
  //                                   .replaceAll(
  //                                       library
  //                                           .aLocalHandler
  //                                           .anInvokeMethodCondition
  //                                           .aMethod
  //                                           .colonAfterMethod,
  //                                       methodNode.returnType.name == 'void'
  //                                           ? ';return null;'
  //                                           : ';')
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
  // );
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
  //                   .map<String>((FieldNode fieldNode) =>
  //                       library.aCreationArgument.aField
  //                           .stringMatch()
  //                           .replaceAll(
  //                             library.aCreationArgument.aField.className,
  //                             classNode.name,
  //                           )
  //                           .replaceAll(
  //                             library.aCreationArgument.aField.name,
  //                             fieldNode.name,
  //                           ))
  //                   .join(','),
  //             ),
  //       )
  //       .join(','),
  // );
}

String getTrueTypeName(ReferenceType type) {
  final Iterable<String> typeArguments = type.typeArguments.map<String>(
    (ReferenceType type) => getTrueTypeName(type),
  );

  if (type.codeGeneratedClass && typeArguments.isEmpty) {
    return '\$${type.name}';
  } else if (type.codeGeneratedClass && typeArguments.isNotEmpty) {
    return '\$${type.name}<${typeArguments.join(',')}>';
  } else if (!type.codeGeneratedClass && typeArguments.isNotEmpty) {
    return '${type.name}<${typeArguments.join(',')}>';
  }

  return type.name;
}

class Library with TemplateRegExp {
  Library(this.template);

  @override
  final String template;

  @override
  RegExp get exp => null;

  @override
  TemplateRegExp get parent => null;

  final RegExp mixins = TemplateRegExp.regExp(
    r'mixin \$ClassTemplate \{[^\}]+\}[^\}]+\}',
  );

  final RegExp channels = TemplateRegExp.regExp(
    r'class \$ClassTemplateChannel.*}(?=\s*class \$ClassTemplateHandler)',
  );

  final RegExp creationArgs = TemplateRegExp.regExp(
    r'class \$ClassTemplateCreationArgs.*}(?=\s*class \$ClassTemplateChannel)',
  );

  final RegExp handlers = TemplateRegExp.regExp(
    r'class \$ClassTemplateHandler.*$',
  );

  Mixin get aMixin => Mixin(this);

  CreationArgsClass get aCreationArgsClass => CreationArgsClass(this);

  Channel get aChannel => Channel(this);

  // Manager get aManager => Manager(this);

  Handler get aHandler => Handler(this);

  // CreationArgument get aCreationArgument => CreationArgument(this);
}

class Mixin with TemplateRegExp {
  Mixin(this.parent);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'mixin \$ClassTemplate \{[^\}]+\}',
  );

  @override
  final Library parent;

  final RegExp name = TemplateRegExp.regExp(r'(?<=mixin \$)ClassTemplate');
  final RegExp fields = TemplateRegExp.regExp(r'int get fieldTemplate;[^;]+;');

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
  final Mixin parent;
}

class ClassMethod with TemplateRegExp {
  ClassMethod(this.parent);

  final RegExp returnType = TemplateRegExp.regExp(r'^Future<String>');

  final RegExp name = TemplateRegExp.regExp(r'methodTemplate');

  final RegExp parameters = TemplateRegExp.regExp(
    r'String parameterTemplate, \$ClassTemplate2 referenceParameterTemplate',
  );

  Parameter get aParameter => Parameter(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'Future<String> methodTemplate\([^;]+;',
  );

  @override
  final Mixin parent;
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

  final RegExp fields = TemplateRegExp.regExp(r'int fieldTemplate;[^;]+;');

  CreationArgsClassField get aField => CreationArgsClassField(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'class \$ClassTemplateCreationArgs[^\}]+\}',
  );

  @override
  final Library parent;
}

class CreationArgsClassField with TemplateRegExp {
  CreationArgsClassField(this.parent);

  final RegExp type = TemplateRegExp.regExp(r'^int');
  final RegExp name = TemplateRegExp.regExp(r'fieldTemplate(?=;)');

  @override
  final RegExp exp = TemplateRegExp.regExp(r'int fieldTemplate;');

  @override
  final CreationArgsClass parent;
}

class Channel with TemplateRegExp {
  Channel(this.parent);

  final RegExp className = TemplateRegExp.regExp(
    r'(?<=class \$)ClassTemplate',
  );

  final RegExp typeArgumentClassName = TemplateRegExp.regExp(
    r'(?<=extends ReferenceChannel<\$)ClassTemplate',
  );

  final RegExp constructorClassName = TemplateRegExp.regExp(
    r'(?<=\$)ClassTemplate(?=Channel\()',
  );

  final RegExp channel = TemplateRegExp.regExp(
    r"(?<=super\(manager, ')github\.penguin/template/template/ClassTemplate",
  );

  ChannelStaticMethod get aStaticMethod => ChannelStaticMethod(this);

  ChannelMethod get aMethod => ChannelMethod(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'class \$ClassTemplateChannel.*}(?=\s*class \$ClassTemplate2Channel)',
  );

  @override
  final Library parent;
}

class ChannelStaticMethod with TemplateRegExp {
  ChannelStaticMethod(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'StaticMethodTemplate');

  final RegExp nameAsParameter = TemplateRegExp.regExp(r'staticMethodTemplate');

  final RegExp parameters = TemplateRegExp.regExp(
    r'String parameterTemplate, \$ClassTemplate2 referenceParameterTemplate',
  );

  final RegExp channelParameters = TemplateRegExp.regExp(
    r'(?<=\[\s*)parameterTemplate[^\)]+\)',
  );

  Parameter get aParameter => Parameter(this);

  ParameterName get aParameterName => ParameterName(this);

  ParameterReference get aParameterReference => ParameterReference(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'Future<Object> \$invokeStaticMethodTemplate[^\}]+\}',
  );

  @override
  final Channel parent;
}

class ChannelMethod with TemplateRegExp {
  ChannelMethod(this.parent);

  final RegExp name = TemplateRegExp.regExp(
    r'(?<=Future<Object>\s\$invoke)MethodTemplate',
  );

  final RegExp instanceClassName = TemplateRegExp.regExp(
    r'(?<=\$)ClassTemplate(?= instance)',
  );

  final RegExp channelMethodName = TemplateRegExp.regExp(
    r"(?<=')methodTemplate(?=')",
  );

  final RegExp parameters = TemplateRegExp.regExp(
    r'String parameterTemplate, \$ClassTemplate2 referenceParameterTemplate',
  );

  final RegExp channelParameters = TemplateRegExp.regExp(
    r'(?<=\[\s*)parameterTemplate[^\)]+\)',
  );

  Parameter get aParameter => Parameter(this);

  ParameterName get aParameterName => ParameterName(this);

  ParameterReference get aParameterReference => ParameterReference(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'Future<Object>\s\$invokeMethodTemplate[^\}]+\}[^\}]+\}',
  );

  @override
  final Channel parent;
}

class ParameterName with TemplateRegExp {
  ParameterName(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'parameterTemplate');

  @override
  final RegExp exp =
      TemplateRegExp.regExp(r'(?<=<Object>\[\s*)parameterTemplate');

  @override
  final TemplateRegExp parent;
}

class ParameterReference with TemplateRegExp {
  ParameterReference(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'referenceParameterTemplate');

  final RegExp channel = TemplateRegExp.regExp(
    r'github\.penguin/template/template/ClassTemplate2',
  );

  @override
  final RegExp exp = TemplateRegExp.regExp(r'_replaceIfUnpaired\([^\)]+\)');

  @override
  final TemplateRegExp parent;
}

class Handler with TemplateRegExp {
  Handler(this.parent);

  final RegExp className = TemplateRegExp.regExp(
    r'(?<=class \$)ClassTemplate(?=Handler)',
  );

  final RegExp typeArgClassName = TemplateRegExp.regExp(
    r'(?<=ReferenceChannelHandler<\$)ClassTemplate',
  );

  final RegExp constructorClassName = TemplateRegExp.regExp(
    r'(?<=\$)ClassTemplate(?=Handler\()',
  );

  final RegExp onDisposeClassName = TemplateRegExp.regExp(
    r'ClassTemplate(?= instance)\s+onDispose;',
  );

  HandlerStaticMethodName get aStaticMethodName =>
      HandlerStaticMethodName(this);

  HandlerOnCreateMethod get aOnCreateMethod => HandlerOnCreateMethod(this);

  HandlerStaticMethod get aStaticMethod => HandlerStaticMethod(this);

  HandlerStaticMethodInvoker get aStaticMethodInvoker =>
      HandlerStaticMethodInvoker(this);

  HandlerCreationArguments get theCreationArguments =>
      HandlerCreationArguments(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'class \$ClassTemplateHandler.*}(?=\s+class \$ClassTemplate2Handler)',
  );

  @override
  final Library parent;
}

class HandlerStaticMethodName with TemplateRegExp {
  HandlerStaticMethodName(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'StaticMethodTemplate');

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'this\.\$onStaticMethodTemplate',
  );

  @override
  final Handler parent;
}

class HandlerOnCreateMethod with TemplateRegExp {
  HandlerOnCreateMethod(this.parent);

  final RegExp returnType =
      TemplateRegExp.regExp(r'(?<=final \$)ClassTemplate');

  final RegExp creationArgsClassName =
      TemplateRegExp.regExp(r'(?<=\$)ClassTemplate(?=CreationArgs args)');

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'final \$ClassTemplate Function.*onCreate;',
  );

  @override
  final Handler parent;
}

class HandlerStaticMethod with TemplateRegExp {
  HandlerStaticMethod(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'StaticMethodTemplate(?=;)');

  final RegExp returnType = TemplateRegExp.regExp(r'(?<=final )double');

  final RegExp parameters = TemplateRegExp.regExp(
    r'String parameterTemplate,\s+\$ClassTemplate2 referenceParameterTemplate',
  );

  Parameter get aParameter => Parameter(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'final double Function.*\$onStaticMethodTemplate;',
  );

  @override
  final Handler parent;
}

class HandlerStaticMethodInvoker with TemplateRegExp {
  HandlerStaticMethodInvoker(this.parent);

  final RegExp methodName = TemplateRegExp.regExp(
    r"(?<=')staticMethodTemplate(?=')",
  );

  final RegExp methodHandler = TemplateRegExp.regExp(
    r'(?<=\$on)StaticMethodTemplate',
  );

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r"case 'staticMethodTemplate'[^;]+;",
  );

  @override
  final Handler parent;
}

class HandlerCreationArguments with TemplateRegExp {
  HandlerCreationArguments(this.parent);

  final RegExp className = TemplateRegExp.regExp(
    r'(?<=\$)ClassTemplate(?= instance,)',
  );

  final RegExp fields = TemplateRegExp.regExp(
    r'(?<=\[\s*)instance\.fieldTemplate[^\)]+\)',
  );

  HandlerCreationArgumentsFieldName get aFieldName =>
      HandlerCreationArgumentsFieldName(this);

  HandlerCreationArgumentsFieldReference get aFieldReference =>
      HandlerCreationArgumentsFieldReference(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'getCreationArguments[^\}]+\}',
  );

  @override
  final Handler parent;
}

class HandlerCreationArgumentsFieldName with TemplateRegExp {
  HandlerCreationArgumentsFieldName(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'fieldTemplate');

  @override
  final RegExp exp =
      TemplateRegExp.regExp(r'(?<=<Object>\[\s*)instance\.fieldTemplate');

  @override
  final HandlerCreationArguments parent;
}

class HandlerCreationArgumentsFieldReference with TemplateRegExp {
  HandlerCreationArgumentsFieldReference(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'referenceParameterTemplate');

  final RegExp channel = TemplateRegExp.regExp(
    r'github\.penguin/template/template/ClassTemplate2',
  );

  @override
  final RegExp exp = TemplateRegExp.regExp(r'_replaceIfUnpaired\([^\)]+\)');

  @override
  final HandlerCreationArguments parent;
}

//
// class LocalHandlerCreator with TemplateRegExp {
//   LocalHandlerCreator(this.parent);
//
//   final RegExp className = TemplateRegExp.regExp(r'ClassTemplate');
//
//   LocalHandlerCreatorCreationArgs get argument =>
//       LocalHandlerCreatorCreationArgs(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'\$ClassTemplate[^\}]+createClassTemplate\([^\}]+}',
//   );
//
//   @override
//   final Handler parent;
// }
//
// class LocalHandlerCreatorCreationArgs with TemplateRegExp {
//   LocalHandlerCreatorCreationArgs(this.parent);
//
//   final RegExp fieldName = TemplateRegExp.regExp(r'fieldTemplate');
//   final RegExp argumentIndex = TemplateRegExp.regExp(r'\d+(?=\])');
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'\.\.fieldTemplate = arguments\[0\]',
//   );
//
//   @override
//   final LocalHandlerCreator parent;
// }
//
// class LocalHandlerStaticMethod with TemplateRegExp {
//   LocalHandlerStaticMethod(this.parent);
//
//   final RegExp className = TemplateRegExp.regExp(r'ClassTemplate');
//
//   LocalHandlerStaticMethodMethod get aMethod =>
//       LocalHandlerStaticMethodMethod(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'\$ClassTemplate[^\}]+classTemplate\$staticMethodTemplate\([^\}]+}[^\}]+}',
//   );
//
//   @override
//   final Handler parent;
// }
//
// class LocalHandlerStaticMethodMethod with TemplateRegExp {
//   LocalHandlerStaticMethodMethod(this.parent);
//
//   final RegExp methodName = TemplateRegExp.regExp(r'staticMethodTemplate');
//   final RegExp classNamePart = TemplateRegExp.regExp(r'classTemplate');
//   final RegExp argument = TemplateRegExp.regExp(r'arguments\[0\]');
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(r"'staticMethodTemplate'[^\}]+}");
//
//   @override
//   final LocalHandlerStaticMethod parent;
// }
//
// class LocalHandlerMethod with TemplateRegExp {
//   LocalHandlerMethod(this.parent);
//
//   final RegExp className = TemplateRegExp.regExp(r'ClassTemplate(?=:)');
//
//   LocalHandlerMethodMethod get aMethod => LocalHandlerMethodMethod(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'\$ClassTemplate[^<]+<String, _\$LocalMethodHandler>[^\}]+}[^\}]+}',
//   );
//
//   @override
//   final Handler parent;
// }
//
// class LocalHandlerMethodMethod with TemplateRegExp {
//   LocalHandlerMethodMethod(this.parent);
//
//   final RegExp methodName = TemplateRegExp.regExp(r'methodTemplate');
//   final RegExp className = TemplateRegExp.regExp(r'ClassTemplate(?=\))');
//   final RegExp argument = TemplateRegExp.regExp(r'arguments\[0\]');
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(r"'methodTemplate'[^\}]+}");
//
//   @override
//   final LocalHandlerMethod parent;
// }
//
// class LocalHandlerStaticMethodField with TemplateRegExp {
//   LocalHandlerStaticMethodField(this.parent);
//
//   final RegExp className = TemplateRegExp.regExp(r'classTemplate');
//   final RegExp name = TemplateRegExp.regExp(r'staticMethodTemplate');
//
//   Parameter get aParameter => Parameter(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'final[^;]+classTemplate\$staticMethodTemplate;',
//   );
//
//   @override
//   final Handler parent;
// }
//
// class LocalHandlerCreatorField with TemplateRegExp {
//   LocalHandlerCreatorField(this.parent);
//
//   final RegExp className = TemplateRegExp.regExp(r'ClassTemplate');
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(r'final[^;]+createClassTemplate;');
//
//   @override
//   final Handler parent;
// }
//
// class LocalHandlerInvokeMethodCondition with TemplateRegExp {
//   LocalHandlerInvokeMethodCondition(this.parent);
//
//   final RegExp className = TemplateRegExp.regExp(r'ClassTemplate');
//
//   LocalHandlerInvokeMethodConditionMethod get aMethod =>
//       LocalHandlerInvokeMethodConditionMethod(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'if\s\(localReference\sis\s\$ClassTemplate\)[^\}]+}[^\}]+}',
//   );
//
//   @override
//   final Handler parent;
// }
//
// class LocalHandlerInvokeMethodConditionMethod with TemplateRegExp {
//   LocalHandlerInvokeMethodConditionMethod(this.parent);
//
//   final RegExp name = TemplateRegExp.regExp(r'methodTemplate');
//   final RegExp argument = TemplateRegExp.regExp(r'arguments\[0\]');
//   final RegExp returnValue = TemplateRegExp.regExp(r'return ');
//   final RegExp colonAfterMethod = TemplateRegExp.regExp(r';');
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(r"case\s'methodTemplate'[^\)]+\);");
//
//   @override
//   final LocalHandlerInvokeMethodCondition parent;
// }

// class CreationArgument with TemplateRegExp {
//   CreationArgument(this.parent);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'\$ClassTemplate: \(LocalReference localReference\)[^\}]+\}',
//   );
//
//   @override
//   final Library parent;
//
//   CreationArgumentField get aField => CreationArgumentField(this);
//
//   final RegExp className = TemplateRegExp.regExp(
//     r'(?<=\$)ClassTemplate(?=:)',
//   );
// }
//
// class CreationArgumentField with TemplateRegExp {
//   CreationArgumentField(this.parent);
//
//   final RegExp className = TemplateRegExp.regExp(r'ClassTemplate');
//   final RegExp name = TemplateRegExp.regExp(r'(?<=\.)fieldTemplate');
//
//   @override
//   final CreationArgument parent;
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'\(localReference as \$ClassTemplate\).fieldTemplate',
//   );
// }
