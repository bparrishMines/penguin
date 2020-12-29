package github.penguin.reference;

import github.penguin.reference.reference.PairedInstance;
import github.penguin.reference.reference.NewUnpairedInstance;
import io.flutter.plugin.common.MethodCall;
import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;

@SuppressWarnings("rawtypes")
class ReferenceMatchers {
  static Matcher isMethodCall(String method, Object arguments) {
    return new IsMethodCall(method, arguments);
  }

  static Matcher isUnpairedReference(
      final Integer classId, final Object creationArguments, final String managerPoolId) {
    return new IsUnpairedReference(classId, creationArguments, managerPoolId);
  }

  static Matcher isRemoteReference(String referenceId) {
    return new IsRemoteReference(referenceId);
  }

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

  private static class IsUnpairedReference extends TypeSafeMatcher<NewUnpairedInstance> {
    private final Integer classId;
    private final Object creationArguments;
    private final String managerPoolId;

    private IsUnpairedReference(Integer classId, Object creationArguments, String managerPoolId) {
      this.classId = classId;
      this.creationArguments = creationArguments;
      this.managerPoolId = managerPoolId;
    }

    private void describe(
        final Integer classId,
        final Object creationArguments,
        final String managerPoolId,
        Description description) {
      description
          .appendText(
              String.format(" An %s with classId: ", NewUnpairedInstance.class.getSimpleName()))
          .appendText(classId != null ? classId.toString() : null)
          .appendText(" and creation arguments: ")
          .appendText(creationArguments != null ? creationArguments.toString() : null)
          .appendText(" and managerPoolId: ")
          .appendText(managerPoolId);
    }

    @Override
    public void describeTo(Description description) {
      describe(classId, creationArguments, managerPoolId, description);
    }

    @Override
    protected void describeMismatchSafely(
        NewUnpairedInstance reference, Description mismatchDescription) {
      describe(
          reference.classId,
          reference.creationArguments,
          reference.managerPoolId,
          mismatchDescription);
    }

    @Override
    protected boolean matchesSafely(NewUnpairedInstance reference) {
      if (!classId.equals(reference.classId)) return false;
      if (managerPoolId != null && !managerPoolId.equals(reference.managerPoolId)) return false;
      if (reference.managerPoolId != null && !reference.managerPoolId.equals(managerPoolId)) {
        return false;
      }
      if (creationArguments instanceof Matcher) {
        return ((Matcher) creationArguments).matches(reference.creationArguments);
      }
      return creationArguments == reference.creationArguments;
    }
  }

  private static class IsRemoteReference extends TypeSafeMatcher<PairedInstance> {
    private final Object referenceId;

    private IsRemoteReference(Object referenceId) {
      this.referenceId = referenceId;
    }

    @Override
    protected boolean matchesSafely(PairedInstance item) {
      if (referenceId instanceof Matcher) return ((Matcher) referenceId).matches(item.referenceId);
      return item.referenceId.equals(referenceId);
    }

    @Override
    public void describeTo(Description description) {
      description
          .appendText(
              String.format(" A %s with referenceId: ", PairedInstance.class.getSimpleName()))
          .appendText("" + referenceId);
    }
  }
}
