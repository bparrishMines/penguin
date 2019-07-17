import 'package:code_builder/code_builder.dart' as cb;
import 'package:pub_semver/pub_semver.dart';
import 'package:pubspec_parse/pubspec_parse.dart';

import 'plugin.dart';
import 'utils.dart';
import 'writer.dart';

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

    final cb.Class dartClass = cb.Class((cb.ClassBuilder builder) {
      builder.name = 'Channel';
      builder.fields.addAll([
        cb.Field((cb.FieldBuilder builder) {
          builder.name = 'channel';
          builder.modifier = cb.FieldModifier.constant;
          builder.static = true;
          builder.type = cb.Reference('MethodChannel');
          builder.assignment = cb.Code('MethodChannel(\'${plugin.channel}\')');
          builder.annotations.add(cb.refer('visibleForTesting'));
        }),
        cb.Field((cb.FieldBuilder builder) {
          builder.name = 'nextHandle';
          builder.static = true;
          builder.type = cb.Reference('int');
          builder.assignment = cb.Code('0');
          builder.annotations.add(cb.refer('visibleForTesting'));
        })
      ]);
    });

    buffer.writeln('${dartClass.accept(_emitter)}');

    return buffer.toString();
  }

  Map<String, String> classesAsStrings() {
    final Map<String, String> classes = <String, String>{};

    for (Class theClass in plugin.classes) {
      final StringBuffer buffer = StringBuffer();
      final ClassStructure structure = ClassStructure.unspecifiedPrivate;

      buffer.writeln('$_libraryPartOfDirective\n');

      final cb.Class codeClass =
          ClassWriter(plugin, structure, theClass.name).write(theClass);

      buffer.writeln('${codeClass.accept(_emitter)}');

      classes[theClass.name] = buffer.toString();
    }

    return classes;
  }

  String pubspecAsString() {
    final String upperCaseName =
        plugin.name[0].toUpperCase() + plugin.name.substring(1);

    final Pubspec pubspec = Pubspec(
      plugin.name,
      description: 'A new flutter plugin project.',
      version: Version.parse('0.0.1'),
      homepage: '',
      environment: <String, VersionConstraint>{
        'sdk': VersionConstraint.compatibleWith(
          Version.parse('2.1.0'),
        ),
        'flutter': VersionConstraint.compatibleWith(
          Version.parse('1.0.0'),
        ),
      },
      dependencies: <String, Dependency>{
        'flutter': SdkDependency('flutter'),
        'json_annotation': HostedDependency(
          version: VersionConstraint.compatibleWith(
            Version.parse('2.4.0'),
          ),
        ),
      },
      devDependencies: <String, Dependency>{
        'flutter_test': SdkDependency('flutter'),
        'json_serializable': HostedDependency(
          version: VersionConstraint.compatibleWith(
            Version.parse('3.0.0'),
          ),
        ),
        'build_runner': HostedDependency(
          version: VersionConstraint.compatibleWith(
            Version.parse('1.0.0'),
          ),
        ),
      },
      flutter: <String, dynamic>{
        'plugin': <String, dynamic>{
          'androidPackage': plugin.channel.replaceAll('/', '.'),
          'pluginClass': '${upperCaseName}Plugin',
        }
      },
    );

    return '''
### Generated file
name: ${pubspec.name}
description: ${pubspec.description}
homepage: ${pubspec.homepage}
version: ${pubspec.version}

environment:${_pubspecMapString(pubspec.environment)}

dependencies:${_pubspecMapString(pubspec.dependencies)}

dev_dependencies:${_pubspecMapString(pubspec.devDependencies)}

flutter: ${_flutterToString(pubspec.flutter)}
###
    ''';
  }

  String _pubspecMapString(Map<String, dynamic> values) {
    final StringBuffer buffer = StringBuffer();

    for (MapEntry<String, dynamic> entry in values.entries) {
      buffer.writeln();
      if (entry.value is VersionConstraint) {
        buffer.write('  ${entry.key}: ${entry.value}');
      } else if (entry.value is SdkDependency) {
        final SdkDependency dep = entry.value;
        buffer.write('  ${entry.key}: \n    sdk: ${dep.sdk}');
      } else if (entry.value is PathDependency) {
        final PathDependency dep = entry.value;
        buffer.write('  ${entry.key}: \n    path: ${dep.path}');
      } else if (entry.value is HostedDependency) {
        final HostedDependency dep = entry.value;
        buffer.write('  ${entry.key}: ${dep.version}');
      } else {
        throw UnimplementedError(
          'Not available for type: ${entry.value.runtimeType}',
        );
      }
    }

    return buffer.toString();
  }

  String _flutterToString(Map<String, dynamic> source) {
    final StringBuffer buffer = StringBuffer();

    buffer.writeln();
    for (MapEntry<String, dynamic> entry in source.entries) {
      buffer.writeln('  ${entry.key}:');

      for (MapEntry<dynamic, dynamic> entry in entry.value.entries) {
        buffer.writeln('    ${entry.key}: ${entry.value}');
      }
    }

    return buffer.toString();
  }
}
