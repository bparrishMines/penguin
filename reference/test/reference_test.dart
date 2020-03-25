import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reference/reference.dart';

void main() {
  const MethodChannel channel = MethodChannel('reference');
  final List<MethodCall> log = <MethodCall>[];

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      log.add(methodCall);
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
    log.clear();
  });

  test('retain', () async {
    final MethodChannelReference reference = MethodChannelReference(
      object: 23,
      channel: channel,
    );

    reference.retain();
    expect(log, <Matcher>[
      isMethodCall('REFERENCE_CREATE', arguments: 23),
    ]);
  });

  test('release', () async {
    final MethodChannelReference reference = MethodChannelReference(
      object: 23,
      channel: channel,
    );

    reference.retain();
    reference.release();
    expect(log, <Matcher>[
      isMethodCall('REFERENCE_CREATE', arguments: 23),
      isMethodCall('REFERENCE_DESTROY', arguments: reference.referenceId),
    ]);
  });

  test('reassign', () async {
    final MethodChannelReference reference = MethodChannelReference(
      object: 23,
      channel: channel,
    );

    reference.reassign(
      'new_id',
      referenceCount: 45,
      useGlobalReferenceManager: false,
    );
    expect(log, <Matcher>[]);
    expect(reference.referenceId, equals('new_id'));
    expect(reference.referenceCount, equals(45));
    expect(reference.useGlobalReferenceManager, isFalse);
  });
}
