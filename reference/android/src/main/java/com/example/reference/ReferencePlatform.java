package com.example.reference;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.common.StandardMethodCodec;

abstract public class ReferencePlatform {
  final ReferenceManager.ReferenceManagerNode referenceManager = new ReferenceManager.ReferenceManagerNode();

  public abstract StandardMessageCodec getMessageCodec();
  public abstract ReferenceMethodCallHandler getMethodCallHandler(ReferenceManager referenceManager);

  public MethodChannel initializeReferenceMethodChannel(final BinaryMessenger binaryMessenger, final String channelName) {
    final MethodChannel channel = new MethodChannel(binaryMessenger,
        channelName,
        new StandardMethodCodec(getMessageCodec()));
    channel.setMethodCallHandler(getMethodCallHandler(referenceManager));

    return channel;
  }
}
