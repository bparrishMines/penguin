import 'package:code_builder/code_builder.dart' as cb;

import 'plugin.dart';

part 'writers.dart';

/// This decides the structure of a generated class.
///
/// It depends solely on what [Constructor]s are defined and whether the [Class]
/// is referenced in another [Class] within the [Plugin].
enum ClassStructure {
  /// When the only [Constructor] is the default [Constructor].
  ///
  /// This occurs when there is no specified [Constructor] and zero
  /// [Method]s/[Field]s that reference this class.
  unspecifiedPublic,

  /// When the only [Constructor] is a default private [Constructor].
  ///
  /// This occurs when there is no specified [Constructor], but there are
  /// methods from other classes that return this class.
  unspecifiedPrivate,

  /*
  /// When one or more public constructors are specified, but no default constructor.
  specifiedNonDefaultWithParameters,

  /// When a default constructor with parameters is specified.
  specifiedDefaultWithParameters,

  /// When no constructor with parameters is specified.
  specifiedWithoutParameters,
  */
}

abstract class Writer<T, K> {
  const Writer(this.plugin);

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

  ClassStructure _tryGetClassStructure(String className) {
    final Class theClass = _classFromString(className);

    if (theClass != null) {
      return _structureFromClass(theClass);
    }

    return null;
  }

  ClassStructure _structureFromClass(Class theClass) {
    assert(theClass != null);

    for (Class dClass in plugin.classes) {
      for (Method method in dClass.methods) {
        if (method.returns == theClass.name) {
          return ClassStructure.unspecifiedPrivate;
        }
      }

      for (Field field in dClass.fields) {
        if (field.type == theClass.name) {
          return ClassStructure.unspecifiedPrivate;
        }
      }
    }

    return ClassStructure.unspecifiedPublic;
  }

  bool _hasParameters(dynamic object) =>
      object.optionalParameters.isNotEmpty ||
      object.requiredParameters.isNotEmpty;

  cb.InvokeExpression _invokeMethodExpression({
    String type = 'void',
    String className,
    String methodName,
    bool hasHandle = false,
    Map<String, cb.Expression> arguments = const <String, cb.Expression>{},
  }) {
    if (hasHandle) {
      Map<String, cb.Expression> newMap =
          Map<String, cb.Expression>.from(arguments);
      newMap['handle'] = cb.refer('_handle');
      arguments = newMap;
    }

    return cb.InvokeExpression.newOf(
      cb.refer('Channel').property('channel').property('invokeMethod'),
      <cb.Expression>[
        cb.literalString('$className#$methodName'),
        cb.literalMap(arguments, cb.refer('String'), cb.refer('dynamic'))
      ],
      <String, cb.Expression>{},
      <cb.Reference>[cb.refer(type)],
    );
  }

  cb.InvokeExpression _constructorExpression({
    String className,
    String name = '',
    bool private = false,
    List<cb.Expression> positionalArguments = const <cb.Expression>[],
    Map<String, cb.Expression> namedArguments = const <String, cb.Expression>{},
  }) {
    return cb.InvokeExpression.newOf(
      cb.refer(className),
      positionalArguments,
      namedArguments,
      <cb.Reference>[],
      private ? '_$name' : name,
    );
  }
}
