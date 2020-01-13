// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// PenguinGenerator
// **************************************************************************

part of 'context.dart';

class $Context extends Wrapper {
  $Context.fromUniqueId(
    String uniqueId, {
    MethodChannel channel,
    bool addToManager = true,
  })  : assert(uniqueId != null),
        super(channel, uniqueId, addToManager);

  String get platformClassName => 'Context';

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
    if (isTypeOf<T, Context>()) {
      return 'Context';
    }

    throw UnsupportedError(
        'Could not find platform class name for ${T.toString()}');
  }

  T getWrapperForType<T>(String uniqueId) {
    assert(isTypeOf<T, Wrapper>());

    if (isTypeOf<T, Context>()) {
      return Context.fromUniqueId(uniqueId) as T;
    }

    throw UnsupportedError('Could not instantiate class ${T.toString()}');
  }
}

dynamic _setParameter(dynamic parameter) {
  if (parameter == null) return null;
  if (parameter is Wrapper) return (parameter as Wrapper).uniqueId;
  return parameter;
}
