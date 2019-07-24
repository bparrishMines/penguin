part of 'writer.dart';

class FieldWriter extends Writer<Field, cb.Method> {
  const FieldWriter(Plugin plugin, this.className) : super(plugin);

  final String className;

  @override
  cb.Method write(Field field) {
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
  }
}

class MethodWriter extends Writer<Method, cb.Method> {
  const MethodWriter(Plugin plugin, this.className) : super(plugin);

  final String className;

  @override
  cb.Method write(Method method) {
    final List<Parameter> allParameters =
        method.requiredParameters + method.optionalParameters;

    final Map<String, cb.Expression> mappedParamExpressions =
        <String, cb.Expression>{};
    for (Parameter parameter in allParameters) {
      mappedParamExpressions[parameter.name] = cb.refer(parameter.name);
    }

    //final ClassStructure structure = _tryGetClassStructure(method.returns);

    final ParameterWriter paramWriter = ParameterWriter(plugin);

    final cb.Method codeMethod = cb.Method((cb.MethodBuilder builder) {
      if (method.type != null) {
        builder.type = method.type;
      } else {
        /*
        switch (structure) {
          case ClassStructure.unspecifiedPublic:
          case ClassStructure.unspecifiedPrivate:
            builder.returns = cb.refer(method.returns);
            break;
          default:
            builder.returns = cb.TypeReference(
              (cb.TypeReferenceBuilder builder) {
                builder.symbol = 'Future';
                builder.types.add(cb.refer(method.returns));
              },
            );
        }
        */
      }

      builder.name = method.name;
      builder.requiredParameters.addAll(
        paramWriter.writeAll(method.requiredParameters),
      );
      builder.optionalParameters.addAll(
        paramWriter.writeAll(method.optionalParameters),
      );

      /*
      if (structure == ClassStructure.unspecifiedPrivate) {
        builder.body = cb.Block((cb.BlockBuilder builder) {
          final String valueName = method.returns.toLowerCase();

          builder.addExpression(_constructorExpression(
            className: method.returns,
            private: true,
          ).assignFinal(valueName, cb.refer(method.returns)));

          mappedParamExpressions['${valueName}Handle'] =
              cb.refer(valueName).property('_handle');

          builder.addExpression(_invokeMethodExpression(
            className: className,
            methodName: method.name,
            hasHandle: true,
            arguments: mappedParamExpressions,
          ));

          builder.addExpression(cb.refer(valueName).returned);
        });
      } else {
        builder.body = cb.Block((cb.BlockBuilder builder) {
          builder.addExpression(_invokeMethodExpression(
            type: method.returns,
            className: className,
            methodName: method.name,
            hasHandle: true,
            arguments: mappedParamExpressions,
          ).returned);
        });
      }
      */
    });

    return codeMethod;
  }
}

class ParameterWriter extends Writer<Parameter, cb.Parameter> {
  const ParameterWriter(Plugin plugin) : super(plugin);

  @override
  cb.Parameter write(Parameter parameter) {
    final cb.Parameter codeParam = cb.Parameter((cb.ParameterBuilder builder) {
      builder.name = parameter.name;
      builder.type = cb.refer(parameter.type);
    });

    return codeParam;
  }
}

class ClassWriter extends Writer<Class, cb.Class> {
  const ClassWriter(Plugin plugin, this.className) : super(plugin);

  final String className;

  @override
  cb.Class write(Class theClass) {
    //final ClassStructure structure = _structureFromClass(theClass);

    final MethodWriter methodWriter = MethodWriter(plugin, className);
    final FieldWriter fieldWriter = FieldWriter(plugin, className);

    final cb.Class codeClass = cb.Class((cb.ClassBuilder builder) {
      builder.name = theClass.name;

      /*
      if (structure == ClassStructure.unspecifiedPrivate ||
          structure == ClassStructure.unspecifiedPublic) {
        builder.fields.add(_handle);
      }
      */

      builder.methods.addAll(fieldWriter.writeAll(theClass.fields));
      builder.methods.addAll(methodWriter.writeAll(theClass.methods));
    });

    return codeClass;
  }

  static final cb.Field _handle = cb.Field((cb.FieldBuilder builder) {
    builder.name = '_handle';
    builder.modifier = cb.FieldModifier.final$;
    builder.type = cb.Reference('int');
    builder.assignment = cb.Code('Channel.nextHandle++');
  });
}
