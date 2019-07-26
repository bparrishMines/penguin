package writers;

import objects.Plugin;
import objects.PluginClass;

import java.util.ArrayList;
import java.util.List;

abstract class Writer<T, K> {
  final Plugin plugin;

  Writer(Plugin plugin) {
    this.plugin = plugin;
  }

  public abstract K write(T object);

  public List<K> writeAll(List<T> objects) {
    final ArrayList<K> list = new ArrayList<>();

    for (T object : objects) {
      list.add(write(object));
    }

    return list;
  }

  final PluginClass classFromString(String className) {
    for (PluginClass pluginClass : plugin.classes) {
      if (pluginClass.name.equals(className)) {
        return pluginClass;
      }
    }

    return null;
  }
}
