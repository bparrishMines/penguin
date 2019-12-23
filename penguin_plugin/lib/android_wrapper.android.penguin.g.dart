part of 'android_wrapper.dart';

class $Context extends AndroidWrapper {
  const $Context(
    String uniqueId, {
    List<MethodCall> Function(Context context) onCreateView,
  }) : super(
          uniqueId: uniqueId,
          platformClassName: 'Context',
          onCreateView: onCreateView,
        );

  @override
  List<MethodCall> onMethodCall(MethodCall call) {
    switch (call.method) {
    }
    throw UnimplementedError('No implementation for ${call.method}.');
  }
}

class _GenericHelper {
  _GenericHelper._();

  static FutureOr<dynamic> fromUniqueId<T>(String uniqueId) {
    assert(isTypeOf<T, Wrapper>());

    if (isTypeOf<T, Context>()) {
      return Context.fromUniqueId(uniqueId);
    }

    throw UnsupportedError('Could not instantiate class ${T.toString()}');
  }
}
