// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:reference/reference.dart';
/*iterate imports import*/
import /*replace :from='template.dart' value*/ 'template.dart' /**/;
/**/

// **************************************************************************
// ReferenceGenerator
// **************************************************************************

/*iterate functions function*/
class $$$function_name$$Channel extends TypeChannel<Object> {
  $$$function_name$$Channel(TypeChannelMessenger messenger)
      : super(messenger, r'__function_channel__');

  Future<PairedInstance?> $create(
    $$function_name$$ $instance, {
    required bool $owner,
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[],
      owner: $owner,
    );
  }

  Future<void> _invoke(
    $$function_name$$ $instance,
    /*iterate parameters parameter*/ /*replace parameter_type*/ String
        /**/ $$parameter_name$$,
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
  $$function_name$$ createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    void function(
      /*iterate parameters parameter*/ /*replace parameter_type*/ String
          /**/ $$parameter_name$$,
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
    covariant $$function_name$$ instance,
    String methodName,
    List<Object?> arguments,
  ) {
    final Function function = () => instance(
          /*iterate parameters parameter*/
          /*replace parameter_argumentCasting*/
          arguments[0] as String
          /**/,
          /**/
        );
    return function();
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
class $$$class_name$$Channel extends TypeChannel<$$class_name$$> {
  $$$class_name$$Channel(TypeChannelMessenger messenger)
      : super(messenger, r'__class_channel__');

  /*iterate constructors constructor*/
  Future<PairedInstance?> $create$__constructor_name__(
    $$class_name$$ $instance, {
    required bool $owner,
    /*iterate parameters parameter*/
    required /*replace parameter_type*/ int /**/ $$parameter_name$$,
    /**/
  }) {
    return createNewInstancePair(
      $instance,
      <Object?>[
        r'__constructor_name__',
        /*iterate parameters parameter*/ $$parameter_name$$, /**/
      ],
      owner: $owner,
    );
  }
  /**/

  /*iterate staticMethods staticMethod*/
  /*if returnsFuture*/
  Future< /*replace staticMethod_returnType*/ double /**/ >
      $__staticMethod_name__(
    /*iterate parameters parameter*/ /*replace parameter_type*/ String
        /**/ $$parameter_name$$,
    /**/
  ) async {
    /*if! returnsVoid*/
    return /**/ /*function casting*/
        await sendInvokeStaticMethod(
      r'__staticMethod_name__',
      <Object?>[
        /*iterate parameters parameter*/ $$parameter_name$$, /**/
      ],
    ) /**/ /*erase*/ as double /**/;
  }
  /**/
  /**/

  /*iterate methods method*/
  /*if returnsFuture*/
  Future< /*replace method_returnType*/ String /**/ > $__method_name__(
    $$class_name$$ $instance,
    /*iterate parameters parameter*/ /*replace parameter_type*/ String
        /**/ $$parameter_name$$,
    /**/
  ) async {
    /*if! returnsVoid*/
    return /**/ /*function casting*/ await sendInvokeMethod(
      $instance,
      r'__method_name__',
      <Object?>[
        /*iterate parameters parameter*/ $$parameter_name$$, /**/
      ],
    ) /**/ /*erase*/ as String /**/;
  }
  /**/
  /**/
}
/**/

/*iterate classes class*/
class $$$class_name$$Handler implements TypeChannelHandler<$$class_name$$> {
  /*iterate constructors constructor*/
  $$class_name$$ $create$__constructor_name__(
    TypeChannelMessenger messenger,
    /*iterate parameters parameter*/
    /*replace parameter_type*/ int /**/ $$parameter_name$$,
    /**/
  ) {
    return $$class_name$$ /*if isNamed*/ . /**/ $$constructor_name$$(
      /*iterate parameters parameter*/
      /*if isNamed*/ $$parameter_name$$: /**/ $$parameter_name$$,
      /**/
      create: false,
    );
  }
  /**/

  /*iterate staticMethods staticMethod*/
  /*if! returnsFuture*/
  /*replace staticMethod_returnType*/ double /**/ $__staticMethod_name__(
    TypeChannelMessenger messenger,
    /*iterate parameters parameter*/
    /*replace parameter_type*/ String /**/ $$parameter_name$$,
    /**/
  ) {
    /*if! returnsVoid*/
    return /**/
        $$class_name$$.$$staticMethod_name$$(
      /*iterate parameters parameter*/
      /*if isNamed*/ $$parameter_name$$: /**/ $$parameter_name$$,
      /**/
    ) /*erase*/ as double /**/;
  }
  /**/
  /**/

  /*iterate methods method*/
  /*if! returnsFuture*/
  /*replace method_returnType*/ String /**/ $__method_name__(
    $$class_name$$ $instance,
    /*iterate parameters parameter*/
    /*replace parameter_type*/ String /**/ $$parameter_name$$,
    /**/
  ) {
    /*if! returnsVoid*/
    return
        /**/
        $instance.$$method_name$$(
      /*iterate parameters parameter*/
      /*if isNamed*/ $$parameter_name$$: /**/ $$parameter_name$$,
      /**/
    ) /*erase*/ as String /**/;
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
      case r'__staticMethod_name__':
        /*if! returnsVoid*/
        return /**/ $__staticMethod_name__(
          messenger,
          /*iterate parameters parameter*/
          /*replace parameter_argumentCasting*/
          arguments[0] as String
          /**/,
          /**/
        );
        /*if returnsVoid*/ return null;
      /**/
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
  $$class_name$$ createInstance(
    TypeChannelMessenger messenger,
    List<Object?> arguments,
  ) {
    final String constructorName = arguments[0] as String;
    switch (constructorName) {
      /*iterate constructors constructor*/
      case r'__constructor_name__':
        return $create$__constructor_name__(
          messenger,
          /*iterate parameters parameter*/
          /*replace parameter_argumentCasting*/
          arguments[1] as int
          /**/,
          /**/
        );
      /**/
    }

    throw ArgumentError.value(
      constructorName,
      'constructorName',
      'Unable to invoke constructor of',
    );
  }

  @override
  Object? invokeMethod(
    TypeChannelMessenger messenger,
    $$class_name$$ instance,
    String methodName,
    List<Object?> arguments,
  ) {
    switch (methodName) {
      /*iterate methods method*/
      /*if! returnsFuture*/
      case r'__method_name__':
        /*if! returnsVoid*/
        return /**/
            $__method_name__(
          instance,
          /*iterate parameters parameter*/
          /*replace parameter_argumentCasting*/
          arguments[0] as String
          /**/,
          /**/
        );
        /*if returnsVoid*/ return null;
      /**/
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
  late $$$class_name$$Channel channel__class_name__ =
      $$$class_name$$Channel(messenger);
  $$$class_name$$Handler handler__class_name__ = $$$class_name$$Handler();
  /**/

  /*iterate functions function*/
  late $$$function_name$$Channel channel__function_name__ =
      $$$function_name$$Channel(messenger);
  late $$$function_name$$Handler handler__function_name__ =
      $$$function_name$$Handler(this);
  /**/
}

class $ChannelRegistrar {
  $ChannelRegistrar(this.implementations);

  static final $ChannelRegistrar instance = $ChannelRegistrar(
      $LibraryImplementations(MethodChannelMessenger.instance))
    ..registerHandlers();

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
