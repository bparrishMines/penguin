package plugins.penguin.penguin_plugin;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;

import java.lang.reflect.Constructor;
import java.util.HashMap;
import java.util.UUID;

import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class PenguinViewFactory extends PlatformViewFactory {
  private final WrapperManager wrapperManager;
  private final MethodChannel callbackChannel;
  private final Constructor contextWrapperConstructor;

  public PenguinViewFactory(WrapperManager wrapperManager, MethodChannel callbackChannel, Constructor contextWrapperConstructor) {
    super(StandardMessageCodec.INSTANCE);
    this.wrapperManager = wrapperManager;
    this.callbackChannel = callbackChannel;
    this.contextWrapperConstructor = contextWrapperConstructor;
  }

  @Override
  public PlatformView create(final Context context, int viewId, final Object args) {
    final FrameLayout frameLayout = new FrameLayout(context);
    final Wrapper contextWrapper;
    try {
      contextWrapper = (Wrapper) contextWrapperConstructor.newInstance(wrapperManager, UUID.randomUUID().toString(), context);
    } catch (Exception exception) {
      exception.printStackTrace();
      return null;
    }

    final HashMap<String, Object> arguments = new HashMap<>();
    arguments.put("context", contextWrapper.$uniqueId);
    arguments.put("callbackId", args);

    callbackChannel.invokeMethod("onCreateView", arguments, new MethodChannel.Result() {
      @Override
      public void success(Object result) {
        final View view;
        try {
          view = wrapperManager.getWrapper((String) result).getView();
        } catch (WrapperNotFoundException exception) {
          exception.printStackTrace();
          return;
        }
        frameLayout.addView(view,
            new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));
      }

      @Override
      public void error(String errorCode, String errorMessage, Object errorDetails) {
        throw new RuntimeException(errorMessage);
      }

      @Override
      public void notImplemented() {
        throw new RuntimeException("notImplemented");
      }
    });

    return new PlatformView() {
      @Override
      public View getView() {
        return frameLayout;
      }

      @Override
      public void dispose() {
        contextWrapper.deallocate(wrapperManager);
      }
    };
  }
}
