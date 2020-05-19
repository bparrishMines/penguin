package github.penguin.reference;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import io.flutter.plugin.common.BinaryMessenger;
import java.nio.ByteBuffer;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

public class MockBinaryMessenger implements BinaryMessenger {
  private final BinaryMessageHandler mockMessageHandler;
  private final BinaryReply mockReply;
  private final Map<String, BinaryMessageHandler> messageHandlers = new HashMap<>();

  MockBinaryMessenger(final BinaryMessageHandler mockMessageHandler, final BinaryReply mockReply) {
    this.mockMessageHandler = mockMessageHandler;
    this.mockReply = mockReply;
  }

  @Override
  public void send(@NonNull String channel, @Nullable ByteBuffer message) {
    send(channel, message, null);
  }

  @Override
  public void send(
      @NonNull String channel, @Nullable ByteBuffer message, @Nullable final BinaryReply callback) {
    mockMessageHandler.onMessage(
        message,
        new BinaryReply() {
          @Override
          public void reply(@Nullable ByteBuffer reply) {
            Objects.requireNonNull(reply).position(0);
            if (callback != null) callback.reply(reply);
          }
        });
  }

  @SuppressWarnings("SameParameterValue")
  void receive(final String channel, final ByteBuffer byteBuffer) {
    byteBuffer.position(0);
    Objects.requireNonNull(messageHandlers.get(channel)).onMessage(byteBuffer, mockReply);
  }

  @Override
  public void setMessageHandler(@NonNull String channel, @Nullable BinaryMessageHandler handler) {
    if (handler != null) {
      messageHandlers.put(channel, handler);
    } else {
      messageHandlers.remove(channel);
    }
  }
}
