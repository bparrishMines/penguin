part of 'writer.dart';

class FieldWriter extends Writer<Field, cb.Method> {
  FieldWriter(Plugin plugin, this.className) : super(plugin);

  final String className;

  @override
  cb.Method write(Field field) {
    final cb.Method codeMethod = cb.Method((cb.MethodBuilder builder) {
      builder.name = field.name;
      builder.type = cb.MethodType.getter;
      builder.returns = cb.refer('Future<${field.type}>');
      builder.type = cb.MethodType.getter;
      builder.static = field.static;
      builder.body = cb.Code(
        '''
        return Channel.channel.invokeMethod<void>(
          '${className}#${field.name}',
          ${field.static ? '' : "<String, dynamic>{'handle': _handle},"}
        );
          ''',
      );
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

    final ParameterWriter paramWriter = ParameterWriter(plugin);

    final cb.Method codeMethod = cb.Method((cb.MethodBuilder builder) {
      builder.name = method.name;
      builder.returns = cb.refer('Future<${method.returns ?? 'void'}>');
      builder.requiredParameters.addAll(
        paramWriter.writeAll(method.requiredParameters),
      );
      builder.optionalParameters.addAll(
        paramWriter.writeAll(method.optionalParameters),
      );
      builder.body = cb.Code(
        '''
        return Channel.channel.invokeMethod<${method.returns ?? 'void'}>(
          '$className#${method.name}',
          <String, dynamic>{'handle': _handle, ${allParameterBuffer.toString()}}
        );
        ''',
      );
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
  ClassWriter(Plugin plugin, this.structure, this.className) : super(plugin);

  final ClassStructure structure;

  final String className;

  @override
  cb.Class write(Class theClass) {
    final ConstructorWriter constructorWriter = ConstructorWriter(
      plugin,
      structure,
      className,
    );
    final MethodWriter methodWriter = MethodWriter(plugin, className);
    final FieldWriter fieldWriter = FieldWriter(plugin, className);

    final cb.Class codeClass = cb.Class((cb.ClassBuilder builder) {
      builder.name = theClass.name;

      builder.constructors.addAll(
        constructorWriter.writeAll(theClass.constructors),
      );

      builder.fields.add(_handle);

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
  ConstructorWriter(Plugin plugin, this.structure, this.className)
      : super(plugin);

  final ClassStructure structure;

  final String className;

  @override
  cb.Constructor write(Constructor constructor) {
    final cb.Constructor codeConstructor = cb.Constructor(
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

    return codeConstructor;
  }
}
