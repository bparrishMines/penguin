import 'package:code_builder/code_builder.dart' as cb;
import 'package:pub_semver/pub_semver.dart';
import 'package:pubspec_parse/pubspec_parse.dart';

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

    for (Class dartClass in plugin.classes) {
      final StringBuffer buffer = StringBuffer();

      buffer.writeln('$_libraryPartOfDirective\n');

      final cb.Class builderClass = cb.Class((cb.ClassBuilder builder) {
        builder.name = dartClass.name;
        builder.methods.addAll(
          _createMethods(dartClass.name, dartClass.methods),
        );

        final _ConstructorType type = _getConstructorType(plugin, dartClass);
        builder.constructors.addAll(
          _createConstructors(type, dartClass.name, dartClass.constructors),
        );
        builder.methods.addAll(_createFields(dartClass.name, dartClass.fields));

        builder.fields.add(_handle);
      });

      buffer.writeln('${builderClass.accept(_emitter)}');

      classes[dartClass.name] = buffer.toString();
    }

    return classes;
  }

  List<cb.Method> _createMethods(String className, List<Method> methods) {
    final List<cb.Method> retMethods = <cb.Method>[];

    for (Method method in methods) {
      final List<Parameter> allParameters =
          method.requiredParameters + method.optionalParameters;

      final StringBuffer allParameterBuffer = StringBuffer();
      for (Parameter parameter in allParameters) {
        allParameterBuffer.write('\'${parameter.name}\': ${parameter.name},');
      }

      final cb.Method codeMethod = cb.Method((cb.MethodBuilder builder) {
        builder.name = method.name;
        builder.returns = cb.refer('Future<${method.returns ?? 'void'}>');
        builder.requiredParameters.addAll(
          _createParameters(method.requiredParameters),
        );
        builder.body = cb.Code('''
          return Channel.channel.invokeMethod<${method.returns ?? 'void'}>(
            '$className#${method.name}',
            <String, dynamic>{'handle': _handle, ${allParameterBuffer.toString()}}
          );
        ''');
      });

      retMethods.add(codeMethod);
    }

    return retMethods;
  }

  List<cb.Constructor> _createConstructors(
    _ConstructorType type,
    String className,
    List<Constructor> constructors,
  ) {
    final List<cb.Constructor> retConstructors = <cb.Constructor>[];

    if (type == _ConstructorType.onlyDefault ||
        type == _ConstructorType.onlyDefaultPrivate) {
      retConstructors.add(
        cb.Constructor((cb.ConstructorBuilder builder) {
          if (type == _ConstructorType.onlyDefaultPrivate) {
            builder.name = '_';
          }
          builder.body = cb.Code('''
            Channel.channel.invokeMethod<void>(
              '$className()',
              <String, dynamic>{'handle': _handle},
            );
          ''');
        }),
      );

      return retConstructors;
    }

    for (Constructor constructor in constructors) {
      final cb.Constructor codeConstruct = cb.Constructor(
        (cb.ConstructorBuilder builder) {
          /*
          builder.name = constructor.name;
          builder.returns = cb.refer('Future<${method.returns ?? 'void'}>');
          builder.body = cb.Code('''
          return Channel.channel.invokeMethod<${method.returns ?? 'void'}>(
            '$className#${method.name}',
            <String, dynamic>{'handle': _handle},
          );
        ''');
        */
        },
      );

      retConstructors.add(codeConstruct);
    }

    return retConstructors;
  }

  List<cb.Parameter> _createParameters(List<Parameter> parameters) {
    final List<cb.Parameter> retParameters = <cb.Parameter>[];
    if (parameters == null) return retParameters;

    for (Parameter parameter in parameters) {
      final cb.Parameter codeParam =
          cb.Parameter((cb.ParameterBuilder builder) {
        builder.name = parameter.name;
        builder.type = cb.refer(parameter.type);
      });

      retParameters.add(codeParam);
    }

    return retParameters;
  }

  List<cb.Method> _createFields(String className, List<Field> fields) {
    final List<cb.Method> retMethods = <cb.Method>[];

    for (Field field in fields) {
      final cb.Method codeMethod = cb.Method((cb.MethodBuilder builder) {
        builder.name = field.name;
        builder.type = cb.MethodType.getter;
        builder.returns = cb.refer('Future<${field.type}>');
        builder.type = cb.MethodType.getter;
        builder.static = field.static;
        builder.body = cb.Code('''
            return Channel.channel.invokeMethod<void>(
              '$className#${field.name}',
              ${field.static ? '' : "<String, dynamic>{'handle': _handle},"}
            );
          ''');
      });

      retMethods.add(codeMethod);
    }

    return retMethods;
  }

  static final cb.Field _handle = cb.Field((cb.FieldBuilder builder) {
    builder.name = '_handle';
    builder.modifier = cb.FieldModifier.final$;
    builder.type = cb.Reference('int');
    builder.assignment = cb.Code('Channel.nextHandle++');
  });

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

  _ConstructorType _getConstructorType(Plugin plugin, Class theClass) {
    if (theClass.constructors.isEmpty) {
      for (Class dClass in plugin.classes) {
        for (Method method in dClass.methods) {
          if (method.returns == theClass.name) {
            return _ConstructorType.onlyDefaultPrivate;
          }
        }
      }

      return _ConstructorType.onlyDefault;
    }
  }
}

enum _ConstructorType {
  /// When the only constructor is the default constructor.
  ///
  /// This occurs when there is no specified constructor and no methods that
  /// reference this class.
  onlyDefault,

  /// When the only constructor is a default private constructor.
  ///
  /// This occurs when there is no specified constructor, but there are methods
  /// from other classes that return this class.
  onlyDefaultPrivate,

  /// When only private constructors are specified.
  specifiedOnlyPrivate,

  /// When one or more public constructors are specified.
  specifiedPublic,
}
