package github.penguin.reference.reference;

import android.annotation.SuppressLint;
import androidx.annotation.NonNull;
import java.util.List;

public class UnpairedReference {
  public final String handlerChannel;
  public final List<Object> creationArguments;

  public UnpairedReference(String handlerChannel, List<Object> creationArguments) {
    this.handlerChannel = handlerChannel;
    this.creationArguments = creationArguments;
  }

  @SuppressLint("DefaultLocale")
  @NonNull
  @Override
  public String toString() {
    return String.format(
        "%s(%s, %s)",
        "UnpairedReference", handlerChannel, creationArguments.toString());
  }
}
