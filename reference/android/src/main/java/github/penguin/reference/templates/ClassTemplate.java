package github.penguin.reference.templates;

import github.penguin.reference.reference.ReferenceChannelManager;

public class ClassTemplate implements LibraryTemplate.$ClassTemplate {
  private static LibraryTemplate.$ClassTemplateChannel channel;

  private final Integer fieldTemplate;
  private final ClassTemplate2 referenceParameterTemplate;

  static void setupChannel(ReferenceChannelManager manager) {
    if (channel != null) return;
    channel = new LibraryTemplate.$ClassTemplateChannel(manager);
    channel.registerHandler(new LibraryTemplate.$ClassTemplateHandler() {
      @Override
      LibraryTemplate.$ClassTemplate onCreate(
          ReferenceChannelManager manager, LibraryTemplate.$ClassTemplateCreationArgs args) {
        return new ClassTemplate(
            args.fieldTemplate, (ClassTemplate2) args.referenceParameterTemplate);
      }

      @Override
      public Object $onStaticMethodTemplate(
          ReferenceChannelManager manager,
          String parameterTemplate,
          LibraryTemplate.$ClassTemplate2 referenceParameterTemplate) {
        return staticMethodTemplate(
            parameterTemplate, (ClassTemplate2) referenceParameterTemplate);
      }
    });
  }

  public static Double staticMethodTemplate(
      String parameterTemplate, ClassTemplate2 referenceParameterTemplate) {
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
  public Object methodTemplate(
      String parameterTemplate, LibraryTemplate.$ClassTemplate2 referenceParameterTemplate)
      throws Exception {
    return parameterTemplate + " World!";
  }
}
