package github.penguin.reference;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import java.nio.ByteBuffer;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
import io.flutter.plugin.common.BinaryMessenger;

public class MockBinaryMessenger implements BinaryMessenger {
  private final BinaryMessageHandler mockMessageHandler;
  private final BinaryReply mockReplay;
  private final Map<String, BinaryMessageHandler> messageHandlers =  new HashMap<>();

  MockBinaryMessenger(final BinaryMessageHandler mockMessageHandler, final BinaryReply mockReplay) {
    this.mockMessageHandler = mockMessageHandler;
    this.mockReplay = mockReplay;
  }

  @Override
  public void send(@NonNull String channel, @Nullable ByteBuffer message) {
    send(channel, message, null);
  }

  @Override
  public void send(@NonNull String channel, @Nullable ByteBuffer message, @Nullable final BinaryReply callback) {
    mockMessageHandler.onMessage(message, new BinaryReply() {
      @Override
      public void reply(@Nullable ByteBuffer reply) {
        Objects.requireNonNull(reply).position(0);
        if (callback != null) callback.reply(reply);
      }
    });
  }

  public void receive(final String channel, final ByteBuffer byteBuffer) {
    Objects.requireNonNull(messageHandlers.get(channel)).onMessage(byteBuffer, mockReplay);
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
