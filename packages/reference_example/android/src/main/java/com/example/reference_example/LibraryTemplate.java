// GENERATED CODE - DO NOT MODIFY BY HAND

/*replace :from='com.example.reference_example' package*/
package com.example.reference_example;
/**/

import androidx.annotation.NonNull;

import java.util.Arrays;
import java.util.List;

import github.penguin.reference.async.Completable;
import github.penguin.reference.reference.PairedInstance;
import github.penguin.reference.reference.TypeChannel;
import github.penguin.reference.reference.TypeChannelHandler;
import github.penguin.reference.reference.TypeChannelMessenger;

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

public class /*replace libraryName*/LibraryTemplate/**/ {
  /*iterate classes class*/
  public interface $__class_name__ { }
  /**/

  /*iterate classes class*/
  public static class $__class_name__Channel extends TypeChannel<$__class_name__> {
    public $__class_name__Channel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "__class_channel__");
    }

    public Completable<PairedInstance> $$create($__class_name__ $instance, boolean $owner, /*iterate fields field*//*replace field.type*/Integer/**/ __field_name__/**/) {
      return createNewInstancePair($instance, Arrays.<Object>asList(/*iterate fields field*/__field_name__/**/), $owner);
    }

    /*iterate staticMethods staticMethod*/
    public Completable<Object> $__staticMethod_name__(/*iterate parameters parameter*//*replace parameter.type*/String/**/ __parameter_name__/**/) {
      return invokeStaticMethod("__staticMethod_name__", Arrays.<Object>asList(/*iterate parameters parameter*/__parameter_name__/**/));
    }
    /**/

    /*iterate methods method*/
    public Completable<Object> $__method_name__($__class_name__ $instance, /*iterate parameters parameter*//*replace parameter.type*/String/**/ __parameter_name__/**/) {
      return invokeMethod($instance, "__method_name__", Arrays.<Object>asList(/*iterate parameters parameter*/__parameter_name__/**/));
    }
    /**/
  }
  /**/

  /*iterate classes class*/
  public static class $__class_name__Handler implements TypeChannelHandler<$__class_name__> {
    public $__class_name__ $$create(TypeChannelMessenger messenger, /*iterate fields field*//*replace field.type*/Integer/**/ __field_name__/**/)
        throws Exception {
      throw new UnsupportedOperationException();
    }

    /*iterate staticMethods staticMethod*/
    public Object $__staticMethod_name__(TypeChannelMessenger messenger, /*iterate parameters parameter*//*replace parameter.type*/String/**/ __parameter_name__/**/)
        throws Exception {
      throw new UnsupportedOperationException();
    }
    /**/

    /*iterate methods method*/
    public Object $__method_name__($__class_name__ $instance, /*iterate parameters parameter*//*replace parameter.type*/String/**/ __parameter_name__/**/) throws Exception {
      throw new UnsupportedOperationException();
    }
    /**/

    @Override
    public Object invokeStaticMethod(
        TypeChannelMessenger messenger, String methodName, List<Object> arguments)
        throws Exception {
      switch (methodName) {
        /*iterate staticMethods staticMethod*/
        case "__staticMethod_name__":
          return $__staticMethod_name__(messenger, /*iterate parameters parameter*/(/*replace parameter_type*/String/**/) arguments.get(/*replace parameter_index*/0/**/)/**/);
        /**/
      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke static method %s", methodName));
    }

    @Override
    public $__class_name__ createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      return $$create(messenger, /*iterate fields field*/(/*replace field_type*/Integer/**/) arguments.get(/*replace field_index*/0/**/)/**/);
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
        case "__method_name__":
          return $__method_name__(instance, /*iterate parameters parameter*/(/*replace parameter_type*/String/**/) arguments.get(/*replace parameter_index*/0/**/)/**/);
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
    }

    public void unregisterHandlers() {
      /*iterate classes class*/
      implementations.getChannel__class_name__().removeHandler();
      /**/
    }
  }
}
