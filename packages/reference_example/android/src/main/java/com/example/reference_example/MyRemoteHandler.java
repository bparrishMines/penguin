package com.example.reference_example;

import java.util.Collections;
import java.util.List;
import github.penguin.reference.method_channel.MethodChannelRemoteHandler;
import github.penguin.reference.reference.LocalReference;
import io.flutter.plugin.common.BinaryMessenger;

class MyRemoteHandler extends MethodChannelRemoteHandler {
  MyRemoteHandler(BinaryMessenger binaryMessenger) {
    super(binaryMessenger, "my_method_channel");
  }

  // This method should return a list of arguments to instantiate a new instance of the object.
  @Override
  public List<Object> getCreationArguments(LocalReference localReference) {
    if (localReference instanceof MyClass) {
      final MyClass value = (MyClass) localReference;
      return Collections.singletonList((Object) value.stringField);
    } else if (localReference instanceof MyOtherClass) {
      final MyOtherClass value = (MyOtherClass) localReference;
      return Collections.singletonList((Object) value.intField);
    }

    throw new UnsupportedOperationException(String.format("%s is not supported.", localReference));
  }
}
