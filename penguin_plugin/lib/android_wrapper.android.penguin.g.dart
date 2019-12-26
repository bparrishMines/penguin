part of 'android_wrapper.dart';

class $Context extends AndroidWrapper {
  $Context(
    String uniqueId, {
    List<MethodCall> Function(Context context) onCreateView,
  }) : super(
          uniqueId: uniqueId,
          platformClassName: 'Context',
          onCreateView: onCreateView,
        );

  @override
  Future<void> onMethodCall(MethodCall call) async {
    switch (call.method) {
    }
    throw UnimplementedError('No implementation for ${call.method}.');
  }
}

class _GenericHelper {
  _GenericHelper._();

  static Wrapper getWrapperForType<T>(String uniqueId) {
    assert(isTypeOf<T, Wrapper>());

    if (isTypeOf<T, Context>()) {
      return $Context(uniqueId);
    }

    throw UnsupportedError('Could not instantiate class ${T.toString()}');
  }

  static FutureOr<dynamic> onAllocated(Wrapper wrapper) {
    if (wrapper is $Context) {
      return Context.onAllocated(wrapper as $Context);
    }

    throw UnsupportedError(
        'Could not instantiate class ${wrapper.runtimeType}');
  }
}
