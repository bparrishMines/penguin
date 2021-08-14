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
import github.penguin.reference.async.Completer;
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
    public abstract Completable<Void> invoke(/*iterate :join=',' parameters parameter*//*replace parameter_type*/String/**/ __parameter_name__/**/)/*if returnsFuture*/throws Exception/**/;
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

    private Completable<Void> invoke($__function_name__ $instance
        /*iterate parameters parameter*/, /*replace parameter_type*/String/**/ __parameter_name__/**/) {
      final Completer<Void> completer = new Completer<>();
      invokeMethod($instance, "", Arrays.<Object>asList(/*iterate :join=',' parameters parameter*/__parameter_name__/**/)).setOnCompleteListener(new Completable.OnCompleteListener<Object>() {
        @Override
        public void onComplete(Object result) {
          completer.complete((Void) result);
        }

        @Override
        public void onError(Throwable throwable) {
          completer.completeWithError(throwable);
        }
      });
      return completer.completable;
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
        public Completable<Void> invoke(/*iterate :join=',' parameters parameter*//*replace parameter_type*/String/**/ __parameter_name__/**/) {
          return implementations.__function_name__Channel.invoke(this/*iterate parameters parameter*/,__parameter_name__/**/);
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
  public static class $__class_name__Channel extends TypeChannel<__class_name__Proxy> {
    public $__class_name__Channel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "__class_channel__");
    }

    /*iterate constructors constructor*/
    public Completable<PairedInstance> $create(__class_name__Proxy $instance, boolean $owner/*iterate parameters parameter*/,/*replace parameter_type*/Integer/**/ __parameter_name__/**/) {
      return createNewInstancePair($instance, Arrays.<Object>asList("__constructor_name__"/*iterate parameters parameter*/, __parameter_name__/**/), $owner);
    }
    /**/

    /*iterate constructors constructor*/
    public Completable<PairedInstance> $create$__constructor_name__(__class_name__Proxy $instance, boolean $owner/*iterate parameters parameter*/,/*replace parameter_type*/Integer/**/ __parameter_name__/**/) {
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
    public Completable<Object> $__method_name__(__class_name__Proxy $instance/*iterate parameters parameter*/,/*replace parameter_type*/String/**/ __parameter_name__/**/) {
      return invokeMethod($instance, "__method_name__", Arrays.<Object>asList(/*iterate :join=',' parameters parameter*/__parameter_name__/**/));
    }
    /**/
    /**/
  }
  /**/

  /*iterate classes class*/
  public static class $__class_name__Handler implements TypeChannelHandler<__class_name__Proxy> {
    public final $LibraryImplementations implementations;

    public $__class_name__Handler($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    /*iterate constructors constructor*/
    public __class_name__Proxy $create(/*replace parameter_type*/Integer/**/ __parameter_name__/**/)
        throws Exception {
      return new __class_name__Proxy(implementations, __parameter_name__);
    }
    /**/

    /*iterate constructors constructor*/
    public __class_name__Proxy $create$__constructor_name__(/*replace parameter_type*/Integer/**/ __parameter_name__/**/)
        throws Exception {
      return new __class_name__Proxy(implementations, __parameter_name__);
    }
    /**/

    /*iterate staticMethods staticMethod*/
    /*if returnsFuture*/
    public Double $__staticMethod_name__(/*replace parameter_type*/String/**/ __parameter_name__/**/)
        throws Exception {
      return __class_name__Proxy.staticMethodTemplate(implementations, __parameter_name__);
    }
    /**/
    /**/

    /*iterate methods method*/
    /*if returnsFuture*/
    public String $__method_name__(__class_name__Proxy $instance/*iterate parameters parameter*/,/*replace parameter_type*/String/**/ __parameter_name__/**/) throws Exception {
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
          return $__staticMethod_name__(/*iterate :join=',' parameters parameter*/(/*replace parameter_type*/String/**/) arguments.get(/*replace parameter_index*/0/**/)/**/);
        /**/
        /**/
      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke static method %s", methodName));
    }

    @Override
    public __class_name__Proxy createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      final String constructorName = (String) arguments.get(0);
      switch(constructorName) {
        /*iterate constructors constructor*/
        case "":
          return $create(/*iterate :join=',' parameters parameter*/(/*replace parameter_type*/Integer/**/) arguments.get(/*replace parameter_index*/1/**/)/**/);
        /**/

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
        __class_name__Proxy instance,
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

    /*iterate classes class*/
    public $__class_name__Channel __class_name__Channel;
    public $__class_name__Handler __class_name__Handler;
    /**/

    /*iterate functions function*/
    public $__function_name__Channel __function_name__Channel;
    public $__function_name__Handler __function_name__Handler;
    /**/

    public $LibraryImplementations(TypeChannelMessenger messenger) {
      this.messenger = messenger;
      this.__class_name__Channel = new $__class_name__Channel(messenger);
      this.__class_name__Handler = new $__class_name__Handler(this);
      this.__function_name__Channel = new $__function_name__Channel(messenger);
      this.__function_name__Handler = new $__function_name__Handler(this);
    }
  }

  public static class $ChannelRegistrar {
    public final $LibraryImplementations implementations;

    public $ChannelRegistrar($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    public void registerHandlers() {
      /*iterate classes class*/
      implementations.__class_name__Channel.setHandler(implementations.__class_name__Handler);
      /**/
      /*iterate functions function*/
      implementations.__function_name__Channel.setHandler(implementations.__function_name__Handler);
      /**/
    }

    public void unregisterHandlers() {
      /*iterate classes class*/
      implementations.__class_name__Channel.removeHandler();
      /**/
      /*iterate functions function*/
      implementations.__function_name__Channel.removeHandler();
      /**/
    }
  }
}
