package com.example.reference_example;

import androidx.annotation.NonNull;

import github.penguin.reference.reference.TypeChannelMessenger;

public class ChannelRegistrar extends LibraryTemplate.$ChannelRegistrar {
  public static class ClassTemplateChannel extends LibraryTemplate.$ClassTemplateChannel {
    public ClassTemplateChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger);
    }
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

  public static class LibraryImplementations implements LibraryTemplate.$LibraryImplementations {
    private final ClassTemplateChannel classTemplateChannel;
    private final ClassTemplateHandler classTemplateHandler;

    public LibraryImplementations(TypeChannelMessenger messenger) {
      this.classTemplateChannel = new ClassTemplateChannel(messenger);
      this.classTemplateHandler = new ClassTemplateHandler();
    }

    @Override
    public LibraryTemplate.$ClassTemplateChannel getClassTemplateChannel() {
      return classTemplateChannel;
    }

    @Override
    public LibraryTemplate.$ClassTemplateHandler getClassTemplateHandler() {
      return classTemplateHandler;
    }
  }

  public ChannelRegistrar(LibraryImplementations implementations) {
    super(implementations);
  }
}
