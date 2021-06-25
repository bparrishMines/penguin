package github.bparrishMines.penguin.penguin_android_camera;

import java.lang.reflect.Field;
import java.lang.reflect.Modifier;

public class Utils {
  static void setFinalStatic(Field field, Object newValue) throws Exception {
    field.setAccessible(true);

    Field modifiersField = Field.class.getDeclaredField("modifiers");
    modifiersField.setAccessible(true);
    modifiersField.setInt(field, field.getModifiers() & ~Modifier.FINAL);

    field.set(null, newValue);
  }
}
