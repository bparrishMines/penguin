package creator;

import com.squareup.javapoet.ClassName;

public class ClassDetails {
  public final boolean hasConstructor;

  /// Referenced by another class method or class field
  public final boolean isReferenced;

  /// Classname of the class
  public final ClassName wrappedClassName;

  /// Classname of wrapper
  public final ClassName wrapperClassName;

  // Name of the wrapped object in the class
  public final String wrappedObjectName;

  ClassDetails(boolean hasConstructor,
               boolean isReferenced,
               ClassName wrappedClassName,
               ClassName wrapperClassName,
               String wrappedObjectName) {
    this.hasConstructor = hasConstructor;
    this.isReferenced = isReferenced;
    this.wrappedClassName = wrappedClassName;
    this.wrapperClassName = wrapperClassName;
    this.wrappedObjectName = wrappedObjectName;
  }
}
