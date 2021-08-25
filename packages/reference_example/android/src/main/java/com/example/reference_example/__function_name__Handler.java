package com.example.reference_example;

import com.example.reference_example.fakelibrary.__function_name__;

import java.util.List;

import github.penguin.reference.async.Completable;
import github.penguin.reference.reference.TypeChannelMessenger;

public class __function_name__Handler extends LibraryTemplate.$__function_name__Handler {
  public __function_name__Handler(LibraryTemplate.$LibraryImplementations implementations) {
    super(implementations);
  }

  @Override
  public __function_name__ createInstance(TypeChannelMessenger messenger, List<Object> arguments) {
    return new __function_name__() {
        @Override
        public Completable<Void> invoke(String __parameter_name__) {
          return implementations.channel__function_name__.$invoke(this/*iterate parameters parameter*/,__parameter_name__/**/);
        }
      };
  }

  @Override
  public void $invoke(__function_name__ $instance, String __parameter_name__) {
    $instance.invoke(__parameter_name__);
  }
}
