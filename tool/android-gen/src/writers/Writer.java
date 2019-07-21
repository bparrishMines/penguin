package writers;

import java.util.ArrayList;
import java.util.List;

abstract class Writer<T, K> {
  public abstract K write(T object);

  public final List<K> writeAll(List<T> objects) {
    final ArrayList<K> list = new ArrayList<>();

    for (T object : objects) {
      list.add(write(object));
    }

    return list;
  }
}
