package github.penguin.reference.method_channel;

import github.penguin.reference.reference.RemoteReference;
import github.penguin.reference.reference.UnpairedRemoteReference;
import io.flutter.plugin.common.StandardMessageCodec;
import java.io.ByteArrayOutputStream;
import java.nio.ByteBuffer;
import java.util.List;

public class ReferenceMessageCodec extends StandardMessageCodec {
  private static final byte REMOTE_REFERENCE = (byte) 128;
  private static final byte UNPAIRED_REMOTE_REFERENCE = (byte) 130;

  @Override
  protected void writeValue(ByteArrayOutputStream stream, Object value) {
    if (value instanceof RemoteReference) {
      stream.write(REMOTE_REFERENCE);
      writeValue(stream, ((RemoteReference) value).referenceId);
    } else if (value instanceof UnpairedRemoteReference) {
      stream.write(UNPAIRED_REMOTE_REFERENCE);
      writeValue(stream, ((UnpairedRemoteReference) value).classId);
      writeValue(stream, ((UnpairedRemoteReference) value).creationArguments);
      writeValue(stream, ((UnpairedRemoteReference) value).managerPoolId);
    } else {
      super.writeValue(stream, value);
    }
  }

  @Override
  protected Object readValueOfType(byte type, ByteBuffer buffer) {
    switch (type) {
      case REMOTE_REFERENCE:
        return new RemoteReference((String) readValueOfType(buffer.get(), buffer));
      case UNPAIRED_REMOTE_REFERENCE:
        //noinspection unchecked
        return new UnpairedRemoteReference(
            (Integer) readValueOfType(buffer.get(), buffer),
            (List<Object>) readValueOfType(buffer.get(), buffer),
            (String) readValueOfType(buffer.get(), buffer));
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}
