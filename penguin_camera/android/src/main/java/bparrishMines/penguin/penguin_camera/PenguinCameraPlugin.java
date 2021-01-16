package bparrishMines.penguin.penguin_camera;

import android.app.Activity;

import androidx.annotation.NonNull;

import androidx.lifecycle.Lifecycle;
import androidx.lifecycle.LifecycleOwner;
import bparrishMines.penguin.penguin_camera.camera.Camera;
import bparrishMines.penguin.penguin_camera.camera.CameraInfo;
import bparrishMines.penguin.penguin_camera.camerax.CameraSelector;
import bparrishMines.penguin.penguin_camera.camerax.Preview;
import bparrishMines.penguin.penguin_camera.camerax.ProcessCameraProvider;
import bparrishMines.penguin.penguin_camera.camerax.SuccessListener;
import github.penguin.reference.ReferencePlugin;
import github.penguin.reference.reference.ReferenceChannelManager;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.embedding.engine.plugins.lifecycle.FlutterLifecycleAdapter;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.view.TextureRegistry;

/** PenguinCameraPlugin */
public class PenguinCameraPlugin implements FlutterPlugin, ActivityAware, LifecycleOwner {
  private FlutterPluginBinding pluginBinding;
  private Lifecycle lifecycle;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    pluginBinding = flutterPluginBinding;
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) { }

  private void initialize(BinaryMessenger binaryMessenger, TextureRegistry textureRegistry, Activity activity) {
    final ReferenceChannelManager manager = ReferencePlugin.getManagerInstance(binaryMessenger);
    Camera.setupChannel(ReferencePlugin.getManagerInstance(binaryMessenger), textureRegistry);
    CameraInfo.setupChannel(ReferencePlugin.getManagerInstance(binaryMessenger));

    bparrishMines.penguin.penguin_camera.camerax.Camera.setupChannel(manager);
    CameraSelector.setupChannel(manager);
    Preview.setupChannel(manager, activity, pluginBinding.getTextureRegistry());
    ProcessCameraProvider.setupChannel(manager, activity, this);
    SuccessListener.setupChannel(manager);
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    lifecycle = FlutterLifecycleAdapter.getActivityLifecycle(binding);
    initialize(pluginBinding.getBinaryMessenger(), pluginBinding.getTextureRegistry(), binding.getActivity());
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {

  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
//    lifecycle = FlutterLifecycleAdapter.getActivityLifecycle(binding);
//    //cameraXManager.setContext(binding.getActivity());
  }

  @Override
  public void onDetachedFromActivity() {

  }

  @NonNull
  @Override
  public Lifecycle getLifecycle() {
    return lifecycle;
  }
}
