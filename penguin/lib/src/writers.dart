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
    String nodeType,
  }) {
    arguments ??= <String, cb.Expression>{};
    parameters ??= <Parameter>[];
    includeSelfInvokerNode ??= true;
    nodeType ??= 'regular';

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
      References.nodeType.property(nodeType),
    ]);
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
  FieldWriter(Plugin plugin, this.nameOfParentClass) : super(plugin) {
    if (nameOfParentClass == null) throw ArgumentError();
  }

  final String nameOfParentClass;

  @override
  cb.Field write(Field field) {
    if (!field.mutable && !field.initialized) throw ArgumentError();

    final Class theClass = _classFromString(field.type);

    return cb.Field((cb.FieldBuilder builder) {
      builder
        ..name = field.mutable ? '_${field.name}' : field.name
        ..static = field.isStatic
        ..type = theClass == null || theClass.name == nameOfParentClass
            ? cb.refer(field.type)
            : cb.refer(theClass.name, theClass.details.file);

      if (!field.mutable) {
        builder.modifier = cb.FieldModifier.final$;
      }
    });
  }
}

class MutableFieldWriter extends Writer<Field, List<cb.Method>> {
  MutableFieldWriter(Plugin plugin, this.nameOfParentClass) : super(plugin);

  final String nameOfParentClass;

  @override
  List<cb.Method> write(Field field) {
    if (!field.mutable) throw ArgumentError();

    final List<cb.Method> methods = <cb.Method>[];
    final cb.Reference variableRef = cb.refer('_${field.name}');
    final Class fieldClass = _classFromString(field.type);

    methods.addAll(<cb.Method>[
      cb.Method((cb.MethodBuilder builder) {
        builder
          ..name = field.name
          ..type = cb.MethodType.getter
          ..static = field.isStatic
          ..lambda = true
          ..body = variableRef.code
          ..returns = fieldClass == null
              ? cb.refer(field.type)
              : cb.refer(fieldClass.name, fieldClass.details.file);
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

            if (!field.isStatic) {
              arguments['handle'] = cb.refer('handle');
            }

            if (fieldClass != null) {
              arguments['${field.name.toLowerCase()}Handle'] =
                  cb.refer(field.name).property('handle');
            } else {
              arguments[field.name] = cb.refer(field.name);
            }

            final String method = '$nameOfParentClass#${field.name}';
            builder.addExpression(_invokerNodeExpression(method,
                arguments: arguments,
                includeSelfInvokerNode: !field.isStatic,
                parameters: <Parameter>[
                  Parameter(field.name, type: field.type),
                ]).assignFinal('newNode', References.methodCallInvokerNode));
            if (field.isStatic) {
              builder.addExpression(
                  cb.refer('newNode').property('invoke').call([]));
            } else {
              builder.addExpression(
                  cb.refer('_invokerNode').assign(cb.refer('newNode')));
            }
            builder.addExpression(variableRef.assign(cb.refer(field.name)));
          });
      }),
    ]);

    return methods;
  }
}

enum MethodStructure {
  staticReturnsVoid,
  returnsVoid,
  primitive,
  staticPrimitive,
  initializers,
  staticInitializers,
  unInitialized,
  staticUninitialized,
}

class MethodWriter extends Writer<dynamic, cb.Method> {
  MethodWriter(
    Plugin plugin, {
    this.nameOfParentClass,
    this.parameterWriter,
    this.parentClassHasDisposer,
  }) : super(plugin) {
    if (nameOfParentClass == null ||
        parameterWriter == null ||
        parameterWriter == null ||
        parentClassHasDisposer == null) {
      throw ArgumentError();
    }
  }

  final String nameOfParentClass;
  final ParameterWriter parameterWriter;
  final bool parentClassHasDisposer;

  @override
  cb.Method write(dynamic fieldOrMethod) {
    if (fieldOrMethod is Field &&
        (Plugin.mutable(fieldOrMethod) || Plugin.initialized(fieldOrMethod))) {
      throw ArgumentError();
    }

    final String name = fieldOrMethod.name;
    final String returnType = Plugin.returnType(fieldOrMethod);
    final bool static = fieldOrMethod.isStatic;
    final Class returnedClass = _classFromString(returnType);
    final List<Parameter> parameters = Plugin.parameters(fieldOrMethod);
    final String invokeMethod = '$nameOfParentClass#$name';
    final bool handlesAllocation =
        Plugin.allocator(fieldOrMethod) || Plugin.disposer(fieldOrMethod);

    final MethodStructure s = _getMethodStructure(
      returnType == 'void',
      static,
      returnedClass != null,
      returnedClass != null && returnedClass.details.hasInitializedFields,
    );

    cb.Reference returnRef;
    if (returnedClass == null || returnType == nameOfParentClass) {
      returnRef = cb.refer(returnType);
    } else {
      returnRef = cb.refer(returnType, returnedClass.details.file);
    }

    cb.Expression diposerAssert;
    if (parentClassHasDisposer && !static) {
      diposerAssert = cb.refer('assert').call(<cb.Expression>[
        cb
            .refer('invokerNode')
            .property('type')
            .notEqualTo(References.nodeType.property('disposer')),
        cb.literalString('This object has been disposed.'),
      ]);
    }

    cb.Expression handleExpression;
    if (returnedClass != null) {
      handleExpression = References.channel
          .property('nextHandle')
          .call(<cb.Expression>[]).assignFinal('newHandle', cb.refer('String'));
    }

    String nodeType;
    if (Plugin.allocator(fieldOrMethod)) {
      nodeType = 'allocator';
    } else if (Plugin.disposer(fieldOrMethod)) {
      nodeType = 'disposer';
    }

    cb.Expression nodeExpression = _invokerNodeExpression(
      invokeMethod,
      arguments: _mappedMethodParams(fieldOrMethod),
      parameters: parameters,
      includeSelfInvokerNode: !static,
      nodeType: nodeType,
    ).assignFinal('newNode', References.methodCallInvokerNode);

    cb.Expression invokeNodeExpression;
    if (handlesAllocation ||
        !_structureIsAny(s, [
          MethodStructure.unInitialized,
          MethodStructure.returnsVoid,
        ])) {
      invokeNodeExpression = cb.refer('newNode').property('invoke').call(
        [],
        {},
        <cb.Reference>[if (returnedClass == null) cb.refer(returnType)],
      );
    }

    cb.Expression objectExpression;
    if (_structureIsAny(s, [
      MethodStructure.unInitialized,
      MethodStructure.staticUninitialized,
    ])) {
      objectExpression = _getConstructor(
              returnedClass, returnedClass.name == nameOfParentClass)
          .call(
        <cb.Expression>[
          cb.refer('newNode'),
          cb.refer('newHandle'),
          cb.literalNull,
        ],
      );
    } else if (_structureIsAny(s, [
      MethodStructure.initializers,
      MethodStructure.staticInitializers,
    ])) {
      objectExpression = _getConstructor(
              returnedClass, returnedClass.name == nameOfParentClass)
          .call(
        <cb.Expression>[
          cb.refer('newNode'),
          cb.refer('newHandle'),
          cb.refer('source'),
        ],
      );
    }

    return cb.Method((cb.MethodBuilder builder) {
      if (returnedClass != null && returnedClass.details.hasInitializedFields) {
        builder.modifier = cb.MethodModifier.async;
      }

      if (fieldOrMethod is Field) {
        builder.type = cb.MethodType.getter;
      }

      builder
        ..name = name
        ..static = static
        ..requiredParameters.addAll(parameterWriter.writeAll(parameters))
        ..returns = !_structureIsAny(s, [
          MethodStructure.unInitialized,
          MethodStructure.staticUninitialized,
        ])
            ? References.future(returnRef)
            : returnRef
        ..body = cb.Block((cb.BlockBuilder builder) {
          switch (s) {
            case MethodStructure.staticReturnsVoid:
            case MethodStructure.staticPrimitive:
            case MethodStructure.primitive:
              if (diposerAssert != null) builder.addExpression(diposerAssert);
              builder.addExpression(nodeExpression);
              builder.addExpression(invokeNodeExpression.returned);
              break;
            case MethodStructure.returnsVoid:
              if (diposerAssert != null) builder.addExpression(diposerAssert);
              builder.addExpression(nodeExpression);
              builder.addExpression(
                  cb.refer('_invokerNode').assign(cb.refer('newNode')));
              if (handlesAllocation) {
                builder.addExpression(invokeNodeExpression.returned);
              } else {
                builder.addExpression(References.future(cb.refer('void'))
                    .property('value')
                    .call(<cb.Expression>[]).returned);
              }
              break;
            case MethodStructure.initializers:
            case MethodStructure.staticInitializers:
              if (diposerAssert != null) builder.addExpression(diposerAssert);
              builder.addExpression(handleExpression);
              builder.addExpression(nodeExpression);
              builder.addExpression(invokeNodeExpression.awaited
                  .assignFinal('source', cb.refer('Map')));
              builder.addExpression(objectExpression.returned);
              break;
            case MethodStructure.unInitialized:
              if (diposerAssert != null) builder.addExpression(diposerAssert);
              builder.addExpression(handleExpression);
              builder.addExpression(nodeExpression);
              if (handlesAllocation) {
                builder.addExpression(invokeNodeExpression);
              }
              builder.addExpression(objectExpression.returned);
              break;
            case MethodStructure.staticUninitialized:
              builder.addExpression(handleExpression);
              builder.addExpression(nodeExpression);
              builder.addExpression(invokeNodeExpression);
              builder.addExpression(objectExpression.returned);
              break;
          }
        });
    });
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

    if (returnedClass != null) {
      final String handleName = '__createdObjectHandle';
      paramExpressions[handleName] = cb.refer('newHandle');
    }

    return paramExpressions;
  }

  MethodStructure _getMethodStructure(
    bool returnsVoid,
    bool isStatic,
    bool recognizedClass,
    bool hasInitializers,
  ) {
    if (isStatic && returnsVoid)
      return MethodStructure.staticReturnsVoid;
    else if (!isStatic && returnsVoid)
      return MethodStructure.returnsVoid;
    else if (isStatic && !recognizedClass)
      return MethodStructure.staticPrimitive;
    else if (!isStatic && !recognizedClass)
      return MethodStructure.primitive;
    else if (isStatic && recognizedClass && hasInitializers)
      return MethodStructure.staticInitializers;
    else if (!isStatic && recognizedClass && hasInitializers)
      return MethodStructure.initializers;
    else if (isStatic && recognizedClass && !hasInitializers)
      return MethodStructure.staticUninitialized;
    else if (!isStatic && recognizedClass && !hasInitializers)
      return MethodStructure.unInitialized;
    else
      throw ArgumentError();
  }

  bool _structureIsAny(
    MethodStructure structure,
    Iterable<MethodStructure> structures,
  ) {
    return structures.any((MethodStructure element) => structure == element);
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
              .call(<cb.Expression>[
              cb.refer('creatorNode'),
              cb.literalString('\$handle+${field.name}'),
              sourceAccess
            ]);

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
                    includeSelfInvokerNode: false,
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
  ImplClassWriter(Plugin plugin, this.nameOfParentClass) : super(plugin) {
    if (nameOfParentClass == null) throw ArgumentError();
  }

  final String nameOfParentClass;

  @override
  cb.Class write(Class theClass) {
    if (theClass.details.hasConstructor) throw ArgumentError();

    return cb.Class((cb.ClassBuilder classBuilder) {
      classBuilder
        ..name = '_${theClass.name}Impl'
        ..extend = theClass.name != nameOfParentClass
            ? cb.refer(
                theClass.name,
                theClass.details.file,
              )
            : cb.refer(theClass.name)
        ..constructors.add(cb.Constructor(
          (cb.ConstructorBuilder builder) {
            builder
              ..requiredParameters.addAll(<cb.Parameter>[
                cb.Parameter((cb.ParameterBuilder builder) {
                  builder.name = 'creatorNode';
                  builder.type = References.methodCallInvokerNode;
                }),
                cb.Parameter((cb.ParameterBuilder builder) {
                  builder.name = 'newHandle';
                  builder.type = cb.refer('String');
                }),
                cb.Parameter((cb.ParameterBuilder builder) {
                  builder.name = 'source';
                  builder.type = cb.refer('Map');
                }),
              ])
              ..initializers.add(
                cb.refer('super').property('internal').call(<cb.Expression>[
                  cb.refer('creatorNode'),
                  cb.refer('newHandle'),
                  cb.refer('source'),
                ]).code,
              );
          },
        ));
    });
  }
}

class ClassWriter extends Writer<Class, cb.Library> {
  ClassWriter(Plugin plugin) : super(plugin);

  @override
  cb.Library write(Class theClass) {
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
      parentClassHasDisposer: theClass.details.hasDisposer,
    );

    final FieldWriter fieldWriter = FieldWriter(plugin, theClass.name);

    final Iterable<Class> implClasses = theClass.fieldsAndMethods
        .map<String>(
          (dynamic fieldOrMethod) => Plugin.returnType(fieldOrMethod),
        )
        .map<Class>((String type) => _classFromString(type))
        .toSet()
        .where(
          (Class theClass) =>
              theClass != null && !theClass.details.hasConstructor,
        );

    final ImplClassWriter implClassWriter = ImplClassWriter(
      plugin,
      theClass.name,
    );

    final MutableFieldWriter mutableFieldWriter = MutableFieldWriter(
      plugin,
      theClass.name,
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
              ...fieldWriter.writeAll(theClass.fields.where(
                (Field field) {
                  return field.mutable || field.initialized;
                },
              )),
            ])
            ..methods.addAll(mutableFieldWriter
                .writeAll(theClass.fields.where((Field field) => field.mutable))
                .expand((_) => _))
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
        ...implClassWriter.writeAll(implClasses),
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
                  builder
                    ..name = 'handle'
                    ..type = cb.refer('String');
                }),
                cb.Parameter((cb.ParameterBuilder builder) {
                  builder.name = 'source';
                  builder.type = cb.refer('Map');
                })
              ])
              ..initializers.addAll(<cb.Code>[
                cb.refer('_invokerNode').assign(cb.refer('creatorNode')).code,
                cb.refer('handle').assign(cb.refer('handle')).code,
                ...initializers,
              ]);
          },
        )
    ];
  }
}
