// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// PenguinGenerator
// **************************************************************************

part of 'ios_view_creator.dart';

class $UIView extends Wrapper {
  $UIView.fromUniqueId(String uniqueId)
      : assert(uniqueId != null),
        super(uniqueId);

  String get platformClassName => 'UIView';

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
    if (isTypeOf<T, UIView>()) {
      return 'UIView';
    }

    throw UnsupportedError(
        'Could not find platform class name for ${T.toString()}');
  }

  T getWrapperForType<T>(String uniqueId) {
    assert(isTypeOf<T, Wrapper>());

    if (isTypeOf<T, UIView>()) {
      return UIView.fromUniqueId(uniqueId) as T;
    }

    throw UnsupportedError('Could not instantiate class ${T.toString()}');
  }
}

dynamic _setParameter(dynamic parameter) {
  if (parameter == null) return null;
  if (parameter is Wrapper) return (parameter as Wrapper).uniqueId;
  return parameter;
}
