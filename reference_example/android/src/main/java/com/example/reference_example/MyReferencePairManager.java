package com.example.reference_example;

import github.penguin.reference.method_channel.MethodChannelReferencePairManager;
import github.penguin.reference.method_channel.MethodChannelRemoteHandler;
import github.penguin.reference.reference.LocalReference;
import github.penguin.reference.reference.ReferencePairManager;
import io.flutter.plugin.common.BinaryMessenger;
import static java.util.Arrays.asList;

class MyReferencePairManager extends MethodChannelReferencePairManager {
  // Constructs a ReferencePairManager that supports types: MyClass and MyOtherClass
  MyReferencePairManager(final BinaryMessenger binaryMessenger) {
    super(asList(MyClass.class, MyOtherClass.class),
        binaryMessenger,
        "my_method_channel");
  }

  @Override
  public ReferencePairManager.LocalReferenceCommunicationHandler getLocalHandler() {
    return new MyLocalHandler();
  }

  @Override
  public MethodChannelRemoteHandler getRemoteHandler() {
    return new MyRemoteHandler(binaryMessenger);
  }
}
