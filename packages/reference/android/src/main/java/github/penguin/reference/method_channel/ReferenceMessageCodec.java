package github.penguin.reference.method_channel;

import java.io.ByteArrayOutputStream;
import java.nio.ByteBuffer;

import github.penguin.reference.reference.PairedInstance;
import io.flutter.plugin.common.StandardMessageCodec;

class ReferenceMessageCodec extends StandardMessageCodec {
  private static final byte PAIRED_INSTANCE = (byte) 128;

  @Override
  protected void writeValue(ByteArrayOutputStream stream, Object value) {
    if (value instanceof PairedInstance) {
      stream.write(PAIRED_INSTANCE);
      writeValue(stream, ((PairedInstance) value).instanceId);
      return;
    }

    super.writeValue(stream, value);
  }

  @Override
  protected Object readValueOfType(byte type, ByteBuffer buffer) {
    if (type == PAIRED_INSTANCE) {
      return new PairedInstance((String) readValueOfType(buffer.get(), buffer));
    }
    return super.readValueOfType(type, buffer);
  }
}
