import 'package:code_builder/code_builder.dart' as cb;
import 'package:pub_semver/pub_semver.dart';
import 'package:pubspec_parse/pubspec_parse.dart';

import 'plugin.dart';
import 'references.dart';
import 'utils.dart';
import 'writers.dart';

enum ConstructorType { none, noDefault, onlyDefault, withDefault }

class ClassDetails {
  ClassDetails(this.constructorType, this.isReferenced, this.file)
      : assert(constructorType != null),
        assert(isReferenced != null),
        assert(file != null);

  /// Enum detailing what constructors the class has
  final ConstructorType constructorType;

  /// Referenced by another class method or
  final bool isReferenced;

  /// File of the class
  final String file;
}

class PluginCreator {
  PluginCreator(this.plugin) : assert(plugin != null) {
    initialize();
  }

  final Plugin plugin;

  void initialize() {
    final Set<String> allClassNames = plugin.classes
        .map<String>(
          (Class theClass) => theClass.name,
        )
        .toSet();

    final Set<String> referencedClasses = <String>{};
    for (Class theClass in plugin.classes) {
      for (Method method in theClass.methods) {
        if ((method.isStatic || theClass.name != method.returns) &&
            allClassNames.contains(method.returns)) {
          referencedClasses.add(method.returns);
        }
      }

      for (Field field in theClass.fields) {
        if ((field.isStatic || theClass.name != field.type) &&
            allClassNames.contains(field.type)) {
          referencedClasses.add(field.type);
        }
      }
    }

    for (Class theClass in plugin.classes) {
      // TODO correctly set constructor type once constructor is reimplemented
      theClass.details = ClassDetails(
        ConstructorType.none,
        referencedClasses.contains(theClass.name),
        '${camelCaseToSnakeCase(theClass.name)}.dart',
      );
    }
  }

  static final cb.DartEmitter _emitter = cb.DartEmitter(cb.Allocator());

  cb.Library get _channelClass => cb.Library((cb.LibraryBuilder builder) =>
      builder.body.add(cb.Class((cb.ClassBuilder builder) {
        builder.name = 'Channel';
        builder.fields.addAll([
          cb.Field((cb.FieldBuilder builder) {
            builder.name = 'channel';
            builder.modifier = cb.FieldModifier.constant;
            builder.static = true;
            builder.type = References.methodChannel;
            builder.assignment = References.methodChannel.call(
              <cb.Expression>[cb.literalString(plugin.channel)],
            ).code;
            builder.annotations.add(References.visibleForTesting);
          }),
          cb.Field((cb.FieldBuilder builder) {
            builder.name = 'nextHandle';
            builder.static = true;
            builder.type = cb.refer('int');
            builder.assignment = cb.Code('0');
            builder.annotations.add(References.visibleForTesting);
          })
        ]);
      })));

  Pubspec get _pubspec => Pubspec(
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
            'pluginClass': '${snakeCaseToCamelCase(plugin.name)}Plugin',
          }
        },
      );

  String _channelAsString() => '${_channelClass.accept(_emitter)}';

  Map<String, String> pluginAsStrings() {
    final Map<String, String> classes = <String, String>{};

    classes['channel.dart'] = _channelAsString();

    final ClassWriter writer = ClassWriter(plugin);
    for (Class theClass in plugin.classes) {
      final cb.Library codeClass = writer.write(theClass);
      classes[theClass.details.file] = '${codeClass.accept(_emitter)}';
    }

    return classes;
  }

  String pubspecAsString() {
    final Pubspec pubspec = _pubspec;

    return '''
name: ${pubspec.name}
description: ${pubspec.description}
homepage: ${pubspec.homepage}
version: ${pubspec.version}

environment:${_pubspecMapString(pubspec.environment)}

dependencies:${_pubspecMapString(pubspec.dependencies)}

dev_dependencies:${_pubspecMapString(pubspec.devDependencies)}

flutter: ${_pubspecFlutterToString(pubspec.flutter)}
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

  String _pubspecFlutterToString(Map<String, dynamic> source) {
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
