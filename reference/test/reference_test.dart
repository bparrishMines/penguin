import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reference/reference.dart';
import 'package:reference/src/templates/implementation.dart' as template;

void main() {
  final List<MethodCall> log = <MethodCall>[];

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    template.referencePairManager = template.GeneratedReferencePairManager(
        'test_plugin', template.LocalReferenceCommunicationHandlerTemplate())
      ..initialize();

    template.referencePairManager.channel.setMockMethodCallHandler(
      (MethodCall methodCall) async {
        log.add(methodCall);
        if (methodCall.method ==
            MethodChannelReferencePairManager.methodMethod) {
          switch (methodCall.arguments[1]) {
            case 'methodTemplate':
              return 'Hello!';
            case 'callbackTemplate':
              return 'Potato';
          }
        }
        return null;
      },
    );
  });

  tearDown(() {
    template.referencePairManager = null;
    log.clear();
  });

  test('incrementOwnerCount', () async {
    final ReferencePairManager referencePairManager =
        template.referencePairManager;
    final template.ClassTemplate testClass = template.ClassTemplate(1);

    referencePairManager.incrementOwnerCount(testClass);
    referencePairManager.incrementOwnerCount(testClass);

    final RemoteReference remoteReference =
        referencePairManager.remoteReferenceFor(testClass);

    expect(remoteReference.referenceId, isNotNull);
    expect(
      referencePairManager.localReferenceFor(remoteReference),
      equals(testClass),
    );
    expect(log, <Matcher>[
      isMethodCall('REFERENCE_CREATE', arguments: <dynamic>[
        remoteReference.referenceId,
        <dynamic>[
          'ClassTemplate',
          <dynamic>[1]
        ],
      ]),
    ]);
  });

  test('decrementOwnerCount', () async {
    final ReferencePairManager referencePairManager =
        template.referencePairManager;
    final template.ClassTemplate testClass = template.ClassTemplate(2);

    referencePairManager.incrementOwnerCount(testClass);
    final RemoteReference remoteReference =
        referencePairManager.remoteReferenceFor(testClass);
    log.clear();

    referencePairManager.decrementOwnerCount(testClass);

    expect(referencePairManager.localReferenceFor(remoteReference), isNull);
    expect(referencePairManager.remoteReferenceFor(testClass), isNull);
    expect(log, <Matcher>[
      isMethodCall(
        'REFERENCE_DISPOSE',
        arguments: remoteReference,
      ),
    ]);
  });
//
//  test('sendMethodCall', () async {
//    final ClassTemplate testClass = ClassTemplate(3, null);
//    referenceManager.retain(testClass);
//    log.clear();
//
//    final String result = await testClass.methodTemplate('Goodbye!');
//
//    expect(result, equals('Hello!'));
//    expect(log, <Matcher>[
//      isMethodCall('REFERENCE_METHOD', arguments: <dynamic>[
//        Reference(referenceManager.referenceIdFor(testClass)),
//        'methodTemplate',
//        <dynamic>['Goodbye!'],
//      ]),
//    ]);
//  });
//
//  test('receiveLocalMethodCall', () async {
//    final Completer<double> callbackCompleter = Completer<double>();
//    final ClassTemplate testClass = ClassTemplate(3, (double testParameter) {
//      callbackCompleter.complete(testParameter);
//      return 'Apple';
//    });
//
//    referenceManager.retain(testClass);
//
//    final Completer<String> responseCompleter = Completer<String>();
//    referenceManager.channel.binaryMessenger.handlePlatformMessage(
//      'reference_plugin',
//      referenceManager.channel.codec.encodeMethodCall(
//        MethodCall(
//          'REFERENCE_METHOD',
//          <dynamic>[
//            Reference(referenceManager.referenceIdFor(testClass)),
//            'callbackTemplate',
//            <dynamic>[46.0],
//          ],
//        ),
//      ),
//      (ByteData data) {
//        responseCompleter.complete(
//          referenceManager.channel.codec.decodeEnvelope(data),
//        );
//      },
//    );
//
//    expect(callbackCompleter.future, completion(46.0));
//    expect(responseCompleter.future, completion('Apple'));
//  });
//
//  test('createLocalReference', () async {
//    final String referenceId = Uuid().v4();
//    referenceManager.channel.binaryMessenger.handlePlatformMessage(
//      'reference_plugin',
//      referenceManager.channel.codec.encodeMethodCall(
//        MethodCall(
//          'REFERENCE_CREATE',
//          <dynamic>[
//            referenceId,
//            <dynamic>[
//              129,
//              <dynamic>[45],
//            ],
//          ],
//        ),
//      ),
//      (ByteData data) {},
//    );
//
//    final ClassTemplate testClass =
//        referenceManager.referenceHolderFor(referenceId);
//    expect(testClass.fieldTemplate, equals(45));
//    expect(testClass.callbackTemplate, isNotNull);
//  });
//
//  test('sendMethodCall for callback', () async {
//    final String referenceId = Uuid().v4();
//    referenceManager.channel.binaryMessenger.handlePlatformMessage(
//      'reference_plugin',
//      referenceManager.channel.codec.encodeMethodCall(
//        MethodCall(
//          'REFERENCE_CREATE',
//          <dynamic>[
//            referenceId,
//            ClassTemplate(45, null),
//          ],
//        ),
//      ),
//      (ByteData data) {},
//    );
//
//    final ClassTemplate testClass =
//        referenceManager.referenceHolderFor(referenceId);
//    final String result = await testClass.callbackTemplate(34.4);
//
//    expect(result, equals('Potato'));
//    expect(log, <Matcher>[
//      isMethodCall('REFERENCE_METHOD', arguments: <dynamic>[
//        Reference(referenceId),
//        'callbackTemplate',
//        <dynamic>[34.4],
//      ]),
//    ]);
//  });
}
