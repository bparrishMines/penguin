import 'package:penguin/src/plugin.dart';

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

  /// When one or more public constructors are specified, but no default constructor.
  specifiedNonDefaultWithParameters,

  /// When a default constructor with parameters is specified.
  specifiedDefaultWithParameters,

  /// When no constructor with parameters is specified.
  specifiedWithoutParameters,
}

ClassStructure getClassStructure(Plugin plugin, Class theClass) {
  if (theClass.constructors.isEmpty) {
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

  bool hasParameters = false;
  for (Constructor constructor in theClass.constructors) {
    if (_hasParameters(constructor) && constructor.name.isEmpty) {
      return ClassStructure.specifiedDefaultWithParameters;
    }

    if (_hasParameters(constructor)) hasParameters = true;
  }

  if (!hasParameters) {
    return ClassStructure.specifiedWithoutParameters;
  } else {
    return ClassStructure.specifiedNonDefaultWithParameters;
  }
}

bool _hasParameters(dynamic object) =>
    object.optionalParameters.isNotEmpty ||
    object.requiredParameters.isNotEmpty;
