package github.penguin.reference.method_channel;

import github.penguin.reference.reference.Reference;
import io.flutter.plugin.common.StandardMessageCodec;
import java.io.ByteArrayOutputStream;
import java.nio.ByteBuffer;

public class ReferenceMessageCodec extends StandardMessageCodec {
  private static final byte REFERENCE = (byte) 128;

  @Override
  protected void writeValue(ByteArrayOutputStream stream, Object value) {
    if (value instanceof Reference) {
      stream.write(REFERENCE);
      writeValue(stream, ((Reference) value).referenceId);
    } else {
      super.writeValue(stream, value);
    }
  }

  @Override
  protected Object readValueOfType(byte type, ByteBuffer buffer) {
    switch (type) {
      case REFERENCE:
        return new Reference((String) readValueOfType(buffer.get(), buffer));
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}
