import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reference/reference.dart';

void main() {
  final List<MethodCall> log = <MethodCall>[];

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    MethodChannelReference.channel.setMockMethodCallHandler(
      (MethodCall methodCall) async {
        log.add(methodCall);
      },
    );
  });

  tearDown(() {
    MethodChannelReference.channel.setMockMethodCallHandler(null);
    log.clear();
  });

  test('retain', () async {
    final MethodChannelReference reference = MethodChannelReference(
      creationParameters: 23,
    );

    reference.retain();
    reference.retain();
    expect(reference.referenceCount, equals(2));
    expect(log, <Matcher>[
      isMethodCall('REFERENCE_RETAIN', arguments: 23),
    ]);
  });

  test('release', () async {
    final MethodChannelReference reference = MethodChannelReference(
      creationParameters: 23,
    );

    reference.retain();
    reference.release();

    expect(() => reference.release(), throwsA(isAssertionError));
    expect(reference.referenceCount, equals(0));
    expect(log, <Matcher>[
      isMethodCall('REFERENCE_RETAIN', arguments: 23),
      isMethodCall('REFERENCE_RELEASE', arguments: reference.referenceId),
    ]);
  });
}
