// GENERATED CODE - DO NOT MODIFY BY HAND

package com.example.reference_example;

import androidx.annotation.NonNull;

import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.List;

import github.penguin.reference.async.Completable;
import github.penguin.reference.reference.TypeChannel;
import github.penguin.reference.reference.TypeChannelHandler;
import github.penguin.reference.reference.TypeChannelMessenger;

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

class LibraryTemplate {
  public interface $ClassTemplate {
    Integer getFieldTemplate();

    Object methodTemplate(String parameterTemplate) throws Exception;
  }

  public interface $LibraryImplementations {
    $ClassTemplateChannel getClassTemplateChannel();

    $ClassTemplateHandler getClassTemplateHandler();
  }

  public static class $ClassTemplateCreationArgs {
    public Integer fieldTemplate;
  }

  public static class $ClassTemplateChannel extends TypeChannel<$ClassTemplate> {
    public $ClassTemplateChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger, "github.penguin/template/template/ClassTemplate");
    }

    public Completable<Object> $invokeStaticMethodTemplate(String parameterTemplate) {
      return invokeStaticMethod("staticMethodTemplate", Arrays.<Object>asList(parameterTemplate));
    }

    public Completable<Object> $invokeMethodTemplate($ClassTemplate instance, String parameterTemplate) {
      return invokeMethod(instance, "methodTemplate", Arrays.<Object>asList(parameterTemplate));
    }
  }

  public static class $ClassTemplateHandler implements TypeChannelHandler<$ClassTemplate> {
    public $ClassTemplate onCreate(TypeChannelMessenger messenger, $ClassTemplateCreationArgs args)
        throws Exception {
      return null;
    }

    public Object $onStaticMethodTemplate(TypeChannelMessenger messenger, String parameterTemplate)
        throws Exception {
      return null;
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
    public List<Object> getCreationArguments(
        TypeChannelMessenger messenger, $ClassTemplate instance) {
      return Arrays.<Object>asList(instance.getFieldTemplate());
    }

    @Override
    public $ClassTemplate createInstance(TypeChannelMessenger messenger, List<Object> arguments)
        throws Exception {
      final $ClassTemplateCreationArgs args = new $ClassTemplateCreationArgs();
      args.fieldTemplate = (Integer) arguments.get(0);
      return onCreate(messenger, args);
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger messenger,
        $ClassTemplate instance,
        String methodName,
        List<Object> arguments)
        throws Exception {
      for (Method method : $ClassTemplate.class.getMethods()) {
        if (method.getName().equals(methodName)) {
          return method.invoke(instance, arguments.toArray());
        }
      }

      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
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
