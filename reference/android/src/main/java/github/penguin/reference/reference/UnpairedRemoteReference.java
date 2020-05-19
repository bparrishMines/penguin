package github.penguin.reference.reference;

import androidx.annotation.NonNull;
import java.util.List;

public class UnpairedRemoteReference {
  public final TypeReference typeReference;
  public final List<Object> creationArguments;

  public UnpairedRemoteReference(TypeReference typeReference, List<Object> creationArguments) {
    this.typeReference = typeReference;
    this.creationArguments = creationArguments;
  }

  @NonNull
  @Override
  public String toString() {
    return String.format(
        "%s(%s, %s)",
        UnpairedRemoteReference.class.getName(),
        typeReference.toString(),
        creationArguments.toString());
  }
}
