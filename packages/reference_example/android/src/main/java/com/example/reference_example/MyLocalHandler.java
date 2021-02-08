package com.example.reference_example;

import java.util.List;
import github.penguin.reference.reference.LocalReference;
import github.penguin.reference.reference.ReferencePairManager;
import github.penguin.reference.reference.ReferencePairManager.LocalReferenceCommunicationHandler;

class MyLocalHandler implements LocalReferenceCommunicationHandler {
  // Every `referenceClass` should represents a type that the LocalReference and RemoteReference
  // share. This method should instantiate a new instance for the type reference and arguments.
  @Override
  public LocalReference create(ReferencePairManager referencePairManager,
                               Class<? extends LocalReference> referenceClass,
                               List<Object> arguments) {
    if (referenceClass == MyClass.class) {
      return new MyClass((String) arguments.get(0));
    } else if (referenceClass == MyOtherClass.class) {
      return new MyOtherClass((Integer) arguments.get(0));
    }

    throw new UnsupportedOperationException(String.format("%s not supported.", referenceClass));
  }

  // This method handles invoking static methods on LocalReferences stored in
  // the ReferencePairManager.
  @Override
  public Object invokeStaticMethod(ReferencePairManager referencePairManager,
                                   Class<? extends LocalReference> referenceClass,
                                   String methodName, List<Object> arguments) {
    if (referenceClass == MyOtherClass.class && methodName.equals("myStaticMethod")) {
      return MyOtherClass.myStaticMethod();
    }

    throw new UnsupportedOperationException(
        String.format("%s.%s not supported.", referenceClass, methodName)
    );
  }

  // This method handles invoking methods on LocalReferences stored in the ReferencePairManager.
  @Override
  public Object invokeMethod(ReferencePairManager referencePairManager,
                             LocalReference localReference,
                             String methodName,
                             List<Object> arguments) {
    if (localReference instanceof MyClass && methodName.equals("myMethod")) {
      final MyClass value = (MyClass) localReference;
      return value.myMethod((Double) arguments.get(0), (MyOtherClass) arguments.get(1));
    }

    throw new UnsupportedOperationException(
        String.format("%s.%s not supported.", localReference, methodName)
    );
  }

  // Handle any additional work when the pair with localReference is removed from a
  // ReferencePairManager.
  @Override
  public void dispose(ReferencePairManager referencePairManager, LocalReference localReference) {
    // Do additional closing.
  }
}
