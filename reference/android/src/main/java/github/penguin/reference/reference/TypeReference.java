package github.penguin.reference.reference;

import android.annotation.SuppressLint;
import androidx.annotation.NonNull;

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

  @SuppressLint("DefaultLocale")
  @NonNull
  @Override
  public String toString() {
    return String.format("%s(%d)", TypeReference.class.getName(), typeId);
  }
}
