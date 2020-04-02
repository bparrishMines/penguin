package com.example.reference;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.common.StandardMethodCodec;

public abstract class ReferencePlatform {
  public final BinaryMessenger binaryMessenger;
  public final String channelName;
  public final ReferenceFactory referenceFactory;
  public final StandardMessageCodec messageCodec;

  ReferenceMethodCallHandler methodCallHandler;

  public ReferencePlatform(final BinaryMessenger binaryMessenger,
                           final String channelName,
                           final ReferenceFactory referenceFactory,
                           final StandardMessageCodec messageCodec) {
    this.binaryMessenger = binaryMessenger;
    this.channelName = channelName;
    this.referenceFactory = referenceFactory;
    this.messageCodec = messageCodec;
  }

  public void initialize() {
    if (methodCallHandler != null) return;
    final MethodChannel channel = new MethodChannel(binaryMessenger,
        channelName,
        new StandardMethodCodec(messageCodec));
    methodCallHandler =
        new ReferenceMethodCallHandler(new ReferenceManager.ReferenceManagerNode(), referenceFactory);
    channel.setMethodCallHandler(methodCallHandler);
  }
}
