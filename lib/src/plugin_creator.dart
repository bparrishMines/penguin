import 'package:code_builder/code_builder.dart' as cb;

import 'plugin.dart';
import 'utils.dart';

class PluginCreator {
  PluginCreator(this.plugin);

  final Plugin plugin;

  static const List<String> _libraryImports = <String>[
    'package:flutter/services.dart',
    'package:flutter/foundation.dart',
  ];

  String get _libraryPartOfDirective => 'part of ${plugin.name};';

  final cb.DartEmitter _emitter = cb.DartEmitter();

  String libraryAsString() {
    final StringBuffer buffer = new StringBuffer();

    buffer.writeln('library ${plugin.name};\n');

    final cb.Library library = cb.Library((cb.LibraryBuilder builder) {
      for (String libraryImport in _libraryImports) {
        builder.directives.add(
          cb.Directive((cb.DirectiveBuilder builder) {
            builder.type = cb.DirectiveType.import;
            builder.url = libraryImport;
          }),
        );
      }
    });

    buffer.writeln('${library.accept(_emitter)}');
    buffer.writeln();

    for (Class dartClass in plugin.classes) {
      buffer.writeln(
        'part \'src/${camelCaseToSnakeCase(dartClass.name)}.dart\';',
      );
    }

    buffer.writeln('part \'src/channel.dart\';');

    return buffer.toString();
  }

  String channelAsString() {
    final StringBuffer buffer = StringBuffer();

    buffer.writeln('$_libraryPartOfDirective\n');

    final cb.Field field = cb.Field((cb.FieldBuilder builder) {
      builder.name = 'channel';
      builder.modifier = cb.FieldModifier.constant;
      builder.type = cb.Reference('MethodChannel');
      builder.assignment = cb.Code('MethodChannel(\'${plugin.channel}\')');
      builder.annotations.add(cb.refer('visibleForTesting'));
    });

    buffer.writeln('${field.accept(_emitter)}');

    return buffer.toString();
  }

  Map<String, String> classesAsStrings() {
    final Map<String, String> classes = <String, String>{};

    for (Class dartClass in plugin.classes) {
      final StringBuffer buffer = StringBuffer();

      buffer.writeln('$_libraryPartOfDirective\n');

      final cb.Class builderClass = cb.Class((cb.ClassBuilder builder) {
        builder.name = dartClass.name;
        builder.methods.addAll(_createMethods(dartClass.methods));
      });

      buffer.writeln('${builderClass.accept(_emitter)}');

      classes[dartClass.name] = buffer.toString();
    }

    return classes;
  }

  List<cb.Method> _createMethods(List<Method> methods) {
    final List<cb.Method> retMethods = <cb.Method>[];

    for (Method method in methods) {
      final cb.Method codeMethod = cb.Method((cb.MethodBuilder builder) {
        builder.name = method.name;
      });

      retMethods.add(codeMethod);
    }

    return retMethods;
  }
}
