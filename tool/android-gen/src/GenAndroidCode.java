import com.esotericsoftware.yamlbeans.YamlException;
import com.esotericsoftware.yamlbeans.YamlReader;

/**
 * Main
 */
public class GenAndroidCode {
  public String name;
  public static void main(String[] args) {
    System.out.println("yolo"); 

    final YamlReader reader = new YamlReader("!GenAndroidCode\nname: apple");

    try {
      GenAndroidCode code = reader.read(GenAndroidCode.class);
      System.out.println(code.name);
    } catch (YamlException e) {
      e.printStackTrace();
    }
  }
}
