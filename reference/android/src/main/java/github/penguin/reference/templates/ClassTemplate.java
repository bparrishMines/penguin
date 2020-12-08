package github.penguin.reference.templates;

import github.penguin.reference.reference.ReferenceChannelManager;

public class ClassTemplate implements LibraryTemplate.$ClassTemplate {
  // TODO: not right
  private static LibraryTemplate.$ClassTemplateChannel channel;

  private final Integer fieldTemplate;

  static void setupChannel(ReferenceChannelManager manager) {
    if (channel != null) return;
    channel = new LibraryTemplate.$ClassTemplateChannel(manager);
    channel.registerHandler(
        new LibraryTemplate.$ClassTemplateHandler() {
          @Override
          LibraryTemplate.$ClassTemplate onCreate(
              ReferenceChannelManager manager, LibraryTemplate.$ClassTemplateCreationArgs args) {
            return new ClassTemplate(args.fieldTemplate);
          }

          @Override
          public Object $onStaticMethodTemplate(
              ReferenceChannelManager manager, String parameterTemplate) {
            return staticMethodTemplate(parameterTemplate);
          }
        });
  }

  public static Double staticMethodTemplate(String parameterTemplate) {
    return parameterTemplate.length() / 1.0;
  }

  public ClassTemplate(Integer fieldTemplate) {
    this.fieldTemplate = fieldTemplate;
  }

  @Override
  public Integer getFieldTemplate() {
    return fieldTemplate;
  }

  @Override
  public Object methodTemplate(String parameterTemplate) {
    return parameterTemplate + " World!";
  }
}
