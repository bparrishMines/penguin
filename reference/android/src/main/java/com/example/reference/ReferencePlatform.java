package com.example.reference;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.common.StandardMethodCodec;

public abstract class ReferencePlatform {
  public final ReferenceMethodCallHandler methodCallHandler;
  public final MethodChannel channel;
  public final ReferenceManager referenceManager;

  public ReferencePlatform(final BinaryMessenger binaryMessenger,
                           final String channelName,
                           final ReferenceFactory referenceFactory,
                           final ReferenceManager referenceManager,
                           final StandardMessageCodec messageCodec) {
    this.referenceManager = referenceManager;
    channel = new MethodChannel(binaryMessenger,
        channelName,
        new StandardMethodCodec(messageCodec));
    methodCallHandler =
        new ReferenceMethodCallHandler(referenceManager, referenceFactory);
  }

  public void initialize() {
    channel.setMethodCallHandler(methodCallHandler);
  }
}
