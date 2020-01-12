// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// PenguinGenerator
// **************************************************************************

part of 'ios_view_creator.dart';

class $CGRect extends Wrapper {
  $CGRect.fromUniqueId(String uniqueId)
      : assert(uniqueId != null),
        super(uniqueId);

  String get platformClassName => 'CGRect';

  @override
  Future<void> onMethodCall(MethodCall call) async {
    switch (call.method) {
    }
    throw UnimplementedError('No implementation for ${call.method}.');
  }
}

class _GenericHelper extends GenericHelper {
  const _GenericHelper._();

  static final _GenericHelper instance = _GenericHelper._();

  String getPlatformClassForType<T>() {
    if (isTypeOf<T, CGRect>()) {
      return 'CGRect';
    }

    throw UnsupportedError(
        'Could not find platform class name for ${T.toString()}');
  }

  T getWrapperForType<T>(String uniqueId) {
    assert(isTypeOf<T, Wrapper>());

    if (isTypeOf<T, CGRect>()) {
      return CGRect.fromUniqueId(uniqueId) as T;
    }

    throw UnsupportedError('Could not instantiate class ${T.toString()}');
  }
}

dynamic _setParameter(dynamic parameter) {
  if (parameter == null) return null;
  if (parameter is Wrapper) return (parameter as Wrapper).uniqueId;
  return parameter;
}
