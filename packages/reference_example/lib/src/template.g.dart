// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:reference/reference.dart';
/*iterate imports import*/
import /*replace :from='dart:core' value*/ 'dart:core' /**/;
/**/

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

/*iterate functions function*/
typedef $$$function_name$$ = dynamic Function(
  /*iterate parameters parameter*/ /*replace parameter_type*/ String /**/ $$parameter_name$$,
  /**/
);
/**/

/*iterate functions function*/
class $$$function_name$$Channel extends TypeChannel<Object> {
  $$$function_name$$Channel(TypeChannelMessenger messenger)
      : super(messenger, '__function_channel__');

  Future<PairedInstance?> $$create(
    $$$function_name$$ $instance, {
    required bool $owner,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[],
      owner: $owner,
    );
  }

  Future<Object?> _invoke(
    $$$function_name$$ $instance,
    /*iterate parameters parameter*/ /*replace parameter_type*/ String /**/ $$parameter_name$$,
    /**/
  ) {
    return sendInvokeMethod(
      $instance,
      '',
      <Object?>[
        /*iterate parameters parameter*/ $$parameter_name$$, /**/
      ],
    );
  }
}
/**/

/*iterate functions function*/
class $$$function_name$$Handler implements TypeChannelHandler<Object> {
  $$$function_name$$Handler(this.implementations);

  final $LibraryImplementations implementations;

  @override
  $$$function_name$$ createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    function(
      /*iterate parameters parameter*/ /*replace parameter_type*/ String /**/ $$parameter_name$$,
      /**/
    ) {
      implementations.channel__function_name__._invoke(
        function,
        /*iterate parameters parameter*/ $$parameter_name$$, /**/
      );
    }

    return function;
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    covariant $$$function_name$$ instance,
    String methodName,
    List<Object?> arguments,
  ) {
    return instance(
      /*iterate parameter parameters*/
      /*replace parameter_argumentCasting*/
      arguments[0] as String,
      /**/
      /**/
    );
  }

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
    String methodName,
    List<Object?> arguments,
  ) {
    throw UnimplementedError();
  }
}
/**/

/*iterate classes class*/
mixin $$$class_name$$ {
  /*iterate methods method*/
  /*if! returnsFuture*/
  dynamic $$method_name$$(
    /*iterate parameters parameter*/ /*replace parameter_type*/ String /**/ $$parameter_name$$,
    /**/
  );
  /**/
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
  /*if returnsFuture*/
  Future<Object?> $__staticMethod_name__(
    /*iterate parameters parameter*/ /*replace parameter_type*/ String /**/ $$parameter_name$$,
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
  /**/

  /*iterate methods method*/
  /*if returnsFuture*/
  Future<Object?> $__method_name__(
    $$$class_name$$ $instance,
    /*iterate parameters parameter*/ /*replace parameter_type*/ String /**/ $$parameter_name$$,
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
  /*if! returnsFuture*/
  dynamic $__staticMethod_name__(
    TypeChannelMessenger messenger,
    /*iterate parameters parameter*/
    /*replace parameter_type*/ String /**/ $$parameter_name$$,
    /**/
  ) {
    throw UnimplementedError();
  }
  /**/
  /**/

  /*iterate methods method*/
  /*if! returnsFuture*/
  dynamic $__method_name__(
    $$$class_name$$ $instance,
    /*iterate parameters parameter*/
    /*replace parameter_type*/ String /**/ $$parameter_name$$,
    /**/
  ) {
    return $instance.$$method_name$$(
      /*iterate parameters parameter*/ $$parameter_name$$, /**/
    );
  }
  /**/
  /**/

  @override
  Object? invokeStaticMethod(
    TypeChannelMessenger messenger,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
      /*iterate staticMethods staticMethod*/
      /*if! returnsFuture*/
      case '__staticMethod_name__':
        return $__staticMethod_name__(
          messenger,
          /*iterate parameter parameters*/
          /*replace parameter_argumentCasting*/
          arguments[0] as String,
          /**/
          /**/
        );
      /**/
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
      /*iterate fields field*/
      /*replace field_argumentCasting*/
      arguments[0] as int,
      /**/
      /**/
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
      /*if! returnsFuture*/
      case '__method_name__':
        return $__method_name__(
          instance,
          /*iterate parameter parameters*/
          /*replace parameter_argumentCasting*/
          arguments[0] as String,
          /**/
          /**/
        );
      /**/
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

  /*iterate functions function*/
  $$$function_name$$Channel get channel__function_name__ =>
      $$$function_name$$Channel(messenger);
  $$$function_name$$Handler get handler__function_name__ =>
      $$$function_name$$Handler(this);
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
    /*iterate functions function*/
    implementations.channel__function_name__.setHandler(
      implementations.handler__function_name__,
    );
    /**/
  }

  void unregisterHandlers() {
    /*iterate classes class*/
    implementations.channel__class_name__.removeHandler();
    /**/
    /*iterate functions function*/
    implementations.channel__function_name__.removeHandler();
    /**/
  }
}
