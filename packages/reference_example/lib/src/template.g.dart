// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:reference/reference.dart';
/*iterate imports import*/
import /*replace :from='dart:core' value*/ 'dart:core' /**/;
/**/

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

/*iterate classes class*/
mixin $$$class_name$$ {
  /*iterate methods method*/
  /*replace method_returnType*/ Object? /**/ $__method_name__(
    /*iterate parameters parameter*/ /*replace parameter_type*/ String /**/ $$parameter_name$$,
    /**/
  );
  /**/
}
/**/

/*iterate classes class*/
class $$$class_name$$Channel extends TypeChannel<$$$class_name$$> {
  $$$class_name$$Channel(TypeChannelMessenger messenger)
      : super(messenger, '__class_channel__');

  Future<PairedInstance?> $$create(
    $$$class_name$$ $instance, {
    required bool $owner,
    /*iterate fields field*/
    required /*replace field_type*/ int /**/ $$field_name$$,
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
  Future< /*replace staticMethod_returnType*/ double /**/ >
      $__staticMethod_name__(
    /*iterate parameters parameter*/ /*replace parameter_type*/ String /**/ $$parameter_name$$,
    /**/
  ) async {
    /*if returnsVoid*/ return /**/ await sendInvokeStaticMethod(
      '__staticMethod_name__',
      <Object?>[
        /*iterate parameters parameter*/ $$parameter_name$$, /**/
      ],
    ) as /*replace staticMethod_returnType*/ double /**/;
  }
  /**/

  /*iterate methods method*/
  Future< /*replace method_returnType*/ String /**/ > $__method_name__(
    $$$class_name$$ $instance,
    /*iterate parameters parameter*/ /*replace parameter_type*/ String /**/ $$parameter_name$$,
    /**/
  ) async {
    /*if returnsVoid*/ return /**/ await sendInvokeMethod(
      $instance,
      '__method_name__',
      <Object?>[
        /*iterate parameters parameter*/ $$parameter_name$$, /**/
      ],
    ) as /*replace method_returnType*/ String /**/;
  }
  /**/
}
/**/

/*iterate classes class*/
class $$$class_name$$Handler implements TypeChannelHandler<$$$class_name$$> {
  $$$class_name$$ $$create(
    TypeChannelMessenger messenger,
    /*iterate fields field*/
    /*replace field_type*/ int /**/ $$field_name$$,
    /**/
  ) {
    throw UnimplementedError();
  }

  /*iterate staticMethods staticMethod*/
  /*replace staticMethod_returnType*/ Object? /**/ $__staticMethod_name__(
    TypeChannelMessenger messenger,
    /*iterate parameters parameter*/
    /*replace parameter_type*/ String /**/ $$parameter_name$$,
    /**/
  ) {
    throw UnimplementedError();
  }
  /**/

  /*iterate methods method*/
  /*replace method_returnType*/ Object? /**/ $__method_name__(
    $$$class_name$$ $instance,
    /*iterate parameters parameter*/
    /*replace parameter_type*/ String /**/ $$parameter_name$$,
    /**/
  ) {
    /*if returnsVoid*/ return /**/ $instance.$__method_name__(
      /*iterate parameters parameter*/ $$parameter_name$$, /**/
    );
  }
  /**/

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
      /*iterate staticMethods staticMethod*/
      case '__staticMethod_name__':
        return $__staticMethod_name__(
          messenger,
          /*iterate parameters parameter*/ arguments[
                  /*replace parameter_index*/ 0 /**/]
              as /*replace parameter_type*/ String /**/, /**/
        );
      /**/
    }

    throw ArgumentError.value(
      methodName,
      'methodName',
      'Unable to invoke static method `$methodName`',
    );
  }

  @override
  $$$class_name$$ createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    return $$create(
      messenger,
      /*iterate fields field*/ arguments[/*replace field_index*/ 0 /**/]
          as /*replace field_type*/ int /**/, /**/
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $$$class_name$$ instance,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
      /*iterate methods method*/
      case '__method_name__':
        return $__method_name__(
          instance,
          /*iterate parameters parameter*/ arguments[
                  /*replace parameter_index*/ 0 /**/]
              as /*replace parameter_type*/ String /**/, /**/
        );
      /**/
    }

    throw ArgumentError.value(
      instance,
      'instance',
      'Unable to invoke method `$methodName` on',
    );
  }
}
/**/

class $LibraryImplementations {
  $LibraryImplementations(this.messenger);

  final TypeChannelMessenger messenger;

  /*iterate classes class*/
  $$$class_name$$Channel get channel__class_name__ =>
      $$$class_name$$Channel(messenger);
  $$$class_name$$Handler get handler__class_name__ => $$$class_name$$Handler();
  /**/
}

class $ChannelRegistrar {
  $ChannelRegistrar(this.implementations);

  final $LibraryImplementations implementations;

  void registerHandlers() {
    /*iterate classes class*/
    implementations.channel__class_name__.setHandler(
      implementations.handler__class_name__,
    );
    /**/
  }

  void unregisterHandlers() {
    /*iterate classes class*/
    implementations.channel__class_name__.removeHandler();
    /**/
  }
}
