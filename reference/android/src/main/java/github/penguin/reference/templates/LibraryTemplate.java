// GENERATED CODE - DO NOT MODIFY BY HAND

package github.penguin.reference.templates;

import androidx.annotation.NonNull;
import github.penguin.reference.async.Completable;
import github.penguin.reference.reference.TypeChannel;
import github.penguin.reference.reference.TypeChannelHandler;
import github.penguin.reference.reference.TypeChannelMessenger;
import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.List;

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

class LibraryTemplate {
  interface $ClassTemplate {
    Integer getFieldTemplate();

    Object methodTemplate(String parameterTemplate) throws Exception;
  }

  static class $ClassTemplateCreationArgs {
    Integer fieldTemplate;
  }

  static class $ClassTemplateChannel extends TypeChannel<$ClassTemplate> {
    $ClassTemplateChannel(@NonNull TypeChannelMessenger manager) {
      super(manager, "github.penguin/template/template/ClassTemplate");
    }

    Completable<Object> $invokeStaticMethodTemplate(String parameterTemplate) {
      return invokeStaticMethod("staticMethodTemplate", Arrays.<Object>asList(parameterTemplate));
    }

    Completable<Object> $invokeMethodTemplate($ClassTemplate instance, String parameterTemplate) {
      return invokeMethod(instance, "methodTemplate", Arrays.<Object>asList(parameterTemplate));
    }
  }

  static class $ClassTemplateHandler implements TypeChannelHandler<$ClassTemplate> {
    $ClassTemplate onCreate(TypeChannelMessenger manager, $ClassTemplateCreationArgs args)
        throws Exception {
      return null;
    }

    public Object $onStaticMethodTemplate(TypeChannelMessenger manager, String parameterTemplate)
        throws Exception {
      return null;
    }

    @Override
    public Object invokeStaticMethod(
            TypeChannelMessenger manager, String methodName, List<Object> arguments)
        throws Exception {
      switch (methodName) {
        case "staticMethodTemplate":
          return $onStaticMethodTemplate(manager, (String) arguments.get(0));
      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke static method %s", methodName));
    }

    @Override
    public List<Object> getCreationArguments(
            TypeChannelMessenger manager, $ClassTemplate instance) {
      return Arrays.<Object>asList(instance.getFieldTemplate());
    }

    @Override
    public $ClassTemplate createInstance(TypeChannelMessenger manager, List<Object> arguments)
        throws Exception {
      final $ClassTemplateCreationArgs args = new $ClassTemplateCreationArgs();
      args.fieldTemplate = (Integer) arguments.get(0);
      return onCreate(manager, args);
    }

    @Override
    public Object invokeMethod(
        TypeChannelMessenger manager,
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

    @Override
    public void onInstanceAdded(TypeChannelMessenger manager, $ClassTemplate instance)
            throws Exception {}

    @Override
    public void onInstanceRemoved(TypeChannelMessenger manager, $ClassTemplate instance)
        throws Exception {}
  }
}
