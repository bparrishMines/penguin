package github.penguin.reference;

import github.penguin.reference.reference.RemoteReference;
import github.penguin.reference.reference.TypeReference;
import github.penguin.reference.reference.UnpairedRemoteReference;
import github.penguin.reference.templates.$ReferencePairManager.ClassTemplate;
import io.flutter.plugin.common.MethodCall;
import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;

@SuppressWarnings("rawtypes")
class ReferenceMatchers {
  static Matcher isMethodCall(String method, Object arguments) {
    return new IsMethodCall(method, arguments);
  }

  static Matcher isUnpairedRemoteReference(
      final TypeReference typeReference, final Object creationArguments) {
    return new IsUnpairedRemoteReference(typeReference, creationArguments);
  }

  static Matcher isClassTemplate(
      int fieldTemplate,
      Object referenceFieldTemplate,
      Object referenceListTemplate,
      Object referenceMapTemplate) {
    return new IsClassTemplate(
        fieldTemplate, referenceFieldTemplate, referenceListTemplate, referenceMapTemplate);
  }

  static Matcher isTypeReference(int typeId) {
    return new IsTypeReference(typeId);
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
          .appendText("A MethodCall with method name: ")
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

  private static class IsUnpairedRemoteReference extends TypeSafeMatcher<UnpairedRemoteReference> {
    private final TypeReference typeReference;
    private final Object creationArguments;

    private IsUnpairedRemoteReference(TypeReference typeReference, Object creationArguments) {
      this.typeReference = typeReference;
      this.creationArguments = creationArguments;
    }

    private void describe(
        final TypeReference typeReference,
        final Object creationArguments,
        Description description) {
      description
          .appendText(" An UnpairedRemoteReference with type reference: ")
          .appendText(typeReference != null ? typeReference.toString() : null)
          .appendText(" and creation arguments: ")
          .appendText(creationArguments != null ? creationArguments.toString() : null);
    }

    @Override
    public void describeTo(Description description) {
      describe(typeReference, creationArguments, description);
    }

    @Override
    protected void describeMismatchSafely(
        UnpairedRemoteReference reference, Description mismatchDescription) {
      describe(reference.typeReference, reference.creationArguments, mismatchDescription);
    }

    @Override
    protected boolean matchesSafely(UnpairedRemoteReference reference) {
      if (!typeReference.equals(reference.typeReference)) return false;
      if (creationArguments instanceof Matcher)
        return ((Matcher) creationArguments).matches(reference.creationArguments);
      return creationArguments == reference.creationArguments;
    }
  }

  private static class IsClassTemplate extends TypeSafeMatcher<ClassTemplate> {
    private final int fieldTemplate;
    private final Object referenceFieldTemplate;
    private final Object referenceListTemplate;
    private final Object referenceMapTemplate;

    private IsClassTemplate(
        int fieldTemplate,
        Object referenceFieldTemplate,
        Object referenceListTemplate,
        Object referenceMapTemplate) {
      this.fieldTemplate = fieldTemplate;
      this.referenceFieldTemplate = referenceFieldTemplate;
      this.referenceListTemplate = referenceListTemplate;
      this.referenceMapTemplate = referenceMapTemplate;
    }

    private void describe(
        Integer fieldTemplate,
        Object referenceFieldTemplate,
        Object referenceListTemplate,
        Object referenceMapTemplate,
        Description description) {
      description
          .appendText(" A ClassTemplate with fieldTemplate:: ")
          .appendText("" + fieldTemplate)
          .appendText(" and referenceFieldTemplate: ")
          .appendText("" + referenceFieldTemplate)
          .appendText(" and referenceListTemplate: ")
          .appendText("" + referenceListTemplate)
          .appendText(" and referenceMapTemplate: ")
          .appendText("" + referenceMapTemplate);
    }

    @Override
    public void describeTo(Description description) {
      describe(
          fieldTemplate,
          referenceFieldTemplate,
          referenceListTemplate,
          referenceMapTemplate,
          description);
    }

    @Override
    protected void describeMismatchSafely(
        ClassTemplate classTemplate, Description mismatchDescription) {
      describe(
          classTemplate.getFieldTemplate(),
          classTemplate.getReferenceListTemplate(),
          classTemplate.getReferenceListTemplate(),
          classTemplate.getReferenceMapTemplate(),
          mismatchDescription);
    }

    @Override
    protected boolean matchesSafely(ClassTemplate item) {
      if (fieldTemplate != item.getFieldTemplate()) return false;
      if (!matches(referenceFieldTemplate, item.getReferenceFieldTemplate())) return false;
      if (!matches(referenceListTemplate, item.getReferenceListTemplate())) return false;
      return matches(referenceMapTemplate, item.getReferenceMapTemplate());
    }

    private boolean matches(Object left, Object right) {
      if (left == right) return true;
      if (right.equals(left)) return true;
      if (left instanceof Matcher) {
        return ((Matcher) left).matches(right);
      }
      return false;
    }
  }

  private static class IsTypeReference extends TypeSafeMatcher<TypeReference> {
    private final Object typeId;

    private IsTypeReference(Object typeId) {
      this.typeId = typeId;
    }

    @Override
    protected boolean matchesSafely(TypeReference item) {
      if (typeId instanceof Matcher) return ((Matcher) typeId).matches(item.typeId);
      return (Integer) item.typeId == typeId;
    }

    // TODO: All describe matchers
    @Override
    public void describeTo(Description description) {}
  }

  private static class IsRemoteReference extends TypeSafeMatcher<RemoteReference> {
    private final Object referenceId;

    private IsRemoteReference(Object referenceId) {
      this.referenceId = referenceId;
    }

    @Override
    protected boolean matchesSafely(RemoteReference item) {
      if (referenceId instanceof Matcher) return ((Matcher) referenceId).matches(item.referenceId);
      return item.referenceId.equals(referenceId);
    }

    @Override
    public void describeTo(Description description) {}
  }
}
