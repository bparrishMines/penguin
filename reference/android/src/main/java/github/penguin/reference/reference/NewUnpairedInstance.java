package github.penguin.reference.reference;

import android.annotation.SuppressLint;
import androidx.annotation.NonNull;
import java.util.List;

public class NewUnpairedInstance {
  public final String channelName;
  public final List<Object> creationArguments;

  public NewUnpairedInstance(String channelName, List<Object> creationArguments) {
    this.channelName = channelName;
    this.creationArguments = creationArguments;
  }

  @SuppressLint("DefaultLocale")
  @NonNull
  @Override
  public String toString() {
    return String.format(
        "%s(%s, %s)", "NewUnpairedReference", channelName, creationArguments.toString());
  }
}
