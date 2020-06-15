package github.penguin.reference.method_channel;

import github.penguin.reference.reference.RemoteReference;
import github.penguin.reference.reference.UnpairedReference;
import io.flutter.plugin.common.StandardMessageCodec;
import java.io.ByteArrayOutputStream;
import java.nio.ByteBuffer;
import java.util.List;

public class ReferenceMessageCodec extends StandardMessageCodec {
  private static final byte REMOTE_REFERENCE = (byte) 128;
  private static final byte UNPAIRED_REFERENCE = (byte) 129;

  @Override
  protected void writeValue(ByteArrayOutputStream stream, Object value) {
    if (value instanceof RemoteReference) {
      stream.write(REMOTE_REFERENCE);
      writeValue(stream, ((RemoteReference) value).referenceId);
    } else if (value instanceof UnpairedReference) {
      stream.write(UNPAIRED_REFERENCE);
      writeValue(stream, ((UnpairedReference) value).classId);
      writeValue(stream, ((UnpairedReference) value).creationArguments);
      writeValue(stream, ((UnpairedReference) value).managerPoolId);
    } else {
      super.writeValue(stream, value);
    }
  }

  @Override
  protected Object readValueOfType(byte type, ByteBuffer buffer) {
    switch (type) {
      case REMOTE_REFERENCE:
        return new RemoteReference((String) readValueOfType(buffer.get(), buffer));
      case UNPAIRED_REFERENCE:
        //noinspection unchecked
        return new UnpairedReference(
            (Integer) readValueOfType(buffer.get(), buffer),
            (List<Object>) readValueOfType(buffer.get(), buffer),
            (String) readValueOfType(buffer.get(), buffer));
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}
