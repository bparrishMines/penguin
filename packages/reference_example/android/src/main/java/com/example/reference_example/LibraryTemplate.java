// GENERATED CODE - DO NOT MODIFY BY HAND

/*replace :from='com.example.reference_example' package*/
package com.example.reference_example;
/**/

/*iterate imports import*/
import /*replace value*/ com.example.reference_example.fakelibrary.__class_name__ /**/;
/*erase*/import com.example.reference_example.fakelibrary.__function_name__;/**/
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
  public static class $__function_name__Channel extends TypeChannel<__function_name__> {
    public final $LibraryImplementations implementations;

    public $__function_name__Channel(@NonNull $LibraryImplementations implementations) {
      super(implementations.messenger, "__function_channel__");
      this.implementations = implementations;
    }

    public Completable<PairedInstance> $create(__function_name__ $instance, boolean $owner) {
      return createNewInstancePair($instance, Collections.emptyList(), $owner);
    }

    public Completable<Void> $invoke(__function_name__ $instance
        /*iterate parameters parameter*/, /*replace parameter_type*/String/**/ __parameter_name__/**/) {
      /*iterate parameters parameter*/
      /*if isReference*/
      /*erase*////**/implementations.channel__parameter_type__.$create$(__parameter_name__, false);
      /**/
      /**/
      return invokeMethod($instance, "", Arrays.<Object>asList(/*iterate :join=',' parameters parameter*/__parameter_name__/**/));
    }
  }
  /**/

  /*iterate functions function*/
  public static class $__function_name__Handler implements TypeChannelHandler<__function_name__> {
    public final $LibraryImplementations implementations;

    public $__function_name__Handler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    public void $invoke(__function_name__ $instance/*iterate parameters parameter*/, /*replace parameter_type*/String/**/ __parameter_name__/**/) {
      $instance.invoke(/*iterate :join=',' parameters parameter*/__parameter_name__/**/);
    }

    @Override
    public __function_name__ createInstance(TypeChannelMessenger messenger, List<Object> arguments) {
      return new __function_name__() {
        @Override
        public Completable<Void> invoke(/*iterate :join=',' parameters parameter*//*replace parameter_type*/String/**/ __parameter_name__/**/) {
          return implementations.channel__function_name__.$invoke(this/*iterate parameters parameter*/,__parameter_name__/**/);
        }
      };
    }

    @Override
    public Object invokeStaticMethod(TypeChannelMessenger messenger, String methodName, List<Object> arguments) {
      throw new UnsupportedOperationException();
    }

    @Override
    public Void invokeMethod(TypeChannelMessenger messenger, __function_name__ instance, String methodName, List<Object> arguments) throws Exception {
      $invoke(instance/*iterate parameters parameter*/,(/*replace parameter_type*/String/**/) arguments.get(/*replace parameter_index*/0/**/)/**/);
      return null;
    }
  }
  /**/

  /*iterate classes class*/
  public static class $__class_name__Channel extends TypeChannel<__class_name__> {
    public final $LibraryImplementations implementations;

    public $__class_name__Channel(@NonNull $LibraryImplementations implementations) {
      super(implementations.messenger, "__class_channel__");
      this.implementations = implementations;
    }

    /*iterate constructors constructor*/
    public Completable<PairedInstance> $create$__constructor_name__(__class_name__ $instance, boolean $owner) {
      /*iterate parameters parameter*/
      /*if isReference*/
      /*erase*////**/implementations.channel__parameter_type__.$create$($instance.__parameter_name__, false);
      /**/
      /**/
      return createNewInstancePair($instance, Arrays.<Object>asList("__constructor_name__"/*iterate parameters parameter*/, $instance.__parameter_name__/**/), $owner);
    }
    /**/

    /*iterate staticMethods staticMethod*/
    /*if! returnsFuture*/
    public Completable</*replace staticMethod_returnType*/Double/**/> $__staticMethod_name__(/*iterate :join=',' parameters parameter*//*replace parameter_type*/String/**/ __parameter_name__/**/) {
      return invokeStaticMethod("__staticMethod_name__", Arrays.<Object>asList(/*iterate :join=',' parameters parameter*/__parameter_name__/**/));
    }
    /**/
    /**/

    /*iterate methods method*/
    /*if! returnsFuture*/
    public Completable</*replace method_returnType*/String/**/> $__method_name__(__class_name__ $instance/*iterate parameters parameter*/,/*replace parameter_type*/String/**/ __parameter_name__/**/) {
      return invokeMethod($instance, "__method_name__", Arrays.<Object>asList(/*iterate :join=',' parameters parameter*/__parameter_name__/**/));
    }
    /**/
    /**/
  }
  /**/

  /*iterate classes class*/
  public static class $__class_name__Handler implements TypeChannelHandler<__class_name__> {
    public final $LibraryImplementations implementations;

    public $__class_name__Handler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    /*iterate constructors constructor*/
    public __class_name__ $create$__constructor_name__(/*iterate :join=',' parameters parameter*//*replace parameter_type*/Integer/**/ __parameter_name__/**/)
        throws Exception {
      /*if! platformThrowsAsDefault*/
      return new __class_name__(__parameter_name__) {
        /*iterate callbackMethods callbackMethod*/
        /*if returnsFuture*/
        @Override
        public void __callbackMethod_name__(/*iterate :join=',' parameters parameter*//*replace parameter_type*/String/**/ __parameter_name__/**/) {
          /*erase*/
          // To have the method name in the return statement
          final __function_name__ __callbackMethod_name__ = __parameter_name__1 -> null;
          /**/
          __callbackMethod_name__.invoke(/*iterate :join=',' parameters parameter*/__parameter_name__/**/);
        }
        /**/
        /**/
      };
      /**/
      /*if platformThrowsAsDefault*//*erase*////**/throw new UnsupportedOperationException();/**/
    }
    /**/

    /*iterate staticMethods staticMethod*/
    /*if returnsFuture*/
    public /*replace staticMethod_returnType*/Double/**/ $__staticMethod_name__(/*iterate :join=',' parameters parameter*//*replace parameter_type*/String/**/ __parameter_name__/**/) throws Exception {
      /*if! platformThrowsAsDefault*/
      /*if! returnsVoid*/
      return /**/__class_name__.__staticMethod_name__(/*iterate :join=',' parameters parameter*/__parameter_name__/**/);
      /**/
      /*if platformThrowsAsDefault*//*erase*////**/throw new UnsupportedOperationException();/**/
    }
    /**/
    /**/

    /*iterate methods method*/
    /*if returnsFuture*/
    public /*replace method_returnType*/String/**/ $__method_name__(__class_name__ $instance/*iterate parameters parameter*/,/*replace parameter_type*/String/**/ __parameter_name__/**/) throws Exception {
      /*if! platformThrowsAsDefault*/
      /*if! returnsVoid*/
      return /**/$instance.__method_name__(/*iterate :join=',' parameters parameter*/__parameter_name__/**/);
      /**/
      /*if platformThrowsAsDefault*//*erase*////**/throw new UnsupportedOperationException();/**/
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
          /*if! returnsVoid*/
          return /**/$__staticMethod_name__(/*iterate :join=',' parameters parameter*/(/*replace parameter_type*/String/**/) arguments.get(/*replace parameter_index*/0/**/)/**/);
          /*if returnsVoid*/
          /*erase*////**/return null;
          /**/
        /**/
        /**/
      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke static method %s", methodName));
    }

    @Override
    public __class_name__ createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      final String constructorName = (String) arguments.get(0);
      switch(constructorName) {
        /*iterate constructors constructor*/
        case "__constructor_name__":
          return $create$__constructor_name__(/*iterate :join=',' parameters parameter*/(/*replace parameter_type*/Integer/**/) arguments.get(/*replace parameter_index*/1/**/)/**/);
        /**/
      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke constructor of %s", constructorName));
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        __class_name__ instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      switch(methodName) {
        /*iterate methods method*/
        /*if returnsFuture*/
        case "__method_name__":
          /*if! returnsVoid*/
          return /**/ $__method_name__(instance/*iterate parameters parameter*/,(/*replace parameter_type*/String/**/) arguments.get(/*replace parameter_index*/0/**/)/**/);
          /*if returnsVoid*/
          /*erase*////**/return null;
          /**/
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

    /*iterate classes class*/
    public $__class_name__Channel channel__class_name__;
    public $__class_name__Handler handler__class_name__;
    /**/

    /*iterate functions function*/
    public $__function_name__Channel channel__function_name__;
    public $__function_name__Handler handler__function_name__;
    /**/

    public $LibraryImplementations(TypeChannelMessenger messenger) {
      this.messenger = messenger;
      /*iterate classes class*/
      this.channel__class_name__ = new $__class_name__Channel(this);
      this.handler__class_name__ = new $__class_name__Handler(this);
      /**/
      /*iterate functions function*/
      this.channel__function_name__ = new $__function_name__Channel(this);
      this.handler__function_name__ = new $__function_name__Handler(this);
      /**/
    }
  }

  public static class $ChannelRegistrar {
    public final $LibraryImplementations implementations;

    public $ChannelRegistrar($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    public void registerHandlers() {
      /*iterate classes class*/
      implementations.channel__class_name__.setHandler(implementations.handler__class_name__);
      /**/
      /*iterate functions function*/
      implementations.channel__function_name__.setHandler(implementations.handler__function_name__);
      /**/
    }

    public void unregisterHandlers() {
      /*iterate classes class*/
      implementations.channel__class_name__.removeHandler();
      /**/
      /*iterate functions function*/
      implementations.channel__function_name__.removeHandler();
      /**/
    }
  }
}
