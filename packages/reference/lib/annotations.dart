/// A [ReferenceParameter] with the ignore flag set to true.
const ignoreParam = ReferenceParameter(ignore: true);

/// Annotation used with reference_generator plugin.
class Reference {
  /// Default constructor for [Reference].
  const Reference(this.channel);

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
