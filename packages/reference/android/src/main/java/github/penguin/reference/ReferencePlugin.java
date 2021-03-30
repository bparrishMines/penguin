package github.penguin.reference;

import android.util.Log;

import androidx.annotation.NonNull;

import java.util.HashMap;
import java.util.Map;

import github.penguin.reference.method_channel.MethodChannelMessenger;
import github.penguin.reference.reference.TypeChannelMessenger;
import github.penguin.reference.templates.PluginTemplate;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;

/**
 * ReferencePlugin
 */
public class ReferencePlugin implements FlutterPlugin {
  private final Apple apple = new Apple();

  private static final Map<BinaryMessenger, TypeChannelMessenger> messengers = new HashMap<>();

  public static TypeChannelMessenger getMessengerInstance(BinaryMessenger messenger) {
    TypeChannelMessenger typeChannelMessenger = messengers.get(messenger);
    if (typeChannelMessenger == null) {
      typeChannelMessenger = new MethodChannelMessenger(messenger, "github.penguin/reference");
      messengers.put(messenger, typeChannelMessenger);
    }
    return typeChannelMessenger;
  }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
    Log.i("APPLE", "HEREE");
    //Log.i("APPLE", getMsgFromJni(apple));
    new PluginTemplate().onAttachedToEngine(binding);
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    new PluginTemplate().onDetachedFromEngine(binding);
    messengers.remove(binding.getBinaryMessenger());
  }

//  static {
//    System.loadLibrary("native_add");
//  }
//
//  public native String getMsgFromJni(Apple appleClass);
//
//  @Override
//  protected void finalize() throws Throwable {
//    super.finalize();
//  }
}
