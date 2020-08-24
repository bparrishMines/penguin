package com.example.reference_example_example;

import com.example.reference_example.MyClass;
import com.example.reference_example.MyReferencePairManager;

import java.util.List;

import github.penguin.reference.reference.LocalReference;
import github.penguin.reference.reference.ReferencePairManager;
import io.flutter.plugin.common.BinaryMessenger;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

class TestReferencePairManager extends MyReferencePairManager {
  final MyClass mockMyClass = mock(MyClass.class);
  final MyClass.MyApiClass mockMyApiClass = mock(MyClass.MyApiClass.class);

  public TestReferencePairManager(BinaryMessenger binaryMessenger) {
    super(binaryMessenger);
    when(mockMyClass.getMyApiClass()).thenReturn(mockMyApiClass);
  }

  @Override
  public LocalReferenceCommunicationHandler getLocalHandler() {
    return new LocalReferenceCommunicationHandler() {
      @Override
      public LocalReference create(ReferencePairManager referencePairManager, Class<? extends LocalReference> referenceClass, List<Object> arguments) throws Exception {
        if (referenceClass == MyClass.class) return mockMyClass;
        return TestReferencePairManager.super.getLocalHandler().create(referencePairManager, referenceClass, arguments);
      }

      @Override
      public Object invokeMethod(ReferencePairManager referencePairManager, LocalReference localReference, String methodName, List<Object> arguments) throws Exception {
        return TestReferencePairManager.super.getLocalHandler().invokeMethod(referencePairManager, localReference, methodName, arguments);
      }

      @Override
      public void dispose(ReferencePairManager referencePairManager, LocalReference localReference) throws Exception {
        TestReferencePairManager.super.getLocalHandler().dispose(referencePairManager, localReference);
      }
    };
  }
}
