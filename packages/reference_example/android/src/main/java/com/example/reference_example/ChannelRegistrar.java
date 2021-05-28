package com.example.reference_example;

import github.penguin.reference.reference.TypeChannelMessenger;

public class ChannelRegistrar extends LibraryTemplate.$ChannelRegistrar {
  public ChannelRegistrar(LibraryImplementations implementations) {
    super(implementations);
  }

  public static class ClassTemplateHandler extends LibraryTemplate.$ClassTemplateHandler {
    @Override
    public ClassTemplateProxy $create(TypeChannelMessenger messenger, Integer fieldTemplate) {
      return new ClassTemplateProxy(fieldTemplate);
    }

    @Override
    public Double $onStaticMethodTemplate(TypeChannelMessenger messenger, String parameterTemplate) {
      return ClassTemplateProxy.staticMethodTemplate(parameterTemplate);
    }

    @Override
    public String $onMethodTemplate(LibraryTemplate.$ClassTemplate $instance, String parameterTemplate) {
      return ((ClassTemplateProxy) $instance).methodTemplate(parameterTemplate);
    }
  }

  public static class LibraryImplementations extends LibraryTemplate.$LibraryImplementations {
    public LibraryImplementations(TypeChannelMessenger messenger) {
      super(messenger);
    }

    @Override
    public ClassTemplateHandler getClassTemplateHandler() {
      return new ClassTemplateHandler();
    }
  }
}
