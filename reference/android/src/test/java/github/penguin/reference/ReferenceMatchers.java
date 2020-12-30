package github.penguin.reference;

import github.penguin.reference.reference.NewUnpairedInstance;
import io.flutter.plugin.common.MethodCall;
import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;

import java.util.List;

@SuppressWarnings("rawtypes")
class ReferenceMatchers {
  static Matcher isMethodCall(String method, Object arguments) {
    return new IsMethodCall(method, arguments);
  }

  static Matcher isUnpairedInstance(String channelName, final Object creationArguments) {
    return new IsUnpairedInstance(channelName, creationArguments);
  }

//  static Matcher isRemoteReference(String referenceId) {
//    return new IsRemoteReference(referenceId);
//  }

  private static class IsMethodCall extends TypeSafeMatcher<MethodCall> {
    private final String method;
    private final Object arguments;

    private IsMethodCall(String method, Object arguments) {
      this.method = method;
      this.arguments = arguments;
    }

    private void describe(final String method, final Object arguments, Description description) {
      description
          .appendText(String.format("A %s with method name: ", MethodCall.class.getSimpleName()))
          .appendText(method)
          .appendText(" and arguments: ")
          .appendText(arguments.toString());
    }

    @Override
    public void describeTo(Description description) {
      describe(method, arguments, description);
    }

    @Override
    protected void describeMismatchSafely(MethodCall call, Description mismatchDescription) {
      describe(call.method, call.arguments, mismatchDescription);
    }

    @Override
    protected boolean matchesSafely(final MethodCall call) {
      if (!call.method.equals(method)) return false;
      if (arguments instanceof Matcher) return ((Matcher) arguments).matches(call.arguments);
      return arguments.equals(call.arguments);
    }
  }

  private static class IsUnpairedInstance extends TypeSafeMatcher<NewUnpairedInstance> {
    private final String channelName;
    private final Object creationArguments;
    //private final String managerPoolId;

    private IsUnpairedInstance(String channelName, Object creationArguments) {
      this.channelName = channelName;
      this.creationArguments = creationArguments;
      //this.managerPoolId = managerPoolId;
    }

    private void describe(
        final String channelName,
        final Object creationArguments,
        Description description) {
      description
          .appendText(
              String.format(" An %s with channelName: ", NewUnpairedInstance.class.getSimpleName()))
          .appendText(channelName)
          .appendText(" and creation arguments: ")
          .appendText(creationArguments != null ? creationArguments.toString() : null);
    }

    @Override
    public void describeTo(Description description) {
      describe(channelName, creationArguments, description);
    }

    @Override
    protected void describeMismatchSafely(
        NewUnpairedInstance unpairedInstance, Description mismatchDescription) {
      describe(
          unpairedInstance.channelName,
          unpairedInstance.creationArguments,
          mismatchDescription);
    }

    @Override
    protected boolean matchesSafely(NewUnpairedInstance unpairedInstance) {
      if (!channelName.equals(unpairedInstance.channelName)) return false;
      if (creationArguments instanceof List) {
        return creationArguments.equals(unpairedInstance.creationArguments);
      }
      if (creationArguments instanceof Matcher) {
        return ((Matcher) creationArguments).matches(unpairedInstance.creationArguments);
      }
      return creationArguments == unpairedInstance.creationArguments;
    }
  }

//  private static class IsRemoteReference extends TypeSafeMatcher<PairedInstance> {
//    private final Object referenceId;
//
//    private IsRemoteReference(Object referenceId) {
//      this.referenceId = referenceId;
//    }
//
//    @Override
//    protected boolean matchesSafely(PairedInstance item) {
//      if (referenceId instanceof Matcher) return ((Matcher) referenceId).matches(item.referenceId);
//      return item.referenceId.equals(referenceId);
//    }
//
//    @Override
//    public void describeTo(Description description) {
//      description
//          .appendText(
//              String.format(" A %s with referenceId: ", PairedInstance.class.getSimpleName()))
//          .appendText("" + referenceId);
//    }
//  }
}
