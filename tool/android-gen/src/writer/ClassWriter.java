package writer;

import com.squareup.javapoet.JavaFile;
import com.squareup.javapoet.TypeSpec;
import objects.Class;

import javax.lang.model.element.Modifier;

public class ClassWriter extends Writer<Class, JavaFile> {
  @Override
  public JavaFile write(Class aClass) {
    TypeSpec helloWorld = TypeSpec.classBuilder("HelloWorld")
        .addModifiers(Modifier.PUBLIC, Modifier.FINAL)
        .build();

    JavaFile javaFile = JavaFile.builder("com.example.helloworld", helloWorld).build();

    return javaFile;
  }
}
