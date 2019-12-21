part of 'ios_wrapper.dart';

class $CGRect extends IosWrapper {
  const $CGRect(
    String uniqueId, {
    List<MethodCall> Function($CGRect cgRect) onCreateView,
  }) : super(
          uniqueId: uniqueId,
          platformClassName: 'CGRect',
          onCreateView: onCreateView,
        );

  @override
  List<MethodCall> onMethodCall(MethodCall call) {
    switch (call.method) {
    }
    throw UnimplementedError('No implementation for ${call.method}.');
  }
}
