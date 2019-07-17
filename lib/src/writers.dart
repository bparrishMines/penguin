part of 'writer.dart';

class FieldWriter extends Writer<Field, cb.Method> {
  FieldWriter(Plugin plugin, this.className) : super(plugin);

  final String className;

  @override
  cb.Method write(Field field) {
    final cb.Method codeMethod = cb.Method((cb.MethodBuilder builder) {
      builder.name = field.name;
      builder.type = cb.MethodType.getter;
      builder.static = field.static;

      final ClassStructure structure = _tryGetClassStructure(className);

      if (structure == ClassStructure.unspecifiedPublic) {
        builder.returns = cb.refer(field.type);
        builder.body = cb.Code('return ${field.type}();');
      } else if (structure == ClassStructure.unspecifiedPrivate) {
        builder.returns = cb.refer(field.type);
        builder.body = cb.Code('return ${field.type}._();');
      } else {
        builder.returns = cb.refer('Future<${field.type}>');
        builder.body = cb.Code(
          '''
          return Channel.channel.invokeMethod<void>(
            '${className}#${field.name}',
            ${field.static ? '' : "<String, dynamic>{'handle': _handle},"}
          );
          ''',
        );
      }
    });

    return codeMethod;
  }
}

class MethodWriter extends Writer<Method, cb.Method> {
  MethodWriter(Plugin plugin, this.className) : super(plugin);

  final String className;

  @override
  cb.Method write(Method method) {
    final List<Parameter> allParameters =
        method.requiredParameters + method.optionalParameters;

    final StringBuffer allParameterBuffer = StringBuffer();
    for (Parameter parameter in allParameters) {
      allParameterBuffer.write('\'${parameter.name}\': ${parameter.name},');
    }

    final ClassStructure structure = _tryGetClassStructure(method.returns);

    final ParameterWriter paramWriter = ParameterWriter(plugin);

    final cb.Method codeMethod = cb.Method((cb.MethodBuilder builder) {
      builder.name = method.name;
      builder.requiredParameters.addAll(
        paramWriter.writeAll(method.requiredParameters),
      );
      builder.optionalParameters.addAll(
        paramWriter.writeAll(method.optionalParameters),
      );

      if (structure == ClassStructure.unspecifiedPublic) {
        builder.returns = cb.refer(method.returns);
        builder.body = cb.Code('return ${method.returns}();');
      } else if (structure == ClassStructure.unspecifiedPrivate) {
        builder.returns = cb.refer(method.returns);
        builder.body = cb.Code('return ${method.returns}._();');
      } else {
        builder.returns = cb.refer('Future<${method.returns}>');
        builder.body = cb.Code(
          '''
          return Channel.channel.invokeMethod<${method.returns}>(
            '$className#${method.name}',
            <String, dynamic>{'handle': _handle, ${allParameterBuffer.toString()}}
          );
          ''',
        );
      }
    });

    return codeMethod;
  }
}

class ParameterWriter extends Writer<Parameter, cb.Parameter> {
  ParameterWriter(Plugin plugin) : super(plugin);

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
  ClassWriter(Plugin plugin, this.className) : super(plugin);

  final String className;

  @override
  cb.Class write(Class theClass) {
    final ClassStructure structure = _structureFromClass(theClass);

    final ConstructorWriter constructorWriter = ConstructorWriter(
      plugin,
      className,
      structure,
    );
    final MethodWriter methodWriter = MethodWriter(plugin, className);
    final FieldWriter fieldWriter = FieldWriter(plugin, className);

    final cb.Class codeClass = cb.Class((cb.ClassBuilder builder) {
      builder.name = theClass.name;

      if (structure == ClassStructure.unspecifiedPrivate ||
          structure == ClassStructure.unspecifiedPublic) {
        builder.constructors.add(constructorWriter.write(null));
        builder.fields.add(_handle);
      }

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

class ConstructorWriter extends Writer<Constructor, cb.Constructor> {
  ConstructorWriter(Plugin plugin, this.className, this.structure)
      : super(plugin);

  final String className;

  final ClassStructure structure;

  @override
  cb.Constructor write(Constructor constructor) {
    switch (structure) {
      case ClassStructure.unspecifiedPublic:
      case ClassStructure.unspecifiedPrivate:
        return _defaultConstructor;
    }

    return null; // Unreachable
  }

  cb.Constructor get _defaultConstructor => cb.Constructor(
        (cb.ConstructorBuilder builder) {
          if (structure == ClassStructure.unspecifiedPrivate) {
            builder.name = '_';
          }
          builder.body = cb.Code(
            '''
            Channel.channel.invokeMethod<void>(
              '$className()',
              <String, dynamic>{'handle': _handle},
            );
            ''',
          );
        },
      );
}
