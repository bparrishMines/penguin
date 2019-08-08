import 'package:code_builder/code_builder.dart' as cb;

import 'plugin.dart';
import 'references.dart';

abstract class Writer<T, K> {
  const Writer(this.plugin) : assert(plugin != null);

  final Plugin plugin;

  K write(T object);

  List<K> writeAll(List<T> objects) =>
      objects.map<K>((T object) => write(object)).toList();

  Class _classFromString(String className) {
    for (Class theClass in plugin.classes) {
      if (className == theClass.name) return theClass;
    }

    return null;
  }

  cb.InvokeExpression _invokeMethodExpression({
    cb.Reference type,
    String className,
    String methodName = '',
    bool hasHandle = false,
    bool useHashTag = true,
    Map<String, cb.Expression> arguments = const <String, cb.Expression>{},
    bool mapMethod = false,
  }) {
    if (mapMethod && type != null) throw ArgumentError();

    if (hasHandle) {
      Map<String, cb.Expression> newMap =
          Map<String, cb.Expression>.from(arguments);
      newMap['handle'] = cb.refer('handle');
      arguments = newMap;
    }

    return cb.InvokeExpression.newOf(
      References.channel
          .property('channel')
          .property(mapMethod ? 'invokeMapMethod' : 'invokeMethod'),
      <cb.Expression>[
        cb.literalString('$className${useHashTag ? '#' : ''}$methodName'),
        cb.literalMap(arguments, cb.refer('String'), cb.refer('dynamic'))
      ],
      <String, cb.Expression>{},
      mapMethod
          ? <cb.Reference>[cb.refer('String'), cb.refer('dynamic')]
          : <cb.Reference>[type ?? cb.refer('void')],
    );
  }

  Map<String, cb.Expression> _mappedParams(
    dynamic constructorFieldOrMethod,
    String returnedType, {
    bool hasInitializedFields = false,
  }) {
    assert(constructorFieldOrMethod is Constructor ||
        constructorFieldOrMethod is Method ||
        constructorFieldOrMethod is Field);

    final Map<String, cb.Expression> paramExpressions =
        <String, cb.Expression>{};

    if (constructorFieldOrMethod is Constructor ||
        constructorFieldOrMethod is Method) {
      for (Parameter parameter in constructorFieldOrMethod.allParameters) {
        final Class aClass = _classFromString(parameter.type);

        if (aClass != null) {
          paramExpressions['${parameter.name.toLowerCase()}Handle'] =
              cb.refer(parameter.name).property('handle');
        } else {
          paramExpressions[parameter.name] = cb.refer(parameter.name);
        }
      }
    }

    final String handleName = '${returnedType.toLowerCase()}Handle';
    final Class returnedClass = _classFromString(returnedType);
    if (constructorFieldOrMethod is Constructor) {
      paramExpressions[handleName] = cb.refer('handle');
    } else if (returnedClass != null &&
        !returnedClass.details.hasInitializedFields) {
      paramExpressions[handleName] =
          cb.refer(returnedType.toLowerCase()).property('handle');
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
  MethodFieldWriter(Plugin plugin, this.className, this.methodWriter)
      : assert(methodWriter != null),
        super(plugin);

  final String className;
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
              ..addExpression(_invokeMethodExpression(
                  className: className,
                  methodName: field.name,
                  hasHandle: !field.isStatic,
                  arguments: arguments))
              ..addExpression(variableRef.assign(cb.refer(field.name)));
          });
      }),
    ]);

    return methods;
  }
}

class MethodWriter extends Writer<dynamic, cb.Method> {
  MethodWriter({Plugin plugin, this.nameOfParentClass, this.implSuffix})
      : assert(nameOfParentClass != null),
        assert(implSuffix != null),
        super(plugin) {
    _paramWriter = ParameterWriter(plugin);
  }

  final String nameOfParentClass;
  final String implSuffix;
  ParameterWriter _paramWriter;

  @override
  cb.Method write(dynamic fieldOrMethod) {
    final String returnType = Plugin.returnType(fieldOrMethod);

    final Class theClass = _classFromString(returnType);

    final cb.InvokeExpression invokeMethodExpression = _invokeMethodExpression(
        type: theClass == null ? cb.refer(returnType) : null,
        className: nameOfParentClass,
        methodName: fieldOrMethod.name,
        hasHandle: !fieldOrMethod.isStatic,
        arguments: _mappedParams(fieldOrMethod, returnType),
        mapMethod: theClass != null && theClass.details.hasInitializedFields);

    void addNameAndParams(cb.MethodBuilder builder) {
      builder
        ..name = fieldOrMethod.name
        ..static = fieldOrMethod.isStatic;

      if (fieldOrMethod is Field) {
        builder.type = cb.MethodType.getter;
      } else {
        builder
          ..requiredParameters.addAll(
            _paramWriter.writeAll(fieldOrMethod.requiredParameters),
          )
          ..optionalParameters.addAll(
            _paramWriter.writeAll(fieldOrMethod.optionalParameters),
          );
      }
    }

    if (theClass == null) {
      return cb.Method((cb.MethodBuilder builder) {
        addNameAndParams(builder);

        builder.returns = References.future(cb.refer(returnType));
        builder.body = cb.Block((cb.BlockBuilder builder) {
          builder.addExpression(invokeMethodExpression.returned);
        });
      });
    } else {
      final cb.Reference returnRef = returnType == nameOfParentClass
          ? cb.refer(returnType)
          : cb.refer(returnType, theClass.details.file);

      final String varName = returnType.toLowerCase();

      return cb.Method((cb.MethodBuilder builder) {
        addNameAndParams(builder);

        builder.returns = theClass.details.hasInitializedFields
            ? References.future(returnRef)
            : returnRef;

        final cb.Expression constructor = !theClass.details.hasConstructor
            ? cb.refer('_${returnType}$implSuffix')
            : returnRef.property('internal');

        if (theClass.details.hasInitializedFields) {
          builder.modifier = cb.MethodModifier.async;
          builder.body = cb.Block((cb.BlockBuilder builder) {
            builder.addExpression(
              invokeMethodExpression.awaited
                  .assignFinal('source', cb.refer('Map')),
            );

            builder.addExpression(
              constructor.call(<cb.Expression>[cb.refer('source')]).returned,
            );
          });
        } else {
          builder.body = cb.Block((cb.BlockBuilder builder) {
            builder.addExpression(
              constructor
                  .call(<cb.Expression>[]).assignFinal(varName, returnRef),
            );

            builder.addExpression(invokeMethodExpression);

            builder.addExpression(cb.refer(varName).returned);
          });
        }
      });
    }
  }
}

class ConstructorWriter extends Writer<Constructor, cb.Constructor> {
  ConstructorWriter(Plugin plugin, this.theClass)
      : assert(theClass != null),
        super(plugin) {
    _paramWriter = ParameterWriter(plugin);
  }

  final Class theClass;
  ParameterWriter _paramWriter;

  @override
  cb.Constructor write(Constructor constructor) {
    return cb.Constructor((cb.ConstructorBuilder builder) {
      builder
        ..requiredParameters.addAll(
          _paramWriter.writeAll(constructor.requiredParameters),
        )
        ..optionalParameters.addAll(
          _paramWriter.writeAll(constructor.optionalParameters),
        )
        ..body = cb.Block((cb.BlockBuilder builder) {
          builder.addExpression(_invokeMethodExpression(
            className: theClass.name,
            methodName: _getMethodCallMethod(constructor.allParameters),
            arguments: _mappedParams(constructor, theClass.name),
            useHashTag: false,
          ));
        });

      if (theClass.details.hasInitializedFields) {
        final Iterable<Field> initializedFields =
            theClass.fields.where((Field field) => field.initialized);

        final Iterable<cb.Code> initializers = initializedFields.map<cb.Code>(
          (Field field) {
            final String fieldName =
                field.mutable ? '_${field.name}' : field.name;
            return cb.refer(fieldName).assign(cb.literalNull).code;
          },
        );

        builder.initializers.addAll(<cb.Code>[
          cb
              .refer('handle')
              .assign(
                References.channel
                    .property('nextHandle')
                    .call(<cb.Expression>[]),
              )
              .code,
          ...initializers,
        ]);
      }

      if (constructor.name != null) {
        builder.name = constructor.name;
      }
    });
  }

  String _getMethodCallMethod(List<Parameter> parameters) {
    final Iterable<String> parameterTypes = parameters.map<String>(
      (Parameter parameter) => parameter.type,
    );

    return '(${parameterTypes.join(',')})';
  }
}

class ParameterWriter extends Writer<Parameter, cb.Parameter> {
  const ParameterWriter(Plugin plugin) : super(plugin);

  @override
  cb.Parameter write(Parameter parameter) {
    final Class theClass = _classFromString(parameter.type);

    final cb.Parameter codeParam = cb.Parameter((cb.ParameterBuilder builder) {
      builder
        ..name = parameter.name
        ..type = theClass == null
            ? cb.refer(parameter.type)
            : cb.refer(parameter.type, theClass.details.file);
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
              ..requiredParameters.add(
                cb.Parameter((cb.ParameterBuilder builder) {
                  builder.name = 'source';
                  builder.type = cb.refer('Map');
                }),
              )
              ..initializers.add(
                cb
                    .refer('super')
                    .property('internal')
                    .call(<cb.Expression>[cb.refer('source')]).code,
              );
          },
        ));
      }
    });
  }
}

class ClassWriter extends Writer<Class, cb.Library> {
  const ClassWriter(Plugin plugin) : super(plugin);

  static final String _implSuffix = 'Impl';

  @override
  cb.Library write(Class theClass) {
    final MethodWriter methodWriter = MethodWriter(
      plugin: plugin,
      nameOfParentClass: theClass.name,
      implSuffix: _implSuffix,
    );

    final MethodFieldWriter methodFieldWriter = MethodFieldWriter(
      plugin,
      theClass.name,
      methodWriter,
    );

    final FieldWriter fieldWriter = FieldWriter(plugin);

    final ConstructorWriter constructWriter = ConstructorWriter(
      plugin,
      theClass,
    );

    final ImplClassWriter implClassWriter =
        ImplClassWriter(plugin, _implSuffix, theClass);

    final List<Class> implClasses = theClass.fieldsAndMethods
        .map<String>(
          (dynamic fieldOrMethod) => Plugin.returnType(fieldOrMethod),
        )
        .map<Class>((String type) => _classFromString(type))
        .toSet()
        .where(
          (Class theClass) =>
              theClass != null && !theClass.details.hasConstructor,
        )
        .toList();

    final cb.Library library = cb.Library((cb.LibraryBuilder builder) {
      builder.body.addAll(<cb.Class>[
        cb.Class((cb.ClassBuilder classBuilder) {
          classBuilder
            ..name = theClass.name
            ..abstract = !theClass.details.hasConstructor
            ..constructors
                .addAll(constructWriter.writeAll(theClass.constructors))
            ..fields.add(_invokerNode)
            ..fields.add(_handle(
              theClass.details.hasInitializedFields,
              theClass.details.isInitializedField,
            ))
            ..fields.addAll(fieldWriter.writeAll(theClass.fields.where(
              (Field field) {
                return field.mutable || field.initialized;
              },
            ).toList()))
            ..methods.addAll(
              methodFieldWriter.writeAll(theClass.fields).expand((_) => _),
            )
            ..methods.addAll(methodWriter.writeAll(theClass.methods));

          if (!theClass.details.hasConstructor &&
              theClass.details.isInitializedField) {
            classBuilder.constructors.add(
              _abstractDefaultConstructor(theClass),
            );
          }

          if ((theClass.details.hasConstructor &&
                  theClass.details.isReferenced) ||
              theClass.details.hasInitializedFields ||
              theClass.details.isInitializedField) {
            classBuilder.constructors.add(_internalConstructor(theClass));
          }
        }),
        ...implClassWriter.writeAll(implClasses),
      ]);
    });

    return library;
  }

  cb.Constructor _internalConstructor(Class theClass) {
    return cb.Constructor(
      (cb.ConstructorBuilder builder) {
        builder.name = 'internal';

        if (!theClass.details.hasInitializedFields &&
            !theClass.details.isInitializedField) {
          return;
        }

        builder
          ..requiredParameters.add(
            cb.Parameter((cb.ParameterBuilder builder) {
              builder.name = 'source';
              builder.type = cb.refer('Map');
            }),
          )
          ..initializers.add(cb
              .refer('handle')
              .assign(
                cb.refer('source').index(cb.literalString('handle')),
              )
              .code);

        final Iterable<Field> initializedFields =
            theClass.fields.where((Field field) => field.initialized);

        final Iterable<cb.Code> initializers = initializedFields.map<cb.Code>(
          (Field field) {
            final String fieldName =
                field.mutable ? '_${field.name}' : field.name;

            final cb.Expression mapAccess =
                cb.refer('source').index(cb.literalString(field.name));

            final Class varClass = _classFromString(field.type);
            final cb.Expression value = varClass == null
                ? mapAccess
                : cb
                    .refer('_${field.type}$_implSuffix')
                    .call(<cb.Expression>[mapAccess]);

            return cb.refer(fieldName).assign(value).code;
          },
        );

        builder.initializers.addAll(initializers);
      },
    );
  }

  cb.Constructor _abstractDefaultConstructor(Class theClass) {
    return cb.Constructor((cb.ConstructorBuilder builder) {
      builder.initializers.add(cb
          .refer('handle')
          .assign(
            References.channel.property('nextHandle').call(<cb.Expression>[]),
          )
          .code);
    });
  }

  cb.Field _handle(bool hasInitializedFields, bool isInitializedField) {
    return cb.Field((cb.FieldBuilder builder) {
      builder
        ..name = 'handle'
        ..modifier = cb.FieldModifier.final$
        ..type = cb.Reference('String');

      if (!hasInitializedFields && !isInitializedField) {
        builder.assignment = References.channel
            .property('nextHandle')
            .call(<cb.Expression>[]).code;
      }
    });
  }

  static cb.Field get _invokerNode => cb.Field((cb.FieldBuilder builder) {
        builder
          ..name = '_invokerNode'
          ..type = References.methodCallInvokerNode;
      });
}
