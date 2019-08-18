import 'package:code_builder/code_builder.dart' as cb;

import 'plugin.dart';
import 'references.dart';

abstract class Writer<T, K> {
  Writer(this.plugin, this.nameOfParentClass) {
    if (plugin == null || nameOfParentClass == null) throw ArgumentError();
  }

  final Plugin plugin;
  final String nameOfParentClass;

  K write(T object);

  Iterable<K> writeAll(Iterable<T> objects) =>
      objects.map<K>((T object) => write(object)).toList();

  Class _classFromString(String className) {
    for (Class theClass in plugin.classes) {
      if (className == theClass.name) return theClass;
    }

    return null;
  }

  String _tryParseTypeFromList(String type) {
    final Match match = RegExp(r'List<(\w+)>').firstMatch(type);
    return match?.group(1);
  }

  List<String> _tryParseTypesFromMap(String type) {
    final Match match = RegExp(r'Map<(\w+)\s*,\s*(\w+)>').firstMatch(type);
    if (match == null || match.groupCount != 2) return null;
    return <String>[match.group(1), match.group(2)];
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

  cb.Expression _createNodeExpression(
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

  bool _isPrimitive(String type) {
    return _classFromString(type) == null;
  }

  bool _isInitializedClass(String type) {
    return _classFromString(type)?.details?.hasInitializedFields ?? false;
  }
}

class FieldWriter extends Writer<Field, cb.Field> {
  FieldWriter(Plugin plugin, String nameOfParentClass)
      : super(plugin, nameOfParentClass);

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
  MutableFieldWriter(Plugin plugin, String nameOfParentClass)
      : super(plugin, nameOfParentClass);

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
            builder.addExpression(_createNodeExpression(method,
                arguments: arguments,
                includeSelfInvokerNode: !field.isStatic,
                parameters: <Parameter>[
                  Parameter(field.name, type: field.type),
                ]).assignFinal('newNode', References.methodCallInvokerNode));
            if (field.force) {
              builder.addExpression(
                  cb.refer('newNode').property('invoke').call([]));
            }
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

//class UpdatedWriter extends Writer<Method, cb.Field> {
//  UpdatedWriter(Plugin plugin, String nameOfParentClass)
//      : super(plugin, nameOfParentClass);
//
//  @override
//  cb.Field write(Method method) {
//    if (!method.updated) return null;
//  }
//}

class MethodWriter extends Writer<dynamic, cb.Method> {
  MethodWriter(
    Plugin plugin,
    String nameOfParentClass, {
    this.parameterWriter,
    this.parentClassHasDisposer,
    this.parentClassHasAllocator,
  }) : super(plugin, nameOfParentClass) {
    if (parameterWriter == null ||
        parameterWriter == null ||
        parentClassHasDisposer == null ||
        parentClassHasAllocator == null) {
      throw ArgumentError();
    }
  }

  final ParameterWriter parameterWriter;
  final bool parentClassHasDisposer;
  final bool parentClassHasAllocator;

  @override
  cb.Method write(dynamic fieldOrMethod) {
    if (fieldOrMethod is Field &&
        (Plugin.mutable(fieldOrMethod) || Plugin.initialized(fieldOrMethod))) {
      throw ArgumentError();
    }

    final String name = fieldOrMethod.name;
    final String returnType = Plugin.returnType(fieldOrMethod);
    final bool static = fieldOrMethod.isStatic;
    final List<Parameter> parameters = Plugin.parameters(fieldOrMethod);
    final Class returnedClass = _classFromString(returnType);
////    final bool handlesAllocation =
////        Plugin.allocator(fieldOrMethod) || Plugin.disposer(fieldOrMethod);
//    final String listType = _tryParseTypeFromList(returnType);
//    final List<String> mapTypes = _tryParseTypesFromMap(returnType);
    final bool allocator = Plugin.allocator(fieldOrMethod);
    final bool returnsVoid = returnType == 'void';
    final bool disposer = Plugin.disposer(fieldOrMethod);
    final bool updater = Plugin.updater(fieldOrMethod);
    final bool forced = Plugin.force(fieldOrMethod);
    final bool primitive = returnedClass == null && returnType != 'void';
    final bool initializers =
        returnedClass != null && returnedClass.details.hasInitializedFields;
    final bool uninitialized = returnedClass != null && !initializers;
    final bool updated = fieldOrMethod.updated;
//
////    final MethodStructure s = _getMethodStructure(
////      returnType == 'void',
////      static,
////      returnedClass != null,
////      returnedClass != null && returnedClass.details.hasInitializedFields,
////    );
//
    final cb.Reference returnRef = _returnRef(
      returnType,
      initializers,
      updater,
    );
    final cb.Expression createCompleter = _createCompleter(returnType);
    final cb.Expression newNodeExpression = _newNodeExpression(fieldOrMethod);
    final cb.Expression setNodeExpression = _setNodeExpression();
    final cb.Expression emptyFutureExpression = _emptyFutureExpression();
    final cb.Expression invokeNodeExpression = _invokeExpression(
      returnType,
      updater,
    );
    final cb.Expression newHandleExpression = _newHandleExpression();
    final cb.Expression completerFuture = _completerFuture(returnType);
    final cb.Expression disposerAssert = _disposerAssert();
    final cb.Expression disposerReturn = _disposerReturn(name);

//
////    cb.Expression disposerAssert;
////    if (parentClassHasDisposer && !static) {
//    cb.Expression disposerAssert = cb.refer('assert').call(<cb.Expression>[
//      cb
//          .refer('invokerNode')
//          .property('type')
//          .notEqualTo(References.nodeType.property('disposer')),
//      cb.literalString('This object has been disposed.'),
//    ]);
////    }
//
////    cb.Expression updateNode;
////    if (parentClassHasAllocator && !static) {
//    cb.Expression updateNode = cb
//        .refer('_updateInvokerNode')
//        .call(<cb.Expression>[cb.refer('newNode')]);
////    }
//
////    cb.Expression handleExpression;
////    if (returnedClass != null) {
//    cb.Expression handleExpression = References.channel
//        .property('nextHandle')
//        .call(<cb.Expression>[]).assignFinal('newHandle', cb.refer('String'));
////    }
//
//    String nodeType;
//    if (Plugin.allocator(fieldOrMethod)) {
//      nodeType = 'allocator';
//    } else if (Plugin.disposer(fieldOrMethod)) {
//      nodeType = 'disposer';
//    }
//
//    cb.Expression newNodeExpression = _invokerNodeExpression(
//      invokeMethod,
//      arguments: _mappedMethodParams(fieldOrMethod),
//      parameters: parameters,
//      includeSelfInvokerNode: !static,
//      nodeType: nodeType,
//    ).assignFinal('newNode', References.methodCallInvokerNode);
//
//    List<cb.Reference> types = <cb.Reference>[];
//    String invokeMethodName;
//    if (listType != null) {
//      invokeMethodName = 'invokeList';
//      types.add(cb.refer(listType));
//    } else if (mapTypes != null) {
//      invokeMethodName = 'invokeMap';
//      types.add(cb.refer(mapTypes[0]));
//      types.add(cb.refer(mapTypes[1]));
//    } else if (returnedClass == null) {
//      invokeMethodName = 'invoke';
//      types.add(cb.refer(returnType));
//    } else if (returnedClass.details.hasInitializedFields) {
//      invokeMethodName = 'invokeMap';
//      types.add(cb.refer('String'));
//      types.add(cb.refer('dynamic'));
//    } else {
//      invokeMethodName = 'invoke';
//      types.add(cb.refer('void'));
//    }
//
////    cb.Expression invokeNodeExpression;
////    if (handlesAllocation ||
////        fieldOrMethod.force ||
////        (s == MethodStructure.returnsVoid && parentClassHasDisposer) ||
////        !_structureIsAny(s, [
////          MethodStructure.unInitialized,
////          MethodStructure.returnsVoid,
////        ])) {
//    cb.Expression invokeNodeExpression =
//        cb.refer('newNode').property(invokeMethodName).call(
//      [],
//      {},
//      types,
//    );
////    }
//
////    cb.Expression setNodeExpression;
////    if (allocator || _structureIsAny(s, [MethodStructure.returnsVoid])) {
//    cb.Expression setNodeExpression =
//        cb.refer('_invokerNode').assign(cb.refer('newNode'));
////    }
//
//    cb.Expression emptyFutureExpression =
//        References.future(cb.refer('void')).property('value').call([]).returned;
//
//    cb.Expression objectExpression;
////    if (_structureIsAny(s, [
////      MethodStructure.unInitialized,
////      MethodStructure.staticUninitialized,
////    ])) {
//    if (returnedClass != null && returnedClass.details.hasInitializedFields) {
//      objectExpression = _getConstructor(
//              returnedClass, returnedClass.name == nameOfParentClass)
//          .call(
//        <cb.Expression>[
//          cb.refer('newNode'),
//          cb.refer('newHandle'),
//          cb.literalNull,
//        ],
//      );
////    } else if (_structureIsAny(s, [
////      MethodStructure.initializers,
////      MethodStructure.staticInitializers,
////    ])) {
//    } else {
//      objectExpression = _getConstructor(
//              returnedClass, returnedClass.name == nameOfParentClass)
//          .call(
//        <cb.Expression>[
//          cb.refer('newNode'),
//          cb.refer('newHandle'),
//          cb.refer('source'),
//        ],
//      );
//    }
////      );
////    }

    return cb.Method((cb.MethodBuilder builder) {
      if (fieldOrMethod is Field) {
        builder.type = cb.MethodType.getter;
      }

      builder
        ..name = name
        ..static = static
        ..requiredParameters.addAll(parameterWriter.writeAll(parameters))
        ..returns = returnRef
        ..body = cb.Block((cb.BlockBuilder builder) {
          if (parentClassHasDisposer && updated && !static) {
            builder
              ..addExpression(disposerReturn)
              ..addExpression(disposerAssert);
          } else if (parentClassHasDisposer && !static) {
            builder..addExpression(disposerAssert);
          }

          if (returnsVoid && static) {
            builder
              ..addExpression(newNodeExpression)
              ..addExpression(invokeNodeExpression.returned);
          } else if (returnsVoid && updater && (allocator || disposer)) {
            builder
              ..addExpression(createCompleter)
              ..addExpression(newNodeExpression)
              ..addExpression(setNodeExpression)
              ..addExpression(invokeNodeExpression)
              ..addExpression(completerFuture);
          } else if (returnsVoid && updater) {
            builder
              ..addExpression(createCompleter)
              ..addExpression(newNodeExpression)
              ..addExpression(invokeNodeExpression)
              ..addExpression(completerFuture);
          } else if (returnsVoid && forced && (allocator || disposer)) {
            builder
              ..addExpression(newNodeExpression)
              ..addExpression(setNodeExpression)
              ..addExpression(invokeNodeExpression.returned);
          } else if (returnsVoid && forced) {
            builder
              ..addExpression(newNodeExpression)
              ..addExpression(invokeNodeExpression.returned);
          } else if (returnsVoid && (allocator || disposer)) {
            builder
              ..addExpression(newNodeExpression)
              ..addExpression(setNodeExpression)
              ..addExpression(invokeNodeExpression.returned);
          } else if (returnsVoid && parentClassHasAllocator) {
            builder
              ..addExpression(newNodeExpression)
              ..addExpression(_allocatorCheckInvoke())
              ..addExpression(setNodeExpression)
              ..addExpression(emptyFutureExpression);
          }else if (returnsVoid) {
            builder
              ..addExpression(newNodeExpression)
              ..addExpression(setNodeExpression)
              ..addExpression(emptyFutureExpression);
          }

          if (primitive && static) {
            builder
              ..addExpression(newNodeExpression)
              ..addExpression(invokeNodeExpression.returned);
          } else if (primitive && updater && (allocator || disposer)) {
            builder
              ..addExpression(createCompleter)
              ..addExpression(newNodeExpression)
              ..addExpression(setNodeExpression)
              ..addExpression(invokeNodeExpression)
              ..addExpression(completerFuture);
          } else if (primitive && updater) {
            builder
              ..addExpression(createCompleter)
              ..addExpression(newNodeExpression)
              ..addExpression(invokeNodeExpression)
              ..addExpression(completerFuture);
          } else if (primitive && (allocator || disposer)) {
            builder
              ..addExpression(newNodeExpression)
              ..addExpression(setNodeExpression)
              ..addExpression(invokeNodeExpression.returned);
          } else if (primitive) {
            builder
              ..addExpression(newNodeExpression)
              ..addExpression(invokeNodeExpression.returned);
          }

          if (initializers && static) {
            builder
              ..addExpression(createCompleter)
              ..addExpression(newHandleExpression)
              ..addExpression(newNodeExpression)
              ..addExpression(invokeNodeExpression)
              ..addExpression(completerFuture);
          } else if (initializers && updater && (allocator || disposer)) {
            builder
              ..addExpression(createCompleter)
              ..addExpression(newHandleExpression)
              ..addExpression(newNodeExpression)
              ..addExpression(setNodeExpression)
              ..addExpression(invokeNodeExpression)
              ..addExpression(completerFuture);
          } else if (initializers && updater) {
            builder
              ..addExpression(createCompleter)
              ..addExpression(newHandleExpression)
              ..addExpression(newNodeExpression)
              ..addExpression(invokeNodeExpression)
              ..addExpression(completerFuture);
          } else if (initializers && (allocator || disposer)) {
            builder
              ..addExpression(createCompleter)
              ..addExpression(newHandleExpression)
              ..addExpression(newNodeExpression)
              ..addExpression(setNodeExpression)
              ..addExpression(invokeNodeExpression)
              ..addExpression(completerFuture);
          } else if (initializers) {
            builder
              ..addExpression(createCompleter)
              ..addExpression(newHandleExpression)
              ..addExpression(newNodeExpression)
              ..addExpression(invokeNodeExpression)
              ..addExpression(completerFuture);
          }

          if (uninitialized && static) {
            builder
              ..addExpression(newHandleExpression)
              ..addExpression(newNodeExpression)
              ..addExpression(invokeNodeExpression)
              ..addExpression(_newObjectExpression(
                returnedClass,
                cb.literalNull,
              ).returned);
          } else if (uninitialized && updater && (allocator || disposer)) {
            builder
              ..addExpression(createCompleter)
              ..addExpression(newHandleExpression)
              ..addExpression(newNodeExpression)
              ..addExpression(setNodeExpression)
              ..addExpression(invokeNodeExpression)
              ..addExpression(completerFuture);
          } else if (uninitialized && updater) {
            builder
              ..addExpression(createCompleter)
              ..addExpression(newHandleExpression)
              ..addExpression(newNodeExpression)
              ..addExpression(invokeNodeExpression)
              ..addExpression(completerFuture);
          } else if (uninitialized && (allocator || disposer)) {
            builder
              ..addExpression(newHandleExpression)
              ..addExpression(newNodeExpression)
              ..addExpression(setNodeExpression)
              ..addExpression(invokeNodeExpression)
              ..addExpression(_newObjectExpression(
                returnedClass,
                cb.literalNull,
              ).returned);
          } else if (uninitialized) {
            builder
              ..addExpression(newHandleExpression)
              ..addExpression(newNodeExpression)
              ..addExpression(invokeNodeExpression)
              ..addExpression(_newObjectExpression(
                returnedClass,
                cb.literalNull,
              ).returned);
          }

          //if ()
//          switch (s) {
//            case MethodStructure.staticReturnsVoid:
//            case MethodStructure.staticPrimitive:
//            case MethodStructure.primitive:
//              if (disposerAssert != null) builder.addExpression(disposerAssert);
//              builder.addExpression(newNodeExpression);
//              if (updateNode != null) builder.addExpression(updateNode);
//              builder.addExpression(invokeNodeExpression.returned);
//              break;
//            case MethodStructure.returnsVoid:
//              if (disposerAssert != null) builder.addExpression(disposerAssert);
//              builder.addExpression(newNodeExpression);
//              if (updateNode != null) builder.addExpression(updateNode);
//              if (!handlesAllocation && parentClassHasAllocator) {
//                builder.addExpression(cb.refer(
//                  'if (invokerNode.type != NodeType.allocator) return Future<void>.value()',
//                ));
//              }
//              if (parentClassHasAllocator) {
//                builder.addExpression(invokeNodeExpression.returned);
//              } else if (fieldOrMethod.force) {
//                builder.addExpression(setNodeExpression);
//                builder.addExpression(invokeNodeExpression.returned);
//              } else {
//                builder.addExpression(setNodeExpression);
//                builder.addExpression(References.future(cb.refer('void'))
//                    .property('value')
//                    .call([]).returned);
//              }
//              break;
//            case MethodStructure.initializers:
//            case MethodStructure.staticInitializers:
//              if (disposerAssert != null) builder.addExpression(disposerAssert);
//              builder.addExpression(handleExpression);
//              builder.addExpression(newNodeExpression);
//              if (updateNode != null) builder.addExpression(updateNode);
//              builder.addExpression(invokeNodeExpression.awaited
//                  .assignFinal('source', cb.refer('Map')));
//              builder.addExpression(objectExpression.returned);
//              break;
//            case MethodStructure.unInitialized:
//              if (disposerAssert != null) builder.addExpression(disposerAssert);
//              builder.addExpression(handleExpression);
//              builder.addExpression(newNodeExpression);
//              if (updateNode != null) builder.addExpression(updateNode);
//              builder.addExpression(objectExpression.returned);
//              break;
//            case MethodStructure.staticUninitialized:
//              builder.addExpression(handleExpression);
//              builder.addExpression(newNodeExpression);
//              builder.addExpression(invokeNodeExpression);
//              if (updateNode != null) builder.addExpression(updateNode);
//              builder.addExpression(objectExpression.returned);
//              break;
//          }
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

  cb.Expression _disposerAssert() {
    return cb.refer('assert').call(<cb.Expression>[
      cb
          .refer('invokerNode')
          .property('type')
          .notEqualTo(References.nodeType.property('disposer')),
      cb.literalString('This object has been disposed.'),
    ]);
  }

  cb.Expression _disposerReturn(String methodName) {
    return cb.refer(
      'if (_invokerNode.type == NodeType.disposer && _$methodName != null) return _$methodName',
    );
  }

  List<cb.Expression> _updateMethodExpressions() {
    final Class parentClass = _classFromString(nameOfParentClass);
    final List<dynamic> updatedMethods = parentClass.fieldsAndMethods
        .where((fieldOrMethod) => fieldOrMethod.updated)
        .toList();

    final List<cb.Expression> updateMethodExpressions = <cb.Expression>[];
    for (dynamic fieldOrMethod in updatedMethods) {
      final String methodName = fieldOrMethod.name;

      final cb.Expression sourceAccess =
          cb.refer('source').index(cb.literalString(methodName));

      updateMethodExpressions.add(
        cb.refer('_$methodName').assign(sourceAccess),
      );
    }

    return updateMethodExpressions;
  }

  cb.Reference _returnRef(String returnType, bool initializers, bool updater) {
    final Class returnedClass = _classFromString(returnType);

    cb.Reference returnRef;
    if (returnedClass == null || returnType == nameOfParentClass) {
      returnRef = cb.refer(returnType);
    } else {
      returnRef = cb.refer(returnType, returnedClass.details.file);
    }

    if (returnedClass == null || initializers || updater) {
      return returnRef = References.future(returnRef);
    }

    return returnRef;
  }

  cb.Expression _createCompleter(String returnType) {
    final Class returnedClass = _classFromString(returnType);

    cb.Reference completerRef;
    if (returnedClass == null || returnType == nameOfParentClass) {
      completerRef = References.completer(cb.refer(returnType));
    } else {
      completerRef = References.completer(cb.refer(
        returnType,
        returnedClass.details.file,
      ));
    }

    return completerRef
        .call(<cb.Expression>[]).assignFinal('completer', completerRef);
  }

  cb.Expression _newNodeExpression(dynamic fieldOrMethod) {
    String nodeType;
    if (Plugin.allocator(fieldOrMethod)) {
      nodeType = 'allocator';
    } else if (Plugin.disposer(fieldOrMethod)) {
      nodeType = 'disposer';
    }

    return _createNodeExpression(
      '$nameOfParentClass#${fieldOrMethod.name}',
      arguments: _mappedMethodParams(fieldOrMethod),
      parameters: Plugin.parameters(fieldOrMethod),
      includeSelfInvokerNode: !fieldOrMethod.isStatic,
      nodeType: nodeType,
    ).assignFinal('newNode', References.methodCallInvokerNode);
  }

  cb.Expression _allocatorCheckInvoke() {
    return cb.refer(
      'if (invokerNode.type == NodeType.allocator) newNode.invoke<void>()',
    );
  }

  cb.Expression _setNodeExpression() {
    return cb.refer('_invokerNode').assign(cb.refer('newNode'));
  }

  cb.Expression _emptyFutureExpression() {
    return References.future(cb.refer('void'))
        .property('value')
        .call([]).returned;
  }

  cb.Expression _invokeExpression(String returnType, bool updater) {
    final String listType = _tryParseTypeFromList(returnType);
    final List<String> mapTypes = _tryParseTypesFromMap(returnType);
    final Class returnedClass = _classFromString(returnType);

    List<cb.Reference> types = <cb.Reference>[];
    String invokeMethodName;
    if (listType != null) {
      invokeMethodName = 'invokeList';
      types.add(cb.refer(listType));
    } else if (mapTypes != null) {
      invokeMethodName = 'invokeMap';
      types.add(cb.refer(mapTypes[0]));
      types.add(cb.refer(mapTypes[1]));
    } else if (returnedClass == null && !updater) {
      invokeMethodName = 'invoke';
      types.add(cb.refer(returnType));
    } else if (updater || _isInitializedClass(returnType)) {
      invokeMethodName = 'invokeMap';
      types.add(cb.refer('String'));
      types.add(cb.refer('dynamic'));
    } else {
      invokeMethodName = 'invoke';
      types.add(cb.refer('void'));
    }

    if (!updater && !_isInitializedClass(returnType)) {
      return cb.refer('newNode').property(invokeMethodName).call(
        [],
        {},
        types,
      );
    } else {
      return cb
          .refer('newNode')
          .property(invokeMethodName)
          .call([], {}, types)
          .property('then')
          .call(<cb.Expression>[_returnedMapExpression(returnType, updater)]);
    }
  }

  cb.Expression _returnedMapExpression(String returnType, updater) {
    return MethodExpression(cb.Method(
      (cb.MethodBuilder builder) {
        builder
          ..name = ''
          ..requiredParameters
              .add(cb.Parameter((cb.ParameterBuilder paramBuilder) {
            paramBuilder
              ..name = 'source'
              ..type = References.standardMap;
          }))
          ..body = cb.Block((cb.BlockBuilder blockBuilder) {
            if (updater) {
              for (cb.Expression expression in _updateMethodExpressions()) {
                blockBuilder.addExpression(expression);
              }
            }
            blockBuilder.addExpression(_completerComplete(returnType));
          });
      },
    ));
  }

  cb.Expression _newHandleExpression() {
    return References.channel
        .property('nextHandle')
        .call(<cb.Expression>[]).assignFinal('newHandle', cb.refer('String'));
  }

  cb.Expression _completerFuture(String returnType) {
    return cb.refer('completer').property('future').returned;
  }

  cb.Expression _completerComplete(String returnType) {
    final Class returnedClass = _classFromString(returnType);

    final cb.Expression source =
        cb.refer('source').index(cb.literalString('result'));

    return cb.refer('completer').property('complete').call(<cb.Expression>[
      if (_isPrimitive(returnType)) source,
      if (returnedClass != null) _newObjectExpression(returnedClass, source),
    ]);
  }

  cb.Expression _newObjectExpression(
    Class returnedClass,
    cb.Expression source,
  ) {
    return _getConstructor(
      returnedClass,
      returnedClass.name == nameOfParentClass,
    ).call(
      <cb.Expression>[cb.refer('newNode'), cb.refer('newHandle'), source],
    );
  }
}

class InitializerWriter extends Writer<Field, cb.Code> {
  InitializerWriter(Plugin plugin, String nameOfParentClass, this.setNull)
      : super(plugin, nameOfParentClass) {
    if (setNull == null) throw ArgumentError();
  }

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
    Plugin plugin,
    String nameOfParentClass, {
    this.initializers,
    this.parameterWriter,
  }) : super(plugin, nameOfParentClass) {
    if (nameOfParentClass == null ||
        initializers == null ||
        parameterWriter == null) throw ArgumentError();
  }

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
              cb.refer('_invokerNode').assign(_createNodeExpression(
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
  ParameterWriter(Plugin plugin, String nameOfParentClass)
      : super(plugin, nameOfParentClass);

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
  ImplClassWriter(Plugin plugin, String nameOfParentClass)
      : super(plugin, nameOfParentClass);

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

class ConstantWriter extends Writer<Constant, cb.Field> {
  ConstantWriter(Plugin plugin, String nameOfParentClass)
      : super(plugin, nameOfParentClass);

  @override
  cb.Field write(Constant constant) {
    final Class constantClass = _classFromString(constant.type);
    final cb.Code assignment = constant.type == 'String'
        ? cb.literalString(constant.literalValue).code
        : cb.Code(constant.literalValue);
    return cb.Field((cb.FieldBuilder builder) {
      builder
        ..name = constant.name
        ..static = true
        ..assignment = assignment
        ..modifier = cb.FieldModifier.final$
        ..type =
            constantClass == null || constantClass.name == nameOfParentClass
                ? cb.refer(constant.type)
                : cb.refer(constantClass.name, constantClass.details.file);
    });
  }
}

class DirectiveWriter extends Writer<Constant, Iterable<cb.Directive>> {
  DirectiveWriter(Plugin plugin, String nameOfParentClass)
      : super(plugin, nameOfParentClass);

  @override
  Iterable<cb.Directive> write(Constant constant) {
    final List<Class> recognizedClasses = <Class>[];
    for (Class pluginClass in plugin.classes) {
      if (pluginClass.name == nameOfParentClass) continue;
      if (constant.literalValue.contains('${pluginClass.name}(')) {
        recognizedClasses.add(_classFromString(plugin.name));
      }
    }

    return recognizedClasses.map<cb.Directive>(
      (Class aClass) => cb.Directive.import(aClass.details.file),
    );
  }
}

class ClassWriter extends Writer<Class, cb.Library> {
  ClassWriter(Plugin plugin) : super(plugin, '');

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
      theClass.name,
      initializers: constructorInitWriter.writeAll(theClass.fields.where(
        (Field field) => field.initialized,
      )),
      parameterWriter: parameterWriter,
    );

    final MethodWriter methodWriter = MethodWriter(
      plugin,
      theClass.name,
      parameterWriter: parameterWriter,
      parentClassHasDisposer: theClass.details.hasDisposer,
      parentClassHasAllocator: theClass.details.hasAllocator,
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

    final ConstantWriter constantWriter = ConstantWriter(plugin, theClass.name);
    final DirectiveWriter directiveWriter = DirectiveWriter(
      plugin,
      theClass.name,
    );

    return cb.Library((cb.LibraryBuilder builder) {
      builder
        ..directives.addAll(
            directiveWriter.writeAll(theClass.constants).expand((_) => _))
        ..body.addAll(<cb.Class>[
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
                ...constantWriter.writeAll(theClass.constants),
                cb.Field((cb.FieldBuilder builder) {
                  builder
                    ..name = '_invokerNode'
                    ..type = References.methodCallInvokerNode;
                }),
                if (theClass.details.hasConstructor ||
                    theClass.details.isReferenced)
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
                  .writeAll(
                      theClass.fields.where((Field field) => field.mutable))
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
              ..methods.addAll([
                if (!theClass.details.hasConstructor &&
                    !theClass.details.isReferenced)
                  cb.Method((cb.MethodBuilder builder) {
                    builder
                      ..name = 'handle'
                      ..returns = cb.refer('String')
                      ..type = cb.MethodType.getter;
                  }),
                ...methodWriter.writeAll(theClass.methods),
                if (theClass.details.hasAllocator) _updateNodeMethod(),
              ]);
          }),
          ...implClassWriter.writeAll(implClasses),
        ]);
    });
  }

  cb.Method _updateNodeMethod() {
    return cb.Method((cb.MethodBuilder builder) {
      builder
        ..name = '_updateInvokerNode'
        ..returns = cb.refer('void')
        ..requiredParameters.add(cb.Parameter(
          (cb.ParameterBuilder paramBuilder) {
            paramBuilder
              ..name = 'newNode'
              ..type = References.methodCallInvokerNode;
          },
        ))
        ..body = cb.Code(
          '''
if (newNode.type != NodeType.disposer && 
    _invokerNode.type == NodeType.allocator) {
  return;
}
_invokerNode = newNode;
''',
        );
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
                    ..toThis = true;
                }),
                cb.Parameter((cb.ParameterBuilder builder) {
                  builder.name = 'source';
                  builder.type = cb.refer('Map');
                })
              ])
              ..initializers.addAll(<cb.Code>[
                cb.refer('_invokerNode').assign(cb.refer('creatorNode')).code,
                ...initializers,
              ]);
          },
        )
    ];
  }
}

class MethodExpression extends cb.Expression {
  MethodExpression(this.method);

  final cb.Method method;

  @override
  R accept<R>(cb.ExpressionVisitor<R> visitor, [R context]) {
    return method.accept(visitor, context);
  }
}
