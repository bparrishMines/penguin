package github.penguin.reference.templates;

import github.penguin.reference.reference.ReferenceChannelManager;

public class ClassTemplate implements LibraryTemplate.$ClassTemplate {
  private static LibraryTemplate.$ClassTemplateChannel channel;

  private final Integer fieldTemplate;
  private final ClassTemplate2 referenceParameterTemplate;

  static void setupChannel(ReferenceChannelManager manager) {
    channel = new LibraryTemplate.$ClassTemplateChannel(manager, new LibraryTemplate.$ClassTemplateHandler() {
      @Override
      LibraryTemplate.$ClassTemplate onCreateClassTemplate(ReferenceChannelManager manager, LibraryTemplate.$ClassTemplateCreationArgs args) throws Exception {
        return new ClassTemplate(args.fieldTemplate, (ClassTemplate2) args.referenceParameterTemplate);
      }

      @Override
      public Object $onStaticMethodTemplate(ReferenceChannelManager manager, String parameterTemplate, LibraryTemplate.$ClassTemplate2 referenceParameterTemplate) throws Exception {
        return staticMethodTemplate(parameterTemplate, (ClassTemplate2) referenceParameterTemplate);
      }
    });
  }

  public static Double staticMethodTemplate(String parameterTemplate, ClassTemplate2 referenceParameterTemplate) {
    return parameterTemplate.length() / 1.0;
  }

  public ClassTemplate(Integer fieldTemplate, ClassTemplate2 referenceParameterTemplate) {
    this.fieldTemplate = fieldTemplate;
    this.referenceParameterTemplate = referenceParameterTemplate;
  }

  @Override
  public Integer getFieldTemplate() {
    return fieldTemplate;
  }

  @Override
  public LibraryTemplate.$ClassTemplate2 getReferenceParameterTemplate() {
    return referenceParameterTemplate;
  }

  @Override
  public Object methodTemplate(String parameterTemplate, LibraryTemplate.$ClassTemplate2 referenceParameterTemplate) throws Exception {
    return parameterTemplate + " World!";
  }
}
