import 'package:code_builder/code_builder.dart' as cb;

import 'plugin.dart';
import 'plugin_creator.dart';
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
      newMap['handle'] = cb.refer('_handle');
      arguments = newMap;
    }

    return cb.InvokeExpression.newOf(
      References.channel.property('channel').property('invokeMethod'),
      <cb.Expression>[
        cb.literalString('$className${useHashTag ? '#' : ''}$methodName'),
        cb.literalMap(arguments, cb.refer('String'), cb.refer('dynamic'))
      ],
      <String, cb.Expression>{},
      <cb.Reference>[type],
    );
  }
}

class FieldWriter extends Writer<Field, cb.Method> {
  const FieldWriter({Plugin plugin, this.className, this.implSuffix})
      : assert(className != null),
        assert(implSuffix != null),
        super(plugin);

  final String className;
  final String implSuffix;

  @override
  cb.Method write(Field field) {
    final Class theClass = _classFromString(field.type);

    void addNameAndParams(cb.MethodBuilder builder) {
      builder
        ..name = field.name
        ..type = cb.MethodType.getter
        ..static = field.static;
    }

    if (theClass == null) {
      return cb.Method((cb.MethodBuilder builder) {
        addNameAndParams(builder);

        builder.returns = cb.TypeReference((cb.TypeReferenceBuilder builder) {
          builder
            ..symbol = 'Future'
            ..types.add(cb.refer(field.type))
            ..url = 'dart:async';
        });
        builder.body = cb.Block((cb.BlockBuilder builder) {
          builder.addExpression(_invokeMethodExpression(
            type: cb.refer(field.type),
            className: className,
            methodName: field.name,
            hasHandle: true,
          ).returned);
        });
      });
    } else {
      final cb.Reference returnRef = cb.refer(
        field.type,
        theClass.details.file,
      );
      final String returnName = field.type.toLowerCase();

      return cb.Method((cb.MethodBuilder builder) {
        addNameAndParams(builder);

        builder.returns = returnRef;
        builder.body = cb.Block((cb.BlockBuilder builder) {
          builder.addExpression(
            cb
                .refer('${field.type}$implSuffix')
                .call(<cb.Expression>[]).assignFinal(returnName),
          );

          builder.addExpression(_invokeMethodExpression(
            type: returnRef,
            className: className,
            methodName: field.type,
            hasHandle: !field.static,
          ));

          builder.addExpression(cb.refer(returnName).returned);
        });
      });
    }
    /*
    final cb.Method codeMethod = cb.Method((cb.MethodBuilder builder) {
      builder.name = field.name;
      builder.type = cb.MethodType.getter;
      builder.static = field.static;



      /*
      final ClassStructure structure = _tryGetClassStructure(field.type);

      if (structure == ClassStructure.unspecifiedPrivate) {
        builder.returns = cb.refer(field.type);
        builder.body = cb.Block((cb.BlockBuilder builder) {
          final String valueName = field.type.toLowerCase();

          builder.addExpression(
            _constructorExpression(
              className: field.type,
              private: true,
            ).assignFinal(valueName, cb.refer(field.type)),
          );

          builder.addExpression(_invokeMethodExpression(
            className: className,
            methodName: field.name,
            hasHandle: false,
            arguments: <String, cb.Expression>{
              '${valueName}Handle': cb.refer(valueName).property('_handle'),
            },
          ));

          builder.addExpression(cb.refer(valueName).returned);
        });
      } else {
        builder.returns = cb.TypeReference(
          (cb.TypeReferenceBuilder builder) {
            builder.symbol = 'Future';
            builder.types.add(cb.refer(field.type));
          },
        );
        builder.body = cb.Block((cb.BlockBuilder builder) {
          builder.addExpression(_invokeMethodExpression(
            type: field.type,
            className: className,
            methodName: field.name,
            hasHandle: !field.static,
          ).returned);
        });
      }*/
    });

    return codeMethod;
    */
  }
}

class MethodWriter extends Writer<Method, cb.Method> {
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
  cb.Method write(Method method) {
    final Class theClass = _classFromString(method.returns);

    void addNameAndParams(cb.MethodBuilder builder) {
      builder
        ..name = method.name
        ..requiredParameters.addAll(
          _paramWriter.writeAll(method.requiredParameters),
        )
        ..optionalParameters.addAll(
          _paramWriter.writeAll(method.optionalParameters),
        );
    }

    if (theClass == null) {
      return cb.Method((cb.MethodBuilder builder) {
        addNameAndParams(builder);

        builder.returns = cb.TypeReference((cb.TypeReferenceBuilder builder) {
          builder
            ..symbol = 'Future'
            ..types.add(cb.refer(method.returns))
            ..url = 'dart:async';
        });
        builder.body = cb.Block((cb.BlockBuilder builder) {
          builder.addExpression(_invokeMethodExpression(
            type: cb.refer(method.returns),
            className: className,
            methodName: method.name,
            hasHandle: true,
            arguments: _mappedParams(method),
          ).returned);
        });
      });
    } else {
      final cb.Reference returnRef = cb.refer(
        method.returns,
        theClass.details.file,
      );
      final String returnName = method.returns.toLowerCase();

      return cb.Method((cb.MethodBuilder builder) {
        addNameAndParams(builder);

        builder.returns = returnRef;
        builder.body = cb.Block((cb.BlockBuilder builder) {
          builder.addExpression(
            cb
                .refer('${method.returns}$implSuffix')
                .call(<cb.Expression>[]).assignFinal(returnName),
          );

          builder.addExpression(_invokeMethodExpression(
            type: returnRef,
            className: className,
            methodName: method.name,
            hasHandle: true,
            arguments: _mappedParams(method),
          ));

          builder.addExpression(cb.refer(returnName).returned);
        });
      });
    }
  }

  Map<String, cb.Expression> _mappedParams(Method method) {
    final List<Parameter> allParameters =
        method.requiredParameters + method.optionalParameters;

    final Map<String, cb.Expression> paramExpressions =
        <String, cb.Expression>{};
    for (Parameter parameter in allParameters) {
      paramExpressions[parameter.name] = cb.refer(parameter.name);
    }

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

    final FieldWriter fieldWriter = FieldWriter(
      plugin: plugin,
      className: theClass.name,
      implSuffix: _implSuffix,
    );

    final cb.Library library = cb.Library((cb.LibraryBuilder builder) {
      builder.body.add(cb.Class((cb.ClassBuilder classBuilder) {
        classBuilder
          ..name = theClass.name
          ..abstract = theClass.details.constructorType == ConstructorType.none
          ..fields.add(_handle)
          ..methods.addAll(fieldWriter.writeAll(theClass.fields))
          ..methods.addAll(methodWriter.writeAll(theClass.methods));
      }));

      for (Method method in theClass.methods) {
        final Class methodClass = _classFromString(method.returns);
        if (methodClass != null) {
          builder.body.add(cb.Class((cb.ClassBuilder classBuilder) {
            classBuilder
              ..name = '${method.returns}$_implSuffix'
              ..extend = cb.refer(methodClass.name, methodClass.details.file);
          }));
        }
      }
    });

    return library;
  }

  static final cb.Field _handle = cb.Field((cb.FieldBuilder builder) {
    builder.name = '_handle';
    builder.modifier = cb.FieldModifier.final$;
    builder.type = cb.Reference('int');
    builder.assignment = References.channel.property('nextHandle++').code;
  });
}
