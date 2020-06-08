package github.penguin.reference.reference;

import android.annotation.SuppressLint;
import androidx.annotation.NonNull;
import java.util.List;

public class UnpairedRemoteReference {
  public final int classId;
  public final List<Object> creationArguments;
  public final String managerPoolId;

  public UnpairedRemoteReference(int classId, List<Object> creationArguments) {
    this(classId, creationArguments, null);
  }

  public UnpairedRemoteReference(int classId, List<Object> creationArguments, String managerPoolId) {
    this.classId = classId;
    this.creationArguments = creationArguments;
    this.managerPoolId = managerPoolId;
  }

  @SuppressLint("DefaultLocale")
  @NonNull
  @Override
  public String toString() {
    return String.format(
        "%s(%d, %s, %s)",
        UnpairedRemoteReference.class.getName(),
        classId,
        creationArguments.toString(),
        managerPoolId);
  }
}
