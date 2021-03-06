package com.example.reference_example;

import java.util.List;

import github.penguin.reference.reference.TypeChannelMessenger;

public class ChannelRegistrar extends LibraryTemplate.$ChannelRegistrar {
  public ChannelRegistrar(LibraryImplementations implementations) {
    super(implementations);
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

  public static class ClassTemplateHandler extends LibraryTemplate.$__class_name__Handler {

    @Override
    public LibraryTemplate.$__class_name__ $create$__constructor_name__(TypeChannelMessenger messenger, Integer __parameter_name__) {
      return new classnameProxy(__parameter_name__);
    }

    @Override
    public Double $__staticMethod_name__(TypeChannelMessenger messenger, String __parameter_name__) {
      return classnameProxy.staticMethodTemplate(__parameter_name__);
    }

    @Override
    public String $__method_name__(LibraryTemplate.$__class_name__ $instance, String __parameter_name__) {
      return ((classnameProxy) $instance).__method_name__(__parameter_name__);
    }

    @Override
    public Object invokeMethod(TypeChannelMessenger messenger, LibraryTemplate.$__class_name__ instance, String methodName, List<Object> arguments) throws Exception {
      if (methodName.equals("callbackTest")) {
        final LibraryTemplate.$__function_name__ callback = (LibraryTemplate.$__function_name__) arguments.get(0);
        callback.invoke("Eureka!");
        return null;
      }
      return super.invokeMethod(messenger, instance, methodName, arguments);
    }
  }
}
