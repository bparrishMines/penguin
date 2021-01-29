package github.penguin.reference;

import java.util.Collections;
import java.util.List;

import github.penguin.reference.async.Completable;
import github.penguin.reference.async.Completer;
import github.penguin.reference.reference.NewUnpairedInstance;
import github.penguin.reference.reference.PairedInstance;
import github.penguin.reference.reference.ReferenceType;
import github.penguin.reference.reference.TypeChannel;
import github.penguin.reference.reference.TypeChannelHandler;
import github.penguin.reference.reference.TypeChannelMessageDispatcher;
import github.penguin.reference.reference.TypeChannelMessenger;

public class TestClasses {
    public static class TestMessenger extends TypeChannelMessenger {
        public final TestMessageDispatcher testMessenger = new TestMessageDispatcher();
        public final TestHandler testHandler;

        public TestMessenger() {
            testHandler = new TestHandler(this);
            registerHandler("test_channel", testHandler);
        }

        @Override
        public TypeChannelMessageDispatcher getMessageDispatcher() {
            return testMessenger;
        }

        @Override
        public String generateUniqueInstanceId(Object instance) {
            return "test_instance_id";
        }
    }

    public static class TestMessageDispatcher implements TypeChannelMessageDispatcher {
        @Override
        public Completable<Void> sendCreateNewInstancePair(String channelName, PairedInstance pairedInstance, List<Object> arguments) {
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
        public Completable<Object> sendInvokeMethodOnUnpairedReference(NewUnpairedInstance unpairedInstance, String methodName, List<Object> arguments) {
            return new Completer<>().complete("return_value").completable;
        }

        @Override
        public Completable<Void> sendDisposePair(String channelName, PairedInstance pairedInstance) {
            return new Completer<Void>().complete(null).completable;
        }
    }

    public static class TestHandler implements TypeChannelHandler<TestClass> {
        public final TestClass testClassInstance;

        public TestHandler(TypeChannelMessenger messenger) {
            testClassInstance = new TestClass(messenger);
        }

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

        @Override
        public void onInstanceAdded(TypeChannelMessenger manager, TestClass instance) throws Exception {

        }

        @Override
        public void onInstanceRemoved(TypeChannelMessenger manager, TestClass instance) {

        }
    }

    public static class TestClass implements ReferenceType<TestClass> {
        public final TypeChannelMessenger messenger;

        public TestClass(TypeChannelMessenger messenger) {
            this.messenger = messenger;
        }

        @Override
        public TypeChannel<TestClass> getTypeChannel() {
            return new TypeChannel<>(messenger, "test_channel");
        }
    }

    public static class TestListener<T> implements Completable.OnCompleteListener<T> {
        public T result;

        @Override
        public void onComplete(T result) {
            this.result = result;
        }

        @Override
        public void onError(Throwable throwable) { }
    }
}
