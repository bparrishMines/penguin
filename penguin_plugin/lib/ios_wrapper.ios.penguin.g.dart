part of 'ios_wrapper.dart';

class $CGRect extends IosWrapper {
  $CGRect(
    String uniqueId, {
    List<MethodCall> Function(CGRect cgRect) onCreateView,
  }) : super(
          uniqueId: uniqueId,
          platformClassName: 'CGRect',
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

    if (isTypeOf<T, CGRect>()) {
      return $CGRect(uniqueId);
    }

    throw UnsupportedError('Could not instantiate class ${T.toString()}');
  }

  static FutureOr<dynamic> onAllocated<T>(String uniqueId) {
    assert(isTypeOf<T, Wrapper>());

    if (isTypeOf<T, CGRect>()) {
      return CGRect.onAllocated(uniqueId);
    }

    throw UnsupportedError('Could not instantiate class ${T.toString()}');
  }
}
