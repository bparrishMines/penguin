/// A [ReferenceParameter] with the ignore flag set to true.
const ignoreParam = ReferenceParameter(ignore: true);

/// A [ReferenceParameter] for `java.lang.Long`.
const javaFloat = ReferenceParameter(platformTypeName: 'Float');

/// A [ReferenceParameter] for `java.lang.Float`.
const javaLong = ReferenceParameter(platformTypeName: 'Long');

/// Annotation used with reference_generator plugin.
class Reference {
  /// Default constructor for [Reference].
  const Reference({
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

/// Annotation to customize methods for reference_generator plugin.
class ReferenceMethod {
  /// Default constructor for [ReferenceMethod].
  const ReferenceMethod({
    this.ignore = false,
    this.platformThrowsAsDefault = false,
  });

  /// Ignore this method.
  final bool ignore;

  /// Whether the default implmenentation of the platform `TypeChannelHandler` method is to throw an exception.
  final bool platformThrowsAsDefault;
}

/// Annotation to customize constructors for reference_generator plugin.
class ReferenceConstructor {
  /// Default constructor for [ReferenceConstructor].
  const ReferenceConstructor({
    this.ignore = false,
    this.platformThrowsAsDefault = false,
  });

  /// Ignore this constructor.
  final bool ignore;

  /// Whether the default implmenentation of the platform `TypeChannelHandler` method is to throw an exception.
  final bool platformThrowsAsDefault;
}

/// Annotation to customize parameters for reference_generator plugin.
class ReferenceParameter {
  /// Default constructor for [ReferenceParameter].
  const ReferenceParameter({
    this.ignore = false,
    this.platformTypeImport,
    this.platformTypeName,
  });

  /// Ignore this parameter.
  final bool ignore;

  /// Import of the platform type.
  final String? platformTypeImport;

  /// Name of the platorm type.
  final String? platformTypeName;
}
