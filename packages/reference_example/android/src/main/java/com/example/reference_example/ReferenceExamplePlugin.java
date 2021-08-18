package com.example.reference_example;

import androidx.annotation.NonNull;

import com.example.reference_example.LibraryTemplate.$ChannelRegistrar;
import com.example.reference_example.LibraryTemplate.$LibraryImplementations;

import java.util.List;

import github.penguin.reference.ReferencePlugin;
import github.penguin.reference.reference.TypeChannelMessenger;
import io.flutter.embedding.engine.plugins.FlutterPlugin;

/**
 * ReferenceExamplePlugin
 */
public class ReferenceExamplePlugin implements FlutterPlugin {
  private LibraryTemplate.$ChannelRegistrar channelRegistrar;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    final TypeChannelMessenger messenger = ReferencePlugin.getMessengerInstance(flutterPluginBinding.getBinaryMessenger());
    channelRegistrar = new $ChannelRegistrar(new $LibraryImplementations(messenger));

    // For testing the anonymous function.
    channelRegistrar.implementations.handler__class_name__ = new LibraryTemplate.$__class_name__Handler(channelRegistrar.implementations) {
      @Override
      public Object invokeMethod(TypeChannelMessenger messenger, __class_name__ instance, String methodName, List<Object> arguments) throws Exception {
        if (methodName.equals("callbackTest")) {
          final LibraryTemplate.$__function_name__ callback = (LibraryTemplate.$__function_name__) arguments.get(0);
          callback.invoke("Eureka!");
          return null;
        }
        return super.invokeMethod(messenger, instance, methodName, arguments);
      }
    };

    channelRegistrar.registerHandlers();
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channelRegistrar.unregisterHandlers();
  }

  public $ChannelRegistrar getChannelRegistrar() {
    return channelRegistrar;
  }
}
