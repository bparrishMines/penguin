// GENERATED CODE - DO NOT MODIFY BY HAND

package github.penguin.reference.templates;

import androidx.annotation.NonNull;
import github.penguin.reference.async.Completable;
import github.penguin.reference.reference.ReferenceChannel;
import github.penguin.reference.reference.ReferenceChannelHandler;
import github.penguin.reference.reference.ReferenceChannelManager;
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

  static class $ClassTemplateChannel extends ReferenceChannel<$ClassTemplate> {
    $ClassTemplateChannel(@NonNull ReferenceChannelManager manager) {
      super(manager, "github.penguin/template/template/ClassTemplate");
    }

    Completable<Object> $invokeStaticMethodTemplate(String parameterTemplate) {
      return invokeStaticMethod(
          "staticMethodTemplate",
          Arrays.<Object>asList(parameterTemplate));
    }

    Completable<Object> $invokeMethodTemplate(
        $ClassTemplate instance,
        String parameterTemplate) {
      final String $methodName = "methodTemplate";
      final List<Object> $arguments =
          Arrays.<Object>asList(parameterTemplate);

      if (manager.isPaired(instance)) return invokeMethod(instance, $methodName, $arguments);
      return invokeMethodOnUnpairedReference(instance, $methodName, $arguments);
    }
  }

  static class $ClassTemplateHandler implements ReferenceChannelHandler<$ClassTemplate> {
    $ClassTemplate onCreate(
        ReferenceChannelManager manager, $ClassTemplateCreationArgs args) throws Exception {
      return null;
    }

    public Object $onStaticMethodTemplate(
        ReferenceChannelManager manager,
        String parameterTemplate)
        throws Exception {
      return null;
    }

    @Override
    public Object invokeStaticMethod(
        ReferenceChannelManager manager, String methodName, List<Object> arguments)
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
        ReferenceChannelManager manager, $ClassTemplate instance) {
      return Arrays.<Object>asList(instance.getFieldTemplate());
    }

    @Override
    public $ClassTemplate createInstance(ReferenceChannelManager manager, List<Object> arguments)
        throws Exception {
      final $ClassTemplateCreationArgs args = new $ClassTemplateCreationArgs();
      args.fieldTemplate = (Integer) arguments.get(0);
      return onCreate(manager, args);
    }

    @Override
    public Object invokeMethod(
        ReferenceChannelManager manager,
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
    public void onInstanceDisposed(ReferenceChannelManager manager, $ClassTemplate instance)
        throws Exception {}
  }
}
