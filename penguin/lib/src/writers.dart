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
  }) {
    if (hasHandle) {
      Map<String, cb.Expression> newMap =
          Map<String, cb.Expression>.from(arguments);
      newMap['handle'] = cb.refer('handle');
      arguments = newMap;
    }

    return cb.InvokeExpression.newOf(
      References.channel.property('channel').property('invokeMethod'),
      <cb.Expression>[
        cb.literalString('$className${useHashTag ? '#' : ''}$methodName'),
        cb.literalMap(arguments, cb.refer('String'), cb.refer('dynamic'))
      ],
      <String, cb.Expression>{},
      <cb.Reference>[type ?? cb.refer('void')],
    );
  }

  Map<String, cb.Expression> _mappedParams(
    dynamic constructorFieldOrMethod,
    String varName,
  ) {
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

    final String handleName = '${varName.toLowerCase()}Handle';
    if (constructorFieldOrMethod is Constructor) {
      paramExpressions[handleName] = cb.refer('handle');
    } else if (_classFromString(varName) != null) {
      paramExpressions[handleName] =
          cb.refer(varName.toLowerCase()).property('handle');
    }

    return paramExpressions;
  }
}

class FieldWriter extends Writer<Field, List<cb.Method>> {
  FieldWriter(Plugin plugin, this.className, this.methodWriter)
      : assert(methodWriter != null),
        super(plugin);

  final String className;
  final MethodWriter methodWriter;

  @override
  List<cb.Method> write(Field field) {
    if (!field.mutable) return <cb.Method>[methodWriter.write(field)];

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
  MethodWriter({Plugin plugin, this.className, this.implSuffix})
      : assert(className != null),
        assert(implSuffix != null),
        super(plugin) {
    _paramWriter = ParameterWriter(plugin);
  }

  final String className;
  final String implSuffix;
  ParameterWriter _paramWriter;

  @override
  cb.Method write(dynamic fieldOrMethod) {
    final String returnType = Plugin.returnType(fieldOrMethod);

    final Class theClass = _classFromString(returnType);

    final cb.InvokeExpression invokeMethodExpression = _invokeMethodExpression(
      type: theClass == null ? cb.refer(returnType) : null,
      className: className,
      methodName: fieldOrMethod.name,
      hasHandle: !fieldOrMethod.isStatic,
      arguments: _mappedParams(fieldOrMethod, returnType),
    );

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
      final cb.Reference returnRef = returnType == className
          ? cb.refer(returnType)
          : cb.refer(returnType, theClass.details.file);

      final String varName = returnType.toLowerCase();

      return cb.Method((cb.MethodBuilder builder) {
        addNameAndParams(builder);

        builder.returns = returnRef;
        builder.body = cb.Block((cb.BlockBuilder builder) {
          builder.addExpression(
            cb
                .refer('_${returnType}$implSuffix')
                .call(<cb.Expression>[]).assignFinal(varName),
          );

          builder.addExpression(invokeMethodExpression);

          builder.addExpression(cb.refer(varName).returned);
        });
      });
    }
  }
}

class ConstructorWriter extends Writer<Constructor, cb.Constructor> {
  ConstructorWriter(Plugin plugin, this.className)
      : assert(className != null),
        super(plugin) {
    _paramWriter = ParameterWriter(plugin);
  }

  final String className;
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
            className: className,
            methodName: _getMethodCallMethod(constructor),
            arguments: _mappedParams(constructor, className),
            useHashTag: false,
          ));
        });

      if (constructor.name != null) {
        builder.name = constructor.name;
      }
    });
  }

  String _getMethodCallMethod(Constructor constructor) {
    final List<Parameter> allParameters =
        constructor.requiredParameters + constructor.optionalParameters;

    final Iterable<String> parameterTypes = allParameters.map<String>(
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

class ClassWriter extends Writer<Class, cb.Library> {
  const ClassWriter(Plugin plugin) : super(plugin);

  static final String _implSuffix = 'Impl';

  @override
  cb.Library write(Class theClass) {
    final MethodWriter methodWriter = MethodWriter(
      plugin: plugin,
      className: theClass.name,
      implSuffix: _implSuffix,
    );

    final FieldWriter fieldWriter = FieldWriter(
      plugin,
      theClass.name,
      methodWriter,
    );

    final ConstructorWriter constructWriter = ConstructorWriter(
      plugin,
      theClass.name,
    );

    final cb.Library library = cb.Library((cb.LibraryBuilder builder) {
      builder.body.add(cb.Class((cb.ClassBuilder classBuilder) {
        classBuilder
          ..name = theClass.name
          ..abstract = !theClass.details.hasConstructor
          ..constructors.addAll(constructWriter.writeAll(theClass.constructors))
          ..fields.add(_handle)
          ..fields.addAll(_getMutableFields(theClass))
          ..methods.addAll(
            fieldWriter.writeAll(theClass.fields).expand((_) => _),
          )
          ..methods.addAll(methodWriter.writeAll(theClass.methods));

        if (theClass.details.hasConstructor && theClass.details.isReferenced) {
          classBuilder.constructors.add(_emptyPrivateConstructor);
        }
      }));

      _addImplClasses(builder, theClass);
    });

    return library;
  }

  static final cb.Constructor _emptyPrivateConstructor = cb.Constructor(
    (cb.ConstructorBuilder builder) => builder.name = 'internal',
  );

  List<cb.Field> _getMutableFields(Class theClass) {
    final List<cb.Field> fields = <cb.Field>[];
    for (Field field in theClass.fields) {
      if (!field.mutable) continue;

      final Class theClass = _classFromString(field.type);

      fields.add(
        cb.Field((cb.FieldBuilder builder) {
          builder
            ..name = '_${field.name}'
            ..static = field.isStatic
            ..type = theClass == null
                ? cb.refer(field.type)
                : cb.refer(theClass.name, theClass.details.file);
        }),
      );
    }

    return fields;
  }

  void _addImplClasses(cb.LibraryBuilder builder, Class theClass) {
    final Set<String> addedClass = <String>{};

    for (dynamic fieldOrMethod in theClass.fieldsAndMethods) {
      if (Plugin.mutable(fieldOrMethod)) continue;

      final String returnType = Plugin.returnType(fieldOrMethod);

      final Class returnClass = _classFromString(returnType);

      if (returnClass != null && !addedClass.contains(returnClass.name)) {
        addedClass.add(returnClass.name);

        final cb.Reference reference = returnType == theClass.name
            ? cb.refer(returnType)
            : cb.refer(returnType, returnClass.details.file);

        builder.body.add(cb.Class((cb.ClassBuilder classBuilder) {
          classBuilder
            ..name = '_${returnType}$_implSuffix'
            ..extend = reference;

          if (returnClass.details.hasConstructor &&
              returnClass.details.isReferenced) {
            classBuilder.constructors.add(cb.Constructor(
              (cb.ConstructorBuilder builder) {
                builder.initializers.add(
                  cb
                      .refer('super')
                      .property('internal')
                      .call(<cb.Expression>[]).code,
                );
              },
            ));
          }
        }));
      }
    }
  }

  static final cb.Field _handle = cb.Field((cb.FieldBuilder builder) {
    builder.name = 'handle';
    builder.modifier = cb.FieldModifier.final$;
    builder.type = cb.Reference('int');
    builder.assignment = References.channel.property('nextHandle++').code;
  });
}
