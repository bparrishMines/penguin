import 'package:reference/reference.dart';

import 'my_class.dart';

class MyReferencePairManager extends MethodChannelReferencePairManager {
  // Constructs a MethodChannelReferencePairManager that supports types: MyClass and MyOtherClass
  MyReferencePairManager()
      : super(<Type>[MyClass, MyOtherClass], 'my_method_channel');

  @override
  LocalReferenceCommunicationHandler get localHandler => MyLocalHandler();

  @override
  MethodChannelRemoteHandler get remoteHandler => MyRemoteHandler();
}

class MyRemoteHandler extends MethodChannelRemoteHandler {
  MyRemoteHandler() : super('my_method_channel');

  // This method should return a list of arguments to instantiate a new instance of the object.
  @override
  List<Object> getCreationArguments(LocalReference localReference) {
    if (localReference is MyClass) {
      return <Object>[localReference.stringField];
    } else if (localReference is MyOtherClass) {
      return <Object>[localReference.intField];
    }

    throw UnsupportedError('${localReference.referenceType} is not supported.');
  }
}

class MyLocalHandler implements LocalReferenceCommunicationHandler {
  // Every `referenceType` should represents a type that the LocalReference and RemoteReference
  // share. This method should instantiate a new instance for the type reference and arguments.
  @override
  LocalReference create(
    ReferencePairManager manager,
    Type referenceType,
    List<Object> arguments,
  ) {
    if (referenceType == MyClass) {
      return MyClass(arguments[0]);
    } else if (referenceType == MyOtherClass) {
      return MyOtherClass(arguments[0]);
    }

    throw UnsupportedError('$referenceType is not supported.');
  }

  // This method handles invoking methods on LocalReferences stored in the ReferencePairManager.
  @override
  Object invokeMethod(
    ReferencePairManager referencePairManager,
    LocalReference localReference,
    String methodName,
    List<Object> arguments,
  ) {
    if (localReference is MyClass && methodName == 'myMethod') {
      return localReference.myMethod(arguments[0], arguments[1]);
    }

    throw UnimplementedError('${localReference.referenceType}.$methodName');
  }

  // Handle any additional work when the pair with localReference is removed from a
  // ReferencePairManager. This method is optional.
  @override
  void dispose(
    ReferencePairManager referencePairManager,
    LocalReference localReference,
  ) {
    // Do additional closing.
  }
}
