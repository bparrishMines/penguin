import 'package:recase/recase.dart';
import 'package:reference_generator/src/ast.dart';

import 'common.dart';

String generateJava({
  String template,
  LibraryNode libraryNode,
  String libraryName,
  String package,
}) {
  final Library library = Library(template);
  return library
      .stringMatch()
      .replaceAll(library.name, libraryName)
      .replaceAll(library.package, package)
      .replaceAll(
        library.interfaces,
        libraryNode.classes.map<String>((ClassNode classNode) {
          final Interface anInterface = library.anInterface;
          return anInterface
              .stringMatch()
              .replaceAll(anInterface.name, classNode.name)
              .replaceAll(
                anInterface.fields,
                classNode.fields.map<String>((FieldNode fieldNode) {
                  final InterfaceField aField = anInterface.aField;
                  return aField
                      .stringMatch()
                      .replaceAll(aField.name, fieldNode.name.pascalCase)
                      .replaceAll(
                        aField.type,
                        getTrueTypeName(fieldNode.type),
                      );
                }).join('\n'),
              )
              .replaceAll(
                anInterface.aMethod.exp,
                classNode.methods.map<String>((MethodNode methodNode) {
                  final InterfaceMethod aMethod = anInterface.aMethod;
                  return aMethod
                      .stringMatch()
                      .replaceAll(aMethod.name, methodNode.name)
                      .replaceAll(
                        aMethod.parameters,
                        methodNode.parameters
                            .map<String>((ParameterNode parameterNode) {
                          final Parameter aParameter = aMethod.aParameter;
                          return aParameter
                              .stringMatch()
                              .replaceAll(aParameter.name, parameterNode.name)
                              .replaceAll(
                                aParameter.type,
                                getTrueTypeName(parameterNode.type),
                              );
                        }).join(','),
                      );
                }).join('\n'),
              );
        }).join('\n'),
      )
      .replaceAll(
        library.creationArgs,
        libraryNode.classes.map<String>((ClassNode classNode) {
          final CreationArgsClass aCreationArgsClass =
              library.aCreationArgsClass;
          return aCreationArgsClass
              .stringMatch()
              .replaceAll(
                aCreationArgsClass.className,
                classNode.name,
              )
              .replaceAll(
                aCreationArgsClass.fields,
                classNode.fields.map<String>((FieldNode fieldNode) {
                  final CreationArgsClassField aField =
                      aCreationArgsClass.aField;
                  return aField
                      .stringMatch()
                      .replaceAll(aField.name, fieldNode.name)
                      .replaceAll(
                        aField.type,
                        getTrueTypeName(fieldNode.type),
                      );
                }).join('\n'),
              );
        }).join('\n\n'),
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
                                methodNode.name.pascalCase,
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
                                methodNode.name.pascalCase,
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
                                    .join(' '),
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
          libraryNode.classes.map<String>((ClassNode classNode) {
            final Handler handler = library.aHandler;
            return handler
                .stringMatch()
                .replaceAll(handler.className, classNode.name)
                .replaceAll(handler.typeArgClassName, classNode.name)
                .replaceAll(
                  handler.onInstanceDisposedClassName,
                  classNode.name,
                )
                .replaceAll(handler.onInstanceDisposedClassName, classNode.name)
                .replaceAll(
                  handler.theOnCreateMethod.exp,
                  handler.theOnCreateMethod
                      .stringMatch()
                      .replaceAll(
                        handler.theOnCreateMethod.returnType,
                        classNode.name,
                      )
                      .replaceAll(
                        handler.theOnCreateMethod.creationArgsClassName,
                        classNode.name,
                      ),
                )
                .replaceAll(
                  handler.aStaticMethod.exp,
                  classNode.staticMethods.map<String>((MethodNode methodNode) {
                    final HandlerStaticMethod staticMethod =
                        handler.aStaticMethod;
                    return staticMethod
                        .stringMatch()
                        .replaceAll(
                          staticMethod.name,
                          methodNode.name.pascalCase,
                        )
                        .replaceAll(
                          staticMethod.parameters,
                          methodNode.parameters
                              .map<String>((ParameterNode parameterNode) {
                            final FollowingParameter parameter =
                                staticMethod.aParameter;
                            return parameter
                                .stringMatch()
                                .replaceAll(parameter.name, parameterNode.name)
                                .replaceAll(
                                  parameter.type,
                                  getTrueTypeName(parameterNode.type),
                                );
                          }).join(' '),
                        );
                  }).join('\n'),
                )
                .replaceAll(
                    handler.aStaticMethodInvoker.exp,
                    classNode.staticMethods
                        .map<String>((MethodNode methodNode) {
                      final HandlerStaticMethodInvoker staticMethodInvoker =
                          handler.aStaticMethodInvoker;
                      return staticMethodInvoker
                          .stringMatch()
                          .replaceAll(
                            staticMethodInvoker.methodName,
                            methodNode.name,
                          )
                          .replaceAll(
                            staticMethodInvoker.methodHandler,
                            methodNode.name.pascalCase,
                          )
                          .replaceAll(
                            staticMethodInvoker.arguments,
                            incrementingList(
                              methodNode.parameters.length,
                            ).map<String>(
                              (int index) {
                                final HandlerStaticMethodInvokerArgument
                                    argument = staticMethodInvoker.anArgument;
                                return argument
                                    .stringMatch()
                                    .replaceAll(
                                      argument.type,
                                      getTrueTypeName(
                                        methodNode.parameters[index].type,
                                      ),
                                    )
                                    .replaceAll(
                                      argument.index,
                                      index.toString(),
                                    );
                              },
                            ).join(','),
                          );
                    }).join('\n'))
                .replaceAll(
                  handler.theCreationArguments.exp,
                  handler.theCreationArguments
                      .stringMatch()
                      .replaceAll(handler.theCreationArguments.className,
                          classNode.name)
                      .replaceAll(
                        handler.theCreationArguments.fields,
                        classNode.fields.map<String>((FieldNode fieldNode) {
                          final HandlerCreationArguments arguments =
                              handler.theCreationArguments;
                          return fieldNode.type.hasReferenceChannel
                              ? arguments.aFieldReference
                                  .stringMatch()
                                  .replaceAll(
                                    arguments.aFieldReference.name,
                                    fieldNode.name.pascalCase,
                                  )
                                  .replaceAll(
                                    arguments.aFieldReference.channel,
                                    fieldNode.type.referenceChannel,
                                  )
                              : arguments.aFieldName.stringMatch().replaceAll(
                                    arguments.aFieldName.name,
                                    fieldNode.name.pascalCase,
                                  );
                        }).join(','),
                      ),
                )
                .replaceAll(
                  handler.theCreateInstance.exp,
                  handler.theCreateInstance
                      .stringMatch()
                      .replaceAll(
                        handler.theCreateInstance.className,
                        classNode.name,
                      )
                      .replaceAll(handler.theCreateInstance.returnTypeClassName,
                          classNode.name)
                      .replaceAll(
                        handler.theCreateInstance.argsClassName,
                        classNode.name,
                      )
                      .replaceAll(
                        handler.theCreateInstance.fields,
                        incrementingList(classNode.fields.length)
                            .map<String>((int index) {
                          final HandlerCreateInstanceField field =
                              handler.theCreateInstance.aField;
                          return field
                              .stringMatch()
                              .replaceAll(
                                field.name,
                                classNode.fields[index].name,
                              )
                              .replaceAll(
                                field.type,
                                getTrueTypeName(
                                  classNode.fields[index].type,
                                ),
                              )
                              .replaceAll(
                                field.index,
                                index.toString(),
                              );
                        }).join('\n'),
                      ),
                )
                .replaceAll(
                  handler.theInvokeMethod.exp,
                  handler.theInvokeMethod
                      .stringMatch()
                      .replaceAll(
                        handler.theInvokeMethod.instanceClassName,
                        classNode.name,
                      )
                      .replaceAll(
                        handler.theInvokeMethod.forLoopClassName,
                        classNode.name,
                      ),
                );
          }).join('\n'));
  // .replaceAll(
  //   library.aClass.exp,
  //   libraryNode.classes
  //       .map<String>(
  //         (ClassNode classNode) => library.aClass
  //             .stringMatch()
  //             .replaceAll(library.aClass.name, classNode.name)
  //             .replaceAll(library.aClass.referenceClass, classNode.name)
  //             .replaceAll(
  //               library.aClass.aField.exp,
  //               classNode.fields
  //                   .map<String>(
  //                     (FieldNode fieldNode) => library.aClass.aField
  //                         .stringMatch()
  //                         .replaceAll(library.aClass.aField.name,
  //                             ReCase(fieldNode.name).pascalCase)
  //                         .replaceAll(
  //                           library.aClass.aField.type,
  //                           getTrueTypeName(fieldNode.type),
  //                         ),
  //                   )
  //                   .join('\n'),
  //             )
  //             .replaceAll(
  //               library.aClass.aMethod.exp,
  //               classNode.methods
  //                   .map<String>(
  //                     (MethodNode methodNode) => library.aClass.aMethod
  //                         .stringMatch()
  //                         .replaceAll(
  //                           library.aClass.aMethod.name,
  //                           methodNode.name,
  //                         )
  //                         .replaceAll(
  //                           library.aClass.aMethod.aParameter.exp,
  //                           methodNode.parameters
  //                               .map<String>(
  //                                 (ParameterNode parameterNode) => library
  //                                     .aClass.aMethod.aParameter
  //                                     .stringMatch()
  //                                     .replaceAll(
  //                                       library
  //                                           .aClass.aMethod.aParameter.type,
  //                                       getTrueTypeName(parameterNode.type),
  //                                     )
  //                                     .replaceAll(
  //                                       library
  //                                           .aClass.aMethod.aParameter.name,
  //                                       parameterNode.name,
  //                                     ),
  //                               )
  //                               .join(', '),
  //                         ),
  //                   )
  //                   .join('\n\n'),
  //             )
  //             .replaceAll(
  //               library.aClass.aProtectedStaticMethod.exp,
  //               classNode.staticMethods
  //                   .map<String>(
  //                     (MethodNode methodNode) => library
  //                         .aClass.aProtectedStaticMethod
  //                         .stringMatch()
  //                         .replaceAll(
  //                           library.aClass.aProtectedStaticMethod.className,
  //                           classNode.name,
  //                         )
  //                         .replaceAll(
  //                           library.aClass.aProtectedStaticMethod.name,
  //                           methodNode.name,
  //                         )
  //                         .replaceAll(
  //                           library.aClass.aProtectedStaticMethod.aParameter
  //                               .exp,
  //                           methodNode.parameters
  //                               .map<String>(
  //                                 (ParameterNode parameterNode) => library
  //                                     .aClass
  //                                     .aProtectedStaticMethod
  //                                     .aParameter
  //                                     .stringMatch()
  //                                     .replaceAll(
  //                                       library
  //                                           .aClass
  //                                           .aProtectedStaticMethod
  //                                           .aParameter
  //                                           .name,
  //                                       parameterNode.name,
  //                                     )
  //                                     .replaceAll(
  //                                       library
  //                                           .aClass
  //                                           .aProtectedStaticMethod
  //                                           .aParameter
  //                                           .type,
  //                                       getTrueTypeName(parameterNode.type),
  //                                     ),
  //                               )
  //                               .join(' '),
  //                         )
  //                         .replaceAll(
  //                           library.aClass.aProtectedStaticMethod
  //                               .aParameterName.exp,
  //                           methodNode.parameters
  //                               .map<String>(
  //                                 (ParameterNode parameterNode) => library
  //                                     .aClass
  //                                     .aProtectedStaticMethod
  //                                     .aParameterName
  //                                     .stringMatch()
  //                                     .replaceAll(
  //                                       library
  //                                           .aClass
  //                                           .aProtectedStaticMethod
  //                                           .aParameterName
  //                                           .name,
  //                                       parameterNode.name,
  //                                     ),
  //                               )
  //                               .join(', '),
  //                         ),
  //                   )
  //                   .join('\n\n'),
  //             )
  //             .replaceAll(
  //               library.aClass.aProtectedMethod.exp,
  //               classNode.methods
  //                   .map<String>(
  //                     (MethodNode methodNode) => library
  //                         .aClass.aProtectedMethod
  //                         .stringMatch()
  //                         .replaceAll(
  //                           library.aClass.aProtectedMethod.name,
  //                           methodNode.name,
  //                         )
  //                         .replaceAll(
  //                           library.aClass.aProtectedMethod.aParameter.exp,
  //                           methodNode.parameters
  //                               .map<String>(
  //                                 (ParameterNode parameterNode) => library
  //                                     .aClass.aProtectedMethod.aParameter
  //                                     .stringMatch()
  //                                     .replaceAll(
  //                                       library.aClass.aProtectedMethod
  //                                           .aParameter.name,
  //                                       parameterNode.name,
  //                                     )
  //                                     .replaceAll(
  //                                       library.aClass.aProtectedMethod
  //                                           .aParameter.type,
  //                                       getTrueTypeName(parameterNode.type),
  //                                     ),
  //                               )
  //                               .join(' '),
  //                         )
  //                         .replaceAll(
  //                           library.aClass.aProtectedMethod
  //                               .anUnpairedReference.exp,
  //                           library
  //                               .aClass.aProtectedMethod.anUnpairedReference
  //                               .stringMatch()
  //                               .replaceAll(
  //                                   library.aClass.aProtectedMethod
  //                                       .anUnpairedReference.name,
  //                                   methodNode.name)
  //                               .replaceAll(
  //                                 library
  //                                     .aClass
  //                                     .aProtectedMethod
  //                                     .anUnpairedReference
  //                                     .aParameterName
  //                                     .exp,
  //                                 methodNode.parameters
  //                                     .map<String>(
  //                                       (ParameterNode parameterNode) =>
  //                                           library
  //                                               .aClass
  //                                               .aProtectedMethod
  //                                               .anUnpairedReference
  //                                               .aParameterName
  //                                               .stringMatch()
  //                                               .replaceAll(
  //                                                 library
  //                                                     .aClass
  //                                                     .aProtectedMethod
  //                                                     .anUnpairedReference
  //                                                     .aParameterName
  //                                                     .name,
  //                                                 parameterNode.name,
  //                                               ),
  //                                     )
  //                                     .join(', '),
  //                               ),
  //                         )
  //                         .replaceAll(
  //                           library.aClass.aProtectedMethod.aPairedReference
  //                               .exp,
  //                           library.aClass.aProtectedMethod.aPairedReference
  //                               .stringMatch()
  //                               .replaceAll(
  //                                 library.aClass.aProtectedMethod
  //                                     .aPairedReference.name,
  //                                 methodNode.name,
  //                               )
  //                               .replaceAll(
  //                                 library.aClass.aProtectedMethod
  //                                     .aPairedReference.aParameterName.exp,
  //                                 methodNode.parameters
  //                                     .map<String>(
  //                                       (ParameterNode parameterNode) =>
  //                                           library
  //                                               .aClass
  //                                               .aProtectedMethod
  //                                               .aPairedReference
  //                                               .aParameterName
  //                                               .stringMatch()
  //                                               .replaceAll(
  //                                                 library
  //                                                     .aClass
  //                                                     .aProtectedMethod
  //                                                     .aPairedReference
  //                                                     .aParameterName
  //                                                     .name,
  //                                                 parameterNode.name,
  //                                               ),
  //                                     )
  //                                     .join(', '),
  //                               ),
  //                         ),
  //                   )
  //                   .join('\n\n'),
  //             ),
  //       )
  //       .join('\n\n'),
  // )
  // .replaceAll(
  //   library.aCreationArgsClass.exp,
  //   libraryNode.classes
  //       .map<String>(
  //         (ClassNode classNode) => library.aCreationArgsClass
  //             .stringMatch()
  //             .replaceAll(
  //               library.aCreationArgsClass.className,
  //               classNode.name,
  //             )
  //             .replaceAll(
  //               library.aCreationArgsClass.aField.exp,
  //               classNode.fields
  //                   .map<String>(
  //                     (FieldNode fieldNode) =>
  //                         library.aCreationArgsClass.aField
  //                             .stringMatch()
  //                             .replaceAll(
  //                               library.aCreationArgsClass.aField.name,
  //                               fieldNode.name,
  //                             )
  //                             .replaceAll(
  //                               library.aCreationArgsClass.aField.type,
  //                               getTrueTypeName(fieldNode.type),
  //                             ),
  //                   )
  //                   .join('\n'),
  //             ),
  //       )
  //       .join('\n\n'),
  // )
  // .replaceAll(
  //   library.aManager.exp,
  //   library.aManager.stringMatch().replaceAll(
  //         library.aManager.aClass.exp,
  //         libraryNode.classes
  //             .map<String>(
  //               (ClassNode classNode) =>
  //                   library.aManager.aClass.stringMatch().replaceAll(
  //                         library.aManager.aClass.name,
  //                         classNode.name,
  //                       ),
  //             )
  //             .join(', '),
  //       ),
  // )
  // .replaceAll(
  //   library.aLocalHandler.exp,
  //   library.aLocalHandler
  //       .stringMatch()
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
  //                                         .argument.fieldType,
  //                                     getTrueTypeName(
  //                                         classNode.fields[index].type),
  //                                   )
  //                                   .replaceAll(
  //                                     library.aLocalHandler.aCreator
  //                                         .argument.argumentIndex,
  //                                     '$index',
  //                                   ),
  //                         )
  //                         .join('\n'),
  //                   ),
  //             )
  //             .join('\n'),
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
  //                                         .aMethod.anArgument.exp,
  //                                     List<int>.generate(
  //                                             methodNode.parameters.length,
  //                                             (int index) => index)
  //                                         .map<String>(
  //                                           (int index) => library
  //                                               .aLocalHandler
  //                                               .aStaticMethod
  //                                               .aMethod
  //                                               .anArgument
  //                                               .stringMatch()
  //                                               .replaceAll(
  //                                                 library
  //                                                     .aLocalHandler
  //                                                     .aStaticMethod
  //                                                     .aMethod
  //                                                     .anArgument
  //                                                     .type,
  //                                                 getTrueTypeName(
  //                                                   methodNode
  //                                                       .parameters[index]
  //                                                       .type,
  //                                                 ),
  //                                               )
  //                                               .replaceAll(
  //                                                 library
  //                                                     .aLocalHandler
  //                                                     .aStaticMethod
  //                                                     .aMethod
  //                                                     .anArgument
  //                                                     .index,
  //                                                 '$index',
  //                                               ),
  //                                         )
  //                                         .join(' '),
  //                                   ),
  //                         )
  //                         .join('\n'),
  //                   ),
  //             )
  //             .join('\n'),
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
  //                                         .anArgument.exp,
  //                                     List<int>.generate(
  //                                       methodNode.parameters.length,
  //                                       (int index) => index,
  //                                     )
  //                                         .map<String>(
  //                                           (int index) => library
  //                                               .aLocalHandler
  //                                               .aMethod
  //                                               .aMethod
  //                                               .anArgument
  //                                               .stringMatch()
  //                                               .replaceAll(
  //                                                 library
  //                                                     .aLocalHandler
  //                                                     .aMethod
  //                                                     .aMethod
  //                                                     .anArgument
  //                                                     .type,
  //                                                 getTrueTypeName(
  //                                                   methodNode
  //                                                       .parameters[index]
  //                                                       .type,
  //                                                 ),
  //                                               )
  //                                               .replaceAll(
  //                                                 library
  //                                                     .aLocalHandler
  //                                                     .aMethod
  //                                                     .aMethod
  //                                                     .anArgument
  //                                                     .index,
  //                                                 '$index',
  //                                               ),
  //                                         )
  //                                         .join(','),
  //                                   ),
  //                         )
  //                         .join('\n'),
  //                   ),
  //             )
  //             .join('\n'),
  //       )
  //       .replaceAll(
  //         library.aLocalHandler.aStaticMethodAbstractMethod.exp,
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
  //                   library.aLocalHandler.aStaticMethodAbstractMethod
  //                       .stringMatch()
  //                       .replaceAll(
  //                         library.aLocalHandler.aStaticMethodAbstractMethod
  //                             .className,
  //                         ReCase(entry.value.name).camelCase,
  //                       )
  //                       .replaceAll(
  //                         library.aLocalHandler.aStaticMethodAbstractMethod
  //                             .name,
  //                         entry.key.name,
  //                       )
  //                       .replaceAll(
  //                         library.aLocalHandler.aStaticMethodAbstractMethod
  //                             .aParameter.exp,
  //                         entry.key.parameters
  //                             .map<String>(
  //                               (ParameterNode parameterNode) => library
  //                                   .aLocalHandler
  //                                   .aStaticMethodAbstractMethod
  //                                   .aParameter
  //                                   .stringMatch()
  //                                   .replaceAll(
  //                                     library
  //                                         .aLocalHandler
  //                                         .aStaticMethodAbstractMethod
  //                                         .aParameter
  //                                         .name,
  //                                     parameterNode.name,
  //                                   )
  //                                   .replaceAll(
  //                                     library
  //                                         .aLocalHandler
  //                                         .aStaticMethodAbstractMethod
  //                                         .aParameter
  //                                         .type,
  //                                     getTrueTypeName(parameterNode.type),
  //                                   ),
  //                             )
  //                             .join(' '),
  //                       ),
  //             )
  //             .join('\n\n'),
  //       )
  //       .replaceAll(
  //         library.aLocalHandler.aCreatorAbstractMethod.exp,
  //         libraryNode.classes
  //             .map<String>(
  //               (ClassNode classNode) => library
  //                   .aLocalHandler.aCreatorAbstractMethod
  //                   .stringMatch()
  //                   .replaceAll(
  //                     library
  //                         .aLocalHandler.aCreatorAbstractMethod.className,
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
  //                                         .className,
  //                                     classNode.name,
  //                                   )
  //                                   .replaceAll(
  //                                     library
  //                                         .aLocalHandler
  //                                         .anInvokeMethodCondition
  //                                         .aMethod
  //                                         .anArgument
  //                                         .exp,
  //                                     List<int>.generate(
  //                                       methodNode.parameters.length,
  //                                       (int index) => index,
  //                                     )
  //                                         .map<String>(
  //                                           (int index) => library
  //                                               .aLocalHandler
  //                                               .anInvokeMethodCondition
  //                                               .aMethod
  //                                               .anArgument
  //                                               .stringMatch()
  //                                               .replaceAll(
  //                                                 library
  //                                                     .aLocalHandler
  //                                                     .anInvokeMethodCondition
  //                                                     .aMethod
  //                                                     .anArgument
  //                                                     .type,
  //                                                 getTrueTypeName(
  //                                                   methodNode
  //                                                       .parameters[index]
  //                                                       .type,
  //                                                 ),
  //                                               )
  //                                               .replaceAll(
  //                                                 library
  //                                                     .aLocalHandler
  //                                                     .aMethod
  //                                                     .aMethod
  //                                                     .anArgument
  //                                                     .index,
  //                                                 '$index',
  //                                               ),
  //                                         )
  //                                         .join(','),
  //                                   ),
  //                             )
  //                             .join('\n'),
  //                       ),
  //             )
  //             .join('else '),
  //       ),
  // )
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
  //                     (FieldNode fieldNode) => library
  //                         .aCreationArgument.aField
  //                         .stringMatch()
  //                         .replaceAll(
  //                           library.aCreationArgument.aField.name,
  //                           ReCase(fieldNode.name).pascalCase,
  //                         ),
  //                   )
  //                   .join(','),
  //             ),
  //       )
  //       .join('\n'),
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
    case 'double':
      return 'Double';
    case 'bool':
      return 'Boolean';
    case 'num':
      return 'Number';
  }

  return type;
}

class Library with TemplateRegExp {
  Library(this.template);

  @override
  final String template;

  @override
  final TemplateRegExp parent = null;

  @override
  final RegExp exp = null;

  final RegExp name = TemplateRegExp.regExp(
    r'(?<=^class )LibraryTemplate(?= \{)',
  );

  final RegExp package = TemplateRegExp.regExp(
    r'(?<=package )github.penguin.reference.templates(?=;)',
  );

  final RegExp interfaces = TemplateRegExp.regExp(
    r'interface \$ClassTemplate \{.+}(?=\s+static class \$ClassTemplateCreationArgs \{)',
  );

  final RegExp creationArgs = TemplateRegExp.regExp(
    r'static class \$ClassTemplateCreationArgs.*}(?=\s*static class \$ClassTemplateChannel)',
  );

  final RegExp channels = TemplateRegExp.regExp(
    r'static class \$ClassTemplateChannel.*}(?=\s*static class \$ClassTemplateHandler)',
  );

  final RegExp handlers = TemplateRegExp.regExp(
    r'static class \$ClassTemplateHandler.*}(?=\s+\}\s+$)',
  );

  Interface get anInterface => Interface(this);

  CreationArgsClass get aCreationArgsClass => CreationArgsClass(this);

  Channel get aChannel => Channel(this);

  Handler get aHandler => Handler(this);

  // Class get aClass => Class(this);
  //
  // CreationArgsClass get aCreationArgsClass => CreationArgsClass(this);
  //
  // Manager get aManager => Manager(this);
  //
  // LocalHandler get aLocalHandler => LocalHandler(this);
  //
  // CreationArgument get aCreationArgument => CreationArgument(this);
}

class Interface with TemplateRegExp {
  Interface(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'(?<=interface \$)ClassTemplate');

  final RegExp fields =
      TemplateRegExp.regExp(r'Integer getFieldTemplate[^;]+;[^;]+;');

  InterfaceField get aField => InterfaceField(this);

  InterfaceMethod get aMethod => InterfaceMethod(this);

  @override
  final RegExp exp =
      TemplateRegExp.regExp(r'interface \$ClassTemplate \{[^\}]+\}');

  @override
  final Library parent;
}

class InterfaceField with TemplateRegExp {
  InterfaceField(this.parent);

  final RegExp type = TemplateRegExp.regExp(r'Integer');

  final RegExp name = TemplateRegExp.regExp(r'(?<=get)FieldTemplate');

  @override
  final RegExp exp = TemplateRegExp.regExp(r'Integer getFieldTemplate\(\);');

  @override
  final Interface parent;
}

class InterfaceMethod with TemplateRegExp {
  InterfaceMethod(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'methodTemplate(?=\()');

  final RegExp parameters = TemplateRegExp.regExp(
    r'String parameterTemplate, \$ClassTemplate2 referenceParameterTemplate',
  );

  Parameter get aParameter => Parameter(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(r'Object methodTemplate\([^;]+;');

  @override
  final Interface parent;
}

class Parameter with TemplateRegExp {
  Parameter(this.parent);

  final RegExp type = TemplateRegExp.regExp(r'String(?= )');

  final RegExp name = TemplateRegExp.regExp(r'parameterTemplate$');

  @override
  final RegExp exp = TemplateRegExp.regExp(r'String parameterTemplate');

  @override
  final TemplateRegExp parent;
}

class FollowingParameter with TemplateRegExp {
  FollowingParameter(this.parent);

  final RegExp type = TemplateRegExp.regExp(r'String(?= )');

  final RegExp name = TemplateRegExp.regExp(r'parameterTemplate$');

  @override
  final RegExp exp = TemplateRegExp.regExp(r',\s+String parameterTemplate');

  @override
  final TemplateRegExp parent;
}

class CreationArgsClass with TemplateRegExp {
  CreationArgsClass(this.parent);

  final RegExp className = TemplateRegExp.regExp(r'(?<=class \$)ClassTemplate');

  final RegExp fields = TemplateRegExp.regExp(r'Integer fieldTemplate;[^;]+;');

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
    r'(?<=super\(manager, ")github\.penguin/template/template/ClassTemplate',
  );

  ChannelStaticMethod get aStaticMethod => ChannelStaticMethod(this);

  ChannelMethod get aMethod => ChannelMethod(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'static class \$ClassTemplateChannel.*}(?=\s*static class \$ClassTemplate2Channel)',
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
    r'(?<=asList\(\s*)parameterTemplate[^\)]+\)',
  );

  Parameter get aParameter => Parameter(this);

  ParameterName get aParameterName => ParameterName(this);

  ParameterReference get aParameterReference => ParameterReference(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'Completable<Object> \$invokeStaticMethodTemplate[^\}]+\}',
  );

  @override
  final Channel parent;
}

class ChannelMethod with TemplateRegExp {
  ChannelMethod(this.parent);

  final RegExp name = TemplateRegExp.regExp(
    r'(?<=Completable<Object>\s\$invoke)MethodTemplate',
  );

  final RegExp instanceClassName = TemplateRegExp.regExp(
    r'(?<=\$)ClassTemplate(?= instance)',
  );

  final RegExp channelMethodName = TemplateRegExp.regExp(
    r'(?<=")methodTemplate(?=")',
  );

  final RegExp parameters = TemplateRegExp.regExp(
    r',\s*String parameterTemplate,\s*\$ClassTemplate2 referenceParameterTemplate',
  );

  final RegExp channelParameters = TemplateRegExp.regExp(
    r'(?<=asList\(\s*)parameterTemplate[^\)]+\)',
  );

  FollowingParameter get aParameter => FollowingParameter(this);

  ParameterName get aParameterName => ParameterName(this);

  ParameterReference get aParameterReference => ParameterReference(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'Completable<Object>\s\$invokeMethodTemplate[^\}]+\}',
  );

  @override
  final Channel parent;
}

class ParameterName with TemplateRegExp {
  ParameterName(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'parameterTemplate');

  @override
  final RegExp exp =
      TemplateRegExp.regExp(r'(?<=asList\(\s*)parameterTemplate');

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
  final RegExp exp = TemplateRegExp.regExp(r'replaceIfUnpaired\([^\)]+\)');

  @override
  final TemplateRegExp parent;
}

class Handler with TemplateRegExp {
  Handler(this.parent);

  final RegExp className = TemplateRegExp.regExp(
    r'(?<=static class \$)ClassTemplate(?=Handler)',
  );

  final RegExp typeArgClassName = TemplateRegExp.regExp(
    r'(?<=ReferenceChannelHandler<\$)ClassTemplate',
  );

  // final RegExp constructorClassName = TemplateRegExp.regExp(
  //   r'(?<=\$)ClassTemplate(?=Handler\()',
  // );

  // final RegExp onDisposeClassName = TemplateRegExp.regExp(
  //   r'ClassTemplate(?= instance\)\s+onDispose;)',
  // );

  // HandlerStaticMethodName get aStaticMethodName =>
  //     HandlerStaticMethodName(this);

  HandlerOnCreateMethod get theOnCreateMethod => HandlerOnCreateMethod(this);

  HandlerStaticMethod get aStaticMethod => HandlerStaticMethod(this);

  HandlerStaticMethodInvoker get aStaticMethodInvoker =>
      HandlerStaticMethodInvoker(this);

  HandlerCreationArguments get theCreationArguments =>
      HandlerCreationArguments(this);

  HandlerCreateInstance get theCreateInstance => HandlerCreateInstance(this);

  HandlerInvokeMethod get theInvokeMethod => HandlerInvokeMethod(this);

  final RegExp onInstanceDisposedClassName = TemplateRegExp.regExp(
    r'(?<=void onInstanceDisposed\([^\$]+\$)ClassTemplate',
  );

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'static class \$ClassTemplateHandler.*}(?=\s+static class \$ClassTemplate2Handler)',
  );

  @override
  final Library parent;
}

class HandlerOnCreateMethod with TemplateRegExp {
  HandlerOnCreateMethod(this.parent);

  final RegExp returnType = TemplateRegExp.regExp(
    r'ClassTemplate(?= onCreate\()',
  );

  final RegExp creationArgsClassName = TemplateRegExp.regExp(
    r'(?<=\$)ClassTemplate(?=CreationArgs args)',
  );

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'\$ClassTemplate onCreate\([^\}]+\}',
  );

  @override
  final Handler parent;
}

class HandlerStaticMethod with TemplateRegExp {
  HandlerStaticMethod(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'StaticMethodTemplate(?=\()');

  final RegExp parameters = TemplateRegExp.regExp(
    r',\s*String parameterTemplate,\s+\$ClassTemplate2 referenceParameterTemplate',
  );

  FollowingParameter get aParameter => FollowingParameter(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'public Object \$onStaticMethodTemplate[^\}]+\}',
  );

  @override
  final Handler parent;
}

class HandlerStaticMethodInvoker with TemplateRegExp {
  HandlerStaticMethodInvoker(this.parent);

  final RegExp methodName = TemplateRegExp.regExp(
    r'(?<=")staticMethodTemplate(?=")',
  );

  final RegExp methodHandler = TemplateRegExp.regExp(
    r'(?<=\$on)StaticMethodTemplate',
  );

  final RegExp arguments = TemplateRegExp.regExp(
    r', \(String\) arguments.get\(0\), \(\$ClassTemplate2\) arguments.get\(1\)',
  );

  HandlerStaticMethodInvokerArgument get anArgument =>
      HandlerStaticMethodInvokerArgument(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'case "staticMethodTemplate"[^;]+;',
  );

  @override
  final Handler parent;
}

class HandlerStaticMethodInvokerArgument with TemplateRegExp {
  HandlerStaticMethodInvokerArgument(this.parent);

  final RegExp type = TemplateRegExp.regExp(r'(?<=\()String(?=\))');

  final RegExp index = TemplateRegExp.regExp(r'(?<=arguments\.get\()0');

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r', \(String\) arguments.get\(0\)',
  );

  @override
  final HandlerStaticMethodInvoker parent;
}

class HandlerCreationArguments with TemplateRegExp {
  HandlerCreationArguments(this.parent);

  final RegExp className = TemplateRegExp.regExp(
    r'(?<=\$)ClassTemplate(?= instance\))',
  );

  final RegExp fields = TemplateRegExp.regExp(
    r'(?<=\(\s*)instance\.getFieldTemplate([^\)]*\)){3}',
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

  final RegExp name = TemplateRegExp.regExp(r'FieldTemplate');

  @override
  final RegExp exp =
      TemplateRegExp.regExp(r'(?<=\(\s*)instance\.getFieldTemplate\(\)');

  @override
  final HandlerCreationArguments parent;
}

class HandlerCreationArgumentsFieldReference with TemplateRegExp {
  HandlerCreationArgumentsFieldReference(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'ReferenceParameterTemplate');

  final RegExp channel = TemplateRegExp.regExp(
    r'github\.penguin/template/template/ClassTemplate2',
  );

  @override
  final RegExp exp = TemplateRegExp.regExp(r'replaceIfUnpaired[^\)]+\)\)');

  @override
  final HandlerCreationArguments parent;
}

class HandlerCreateInstance with TemplateRegExp {
  HandlerCreateInstance(this.parent);

  final RegExp className = TemplateRegExp.regExp(
    r'ClassTemplate(?= createInstance\()',
  );

  final RegExp returnTypeClassName = TemplateRegExp.regExp(
    r'(?<=^\$)ClassTemplate',
  );

  final RegExp argsClassName = TemplateRegExp.regExp(
      r'ClassTemplate(?=CreationArgs\(|CreationArgs args)');

  final RegExp fields = TemplateRegExp.regExp(
    r'args\.fieldTemplate([^;]+;){2}',
  );

  HandlerCreateInstanceField get aField => HandlerCreateInstanceField(this);

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'\$ClassTemplate createInstance\([^\}]+\}',
  );

  @override
  final Handler parent;
}

class HandlerCreateInstanceField with TemplateRegExp {
  HandlerCreateInstanceField(this.parent);

  final RegExp name = TemplateRegExp.regExp(r'fieldTemplate');

  final RegExp type = TemplateRegExp.regExp(r'(?<=\()Integer(?=\))');

  final RegExp index = TemplateRegExp.regExp(r'(?<=\.get\()0');

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'args\.fieldTemplate = \(Integer\) arguments.get\(0\);',
  );

  @override
  final HandlerCreateInstance parent;
}

class HandlerInvokeMethod with TemplateRegExp {
  HandlerInvokeMethod(this.parent);

  final RegExp instanceClassName = TemplateRegExp.regExp(
    r'ClassTemplate(?= instance,)',
  );

  final RegExp forLoopClassName = TemplateRegExp.regExp(
    r'ClassTemplate(?=\.class)',
  );

  @override
  final RegExp exp = TemplateRegExp.regExp(
    r'Object invokeMethod\([^\}]+\}',
  );

  @override
  final Handler parent;
}

// class Class with TemplateRegExp {
//   Class(this.parent);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'abstract static class \$ClassTemplate.+?getReferenceClass[^\}]+\}[^\}]+\}',
//   );
//
//   @override
//   final Library parent;
//
//   final RegExp name = TemplateRegExp.regExp(
//     r'(?<=class \$)ClassTemplate(?= implements)',
//   );
//
//   final RegExp referenceClass = TemplateRegExp.regExp(
//     r'(?<=return \$)ClassTemplate(?=\.class;)',
//   );
//
//   ClassMethod get aMethod => ClassMethod(this);
//   ClassField get aField => ClassField(this);
//
//   ClassProtectedStaticMethod get aProtectedStaticMethod =>
//       ClassProtectedStaticMethod(this);
//
//   ClassProtectedMethod get aProtectedMethod => ClassProtectedMethod(this);
// }
//
// class ClassField with TemplateRegExp {
//   ClassField(this.parent);
//
//   final RegExp type = TemplateRegExp.regExp(r'Integer');
//   final RegExp name = TemplateRegExp.regExp(r'FieldTemplate');
//
//   @override
//   final RegExp exp =
//       TemplateRegExp.regExp(r'abstract Integer getFieldTemplate\(\);');
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
//     r'abstract Object methodTemplate\(String parameterTemplate\) throws Exception;',
//   );
//
//   @override
//   final Class parent;
// }
//
// class Parameter with TemplateRegExp {
//   Parameter(this.parent);
//
//   final RegExp type = TemplateRegExp.regExp(r'(?<=^|\s)String');
//
//   final RegExp name = TemplateRegExp.regExp(r'parameterTemplate$');
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(r',*\s*String parameterTemplate');
//
//   @override
//   final TemplateRegExp parent;
// }
//
// class CreationArgsClass with TemplateRegExp {
//   CreationArgsClass(this.parent);
//
//   final RegExp className = TemplateRegExp.regExp(r'(?<=class \$)ClassTemplate');
//
//   CreationArgsClassField get aField => CreationArgsClassField(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'static class \$ClassTemplateCreationArgs[^\}]+\}',
//   );
//
//   @override
//   final Library parent;
// }
//
// class CreationArgsClassField with TemplateRegExp {
//   CreationArgsClassField(this.parent);
//
//   final RegExp type = TemplateRegExp.regExp(r'^Integer');
//   final RegExp name = TemplateRegExp.regExp(r'fieldTemplate(?=;)');
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(r'Integer fieldTemplate;');
//
//   @override
//   final CreationArgsClass parent;
// }
//
// class ClassProtectedStaticMethod with TemplateRegExp {
//   ClassProtectedStaticMethod(this.parent);
//
//   final RegExp className = TemplateRegExp.regExp(
//     r'(?<=invokeRemoteStaticMethod.*?\$)ClassTemplate(?=\.class)',
//   );
//
//   final RegExp name = TemplateRegExp.regExp(
//     r'(?<="|\$)staticMethodTemplate(?="|\()',
//   );
//
//   Parameter get aParameter => Parameter(this);
//
//   ParameterName get aParameterName => ParameterName(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'protected static.+\$staticMethodTemplate\([^\}]+\}',
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
//     r'(?<=Completable<Object> \$)methodTemplate',
//   );
//
//   Parameter get aParameter => Parameter(this);
//
//   ClassProtectedMethodUnpairedReference get anUnpairedReference =>
//       ClassProtectedMethodUnpairedReference(this);
//
//   ClassProtectedMethodPairedReference get aPairedReference =>
//       ClassProtectedMethodPairedReference(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'protected Completable<Object> \$methodTemplate[^\}]+\}[^\}]+\}',
//   );
//
//   @override
//   final Class parent;
// }
//
// class ParameterName with TemplateRegExp {
//   ParameterName(this.parent);
//
//   final RegExp name = TemplateRegExp.regExp(r'parameterTemplate');
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(r'\(Object\) parameterTemplate');
//
//   @override
//   final TemplateRegExp parent;
// }
//
// class ClassProtectedMethodUnpairedReference with TemplateRegExp {
//   ClassProtectedMethodUnpairedReference(this.parent);
//
//   final RegExp name = TemplateRegExp.regExp(r'methodTemplate(?=")');
//
//   ParameterName get aParameterName => ParameterName(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'invokeRemoteMethodOnUnpairedReference[^\}]+\}',
//   );
//
//   @override
//   final ClassProtectedMethod parent;
// }
//
// class ClassProtectedMethodPairedReference with TemplateRegExp {
//   ClassProtectedMethodPairedReference(this.parent);
//
//   final RegExp name = TemplateRegExp.regExp(r'methodTemplate(?=")');
//
//   ParameterName get aParameterName => ParameterName(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'invokeRemoteMethod\([^\}]+\}',
//   );
//
//   @override
//   final ClassProtectedMethod parent;
// }
//
// class Manager with TemplateRegExp {
//   Manager(this.parent);
//
//   ManagerClass get aClass => ManagerClass(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'(?<=abstract static class \$)ReferencePairManager([^\}]+\}){4}',
//   );
//
//   @override
//   final Library parent;
// }
//
// class ManagerClass with TemplateRegExp {
//   ManagerClass(this.parent);
//
//   final RegExp name = TemplateRegExp.regExp(r'ClassTemplate');
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(r'\$ClassTemplate.class');
//
//   @override
//   final Manager parent;
// }
//
// class LocalHandler with TemplateRegExp {
//   LocalHandler(this.parent);
//
//   LocalHandlerCreator get aCreator => LocalHandlerCreator(this);
//
//   LocalHandlerStaticMethod get aStaticMethod => LocalHandlerStaticMethod(this);
//
//   LocalHandlerMethod get aMethod => LocalHandlerMethod(this);
//
//   LocalHandlerStaticMethodAbstractMethod get aStaticMethodAbstractMethod =>
//       LocalHandlerStaticMethodAbstractMethod(this);
//
//   LocalHandlerCreatorAbstractMethod get aCreatorAbstractMethod =>
//       LocalHandlerCreatorAbstractMethod(this);
//
//   LocalHandlerInvokeMethodCondition get anInvokeMethodCondition =>
//       LocalHandlerInvokeMethodCondition(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'abstract static class \$LocalHandler.+?public void dispose\(([^\}]+\}){2}',
//   );
//
//   @override
//   final Library parent;
// }
//
// class LocalHandlerCreator with TemplateRegExp {
//   LocalHandlerCreator(this.parent);
//
//   final RegExp className = TemplateRegExp.regExp(
//     r'(?<=put\(\s+\$|final \$|new \$|localHandler\.create)ClassTemplate',
//   );
//
//   LocalHandlerCreatorCreationArgs get argument =>
//       LocalHandlerCreatorCreationArgs(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'put\(\s+\$ClassTemplate\.class,\s+new \$LocalCreatorHandler([^\}]*\}){2}\);',
//   );
//
//   @override
//   final LocalHandler parent;
// }
//
// class LocalHandlerCreatorCreationArgs with TemplateRegExp {
//   LocalHandlerCreatorCreationArgs(this.parent);
//
//   final RegExp fieldName = TemplateRegExp.regExp(r'fieldTemplate');
//   final RegExp argumentIndex = TemplateRegExp.regExp(r'(?<=get\()\d');
//   final RegExp fieldType = TemplateRegExp.regExp(r'(?<=\()Integer(?=\))');
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'args\.fieldTemplate = \(Integer\) arguments.get\(0\);',
//   );
//
//   @override
//   final LocalHandlerCreator parent;
// }
//
// class LocalHandlerStaticMethod with TemplateRegExp {
//   LocalHandlerStaticMethod(this.parent);
//
//   final RegExp className =
//       TemplateRegExp.regExp(r'(?<=put\(\s+\$)ClassTemplate');
//
//   LocalHandlerStaticMethodMethod get aMethod =>
//       LocalHandlerStaticMethodMethod(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'put\(\s+\$ClassTemplate\.class,\s+new HashMap<String, \$LocalStaticMethodHandler([^\}]*\}){4}\);',
//   );
//
//   @override
//   final LocalHandler parent;
// }
//
// class LocalHandlerStaticMethodMethod with TemplateRegExp {
//   LocalHandlerStaticMethodMethod(this.parent);
//
//   final RegExp methodName = TemplateRegExp.regExp(
//     r'(?<=\$|")staticMethodTemplate',
//   );
//
//   final RegExp classNamePart = TemplateRegExp.regExp(r'classTemplate(?=\$)');
//
//   Argument get anArgument => Argument(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'put\(\s+"staticMethodTemplate",\s+new \$LocalStaticMethodHandler([^\}]*\}){2}\);',
//   );
//
//   @override
//   final LocalHandlerStaticMethod parent;
// }
//
// class Argument with TemplateRegExp {
//   Argument(this.parent);
//
//   final RegExp index = TemplateRegExp.regExp(r'(?<=get\()\d');
//   final RegExp type = TemplateRegExp.regExp(r'(?<=\()String(?=\))');
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r',*\s*\(String\) arguments\.get\(0\)',
//   );
//
//   @override
//   final TemplateRegExp parent;
// }
//
// class LocalHandlerMethod with TemplateRegExp {
//   LocalHandlerMethod(this.parent);
//
//   final RegExp className = TemplateRegExp.regExp(
//     r'(?<=put\(\s+\$)ClassTemplate',
//   );
//
//   LocalHandlerMethodMethod get aMethod => LocalHandlerMethodMethod(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'put\(\s+\$ClassTemplate\.class,\s+new HashMap<String, \$LocalMethodHandler([^\}]*\}){4}\);',
//   );
//
//   @override
//   final LocalHandler parent;
// }
//
// class LocalHandlerMethodMethod with TemplateRegExp {
//   LocalHandlerMethodMethod(this.parent);
//
//   final RegExp methodName = TemplateRegExp.regExp(r'methodTemplate');
//   final RegExp className =
//       TemplateRegExp.regExp(r'(?<=return \(\(\$)ClassTemplate');
//
//   Argument get anArgument => Argument(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'put\(\s+"methodTemplate",\s+new \$LocalMethodHandler([^\}]*\}){2}\);',
//   );
//
//   @override
//   final LocalHandlerMethod parent;
// }
//
// class LocalHandlerStaticMethodAbstractMethod with TemplateRegExp {
//   LocalHandlerStaticMethodAbstractMethod(this.parent);
//
//   final RegExp className = TemplateRegExp.regExp(r'classTemplate(?=\$)');
//   final RegExp name = TemplateRegExp.regExp(r'(?<=\$)staticMethodTemplate');
//
//   Parameter get aParameter => Parameter(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'public abstract Object classTemplate\$staticMethodTemplate[^;]+;',
//   );
//
//   @override
//   final LocalHandler parent;
// }
//
// class LocalHandlerCreatorAbstractMethod with TemplateRegExp {
//   LocalHandlerCreatorAbstractMethod(this.parent);
//
//   final RegExp className =
//       TemplateRegExp.regExp(r'(?<=\$|create)ClassTemplate');
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'public abstract \$ClassTemplate createClassTemplate[^;]+;',
//   );
//
//   @override
//   final LocalHandler parent;
// }
//
// class LocalHandlerInvokeMethodCondition with TemplateRegExp {
//   LocalHandlerInvokeMethodCondition(this.parent);
//
//   final RegExp className = TemplateRegExp.regExp(
//     r'(?<=instanceof \$)ClassTemplate',
//   );
//
//   LocalHandlerInvokeMethodConditionMethod get aMethod =>
//       LocalHandlerInvokeMethodConditionMethod(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'if \(localReference instanceof \$ClassTemplate\)[^\}]*}[^\}]*}',
//   );
//
//   @override
//   final LocalHandler parent;
// }
//
// class LocalHandlerInvokeMethodConditionMethod with TemplateRegExp {
//   LocalHandlerInvokeMethodConditionMethod(this.parent);
//
//   final RegExp className = TemplateRegExp.regExp(r'(?<=\$)ClassTemplate');
//
//   final RegExp name = TemplateRegExp.regExp(r'(?<=\.|")methodTemplate');
//
//   Argument get anArgument => Argument(this);
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(r'case "methodTemplate"[^;]+;');
//
//   @override
//   final LocalHandlerInvokeMethodCondition parent;
// }
//
// class CreationArgument with TemplateRegExp {
//   CreationArgument(this.parent);
//
//   CreationArgumentField get aField => CreationArgumentField(this);
//
//   final RegExp className = TemplateRegExp.regExp(
//     r'ClassTemplate(?=\.class| value|\) localReference)',
//   );
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'put\(\s+\$ClassTemplate\.class,\s+new \$CreationArgumentsHandler([^\}]*\}){2}\);',
//   );
//
//   @override
//   final Library parent;
// }
//
// class CreationArgumentField with TemplateRegExp {
//   CreationArgumentField(this.parent);
//
//   final RegExp name = TemplateRegExp.regExp(r'(?<=\.get)FieldTemplate');
//
//   @override
//   final CreationArgument parent;
//
//   @override
//   final RegExp exp = TemplateRegExp.regExp(
//     r'\(Object\) value.getFieldTemplate\(\)',
//   );
// }
