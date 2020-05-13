package github.penguin.reference.reference;

public class TypeReference {
  public final int typeId;

  public TypeReference(final int typeId) {
    this.typeId = typeId;
  }

  @Override
  public boolean equals(Object obj) {
    return obj instanceof TypeReference && typeId == ((TypeReference) obj).typeId;
  }

  @Override
  public int hashCode() {
    return typeId;
  }
}
