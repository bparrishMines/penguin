package plugins.penguin.penguin_plugin;

import android.view.View;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.platform.PlatformView;

public abstract class Wrapper implements PlatformView {
  final String $uniqueId;

  public Wrapper(String uniqueId) {
    this.$uniqueId = uniqueId;
  }

  public abstract Object onMethodCall(WrapperManager wrapperManager, MethodCall call) throws Exception;
  public abstract Object $getValue();

  public void allocate(WrapperManager wrapperManager) {
    wrapperManager.addAllocatedWrapper(this);
  }

  public void deallocate(WrapperManager wrapperManager) {
    wrapperManager.removeAllocatedWrapper($uniqueId);
  }

  @Override
  public View getView() {
    return (View) $getValue();
  }

  @Override
  public void dispose() {
    // Do nothing
  }
}
