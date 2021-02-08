package github.penguin.reference.templates;

import github.penguin.reference.reference.TypeChannelMessenger;

public class ClassTemplate implements LibraryTemplate.$ClassTemplate {
  private final Integer fieldTemplate;

  public ClassTemplate(Integer fieldTemplate) {
    this.fieldTemplate = fieldTemplate;
  }

  static void setupChannel(TypeChannelMessenger messenger) {
    final LibraryTemplate.$ClassTemplateChannel channel = new LibraryTemplate.$ClassTemplateChannel(messenger);
    channel.setHandler(
        new LibraryTemplate.$ClassTemplateHandler() {
          @Override
          LibraryTemplate.$ClassTemplate onCreate(TypeChannelMessenger messenger, LibraryTemplate.$ClassTemplateCreationArgs args) {
            return new ClassTemplate(args.fieldTemplate);
          }

          @Override
          public Object $onStaticMethodTemplate(TypeChannelMessenger messenger, String parameterTemplate) {
            return staticMethodTemplate(parameterTemplate);
          }
        });
  }

  public static Double staticMethodTemplate(String parameterTemplate) {
    return parameterTemplate.length() / 1.0;
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
