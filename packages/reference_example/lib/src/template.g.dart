// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:reference/reference.dart';

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

/*iterate classes class*/
mixin $__class_name__ {}
/**/

/*iterate classes class*/
class $__class_name__Channel extends TypeChannel<$__class_name__> {
  $__class_name__Channel(TypeChannelMessenger messenger)
      : super(messenger, '__class_channel__');

  Future<PairedInstance?> $$create(
    $__class_name__ $instance, {
    required bool $owner,
    /*iterate fields field*/
    required /*replace field.type*/ int /**/ $$field_name$$,
    /**/
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        /*iterate fields field*/ $$field_name$$, /**/
      ],
      owner: $owner,
    );
  }

  /*iterate staticMethods staticMethod*/
  Future<Object?> $__staticMethod_name__(
    /*iterate parameters parameter*/ /*replace parameter.type*/ String /**/ $$parameter_name$$,
    /**/
  ) {
    return sendInvokeStaticMethod(
      '__staticMethod_name__',
      <Object?>[
        /*iterate parameters parameter*/ $$parameter_name$$, /**/
      ],
    );
  }
  /**/

  /*iterate methods method*/
  Future<Object?> $__method_name__(
    $__class_name__ $instance,
    /*iterate parameters parameter*/ /*replace parameter.type*/ String /**/ $$parameter_name$$,
    /**/
  ) {
    return sendInvokeMethod(
      $instance,
      '__method_name__',
      <Object?>[
        /*iterate parameters parameter*/ $$parameter_name$$, /**/
      ],
    );
  }
  /**/
}
/**/

class $ClassTemplateHandler implements TypeChannelHandler<$ClassTemplate> {
  $ClassTemplate $create(TypeChannelMessenger messenger, int fieldTemplate) {
    throw UnimplementedError();
  }

  Object? $onStaticMethodTemplate(
      TypeChannelMessenger messenger, String parameterTemplate) {
    throw UnimplementedError();
  }

  Object? $onMethodTemplate(
      $ClassTemplate $instance, String parameterTemplate) {
    throw UnimplementedError();
  }

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
      case 'staticMethodTemplate':
        return $onStaticMethodTemplate(messenger, arguments[0] as String);
    }

    throw ArgumentError.value(
      methodName,
      'methodName',
      'Unable to invoke static method `$methodName`',
    );
  }

  @override
  $ClassTemplate createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return $create(messenger, arguments[0] as int);
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $ClassTemplate instance,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
      case 'methodTemplate':
        return $onMethodTemplate(instance, arguments[0] as String);
    }

    throw ArgumentError.value(
      instance,
      'instance',
      'Unable to invoke method `$methodName` on',
    );
  }
}

class $LibraryImplementations {
  $LibraryImplementations(this.messenger);

  final TypeChannelMessenger messenger;

  $ClassTemplateChannel get classTemplateChannel =>
      $ClassTemplateChannel(messenger);
  $ClassTemplateHandler get classTemplateHandler => $ClassTemplateHandler();
}

class $ChannelRegistrar {
  $ChannelRegistrar(this.implementations);

  final $LibraryImplementations implementations;

  void registerHandlers() {
    implementations.classTemplateChannel.setHandler(
      implementations.classTemplateHandler,
    );
  }

  void unregisterHandlers() {
    implementations.classTemplateChannel.removeHandler();
  }
}
