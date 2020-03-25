package com.example.test_plugin;

import com.example.reference.Reference;
import com.example.reference.ReferenceManager;
import com.example.reference.ReferenceMethodCallHandler;
import java.io.ByteArrayOutputStream;
import java.nio.ByteBuffer;
import io.flutter.Log;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.common.StandardMethodCodec;

public abstract class TestPluginPlatform {
  public static class TestClass extends Reference {
    public final String testField;

    public TestClass(final String testField, final String referenceId) {
      super(referenceId);
      this.testField = testField;
    }

    public String testMethod(String testParameter) throws Exception {
      throw new UnsupportedOperationException();
    }
  }

  private class ReferenceMethodCallHandlerImpl extends ReferenceMethodCallHandler {
    @Override
    public void onMethodCall(MethodCall call, Result result) {
      Log.d(ReferenceMethodCallHandlerImpl.class.getName(), "onMethodCall: " + call.method);
      if (call.method.equals(ReferenceMethodCallHandler.METHOD_CREATE)) {
        if (call.arguments instanceof TestClass) {
          final TestClass instance = createTestClass((TestClass) call.arguments);
          ReferenceManager.getGlobalInstance().addReference(instance);
        }
        result.success(null);
      } else {
        super.onMethodCall(call, result);
      }
    }
  }

  private class TestPluginMessageCodec extends StandardMessageCodec {
    private static final byte TEST_CLASS = (byte) 128;

    @Override
    protected void writeValue(ByteArrayOutputStream stream, Object value) {
      if (value instanceof TestClass) {
        stream.write(TEST_CLASS);
        writeValue(stream, ((TestClass) value).testField);
        writeValue(stream, ((TestClass) value).referenceId);
      } else {
        super.writeValue(stream, value);
      }
    }

    @Override
    protected Object readValueOfType(byte type, ByteBuffer buffer) {
      switch (type) {
        case TEST_CLASS:
          return new TestClass((String) readValueOfType(buffer.get(), buffer),
              (String) readValueOfType(buffer.get(), buffer));
        default:
          return super.readValueOfType(type, buffer);
      }
    }
  }

  public abstract TestClass createTestClass(TestClass testClass);

  public MethodChannel initializeReferenceMethodChannel(final BinaryMessenger binaryMessenger, final String channelName) {
    final MethodChannel channel = new MethodChannel(binaryMessenger,
        channelName,
        new StandardMethodCodec(new TestPluginMessageCodec()));
    channel.setMethodCallHandler(new ReferenceMethodCallHandlerImpl());

    return channel;
  }
}
