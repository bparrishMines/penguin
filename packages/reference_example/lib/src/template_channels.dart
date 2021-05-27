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

class LibraryImplementations extends $LibraryImplementations {
  LibraryImplementations(TypeChannelMessenger messenger) : super(messenger);

  @override
  $ClassTemplateHandler get classTemplateHandler => ClassTemplateHandler();
}

class ClassTemplateHandler extends $ClassTemplateHandler {
  @override
  $ClassTemplate $create(TypeChannelMessenger messenger, int fieldTemplate) {
    return ClassTemplate(fieldTemplate);
  }
}
