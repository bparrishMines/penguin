package com.example.reference_example;

import github.penguin.reference.reference.TypeChannelMessenger;

public class ChannelRegistrar extends LibraryTemplate.$ChannelRegistrar {
  public ChannelRegistrar(LibraryImplementations implementations) {
    super(implementations);
  }

  public static class ClassTemplateHandler extends LibraryTemplate.$__class_name__Handler {
    @Override
    public LibraryTemplate.$__class_name__ $$create(TypeChannelMessenger messenger, Integer __field_name__) {
      return new classnameProxy(__field_name__);
    }

    @Override
    public Double $__staticMethod_name__(TypeChannelMessenger messenger, String __parameter_name__) {
      return classnameProxy.staticMethodTemplate(__parameter_name__);
    }

    @Override
    public Object $__method_name__(LibraryTemplate.$__class_name__ $instance, String __parameter_name__) {
      return ((classnameProxy) $instance).methodTemplate(__parameter_name__);
    }
  }

  public static class LibraryImplementations extends LibraryTemplate.$LibraryImplementations {
    public LibraryImplementations(TypeChannelMessenger messenger) {
      super(messenger);
    }

    @Override
    public ClassTemplateHandler getHandler__class_name__() {
      return new ClassTemplateHandler();
    }
  }
}
