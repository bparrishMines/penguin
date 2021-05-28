// GENERATED CODE - DO NOT MODIFY BY HAND

package com.example.reference_example;

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

public class LibraryTemplate {
  public interface $ClassTemplate { }

  public static class $ClassTemplateChannel extends TypeChannel<$ClassTemplate> {
    public $ClassTemplateChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "github.penguin/template/template/ClassTemplate");
    }

    public Completable<PairedInstance> $create($ClassTemplate $instance, boolean $owner, Integer fieldTemplate) {
      return createNewInstancePair($instance, Arrays.<Object>asList(fieldTemplate), $owner);
    }

    public Completable<Object> $invokeStaticMethodTemplate(String parameterTemplate) {
      return invokeStaticMethod("staticMethodTemplate", Arrays.<Object>asList(parameterTemplate));
    }

    public Completable<Object> $invokeMethodTemplate($ClassTemplate instance, String parameterTemplate) {
      return invokeMethod(instance, "methodTemplate", Arrays.<Object>asList(parameterTemplate));
    }
  }

  public static class $ClassTemplateHandler implements TypeChannelHandler<$ClassTemplate> {
    public $ClassTemplate $create(TypeChannelMessenger messenger, Integer fieldTemplate)
        throws Exception {
      throw new UnsupportedOperationException();
    }

    public Object $onStaticMethodTemplate(TypeChannelMessenger messenger, String parameterTemplate)
        throws Exception {
      throw new UnsupportedOperationException();
    }

    public Object $onMethodTemplate($ClassTemplate $instance, String parameterTemplate) throws Exception {
      throw new UnsupportedOperationException();
    }

    @Override
    public Object invokeStaticMethod(
        TypeChannelMessenger messenger, String methodName, List<Object> arguments)
        throws Exception {
      switch (methodName) {
        case "staticMethodTemplate":
          return $onStaticMethodTemplate(messenger, (String) arguments.get(0));
      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke static method %s", methodName));
    }

    @Override
    public $ClassTemplate createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      return $create(messenger, (Integer) arguments.get(0));
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        $ClassTemplate instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      switch(methodName) {
        case "methodTemplate":
          return $onMethodTemplate(instance, (String) arguments.get(0));
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }
  }

  public static class $LibraryImplementations {
    public final TypeChannelMessenger messenger;

    public $LibraryImplementations(TypeChannelMessenger messenger) {
      this.messenger = messenger;
    }

    public $ClassTemplateChannel getClassTemplateChannel() {
      return new $ClassTemplateChannel(messenger);
    }

    public $ClassTemplateHandler getClassTemplateHandler() {
      return new $ClassTemplateHandler();
    }
  }

  public static class $ChannelRegistrar {
    public final $LibraryImplementations implementations;

    public $ChannelRegistrar($LibraryImplementations implementations) {
      this.implementations = implementations;
    }

    public void registerHandlers() {
      implementations.getClassTemplateChannel().setHandler(implementations.getClassTemplateHandler());
    }

    public void unregisterHandlers() {
      implementations.getClassTemplateChannel().removeHandler();
    }
  }
}
