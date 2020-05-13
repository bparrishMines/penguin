package github.penguin.reference.reference;

import java.util.List;

public class UnpairedRemoteReference {
  public final TypeReference typeReference;
  public final List<Object> creationArguments;

  public UnpairedRemoteReference(TypeReference typeReference, List<Object> creationArguments) {
    this.typeReference = typeReference;
    this.creationArguments = creationArguments;
  }
}
