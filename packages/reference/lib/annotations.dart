/// A [ReferenceParameter] with the ignore flag set to true.
const ignoreParam = ReferenceParameter(ignore: true);

/// Annotation used with reference_generator plugin.
class ClassReference {
  /// Default constructor for [Reference].
  const ClassReference({
    required this.channel,
    required this.platformImport,
    required this.platformClassName,
  });

  /// Name of the channel used to generate a `TypeChannel`.
  final String channel;

  /// Import of the platform class [platformClassName].
  final String platformImport;

  /// Name of the platorm implementation of a class.
  final String platformClassName;
}

/// Annotation used with reference_generator plugin.
class FunctionReference {
  /// Default constructor for [Reference].
  const FunctionReference(this.channel);

  /// Name of the channel used to generate a `TypeChannel`.
  final String channel;
}

/// Annotation to customize methods for reference_generator plugin.
class ReferenceMethod {
  /// Default constructor for [ReferenceMethod].
  const ReferenceMethod({this.ignore = false});

  /// Ignore this method.
  final bool ignore;
}

/// Annotation to customize constructors for reference_generator plugin.
class ReferenceConstructor {
  /// Default constructor for [ReferenceConstructor].
  const ReferenceConstructor({this.ignore = false});

  /// Ignore this constructor.
  final bool ignore;
}

/// Annotation to customize parameters for reference_generator plugin.
class ReferenceParameter {
  /// Default constructor for [ReferenceParameter].
  const ReferenceParameter({this.ignore = false});

  /// Ignore this parameter.
  final bool ignore;
}
