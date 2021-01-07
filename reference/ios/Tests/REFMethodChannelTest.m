//#import <XCTest/XCTest.h>
//#import "ReferenceMatchers.h"
//
//@import OCMockito;
//@import OCHamcrest;
//
//@import reference;
//
//@interface REFMethodChannelTest : XCTestCase
//@end
//
//@implementation REFMethodChannelTest {
//  FlutterStandardMethodCodec *_methodCodec;
//  id<FlutterMessageCodec> _messageCodec;
//  TestMethodChannelReferencePairManager *_testManager;
//}
//
//- (void)setUp {
//  _messageCodec =
//      [FlutterStandardMessageCodec codecWithReaderWriter:[[REFReferenceReaderWriter alloc] init]];
//  _methodCodec =
//      [FlutterStandardMethodCodec codecWithReaderWriter:[[REFReferenceReaderWriter alloc] init]];
//
//  _testManager = [[TestMethodChannelReferencePairManager alloc] init];
//  [_testManager initialize];
//}
//
//- (FlutterMethodCall *_Nonnull)getRemoteHandlerMethodCall {
//  TestRemoteHandler *remoteHandler = (TestRemoteHandler *)_testManager.remoteHandler;
//
//  HCArgumentCaptor *messageCaptor = [[HCArgumentCaptor alloc] init];
//  [verify(remoteHandler.binaryMessenger) sendOnChannel:@"test_channel"
//                                               message:(id)messageCaptor
//                                           binaryReply:anything()];
//
//  NSData *messageData = messageCaptor.value;
//
//  return [_methodCodec decodeMethodCall:messageData];
//}
//
//- (FlutterBinaryMessageHandler _Nullable)getBinaryMessageHandler {
//  HCArgumentCaptor *handlerCaptor = [[HCArgumentCaptor alloc] init];
//  [verify(_testManager.binaryMessenger) setMessageHandlerOnChannel:@"test_channel"
//                                              binaryMessageHandler:(id)handlerCaptor];
//
//  return handlerCaptor.value;
//}
//
//- (void)testReferenceReaderWriter_encodeAndDecodeRemoteReference {
//  XCTAssertEqualObjects(
//      [_messageCodec decode:[_messageCodec encode:[REFRemoteReference fromID:@"taco"]]],
//      [REFRemoteReference fromID:@"taco"]);
//}
//
//- (void)testReferenceReaderWriter_encodeAndDecodeUnpairedReference {
//  REFUnpairedReference *unpairedReference =
//      [[REFUnpairedReference alloc] initWithClassID:5 creationArguments:@[] managerPoolID:@"tiny"];
//
//  NSData *data = [_messageCodec encode:unpairedReference];
//  assertThat([_messageCodec decode:data], isUnpairedReference(5, isEmpty(), @"tiny"));
//}
//
//- (void)testMethodChannelReferencePairManager_pairWithNewRemoteReference {
//  TestClass *testClass = [TestClass testClass];
//
//  [_testManager pairWithNewRemoteReference:testClass
//                                completion:^(REFRemoteReference *remoteReference, NSError *error){
//                                }];
//  REFRemoteReference *remoteReference = [_testManager getPairedRemoteReference:testClass];
//
//  FlutterMethodCall *call = [self getRemoteHandlerMethodCall];
//
//  XCTAssertEqualObjects(call.method, @"REFERENCE_CREATE");
//  assertThat(call.arguments, contains(equalTo(remoteReference), equalTo(@(0)), isEmpty(), nil));
//}
//
//- (void)testMethodChannelReferencePairManager_invokeRemoteStaticMethod {
//  [_testManager invokeRemoteStaticMethod:[TestClass class]
//                              methodName:@"aStaticMethod"
//                              completion:(^(id result, NSError *error){
//                                         })];
//
//  FlutterMethodCall *call = [self getRemoteHandlerMethodCall];
//
//  XCTAssertEqualObjects(call.method, @"REFERENCE_STATIC_METHOD");
//  assertThat(call.arguments, contains(equalTo(@(0)), equalTo(@"aStaticMethod"), isEmpty(), nil));
//}
//
//- (void)testMethodChannelReferencePairManager_invokeRemoteMethod {
//  TestClass *testClass = [TestClass testClass];
//
//  [_testManager pairWithNewRemoteReference:testClass
//                                completion:^(REFRemoteReference *remoteReference, NSError *error){
//                                }];
//  [self getRemoteHandlerMethodCall];
//
//  REFRemoteReference *remoteReference = [_testManager getPairedRemoteReference:testClass];
//  [_testManager invokeRemoteMethod:remoteReference
//                        methodName:@"aMethod"
//                        completion:(^(id result, NSError *error){
//                                   })];
//
//  FlutterMethodCall *call = [self getRemoteHandlerMethodCall];
//
//  XCTAssertEqualObjects(call.method, @"REFERENCE_METHOD");
//  assertThat(call.arguments,
//             contains(equalTo(remoteReference), equalTo(@"aMethod"), isEmpty(), nil));
//}
//
//- (void)testMethodChannelReferencePairManager_invokeRemoteMethodOnUnpairedReference {
//  TestClass *testClass = [TestClass testClass];
//
//  [_testManager pairWithNewRemoteReference:testClass
//                                completion:^(REFRemoteReference *remoteReference, NSError *error){
//                                }];
//  [self getRemoteHandlerMethodCall];
//
//  [_testManager invokeRemoteMethodOnUnpairedReference:testClass
//                                           methodName:@"aMethod"
//                                           completion:(^(id result, NSError *error){
//                                                      })];
//
//  FlutterMethodCall *call = [self getRemoteHandlerMethodCall];
//
//  XCTAssertEqualObjects(call.method, @"REFERENCE_METHOD");
//  assertThat(call.arguments,
//             contains(isUnpairedReference(0, isEmpty(), nil), equalTo(@"aMethod"), isEmpty(), nil));
//}
//
//- (void)testMethodChannelReferencePairManager_disposePairWithLocalReference {
//  TestClass *testClass = [TestClass testClass];
//
//  [_testManager pairWithNewRemoteReference:testClass
//                                completion:^(REFRemoteReference *remoteReference, NSError *error){
//                                }];
//  [self getRemoteHandlerMethodCall];
//
//  REFRemoteReference *remoteReference = [_testManager getPairedRemoteReference:testClass];
//  [_testManager disposePairWithLocalReference:testClass
//                                   completion:(^(NSError *error){
//                                              })];
//
//  FlutterMethodCall *call = [self getRemoteHandlerMethodCall];
//
//  XCTAssertEqualObjects(call.method, @"REFERENCE_DISPOSE");
//  XCTAssertEqualObjects(call.arguments, remoteReference);
//}
//
//- (void)testMethodChannelReferencePairManager_pairWithNewLocalReference {
//  [given([_testManager.localHandler create:_testManager
//                            referenceClass:[TestClass class]
//                                 arguments:anything()]) willReturn:[TestClass testClass]];
//
//  NSData *message = [_methodCodec
//      encodeMethodCall:[FlutterMethodCall
//                           methodCallWithMethodName:@"REFERENCE_CREATE"
//                                          arguments:@[
//                                            [REFRemoteReference fromID:@"table"], @(0), @[]
//                                          ]]];
//  FlutterBinaryMessageHandler messageHandler = [self getBinaryMessageHandler];
//  messageHandler(message, ^(NSData *reply){
//                 });
//
//  assertThat([_testManager getPairedLocalReference:[REFRemoteReference fromID:@"table"]],
//             isA([TestClass class]));
//}
//
//- (void)testMethodChannelReferencePairManager_invokeLocalStaticMethod {
//  NSData *message = [_methodCodec
//      encodeMethodCall:[FlutterMethodCall
//                           methodCallWithMethodName:@"REFERENCE_STATIC_METHOD"
//                                          arguments:@[ @(0), @"aStaticMethod", @[] ]]];
//  FlutterBinaryMessageHandler messageHandler = [self getBinaryMessageHandler];
//  messageHandler(message, ^(NSData *reply){
//                 });
//
//  [verify(_testManager.localHandler) invokeStaticMethod:_testManager
//                                         referenceClass:[TestClass class]
//                                             methodName:@"aStaticMethod"
//                                              arguments:isEmpty()];
//}
//
//- (void)testMethodChannelReferencePairManager_invokeLocalMethod {
//  TestClass *testClass = [TestClass testClass];
//
//  [_testManager pairWithNewRemoteReference:testClass
//                                completion:^(REFRemoteReference *remoteReference, NSError *error){
//                                }];
//  REFRemoteReference *remoteReference = [_testManager getPairedRemoteReference:testClass];
//
//  NSData *message = [_methodCodec
//      encodeMethodCall:[FlutterMethodCall
//                           methodCallWithMethodName:@"REFERENCE_METHOD"
//                                          arguments:@[ remoteReference, @"aMethod", @[] ]]];
//  FlutterBinaryMessageHandler messageHandler = [self getBinaryMessageHandler];
//  messageHandler(message, ^(NSData *reply){
//                 });
//
//  [verify(_testManager.localHandler) invokeMethod:_testManager
//                                   localReference:testClass
//                                       methodName:@"aMethod"
//                                        arguments:isEmpty()];
//}
//
//- (void)testMethodChannelReferencePairManager_invokeLocalMethodOnUnpairedReference {
//  [given([_testManager.localHandler create:_testManager
//                            referenceClass:[TestClass class]
//                                 arguments:anything()]) willReturn:[TestClass testClass]];
//
//  REFUnpairedReference *unpairedReference =
//      [[REFUnpairedReference alloc] initWithClassID:0 creationArguments:@[]];
//  NSData *message = [_methodCodec
//      encodeMethodCall:[FlutterMethodCall
//                           methodCallWithMethodName:@"REFERENCE_METHOD"
//                                          arguments:@[ unpairedReference, @"aMethod", @[] ]]];
//
//  FlutterBinaryMessageHandler messageHandler = [self getBinaryMessageHandler];
//  messageHandler(message, ^(NSData *reply){
//                 });
//
//  [verify(_testManager.localHandler) invokeMethod:_testManager
//                                   localReference:isA([TestClass class])
//                                       methodName:@"aMethod"
//                                        arguments:isEmpty()];
//}
//
//- (void)testMethodChannelReferencePairManager_disposePairWithRemoteReference {
//  TestClass *testClass = [TestClass testClass];
//
//  [_testManager pairWithNewRemoteReference:testClass
//                                completion:^(REFRemoteReference *remoteReference, NSError *error){
//                                }];
//  REFRemoteReference *remoteReference = [_testManager getPairedRemoteReference:testClass];
//
//  NSData *message = [_methodCodec
//      encodeMethodCall:[FlutterMethodCall methodCallWithMethodName:@"REFERENCE_DISPOSE"
//                                                         arguments:remoteReference]];
//  FlutterBinaryMessageHandler messageHandler = [self getBinaryMessageHandler];
//  messageHandler(message, ^(NSData *reply){
//                 });
//
//  [verify(_testManager.localHandler) dispose:_testManager localReference:testClass];
//}
//@end
