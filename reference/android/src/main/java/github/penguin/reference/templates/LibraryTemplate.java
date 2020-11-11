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
  private static Object replaceIfUnpaired(
      ReferenceChannelManager manager, String handlerChannel, Object instance) {
    return manager.isPaired(instance)
        ? instance
        : manager.createUnpairedReference(handlerChannel, instance);
  }

  interface $ClassTemplate {
    Integer getFieldTemplate();

    $ClassTemplate2 getReferenceParameterTemplate();

    Object methodTemplate(String parameterTemplate, $ClassTemplate2 referenceParameterTemplate)
        throws Exception;
  }

  interface $ClassTemplate2 {}

  static class $ClassTemplateCreationArgs {
    Integer fieldTemplate;
    $ClassTemplate2 referenceParameterTemplate;
  }

  static class $ClassTemplate2CreationArgs {}

  static class $ClassTemplateChannel extends ReferenceChannel<$ClassTemplate> {
    $ClassTemplateChannel(@NonNull ReferenceChannelManager manager) {
      super(manager, "github.penguin/template/template/ClassTemplate");
    }

    Completable<Object> $invokeStaticMethodTemplate(
        String parameterTemplate, $ClassTemplate2 referenceParameterTemplate) {
      return invokeStaticMethod(
          "staticMethodTemplate",
          Arrays.<Object>asList(
              parameterTemplate,
              replaceIfUnpaired(
                  manager,
                  "github.penguin/template/template/ClassTemplate2",
                  referenceParameterTemplate)));
    }

    Completable<Object> $invokeMethodTemplate(
        $ClassTemplate instance,
        String parameterTemplate,
        $ClassTemplate2 referenceParameterTemplate) {
      final String $methodName = "methodTemplate";
      final List<Object> $arguments =
          Arrays.<Object>asList(
              parameterTemplate,
              replaceIfUnpaired(
                  manager,
                  "github.penguin/template/template/ClassTemplate2",
                  referenceParameterTemplate));

      if (manager.isPaired(instance)) return invokeMethod(instance, $methodName, $arguments);
      return invokeMethodOnUnpairedReference(instance, $methodName, $arguments);
    }
  }

  static class $ClassTemplate2Channel extends ReferenceChannel<$ClassTemplate2> {
    $ClassTemplate2Channel(@NonNull ReferenceChannelManager manager) {
      super(manager, "github.penguin/template/template/ClassTemplate2");
    }
  }

  static class $ClassTemplateHandler implements ReferenceChannelHandler<$ClassTemplate> {
    $ClassTemplate onCreate(
        ReferenceChannelManager manager, $ClassTemplateCreationArgs args) throws Exception {
      return null;
    }

    public Object $onStaticMethodTemplate(
        ReferenceChannelManager manager,
        String parameterTemplate,
        $ClassTemplate2 referenceParameterTemplate)
        throws Exception {
      return null;
    }

    @Override
    public Object invokeStaticMethod(
        ReferenceChannelManager manager, String methodName, List<Object> arguments)
        throws Exception {
      switch (methodName) {
        case "staticMethodTemplate":
          return $onStaticMethodTemplate(
              manager, (String) arguments.get(0), ($ClassTemplate2) arguments.get(1));
      }

      throw new UnsupportedOperationException(
          String.format("Unable to invoke static method %s", methodName));
    }

    @Override
    public List<Object> getCreationArguments(
        ReferenceChannelManager manager, $ClassTemplate instance) {
      return Arrays.<Object>asList(
          instance.getFieldTemplate(),
          replaceIfUnpaired(
              manager,
              "github.penguin/template/template/ClassTemplate2",
              instance.getReferenceParameterTemplate()));
    }

    @Override
    public $ClassTemplate createInstance(ReferenceChannelManager manager, List<Object> arguments)
        throws Exception {
      final $ClassTemplateCreationArgs args = new $ClassTemplateCreationArgs();
      args.fieldTemplate = (Integer) arguments.get(0);
      args.referenceParameterTemplate = ($ClassTemplate2) arguments.get(1);
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

  static class $ClassTemplate2Handler implements ReferenceChannelHandler<$ClassTemplate2> {
    $ClassTemplate2 onCreateClassTemplate2(
        ReferenceChannelManager manager, $ClassTemplate2CreationArgs args) {
      return null;
    }

    @Override
    public Object invokeStaticMethod(
        ReferenceChannelManager manager, String methodName, List<Object> arguments) {
      throw new UnsupportedOperationException(
          String.format("Unable to invoke static method %s", methodName));
    }

    @Override
    public List<Object> getCreationArguments(
        ReferenceChannelManager manager, $ClassTemplate2 instance) {
      return Arrays.asList();
    }

    @Override
    public $ClassTemplate2 createInstance(ReferenceChannelManager manager, List<Object> arguments) {
      return onCreateClassTemplate2(manager, new $ClassTemplate2CreationArgs());
    }

    @Override
    public Object invokeMethod(
        ReferenceChannelManager manager,
        $ClassTemplate2 instance,
        String methodName,
        List<Object> arguments) {
      throw new UnsupportedOperationException(
          String.format("%s.%s not supported.", instance, methodName));
    }

    @Override
    public void onInstanceDisposed(ReferenceChannelManager manager, $ClassTemplate2 instance) {}
  }
}
