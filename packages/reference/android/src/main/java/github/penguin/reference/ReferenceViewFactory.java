package github.penguin.reference;

import android.content.Context;

import github.penguin.reference.method_channel.ReferenceMessageCodec;
import github.penguin.reference.reference.InstanceManager;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class ReferenceViewFactory extends PlatformViewFactory {
  private final InstanceManager instanceManager;

  public ReferenceViewFactory(InstanceManager instanceManager) {
    super(new ReferenceMessageCodec());
    this.instanceManager = instanceManager;
  }

  @Override
  public PlatformView create(Context context, int viewId, Object args) {
    final String instanceId = (String) args;
    final PlatformView view = (PlatformView) instanceManager.getInstance(instanceId);

    if (view == null) {
      final String message = String.format("Unable to find instance with instanceId: %s", instanceId);
      throw new IllegalArgumentException(message);
    }

    return view;
  }
}
