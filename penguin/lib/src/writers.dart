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
}

class MethodWriter extends Writer<dynamic, cb.Method> {
  MethodWriter({Plugin plugin, this.className, this.implSuffix})
      : assert(className != null),
        assert(implSuffix != null),
        super(plugin) {
    _paramWriter = ParameterWriter(plugin);
  }

  @override
  cb.Method write(dynamic methodCreator) {
    assert(methodCreator is Method || methodCreator is Field);

    if (methodCreator is Method) {
      return _writeFor(
        name: methodCreator.name,
        returnType: methodCreator.returns,
        isStatic: methodCreator.isStatic,
        requiredParameters: methodCreator.requiredParameters,
        optionalParameters: methodCreator.optionalParameters,
      );
    }

    final Field field = methodCreator;
    return _writeFor(
      name: field.name,
      returnType: field.type,
      isStatic: field.isStatic,
      isField: true,
    );
  }

  final String className;
  final String implSuffix;
  ParameterWriter _paramWriter;

  cb.Method _writeFor({
    String name,
    String returnType,
    bool isStatic = false,
    List<Parameter> requiredParameters = const <Parameter>[],
    List<Parameter> optionalParameters = const <Parameter>[],
    bool isField = false,
  }) {
    final Class theClass = _classFromString(returnType);

    void addNameAndParams(cb.MethodBuilder builder) {
      builder
        ..name = name
        ..static = isStatic
        ..requiredParameters.addAll(
          _paramWriter.writeAll(requiredParameters),
        )
        ..optionalParameters.addAll(
          _paramWriter.writeAll(optionalParameters),
        );

      if (isField) {
        builder.type = cb.MethodType.getter;
      }
    }

    if (theClass == null) {
      return cb.Method((cb.MethodBuilder builder) {
        addNameAndParams(builder);

        builder.returns = References.future(cb.refer(returnType));
        builder.body = cb.Block((cb.BlockBuilder builder) {
          builder.addExpression(_invokeMethodExpression(
            type: cb.refer(returnType),
            className: className,
            methodName: name,
            hasHandle: !isStatic,
            arguments: _mappedParams(
              returnType: returnType,
              requiredParameters: requiredParameters,
              optionalParameters: optionalParameters,
            ),
          ).returned);
        });
      });
    } else {
      final cb.Reference returnRef = returnType == className
          ? cb.refer(returnType)
          : cb.refer(returnType, theClass.details.file);

      final String returnName = returnType.toLowerCase();

      return cb.Method((cb.MethodBuilder builder) {
        addNameAndParams(builder);

        builder.returns = returnRef;
        builder.body = cb.Block((cb.BlockBuilder builder) {
          builder.addExpression(
            cb
                .refer('_${returnType}$implSuffix')
                .call(<cb.Expression>[]).assignFinal(returnName),
          );

          builder.addExpression(_invokeMethodExpression(
            className: className,
            methodName: name,
            hasHandle: !isStatic,
            arguments: _mappedParams(
              returnType: returnType,
              requiredParameters: requiredParameters,
              optionalParameters: optionalParameters,
              returnName: returnName,
            ),
          ));

          builder.addExpression(cb.refer(returnName).returned);
        });
      });
    }
  }

  Map<String, cb.Expression> _mappedParams({
    String returnType,
    List<Parameter> requiredParameters = const <Parameter>[],
    List<Parameter> optionalParameters = const <Parameter>[],
    String returnName,
  }) {
    final List<Parameter> allParameters =
        requiredParameters + optionalParameters;

    final Map<String, cb.Expression> paramExpressions =
        <String, cb.Expression>{};
    for (Parameter parameter in allParameters) {
      final Class aClass = _classFromString(parameter.type);

      if (aClass != null) {
        paramExpressions['${parameter.name.toLowerCase()}Handle'] =
            cb.refer(parameter.name).property('handle');
      } else {
        paramExpressions[parameter.name] = cb.refer(parameter.name);
      }
    }

    if (returnName != null) {
      paramExpressions['${returnName}Handle'] =
          cb.refer(returnName).property('handle');
    }

    return paramExpressions;
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
            arguments: _mappedParams(constructor),
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

  Map<String, cb.Expression> _mappedParams(Constructor constructor) {
    final List<Parameter> allParameters =
        constructor.requiredParameters + constructor.optionalParameters;

    final Map<String, cb.Expression> paramExpressions =
        <String, cb.Expression>{};
    for (Parameter parameter in allParameters) {
      final Class aClass = _classFromString(parameter.type);

      if (aClass != null) {
        paramExpressions['${parameter.name.toLowerCase()}Handle'] =
            cb.refer(parameter.name).property('handle');
      } else {
        paramExpressions[parameter.name] = cb.refer(parameter.name);
      }
    }

    final String handleName = className.toLowerCase();
    paramExpressions['${handleName}Handle'] = cb.refer('handle');

    return paramExpressions;
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
          ..methods.addAll(methodWriter.writeAll(theClass.fields))
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

  void _addImplClasses(cb.LibraryBuilder builder, Class theClass) {
    final Set<String> addedClass = <String>{};

    final List<dynamic> allReturners = List<dynamic>()
      ..addAll(theClass.methods)
      ..addAll(theClass.fields);

    for (dynamic returner in allReturners) {
      String returnType;
      if (returner is Method) {
        returnType = returner.returns;
      } else if (returner is Field) {
        returnType = returner.type;
      }

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
