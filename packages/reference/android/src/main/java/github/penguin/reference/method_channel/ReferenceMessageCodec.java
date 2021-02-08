package github.penguin.reference.method_channel;

import java.io.ByteArrayOutputStream;
import java.nio.ByteBuffer;
import java.util.List;

import github.penguin.reference.reference.NewUnpairedInstance;
import github.penguin.reference.reference.PairedInstance;
import io.flutter.plugin.common.StandardMessageCodec;

class ReferenceMessageCodec extends StandardMessageCodec {
  private static final byte PAIRED_INSTANCE = (byte) 128;
  private static final byte NEW_UNPAIRED_INSTANCE = (byte) 129;

  @Override
  protected void writeValue(ByteArrayOutputStream stream, Object value) {
    if (value instanceof PairedInstance) {
      stream.write(PAIRED_INSTANCE);
      writeValue(stream, ((PairedInstance) value).instanceId);
    } else if (value instanceof NewUnpairedInstance) {
      stream.write(NEW_UNPAIRED_INSTANCE);
      writeValue(stream, ((NewUnpairedInstance) value).channelName);
      writeValue(stream, ((NewUnpairedInstance) value).creationArguments);
    } else {
      super.writeValue(stream, value);
    }
  }

  @Override
  protected Object readValueOfType(byte type, ByteBuffer buffer) {
    switch (type) {
      case PAIRED_INSTANCE:
        return new PairedInstance((String) readValueOfType(buffer.get(), buffer));
      case NEW_UNPAIRED_INSTANCE:
        //noinspection unchecked
        return new NewUnpairedInstance(
            (String) readValueOfType(buffer.get(), buffer),
            (List<Object>) readValueOfType(buffer.get(), buffer));
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}
