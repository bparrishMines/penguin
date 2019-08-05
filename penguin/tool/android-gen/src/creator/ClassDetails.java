package creator;

import com.squareup.javapoet.ClassName;

public class ClassDetails {
  public final boolean hasConstructor;

  /// Referenced by another class method or class field
  public final boolean isReferenced;

  /// Classname of the class
  public final ClassName className;

  /// Classname of wrapper
  public final ClassName wrapperClassName;

  // Name of the wrapped object in the class
  public final String variableName;

  ClassDetails(boolean hasConstructor,
               boolean isReferenced,
               ClassName className,
               ClassName wrapperClassName,
               String variableName) {
    this.hasConstructor = hasConstructor;
    this.isReferenced = isReferenced;
    this.className = className;
    this.wrapperClassName = wrapperClassName;
    this.variableName = variableName;
  }
}
