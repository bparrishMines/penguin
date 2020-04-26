package com.example.reference.templates;

import com.example.reference.reference.CompletableRunnable;
import com.example.reference.method_channel.MethodChannelReferenceManager;
import com.example.reference.method_channel.ReferenceMessageCodec;
import java.io.ByteArrayOutputStream;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import io.flutter.plugin.common.BinaryMessenger;

public abstract class GeneratedReferenceManager extends MethodChannelReferenceManager {
  public interface ClassTemplate extends ReferenceHolder {
    CompletableRunnable<String> methodTemplate(String parameterType);
    CompletableRunnable<String> callbackTemplate(double testParameter);
    int getFieldTemplate();
  }

  public static class GeneratedMessageCodec extends ReferenceMessageCodec {
    private static final byte CLASS_TEMPLATE = (byte) 129;

    @Override
    protected void writeValue(ByteArrayOutputStream stream, Object value) {
      if (value instanceof ClassTemplate) {
        stream.write(CLASS_TEMPLATE);
        final ClassTemplate classValue = (ClassTemplate) value;
        writeValue(stream, toCreationParams(CLASS_TEMPLATE, new Object[]{classValue.getFieldTemplate()}));
      } else {
        super.writeValue(stream, value);
      }
    }

    @Override
    protected Object readValueOfType(byte type, ByteBuffer buffer) {
      switch (type) {
        case CLASS_TEMPLATE:
          return readValueOfType(buffer.get(), buffer);
        default:
          return super.readValueOfType(type, buffer);
      }
    }

    private List<Object> toCreationParams(final Byte classConst, final Object[] arguments) {
      final List<Object> codecArgs = new ArrayList<>(1 + arguments.length);
      codecArgs.add(classConst);
      codecArgs.add(Arrays.asList(arguments));
      return codecArgs;
    }
  }

  @Override
  public CompletableRunnable<?> receiveLocalMethodCall(ReferenceHolder holder, String methodName, Object[] arguments) {
    final CompletableRunnable<?> runnable;
    if (holder instanceof ClassTemplate && methodName.equals("methodTemplate")) {
      runnable = ((ClassTemplate) holder).methodTemplate((String) arguments[0]);
    } else if (holder instanceof ClassTemplate && methodName.equals("callbackTemplate")) {
      runnable = ((ClassTemplate) holder).callbackTemplate((Double) arguments[0]);
    } else {
      final String message = String.format("Could not call %s on %s.", methodName, holder.getClass().getName());
      throw new IllegalStateException(message);
    }

    uiHandler.post(runnable);
    return runnable;
  }

  public abstract ClassTemplate createClassTemplate(String referenceId, int fieldTemplate);

  @Override
  public ReferenceHolder createLocalReference(String referenceId, Object arguments) {
    final List<Object> argumentList = (List<Object>) arguments;
    if (argumentList.get(0) == (Byte) GeneratedMessageCodec.CLASS_TEMPLATE) {
      final List<Object> parameters = (List<Object>) argumentList.get(1);
      return createClassTemplate(referenceId, (Integer) parameters.get(0));
    }

    throw new IllegalStateException("Could not instantiate an object with arguments.");
  }

  public GeneratedReferenceManager(final BinaryMessenger binaryMessenger,
                                   final String channelName,
                                   final GeneratedMessageCodec messageCodec) {
    super(binaryMessenger, channelName, messageCodec);
  }
}
