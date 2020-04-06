package com.example.reference;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.common.StandardMethodCodec;

public abstract class MethodChannelReferencePlatform extends ReferencePlatform {
  public final ReferenceMethodCallHandler methodCallHandler;
  public final MethodChannel channel;

  public MethodChannelReferencePlatform(final BinaryMessenger binaryMessenger,
                                        final String channelName,
                                        final ReferenceFactory referenceFactory,
                                        final ReferenceManager referenceManager,
                                        final StandardMessageCodec messageCodec) {
    super(referenceManager);
    channel = new MethodChannel(binaryMessenger,
        channelName,
        new StandardMethodCodec(messageCodec));
    methodCallHandler =
        new ReferenceMethodCallHandler(referenceManager, referenceFactory);
  }

  @Override
  public void initialize() {
    channel.setMethodCallHandler(methodCallHandler);
  }
}
