package github.penguin.reference;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import github.penguin.reference.async.Completable;
import github.penguin.reference.async.Completer;
import github.penguin.reference.reference.InstanceManager;
import github.penguin.reference.reference.PairedInstance;
import github.penguin.reference.reference.TypeChannelHandler;
import github.penguin.reference.reference.TypeChannelMessageDispatcher;
import github.penguin.reference.reference.TypeChannelMessenger;

public class TestClasses {
  public static class TestMessenger extends TypeChannelMessenger {
    public final TestMessageDispatcher testMessageDispatcher = new TestMessageDispatcher();
    public final TestInstanceManager testInstancePairManager = new TestInstanceManager();
    public final TestHandler testHandler = new TestHandler();

    public TestMessenger() {
      registerHandler("test_channel", testHandler);
    }

    @Override
    public TypeChannelMessageDispatcher getMessageDispatcher() {
      return testMessageDispatcher;
    }

    @NonNull
    @Override
    public InstanceManager getInstanceManager() {
      return testInstancePairManager;
    }
  }

  public static class TestMessageDispatcher implements TypeChannelMessageDispatcher {
    @Override
    public Completable<Void> sendCreateNewInstancePair(String channelName, PairedInstance pairedInstance, List<Object> arguments, boolean owner) {
      return new Completer<Void>().complete(null).completable;
    }

    @Override
    public Completable<Object> sendInvokeStaticMethod(String channelName, String methodName, List<Object> arguments) {
      return new Completer<>().complete("return_value").completable;
    }

    @Override
    public Completable<Object> sendInvokeMethod(String channelName, PairedInstance pairedInstance, String methodName, List<Object> arguments) {
      return new Completer<>().complete("return_value").completable;
    }

    @Override
    public Completable<Void> sendDisposeInstancePair(PairedInstance pairedInstance) {
      return new Completer<Void>().complete(null).completable;
    }
  }

  public static class TestHandler implements TypeChannelHandler<TestClass> {
    public final TestClass testClassInstance = new TestClass();

    @Override
    public List<Object> getCreationArguments(TypeChannelMessenger manager, TestClass instance) {
      return Collections.emptyList();
    }

    @Override
    public TestClass createInstance(TypeChannelMessenger manager, List<Object> arguments) {
      return testClassInstance;
    }

    @Override
    public Object invokeStaticMethod(TypeChannelMessenger manager, String methodName, List<Object> arguments) {
      return "return_value";
    }

    @Override
    public Object invokeMethod(TypeChannelMessenger manager, TestClass instance, String methodName, List<Object> arguments) {
      return "return_value";
    }
  }

  public static class TestInstanceManager extends InstanceManager {
    @Override
    protected String generateUniqueInstanceId(Object instance) {
      return "test_instance_id";
    }
  }

  public static class TestClass {
  }

  public static class TestListener<T> implements Completable.OnCompleteListener<T> {
    public T result;

    @Override
    public void onComplete(T result) {
      this.result = result;
    }

    @Override
    public void onError(Throwable throwable) {
    }
  }
}
