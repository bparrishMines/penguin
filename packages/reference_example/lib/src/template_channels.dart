import 'package:reference/reference.dart';
import 'package:reference_example/reference_example.dart';

import 'template.g.dart';

class ChannelRegistrar extends $ChannelRegistrar {
  ChannelRegistrar(LibraryImplementations implementations)
      : super(implementations);

  static ChannelRegistrar instance =
      ChannelRegistrar(LibraryImplementations(MethodChannelMessenger.instance))
        ..registerHandlers();
}

class LibraryImplementations with $LibraryImplementations {
  LibraryImplementations(TypeChannelMessenger messenger)
      : classTemplateChannel = ClassTemplateChannel(messenger);

  @override
  final ClassTemplateChannel classTemplateChannel;

  @override
  final ClassTemplateHandler classTemplateHandler = ClassTemplateHandler();
}

class ClassTemplateChannel extends $ClassTemplateChannel {
  ClassTemplateChannel(TypeChannelMessenger messenger) : super(messenger);
}

class ClassTemplateHandler extends $ClassTemplateHandler {
  @override
  ClassTemplate onCreate(
    TypeChannelMessenger messenger,
    $ClassTemplateCreationArgs args,
  ) {
    return ClassTemplate(args.fieldTemplate);
  }
}
