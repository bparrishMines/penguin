package com.example.test_plugin;

import com.example.reference.Reference;
import com.example.reference.ReferenceFactory;
import com.example.reference.ReferenceManager;
import com.example.reference.ReferencePlatform;
import java.io.ByteArrayOutputStream;
import java.nio.ByteBuffer;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.StandardMessageCodec;

public final class GeneratedPlatform extends ReferencePlatform {
  public static class TestClass extends Reference {
    public final String testField;

    public TestClass(final String testField, final String referenceId) {
      super(referenceId);
      this.testField = testField;
    }

    public TestClass(final String testField) {
      this.testField = testField;
    }

    public Object testMethod(String testParameter) throws Exception {
      throw new UnsupportedOperationException();
    }

    public final MethodCall onTestCallback(TestClass testParameter) {
      return createMethodCall("onTestCallback", new Object[]{testParameter});
    }
  }

  public abstract static class GeneratedReferenceFactory implements ReferenceFactory {
    @Override
    public Reference createReference(final Object arguments) {
      if (arguments instanceof TestClass) {
        return createTestClass((TestClass) arguments);
      }

      final String output;
      if (arguments == null) {
        output = null;
      } else {
        output = arguments.getClass().getName();
      }

      final String message = String.format("Failed to instantiate an object with parameters: `%s`",
          output);
      throw new IllegalArgumentException(message);
    }

    abstract public TestClass createTestClass(TestClass testClass);
  }

  public static class GeneratedMessageCodec extends StandardMessageCodec {
    private static final byte TEST_CLASS = (byte) 128;

    private final ReferenceManager referenceManager;

    public GeneratedMessageCodec(ReferenceManager referenceManager) {
      this.referenceManager = referenceManager;
    }

    @Override
    protected void writeValue(ByteArrayOutputStream stream, Object value) {
      if (value instanceof Reference) referenceManager.addReference((Reference) value);

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

  public GeneratedPlatform(final BinaryMessenger binaryMessenger,
                           final String channelName,
                           final ReferenceManager referenceManager,
                           final GeneratedReferenceFactory referenceFactory) {
    this(binaryMessenger, channelName, referenceManager, referenceFactory, new GeneratedMessageCodec(referenceManager));
  }

  public GeneratedPlatform(final BinaryMessenger binaryMessenger,
                           final String channelName,
                           final ReferenceManager referenceManager,
                           final GeneratedReferenceFactory referenceFactory,
                           final GeneratedMessageCodec messageCodec) {
    super(binaryMessenger, channelName, referenceFactory, referenceManager, messageCodec);
  }
}
