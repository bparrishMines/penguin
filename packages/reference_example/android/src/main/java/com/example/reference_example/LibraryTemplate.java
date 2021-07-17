// GENERATED CODE - DO NOT MODIFY BY HAND

/*replace :from='com.example.reference_example' package*/
package com.example.reference_example;
/**/

/*iterate imports import*/
import /*replace value*/ java.lang.Object /**/;
/**/

import androidx.annotation.NonNull;
import java.util.*;
import github.penguin.reference.async.Completable;
import github.penguin.reference.reference.PairedInstance;
import github.penguin.reference.reference.TypeChannel;
import github.penguin.reference.reference.TypeChannelHandler;
import github.penguin.reference.reference.TypeChannelMessenger;

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

public class /*replace libraryName*/LibraryTemplate/**/ {
  /*iterate functions function*/
  public static abstract class $__function_name__ {
    public abstract Object invoke(/*iterate :join=',' parameters parameter*//*replace parameter_type*/String/**/ __parameter_name__/**/)/*if returnsFuture*/throws Exception/**/;
  }
  /**/

  /*iterate functions function*/
  public static class $__function_name__Channel extends TypeChannel<$__function_name__> {
    public $__function_name__Channel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "__function_channel__");
    }

    public Completable<PairedInstance> $$create($__function_name__ $instance, boolean $owner) {
      return createNewInstancePair($instance, Collections.emptyList(), $owner);
    }

    private Completable<Object> invoke($__function_name__ $instance
        /*iterate parameters parameter*/,/*replace parameter_type*/String/**/ __parameter_name__/**/) {
      return invokeMethod($instance, "", Arrays.<Object>asList(/*iterate :join=',' parameters parameter*/__parameter_name__/**/));
    }
  }
  /**/

  /*iterate functions function*/
  public static class $__function_name__Handler implements TypeChannelHandler<$__function_name__> {
    public final $LibraryImplementations implementations;

    public $__function_name__Handler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    @Override
    public $__function_name__ createInstance(TypeChannelMessenger messenger, List<Object> arguments) {
      return new $__function_name__() {
        @Override
        public Object invoke(/*iterate :join=',' parameters parameter*//*replace parameter_type*/String/**/ __parameter_name__/**/) {
          return implementations.getChannel__function_name__().invoke(this/*iterate parameters parameter*/,__parameter_name__/**/);
        }
      };
    }

    @Override
    public Void invokeStaticMethod(TypeChannelMessenger messenger, String methodName, List<Object> arguments) {
      throw new UnsupportedOperationException();
    }

    @Override
    public Object invokeMethod(TypeChannelMessenger messenger, $__function_name__ instance, String methodName, List<Object> arguments) throws Exception {
      return instance.invoke(/*iterate :join=',' parameters parameter*/(/*replace parameter_type*/String/**/) arguments.get(/*replace parameter_index*/0/**/)/**/);
    }
  }
  /**/

  /*iterate classes class*/
  public interface $__class_name__ {
    /*iterate methods method*/
    /*if returnsFuture*/
    Object __method_name__(/*iterate :join=',' parameters parameter*//*replace parameter_type*/String/**/ __parameter_name__/**/) throws Exception;
    /**/
    /**/
  }
  /**/

  /*iterate classes class*/
  public static class $__class_name__Channel extends TypeChannel<$__class_name__> {
    public $__class_name__Channel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "__class_channel__");
    }

    /*iterate constructors constructor*/
    public Completable<PairedInstance> $create$__constructor_name__($__class_name__ $instance, boolean $owner/*iterate parameters parameter*/,/*replace parameter_type*/Integer/**/ __parameter_name__/**/) {
      return createNewInstancePair($instance, Arrays.<Object>asList("__constructor_name__"/*iterate parameters parameter*/, __parameter_name__/**/), $owner);
    }
    /**/

    /*iterate staticMethods staticMethod*/
    /*if! returnsFuture*/
    public Completable<Object> $__staticMethod_name__(/*iterate :join=',' parameters parameter*//*replace parameter_type*/String/**/ __parameter_name__/**/) {
      return invokeStaticMethod("__staticMethod_name__", Arrays.<Object>asList(/*iterate :join=',' parameters parameter*/__parameter_name__/**/));
    }
    /**/
    /**/

    /*iterate methods method*/
    /*if! returnsFuture*/
    public Completable<Object> $__method_name__($__class_name__ $instance/*iterate parameters parameter*/,/*replace parameter_type*/String/**/ __parameter_name__/**/) {
      return invokeMethod($instance, "__method_name__", Arrays.<Object>asList(/*iterate :join=',' parameters parameter*/__parameter_name__/**/));
    }
    /**/
    /**/
  }
  /**/

  /*iterate classes class*/
  public static class $__class_name__Handler implements TypeChannelHandler<$__class_name__> {
    /*iterate constructors constructor*/
    public $__class_name__ $create$__constructor_name__(TypeChannelMessenger messenger/*iterate parameters parameter*/,/*replace parameter_type*/Integer/**/ __parameter_name__/**/)
        throws Exception {
      throw new UnsupportedOperationException();
    }
    /**/

    /*iterate staticMethods staticMethod*/
    /*if returnsFuture*/
    public Object $__staticMethod_name__(TypeChannelMessenger messenger/*iterate parameters parameter*/,/*replace parameter_type*/String/**/ __parameter_name__/**/)
        throws Exception {
      throw new UnsupportedOperationException();
    }
    /**/
    /**/

    /*iterate methods method*/
    /*if returnsFuture*/
    public Object $__method_name__($__class_name__ $instance/*iterate parameters parameter*/,/*replace parameter_type*/String/**/ __parameter_name__/**/) throws Exception {
      return $instance.__method_name__(/*iterate :join=',' parameters parameter*/ __parameter_name__ /**/);
    }
    /**/
    /**/

    @Override
    public Object invokeStaticMethod(
        TypeChannelMessenger messenger, String methodName, List<Object> arguments)
        throws Exception {
      switch (methodName) {
        /*iterate staticMethods staticMethod*/
        /*if returnsFuture*/
        case "__staticMethod_name__":
          return $__staticMethod_name__(messenger/*iterate parameters parameter*/,(/*replace parameter_type*/String/**/) arguments.get(/*replace parameter_index*/0/**/)/**/);
        /**/
        /**/
      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke static method %s", methodName));
    }

    @Override
    public $__class_name__ createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      final String constructorName = (String) arguments.get(0);
      switch(constructorName) {
        /*iterate constructors constructor*/
        case "__constructor_name__":
          return $create$__constructor_name__(messenger/*iterate parameters parameter*/,(/*replace parameter_type*/Integer/**/) arguments.get(/*replace parameter_index*/1/**/)/**/);
        /**/
      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke constructor of %s", constructorName));
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        $__class_name__ instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      switch(methodName) {
        /*iterate methods method*/
        /*if returnsFuture*/
        case "__method_name__":
          return $__method_name__(instance/*iterate parameters parameter*/,(/*replace parameter_type*/String/**/) arguments.get(/*replace parameter_index*/0/**/)/**/);
        /**/
        /**/
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }
  /**/

  public static class $LibraryImplementations {
    public final TypeChannelMessenger messenger;

    public $LibraryImplementations(TypeChannelMessenger messenger) {
      this.messenger = messenger;
    }

    /*iterate classes class*/
    public $__class_name__Channel getChannel__class_name__() {
      return new $__class_name__Channel(messenger);
    }

    public $__class_name__Handler getHandler__class_name__() {
      return new $__class_name__Handler();
    }
    /**/

    /*iterate functions function*/
    public $__function_name__Channel getChannel__function_name__() {
      return new $__function_name__Channel(messenger);
    }

    public $__function_name__Handler getHandler__function_name__() {
      return new $__function_name__Handler(this);
    }
    /**/
  }

  public static class $ChannelRegistrar {
    public final $LibraryImplementations implementations;

    public $ChannelRegistrar($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    public void registerHandlers() {
      /*iterate classes class*/
      implementations.getChannel__class_name__().setHandler(implementations.getHandler__class_name__());
      /**/
      /*iterate functions function*/
      implementations.getChannel__function_name__().setHandler(implementations.getHandler__function_name__());
      /**/
    }

    public void unregisterHandlers() {
      /*iterate classes class*/
      implementations.getChannel__class_name__().removeHandler();
      /**/
      /*iterate functions function*/
      implementations.getChannel__function_name__().removeHandler();
      /**/
    }
  }
}
