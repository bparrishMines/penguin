package com.example.reference_example;

import github.penguin.reference.reference.TypeChannelMessenger;

public class ChannelRegistrar extends LibraryTemplate.$ChannelRegistrar {
  public ChannelRegistrar(LibraryImplementations implementations) {
    super(implementations);
  }

  public static class ClassTemplateHandler extends LibraryTemplate.$ClassTemplateHandler {
    @Override
    public ClassTemplateProxy onCreate(TypeChannelMessenger messenger, LibraryTemplate.$ClassTemplateCreationArgs args) {
      return new ClassTemplateProxy(args.fieldTemplate);
    }

    @Override
    public Object $onStaticMethodTemplate(TypeChannelMessenger messenger, String parameterTemplate) {
      return ClassTemplateProxy.staticMethodTemplate(parameterTemplate);
    }
  }

  public static class LibraryImplementations extends LibraryTemplate.$LibraryImplementations {
    public LibraryImplementations(TypeChannelMessenger messenger) {
      super(messenger);
    }

    @Override
    public LibraryTemplate.$ClassTemplateHandler getClassTemplateHandler() {
      return new ClassTemplateHandler();
    }
  }
}
