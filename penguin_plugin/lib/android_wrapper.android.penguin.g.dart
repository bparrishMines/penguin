part of 'android_wrapper.dart';

class $Context extends AndroidWrapper {
  const $Context(
    String uniqueId, {
    List<MethodCall> Function($Context context) onCreateView,
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
