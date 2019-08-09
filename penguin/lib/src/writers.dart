import 'package:code_builder/code_builder.dart' as cb;

import 'plugin.dart';
import 'references.dart';

abstract class Writer<T, K> {
  Writer(this.plugin) {
    if (plugin == null) throw ArgumentError();
  }

  final Plugin plugin;

  K write(T object);

  Iterable<K> writeAll(Iterable<T> objects) =>
      objects.map<K>((T object) => write(object)).toList();

  Class _classFromString(String className) {
    for (Class theClass in plugin.classes) {
      if (className == theClass.name) return theClass;
    }

    return null;
  }

  cb.Expression _getConstructor(
    Class classOfConstructor,
    bool isSelfFileReference,
  ) {
    final bool hasConstructor = classOfConstructor.details.hasConstructor;

    if (hasConstructor && isSelfFileReference) {
      return cb.refer(classOfConstructor.name).property('internal');
    } else if (hasConstructor) {
      return cb
          .refer(classOfConstructor.name, classOfConstructor.details.file)
          .property('internal');
    } else {
      return cb.refer('_${classOfConstructor.name}Impl');
    }
  }

  List<cb.Expression> _getParameterNodeList(Iterable<Parameter> parameters) {
    final List<cb.Expression> parameterNodeList = <cb.Expression>[];
    for (Parameter parameter in parameters) {
      final Class parameterClass = _classFromString(parameter.type);
      if (parameterClass == null) continue;

      parameterNodeList.add(cb.refer(parameter.name).property('invokerNode'));
    }

    return parameterNodeList;
  }

  cb.Expression _invokerNodeExpression(
    String method, {
    Map<String, cb.Expression> arguments,
    List<Parameter> parameters,
    bool includeSelfInvokerNode,
  }) {
    arguments ??= <String, cb.Expression>{};
    parameters ??= <Parameter>[];
    includeSelfInvokerNode ??= true;

    return References.methodCallInvokerNode.call(<cb.Expression>[
      References.methodCall.call(<cb.Expression>[
        cb.literalString(method),
        cb.literalMap(arguments, cb.refer('String'), cb.refer('dynamic')),
      ]),
      cb.literalList(
        <cb.Expression>[
          if (includeSelfInvokerNode) cb.refer('invokerNode'),
          ..._getParameterNodeList(parameters),
        ],
        References.methodCallInvokerNode,
      ),
    ]);
  }

  cb.Expression _invokerExpression(
    String method, {
    Map<String, cb.Expression> arguments,
    List<Parameter> parameters,
  }) {
    arguments ??= <String, cb.Expression>{};
    parameters ??= <Parameter>[];

    return References.methodCallInvoker.property('invoke').call(<cb.Expression>[
      cb.literalList(
        <cb.Expression>[
          cb.refer('invokerNode'),
          ..._getParameterNodeList(parameters),
        ],
        References.methodCallInvokerNode,
      ),
      References.methodCall.call(<cb.Expression>[
        cb.literalString(method),
        cb.literalMap(arguments, cb.refer('String'), cb.refer('dynamic')),
      ]),
    ]);
  }

  cb.InvokeExpression _invokeMethodExpression({
    String method,
    cb.Reference type,
    Map<String, cb.Expression> arguments = const <String, cb.Expression>{},
    bool mapMethod = false,
  }) {
    if (mapMethod && type != null) throw ArgumentError();

    return cb.InvokeExpression.newOf(
      References.channel
          .property('channel')
          .property(mapMethod ? 'invokeMapMethod' : 'invokeMethod'),
      <cb.Expression>[
        cb.literalString(method),
        cb.literalMap(arguments, cb.refer('String'), cb.refer('dynamic'))
      ],
      <String, cb.Expression>{},
      mapMethod
          ? <cb.Reference>[cb.refer('String'), cb.refer('dynamic')]
          : <cb.Reference>[type ?? cb.refer('void')],
    );
  }

  Map<String, cb.Expression> _mappedParams(List<Parameter> parameters) {
    final Map<String, cb.Expression> paramExpressions =
        <String, cb.Expression>{};

    for (Parameter parameter in parameters) {
      final Class aClass = _classFromString(parameter.type);

      if (aClass != null) {
        paramExpressions['${parameter.name.toLowerCase()}Handle'] =
            cb.refer(parameter.name).property('handle');
      } else {
        paramExpressions[parameter.name] = cb.refer(parameter.name);
      }
    }

    return paramExpressions;
  }
}

class FieldWriter extends Writer<Field, cb.Field> {
  FieldWriter(Plugin plugin) : super(plugin);

  @override
  cb.Field write(Field field) {
    assert(field.mutable || field.initialized);

    final Class theClass = _classFromString(field.type);

    return cb.Field((cb.FieldBuilder builder) {
      builder
        ..name = field.mutable ? '_${field.name}' : field.name
        ..static = field.isStatic
        ..type = theClass == null
            ? cb.refer(field.type)
            : cb.refer(theClass.name, theClass.details.file);

      if (!field.mutable) {
        builder.modifier = cb.FieldModifier.final$;
      }
    });
  }
}

// For writing fields that require method logic
class MethodFieldWriter extends Writer<Field, List<cb.Method>> {
  MethodFieldWriter(Plugin plugin, this.nameOfParentClass, this.methodWriter)
      : assert(methodWriter != null),
        super(plugin);

  final String nameOfParentClass;
  final MethodWriter methodWriter;

  @override
  List<cb.Method> write(Field field) {
    if (!field.mutable && !field.initialized) {
      return <cb.Method>[methodWriter.write(field)];
    } else if (!field.mutable) {
      return <cb.Method>[];
    }

    final List<cb.Method> methods = <cb.Method>[];

    final cb.Reference variableRef = cb.refer('_${field.name}');

    final Class theClass = _classFromString(field.type);

    methods.addAll(<cb.Method>[
      cb.Method((cb.MethodBuilder builder) {
        builder
          ..name = field.name
          ..type = cb.MethodType.getter
          ..static = field.isStatic
          ..lambda = true
          ..body = variableRef.code
          ..returns = theClass == null
              ? cb.refer(field.type)
              : cb.refer(theClass.name, theClass.details.file);
      }),
      cb.Method((cb.MethodBuilder builder) {
        builder
          ..name = field.name
          ..type = cb.MethodType.setter
          ..static = field.isStatic
          ..requiredParameters.add(
            cb.Parameter((cb.ParameterBuilder paramBuilder) {
              paramBuilder
                ..name = field.name
                ..type = cb.refer(field.type);
            }),
          )
          ..body = cb.Block((cb.BlockBuilder builder) {
            Map<String, cb.Expression> arguments = <String, cb.Expression>{};

            if (theClass != null) {
              arguments['${field.name.toLowerCase()}Handle'] =
                  cb.refer(field.name).property('handle');
            } else {
              arguments[field.name] = variableRef;
            }

            builder
              ..addExpression(field.isStatic
                  ? _invokeMethodExpression(
                      //className: nameOfParentClass,
                      //methodName: field.name,
                      arguments: arguments)
                  : _invokerNodeExpression('$nameOfParentClass#${field.name}',
                      arguments: arguments))
              ..addExpression(variableRef.assign(cb.refer(field.name)));
          });
      }),
    ]);

    return methods;
  }
}

class MethodWriter extends Writer<dynamic, cb.Method> {
  MethodWriter(Plugin plugin, {this.nameOfParentClass, this.parameterWriter})
      : super(plugin) {
    if (nameOfParentClass == null ||
        parameterWriter == null ||
        parameterWriter == null) {
      throw ArgumentError();
    }
  }

  final String nameOfParentClass;
  final ParameterWriter parameterWriter;

  @override
  cb.Method write(dynamic fieldOrMethod) {
    final String name = fieldOrMethod.name;
    final String returnType = Plugin.returnType(fieldOrMethod);
    final bool static = fieldOrMethod.isStatic;
    final Class returnedClass = _classFromString(returnType);
    final List<Parameter> parameters = Plugin.parameters(fieldOrMethod);
    final String invokeMethod = '$nameOfParentClass#$name';

//    final bool useInvoker = !static;
//    final bool returnMethodInvocation =
//        !recognizedClass && !(returnType == 'void' && !static);
//    final bool returnObject = recognizedClass;
//    final bool setInvokerNode = returnType == 'void' && !static;
//    final bool createNewNode = recognizedClass;
//    final bool newNodeHasParents = recognizedClass && !static;
//    final bool sourceIsNull = recognizedClass && static;
//    final bool retrieveSource =
//        recognizedClass && returnedClass.details.hasInitializedFields;
//    final bool isGetter = fieldOrMethod is Field;

    final bool recognizedClass = returnedClass != null;
    cb.Reference returnRef;
    if (recognizedClass) {
      returnRef = returnType == nameOfParentClass
          ? cb.refer(returnType)
          : cb.refer(returnType, returnedClass.details.file);
    } else {
      returnRef = cb.refer(returnType);
    }

//    if (useFutureInTypeRef) {
//      returnRef = References.future(returnRef);
//    }

    final bool returnsVoid = returnType == 'void';
    final bool setNode = recognizedClass || (returnsVoid && !static);
    final bool includeSelfInvokerNode = !static;

    cb.Expression nodeExpression;
    if (setNode) {
      nodeExpression = _invokerNodeExpression(
        invokeMethod,
        arguments: _mappedMethodParams(fieldOrMethod),
        parameters: parameters,
        includeSelfInvokerNode: includeSelfInvokerNode,
      );
    }

    //final bool returnsUnrecognizedClass = !recognizedClass && !returnsVoid;
    final bool hasInitializedTypes =
        recognizedClass && returnedClass.details.hasInitializedFields;

    final bool invokeChannel = static;
    cb.Expression invokeChannelExpression;
    if (invokeChannel) {
      invokeChannelExpression = _invokeMethodExpression(
        method: invokeMethod,
        arguments: _mappedMethodParams(fieldOrMethod),
        type: recognizedClass ? null : returnRef,
        mapMethod: hasInitializedTypes,
      );
    }

    final bool useInvoker = !static && (!recognizedClass || hasInitializedTypes);
    cb.Expression invokerExpression;
    if (useInvoker) {
      invokerExpression = _invokerExpression(
        invokeMethod,
        arguments: _mappedMethodParams(fieldOrMethod),
        parameters: parameters,
      );
    }

    final bool createsObject = recognizedClass;
    final bool mapIsNull = createsObject && !hasInitializedTypes;
    cb.Expression objectExpression;
    if (createsObject && mapIsNull) {
      objectExpression = _getConstructor(
              returnedClass, returnedClass.name == nameOfParentClass)
          .call(<cb.Expression>[cb.refer('newNode'), cb.literalNull]);
    } else if (createsObject) {
      objectExpression = _getConstructor(
              returnedClass, returnedClass.name == nameOfParentClass)
          .call(<cb.Expression>[cb.refer('newNode'), cb.refer('source')]);
    }

//    cb.Expression invocationExpression;
//    if (returnMethodInvocation && useInvoker) {
//      invocationExpression = _invokerExpression(
//        '$name#$returnType',
//        arguments: _mappedMethodParams(fieldOrMethod),
//        parameters: parameters,
//      );
//    } else if (returnMethodInvocation) {
//      invocationExpression = _invokeMethodExpression(
//        method: '$name#$returnType',
//        type: returnObject ? null : typeRef,
//        arguments: _mappedMethodParams(fieldOrMethod),
//        mapMethod: retrieveSource,
//      );
//    }
//
//    if (setInvokerNode) {
//    } else if (createNewNode) {}

    //cb.Expression nodeExpression = _

    return cb.Method((cb.MethodBuilder builder) {
      final bool useFutureInTypeRef = !recognizedClass || hasInitializedTypes;
      final bool setNodeToNewNode = recognizedClass;
      final bool returnNullFuture = returnsVoid && !static;
      final bool returnChannelInvoke = invokeChannel && !recognizedClass;
      final bool returnInvokerInvoke = useInvoker && !recognizedClass;
      final bool retrieveObjectJson = recognizedClass && hasInitializedTypes;

      if (fieldOrMethod is Field) {
        builder.type = cb.MethodType.getter;
      }

      if (hasInitializedTypes) {
        builder.modifier = cb.MethodModifier.async;
      }

      builder
        ..name = name
        ..static = static
        ..requiredParameters.addAll(parameterWriter.writeAll(parameters))
        ..returns =
            useFutureInTypeRef ? References.future(returnRef) : returnRef
        ..body = cb.Block((cb.BlockBuilder builder) {
          if (setNode && setNodeToNewNode) {
            builder.addExpression(nodeExpression.assignFinal(
                'newNode', References.methodCallInvokerNode));
          } else if (setNode) {
            builder
                .addExpression(cb.refer('_invokerNode').assign(nodeExpression));
          }

          if (retrieveObjectJson && useInvoker) {
            builder.addExpression(
              invokerExpression.awaited.assignFinal('source', cb.refer('Map')),
            );
          } else if (retrieveObjectJson) {
            builder.addExpression(
              invokeChannelExpression.awaited.assignFinal('source', cb.refer('Map')),
            );
          }

          if (recognizedClass && createsObject && mapIsNull) {
            builder.addExpression(
                objectExpression.assignFinal('value', returnRef));
          }

          if (recognizedClass && createsObject && !mapIsNull) {
            builder.addExpression(objectExpression.returned);
          } else if (returnNullFuture) {
            builder.addExpression(References.future(cb.refer('void'))
                .property('value')
                .call(<cb.Expression>[]).returned);
          } else if (returnChannelInvoke) {
            builder.addExpression(invokeChannelExpression.returned);
          } else if (returnInvokerInvoke) {
            builder.addExpression(invokerExpression.returned);
          }
        });
    });
//    final String returnType = Plugin.returnType(fieldOrMethod);
//
//    final Class theClass = _classFromString(returnType);
//
//    cb.Expression invokeMethodExpression;
//    if (fieldOrMethod.isStatic) {
//      invokeMethodExpression = _invokeMethodExpression(
//        type: theClass == null ? cb.refer(returnType) : null,
//        className: nameOfParentClass,
//        methodName: fieldOrMethod.name,
//        arguments: _mappedParams(fieldOrMethod, returnType),
//        mapMethod: theClass != null && theClass.details.hasInitializedFields,
//      );
//    } else if (returnType == 'void' ||
//        (theClass != null && !theClass.details.hasInitializedFields)) {
//      invokeMethodExpression = _invokerNodeExpression(
//        '$nameOfParentClass#${fieldOrMethod.name}',
//        arguments: _mappedParams(fieldOrMethod, returnType),
//        parameters: Plugin.parameters(fieldOrMethod),
//      );
//    } else {
//      invokeMethodExpression = _invokerExpression(
//          '$nameOfParentClass#${fieldOrMethod.name}',
//          arguments: _mappedParams(fieldOrMethod, returnType),
//          parameters: Plugin.parameters(fieldOrMethod));
//    }
//
//    void addNameAndParams(cb.MethodBuilder builder) {
//      builder
//        ..name = fieldOrMethod.name
//        ..static = fieldOrMethod.isStatic;
//
//      if (fieldOrMethod is Field) {
//        builder.type = cb.MethodType.getter;
//      } else {
//        builder
//          ..requiredParameters.addAll(
//            _paramWriter.writeAll(fieldOrMethod.requiredParameters),
//          )
//          ..optionalParameters.addAll(
//            _paramWriter.writeAll(fieldOrMethod.optionalParameters),
//          );
//      }
//    }
//
//    if (theClass == null) {
//      return cb.Method((cb.MethodBuilder builder) {
//        addNameAndParams(builder);
//
//        builder.returns = References.future(cb.refer(returnType));
//        builder.body = cb.Block((cb.BlockBuilder builder) {
//          if (returnType != 'void') {
//            builder.addExpression(invokeMethodExpression.returned);
//          } else {
//            builder.addExpression(invokeMethodExpression);
//            builder.addExpression(
//              References.future(cb.refer('void'))
//                  .property('value')
//                  .call(<cb.Expression>[]).returned,
//            );
//          }
//        });
//      });
//    } else {
//      final cb.Reference returnRef = returnType == nameOfParentClass
//          ? cb.refer(returnType)
//          : cb.refer(returnType, theClass.details.file);
//
//      final String varName = returnType.toLowerCase();
//
//      return cb.Method((cb.MethodBuilder builder) {
//        addNameAndParams(builder);
//
//        builder.returns = theClass.details.hasInitializedFields
//            ? References.future(returnRef)
//            : returnRef;
//
//        final List<cb.Expression> constructorParams = <cb.Expression>[
//          cb.refer('invokerNode'),
//          if (theClass.details.hasInitializedFields) cb.refer('source'),
//        ];
//
//        final cb.Expression constructor = !theClass.details.hasConstructor
//            ? cb.refer('_${returnType}$implSuffix').call(constructorParams)
//            : returnRef.property('internal').call(constructorParams);
//
//        if (theClass.details.hasInitializedFields) {
//          builder.modifier = cb.MethodModifier.async;
//          builder.body = cb.Block((cb.BlockBuilder builder) {
//            builder.addExpression(
//              invokeMethodExpression.awaited
//                  .assignFinal('source', cb.refer('Map')),
//            );
//
//            builder.addExpression(
//              constructor.returned,
//            );
//          });
//        } else {
//          builder.body = cb.Block((cb.BlockBuilder builder) {
//            builder.addExpression(
//              constructor.assignFinal(varName, returnRef),
//            );
//
//            builder.addExpression(invokeMethodExpression);
//
//            builder.addExpression(cb.refer(varName).returned);
//          });
//        }
//      });
//    }
  }

  Map<String, cb.Expression> _mappedMethodParams(dynamic fieldOrMethod) {
    final Map<String, cb.Expression> paramExpressions = _mappedParams(
      Plugin.parameters(fieldOrMethod),
    );

    if (!fieldOrMethod.isStatic) {
      paramExpressions['handle'] = cb.refer('handle');
    }

    final Class returnedClass = _classFromString(
      Plugin.returnType(fieldOrMethod),
    );

    if (returnedClass != null && !returnedClass.details.hasInitializedFields) {
      final String handleName = '${returnedClass.name.toLowerCase()}Handle';
      paramExpressions[handleName] =
          cb.refer(returnedClass.name.toLowerCase()).property('handle');
    }

    return paramExpressions;
  }
}

class InitializerWriter extends Writer<Field, cb.Code> {
  InitializerWriter(
    Plugin plugin,
    this.nameOfParentClass,
    this.setNull,
  ) : super(plugin) {
    if (nameOfParentClass == null || setNull == null) throw ArgumentError();
  }

  final String nameOfParentClass;
  final bool setNull;

  @override
  cb.Code write(Field field) {
    final String fieldName = field.mutable ? '_${field.name}' : field.name;

    if (setNull) {
      return cb.refer(fieldName).assign(cb.literalNull).code;
    } else {
      final cb.Expression sourceAccess =
          cb.refer('source').index(cb.literalString(field.name));

      final Class fieldClass = _classFromString(field.type);
      final cb.Expression value = fieldClass == null
          ? sourceAccess
          : _getConstructor(fieldClass, fieldClass.name == nameOfParentClass)
              .call(<cb.Expression>[cb.refer('creatorNode'), sourceAccess]);

      return cb.refer(fieldName).assign(value).code;
    }
  }
}

class ConstructorWriter extends Writer<Constructor, cb.Constructor> {
  ConstructorWriter(
    Plugin plugin, {
    this.nameOfParentClass,
    this.initializers,
    this.parameterWriter,
  }) : super(plugin) {
    if (nameOfParentClass == null ||
        initializers == null ||
        parameterWriter == null) throw ArgumentError();
  }

  final String nameOfParentClass;
  final Iterable<cb.Code> initializers;
  final ParameterWriter parameterWriter;

  @override
  cb.Constructor write(Constructor constructor) {
    return cb.Constructor((cb.ConstructorBuilder builder) {
      if (constructor.name != null) builder.name = constructor.name;
      builder
        ..requiredParameters
            .addAll(parameterWriter.writeAll(constructor.allParameters))
        ..body = cb.Block((cb.BlockBuilder builder) {
          builder.addExpression(
              cb.refer('_invokerNode').assign(_invokerNodeExpression(
                    '${nameOfParentClass}${_getMethodCallMethod(constructor.allParameters)}',
                    arguments: _mappedConstructorParams(constructor),
                    parameters: constructor.allParameters,
                    includeSelfInvokerNode: true,
                  )));
        })
        ..initializers.add(cb
            .refer('handle')
            .assign(
              References.channel.property('nextHandle').call(<cb.Expression>[]),
            )
            .code)
        ..initializers.addAll(initializers);
      //..in
    });
  }

  String _getMethodCallMethod(List<Parameter> parameters) {
    final Iterable<String> parameterTypes = parameters.map<String>(
      (Parameter parameter) => parameter.type,
    );

    return '(${parameterTypes.join(',')})';
  }

  Map<String, cb.Expression> _mappedConstructorParams(Constructor constructor) {
    final Map<String, cb.Expression> paramExpressions = _mappedParams(
      constructor.allParameters,
    );

    final String handleName = '${nameOfParentClass.toLowerCase()}Handle';
    paramExpressions[handleName] = cb.refer('handle');

    return paramExpressions;
  }
}

class ParameterWriter extends Writer<Parameter, cb.Parameter> {
  ParameterWriter(Plugin plugin, this.nameOfParentClass) : super(plugin) {
    if (nameOfParentClass == null) throw ArgumentError();
  }

  final String nameOfParentClass;

  @override
  cb.Parameter write(Parameter parameter) {
    final Class parameterClass = _classFromString(parameter.type);

    final cb.Parameter codeParam = cb.Parameter((cb.ParameterBuilder builder) {
      builder
        ..name = parameter.name
        ..type =
            parameterClass == null || parameterClass.name == nameOfParentClass
                ? cb.refer(parameter.type)
                : cb.refer(parameter.type, parameterClass.details.file);
    });

    return codeParam;
  }
}

class ImplClassWriter extends Writer<Class, cb.Class> {
  ImplClassWriter(Plugin plugin, this.implSuffix, this.parentClass)
      : assert(implSuffix != null),
        super(plugin);

  final String implSuffix;
  final Class parentClass;

  @override
  cb.Class write(Class theClass) {
    assert(theClass.details.isReferenced && !theClass.details.hasConstructor);

    return cb.Class((cb.ClassBuilder classBuilder) {
      classBuilder
        ..name = '_${theClass.name}$implSuffix'
        ..extend = cb.refer(theClass.name, theClass.details.file);

      if (theClass.details.hasInitializedFields ||
          (theClass.details.isInitializedField &&
              parentClass.fieldsAndMethods.any((dynamic fieldOrMethod) =>
                  Plugin.initialized(fieldOrMethod)))) {
        classBuilder.constructors.add(cb.Constructor(
          (cb.ConstructorBuilder builder) {
            builder
              ..requiredParameters.addAll(<cb.Parameter>[
                cb.Parameter((cb.ParameterBuilder builder) {
                  builder.name = 'creatorNode';
                  builder.type = References.methodCallInvokerNode;
                }),
                cb.Parameter((cb.ParameterBuilder builder) {
                  builder.name = 'source';
                  builder.type = cb.refer('Map');
                }),
              ])
              ..initializers.add(
                cb.refer('super').property('internal').call(<cb.Expression>[
                  cb.refer('creatorNode'),
                  cb.refer('source')
                ]).code,
              );
          },
        ));
      }
    });
  }
}

class ClassWriter extends Writer<Class, cb.Library> {
  ClassWriter(Plugin plugin) : super(plugin);

  //static final String _implSuffix = 'Impl';

  @override
  cb.Library write(Class theClass) {
//    final MethodWriter methodWriter = MethodWriter(
//      plugin: plugin,
//      nameOfParentClass: theClass.name,
//      implSuffix: _implSuffix,
//    );
//
//    final MethodFieldWriter methodFieldWriter = MethodFieldWriter(
//      plugin,
//      theClass.name,
//      methodWriter,
//    );
//
//    final FieldWriter fieldWriter = FieldWriter(plugin);
//
//    final ConstructorWriter constructWriter = ConstructorWriter(
//      plugin,
//      theClass,
//    );
//
//    final ImplClassWriter implClassWriter =
//        ImplClassWriter(plugin, _implSuffix, theClass);
//
//    final List<Class> implClasses = theClass.fieldsAndMethods
//        .map<String>(
//          (dynamic fieldOrMethod) => Plugin.returnType(fieldOrMethod),
//        )
//        .map<Class>((String type) => _classFromString(type))
//        .toSet()
//        .where(
//          (Class theClass) =>
//              theClass != null && !theClass.details.hasConstructor,
//        )
//        .toList();
//
//    final cb.Library library = cb.Library((cb.LibraryBuilder builder) {
//      builder.body.addAll(<cb.Class>[
//        cb.Class((cb.ClassBuilder classBuilder) {
//          classBuilder
//            ..name = theClass.name
//            ..abstract = !theClass.details.hasConstructor
//            ..constructors
//                .addAll(constructWriter.writeAll(theClass.constructors))
//            ..fields.add(_invokerNode)
//            ..fields.add(_handle(
//              theClass.details.hasInitializedFields,
//              theClass.details.isInitializedField,
//            ))
//            ..fields.addAll(fieldWriter.writeAll(theClass.fields.where(
//              (Field field) {
//                return field.mutable || field.initialized;
//              },
//            ).toList()))
//            ..methods.addAll(
//              methodFieldWriter.writeAll(theClass.fields).expand((_) => _),
//            )
//            ..methods.addAll(methodWriter.writeAll(theClass.methods));
//
//          if (!theClass.details.hasConstructor &&
//              (theClass.details.isInitializedField ||
//                  theClass.details.isReferenced)) {
//            classBuilder.constructors.add(
//              _abstractDefaultConstructor(theClass),
//            );
//          }
//
//          if ((theClass.details.hasConstructor &&
//                  theClass.details.isReferenced) ||
//              theClass.details.hasInitializedFields ||
//              theClass.details.isInitializedField) {
//            classBuilder.constructors.add(_internalConstructor(theClass));
//          }
//        }),
//        ...implClassWriter.writeAll(implClasses),
//      ]);
//    });
//    return cb.Library((cb.LibraryBuilder builder) {
//      builder.body.addAll(<cb.Class>[
//        cb.Class((cb.ClassBuilder classBuilder)
//      {
//        classBuilder
//          ..name = theClass.name;
//      },)])});

    final ParameterWriter parameterWriter = ParameterWriter(
      plugin,
      theClass.name,
    );

    final InitializerWriter constructorInitWriter =
        InitializerWriter(plugin, theClass.name, true);
    final InitializerWriter internalConstructorInitWriter =
        InitializerWriter(plugin, theClass.name, false);

    final ConstructorWriter constructorWriter = ConstructorWriter(
      plugin,
      nameOfParentClass: theClass.name,
      initializers: constructorInitWriter.writeAll(theClass.fields.where(
        (Field field) => field.initialized,
      )),
      parameterWriter: parameterWriter,
    );

    final MethodWriter methodWriter = MethodWriter(
      plugin,
      nameOfParentClass: theClass.name,
      parameterWriter: parameterWriter,
    );

    return cb.Library((cb.LibraryBuilder builder) {
      builder.body.addAll(<cb.Class>[
        cb.Class((cb.ClassBuilder classBuilder) {
          classBuilder
            ..name = theClass.name
            ..abstract = !theClass.details.hasConstructor
            ..constructors.addAll(
              _getConstructors(
                  constructors: constructorWriter.writeAll(
                    theClass.constructors,
                  ),
                  initializers: internalConstructorInitWriter.writeAll(
                    theClass.fields.where(
                      (Field field) => field.initialized,
                    ),
                  ),
                  hasInternalConstructor:
                      theClass.details.hasInitializedFields ||
                          theClass.details.isInitializedField ||
                          theClass.details.isReferenced),
            )
            ..fields.addAll(<cb.Field>[
              cb.Field((cb.FieldBuilder builder) {
                builder
                  ..name = '_invokerNode'
                  ..type = References.methodCallInvokerNode;
              }),
              cb.Field((cb.FieldBuilder builder) {
                builder
                  ..name = 'handle'
                  ..type = cb.refer('String')
                  ..modifier = cb.FieldModifier.final$;
              }),
            ])
            ..methods.add(cb.Method((cb.MethodBuilder builder) {
              builder
                ..name = 'invokerNode'
                ..type = cb.MethodType.getter
                ..lambda = true
                ..body = cb.refer('_invokerNode').code
                ..returns = References.methodCallInvokerNode;
            }))
            ..methods.addAll(
              methodWriter.writeAll(
                theClass.fields.where((Field field) =>
                    !Plugin.mutable(field) && !Plugin.initialized(field)),
              ),
            )
            ..methods.addAll(methodWriter.writeAll(theClass.methods));
        }),
      ]);
    });
  }

  List<cb.Constructor> _getConstructors({
    Iterable<cb.Constructor> constructors,
    Iterable<cb.Code> initializers,
    bool hasInternalConstructor,
  }) {
    return <cb.Constructor>[
      ...constructors,
      if (hasInternalConstructor)
        cb.Constructor(
          (cb.ConstructorBuilder builder) {
            builder
              ..name = 'internal'
              ..requiredParameters.addAll(<cb.Parameter>[
                cb.Parameter((cb.ParameterBuilder builder) {
                  builder
                    ..name = 'creatorNode'
                    ..type = References.methodCallInvokerNode;
                }),
                cb.Parameter((cb.ParameterBuilder builder) {
                  builder.name = 'source';
                  builder.type = cb.refer('Map');
                })
              ])
              ..initializers.addAll(<cb.Code>[
                cb.refer('_invokerNode').assign(cb.refer('creatorNode')).code,
                cb
                    .refer('handle')
                    .assign(
                      cb.refer('source').notEqualTo(cb.literalNull).conditional(
                          cb.refer('source').index(cb.literalString('handle')),
                          References.channel
                              .property('nextHandle')
                              .call(<cb.Expression>[])),
                    )
                    .code,
                ...initializers,
              ]);
          },
        )
    ];
  }
}
