import 'package:reference/reference.dart';

import 'template.dart';
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
  $$$class_name$$Handler get handler__class_name__ => $$$class_name$$Handler();
}

class ClassTemplateHandler extends $$$class_name$$Handler {
  @override
  $$$class_name$$ $create$__constructor_name__(
    TypeChannelMessenger messenger,
    int $$field_name$$,
  ) {
    return $$class_name$$.$$constructor_name$$($$field_name$$);
  }
}
