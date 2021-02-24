import 'package:reference/reference.dart';

import 'template.dart';
import 'template.g.dart';

class Channels with $Channels {
  Channels(TypeChannelMessenger messenger)
      : classTemplateChannel = ClassTemplateChannel(messenger);

  static Channels instance = Channels(MethodChannelMessenger.instance)
    ..registerHandlers();

  @override
  final ClassTemplateChannel classTemplateChannel;

  @override
  void registerHandlers() {
    classTemplateChannel.setHandler(ClassTemplateHandler());
  }

  @override
  void unregisterHandlers() {
    classTemplateChannel.removeHandler();
  }
}

class ClassTemplateChannel extends $ClassTemplateChannel {
  ClassTemplateChannel(TypeChannelMessenger messenger) : super(messenger);
}

class ClassTemplateHandler extends $ClassTemplateHandler {
  ClassTemplateHandler()
      : super(
          onCreate: (
            TypeChannelMessenger messenger,
            $ClassTemplateCreationArgs args,
          ) {
            return ClassTemplate(args.fieldTemplate);
          },
        );
}
