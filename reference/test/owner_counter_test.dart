import 'package:flutter_test/flutter_test.dart';
import 'package:reference/reference.dart';

void main() {
  group('$OwnerCounter', () {
    test('increment', () {
      int callCount = 0;

      final OwnerCounter counter = OwnerCounter(
        OwnerCounterLifecycleListener(
          onCreate: () {
            callCount++;
            return Future<void>.value();
          },
          onDispose: () => null,
        ),
      );

      counter.increment();
      counter.increment();

      expect(callCount, 1);
    });

    test('decrement', () {
      int callCount = 0;

      final OwnerCounter counter = OwnerCounter(
          OwnerCounterLifecycleListener(
            onCreate: () => null,
            onDispose: () {
              callCount++;
              return Future<void>.value();
            },
          ),
          2);

      counter.decrement();
      counter.decrement();

      expect(callCount, 1);
      expect(() => counter.decrement(), throwsAssertionError);
    });
  });
}
