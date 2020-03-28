package com.example.test_plugin;

import com.example.reference.Reference;
import com.example.reference.ReferenceManager;
import com.example.reference.ReferenceMethodCallHandler;
import com.example.reference.ReferencePlatform;
import java.io.ByteArrayOutputStream;
import java.nio.ByteBuffer;
import io.flutter.Log;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.StandardMessageCodec;

public abstract class TestPluginPlatform extends ReferencePlatform  {
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

  private class GeneratedReferenceMethodCallHandler extends ReferenceMethodCallHandler {
    private GeneratedReferenceMethodCallHandler(ReferenceManager referenceManager) {
      super(referenceManager);
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
      Log.d(GeneratedReferenceMethodCallHandler.class.getName(), "onMethodCall: " + call.method);
      if (call.method.equals(ReferenceMethodCallHandler.METHOD_RETAIN)) {
        if (call.arguments instanceof TestClass) {
          final TestClass instance = createTestClass((TestClass) call.arguments);
          if (!referenceManager.addReference(instance)) {
            final String message = String.format("%s with the following referenceId already exists: %s",
                instance.getClass().getSimpleName(),
                instance.referenceId);
            throw new IllegalArgumentException(message);
          }
        } else {
          final String message = String.format("Failed to instantiate an object with parameters `%s`",
              call.arguments.getClass().getSimpleName());
          throw new IllegalArgumentException(message);
        }
        result.success(null);
      } else {
        super.onMethodCall(call, result);
      }
    }
  }

  private static class GeneratedMessageCodec extends StandardMessageCodec {
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

  public StandardMessageCodec getMessageCodec() {
    return new GeneratedMessageCodec();
  }

  public ReferenceMethodCallHandler getMethodCallHandler(ReferenceManager referenceManager) {
    return new GeneratedReferenceMethodCallHandler(referenceManager);
  }
}
