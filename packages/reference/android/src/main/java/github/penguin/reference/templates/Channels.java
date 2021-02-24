package github.penguin.reference.templates;

import androidx.annotation.NonNull;

import github.penguin.reference.reference.TypeChannelMessenger;

public class Channels implements LibraryTemplate.$Channels {
  private final ClassTemplateChannel classTemplateChannel;

  public Channels(TypeChannelMessenger messenger) {
    classTemplateChannel = new ClassTemplateChannel(messenger);
  }

  @Override
  public void registerHandlers() {
    classTemplateChannel.setHandler(new ClassTemplateHandler());
  }

  @Override
  public void unregisterHandlers() {
    classTemplateChannel.removeHandler();
  }

  @Override
  public ClassTemplateChannel getClassTemplateChannel() {
    return classTemplateChannel;
  }

  public static class ClassTemplateChannel extends LibraryTemplate.$ClassTemplateChannel {
    public ClassTemplateChannel(@NonNull TypeChannelMessenger messenger) {
      super(messenger);
    }
  }

  public static class ClassTemplateHandler extends LibraryTemplate.$ClassTemplateHandler {
    @Override
    public ClassTemplate onCreate(TypeChannelMessenger messenger, LibraryTemplate.$ClassTemplateCreationArgs args) {
      return new ClassTemplate(args.fieldTemplate);
    }

    @Override
    public Object $onStaticMethodTemplate(TypeChannelMessenger messenger, String parameterTemplate) {
      return ClassTemplate.staticMethodTemplate(parameterTemplate);
    }
  }
}
