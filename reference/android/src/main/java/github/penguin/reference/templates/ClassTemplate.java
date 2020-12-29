package github.penguin.reference.templates;

import github.penguin.reference.reference.TypeChannelManager;

public class ClassTemplate implements LibraryTemplate.$ClassTemplate {
  // TODO: not right
  private static LibraryTemplate.$ClassTemplateChannel channel;

  private final Integer fieldTemplate;

  static void setupChannel(TypeChannelManager manager) {
    if (channel != null) return;
    channel = new LibraryTemplate.$ClassTemplateChannel(manager);
    channel.setHandler(
        new LibraryTemplate.$ClassTemplateHandler() {
          @Override
          LibraryTemplate.$ClassTemplate onCreate(
              TypeChannelManager manager, LibraryTemplate.$ClassTemplateCreationArgs args) {
            return new ClassTemplate(args.fieldTemplate);
          }

          @Override
          public Object $onStaticMethodTemplate(
              TypeChannelManager manager, String parameterTemplate) {
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
