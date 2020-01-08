import 'dart:async';
import 'dart:convert';

import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:meta/meta.dart';

import 'penguin_builder.dart';
import 'info_builder.dart';
import '../info.dart';

abstract class CodeBuilder extends Builder {
  CodeBuilder(this.penguinBuilders);

  final List<PenguinBuilder> penguinBuilders;

  Iterable<ClassInfo> getClasses({
    @required String key,
    @required String json,
  }) {
    return jsonDecode(json)[key].map<ClassInfo>(
      (dynamic json) => ClassInfo.fromJson(json),
    );
  }

  Iterable<ClassInfo> getLibraryClasses(String json) {
    return getClasses(key: InfoBuilder.libraryClassesKey, json: json);
  }

  Iterable<ClassInfo> getImportedClasses(String json) {
    return getClasses(key: InfoBuilder.importedClassesKey, json: json);
  }

  List<ClassInfo> classesForPlatforms(
    Iterable<ClassInfo> classes,
    Iterable<Type> platformTypes,
  ) {
    return classes
        .where(
          (ClassInfo classInfo) => platformTypes.any(
            (Type type) =>
                classInfo.aClass.platform.runtimeType.toString() ==
                type.toString(),
          ),
        )
        .toList();
  }
}

class DartBuilder extends CodeBuilder {
  DartBuilder(List<PenguinBuilder> penguinBuilders) : super(penguinBuilders);

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final String json = await buildStep.readAsString(buildStep.inputId);
    final Iterable<ClassInfo> libraryClasses = getLibraryClasses(json);
    final Iterable<ClassInfo> importedClasses = getImportedClasses(json);

    if (libraryClasses.isEmpty) return;

    await Future.wait<void>(
      penguinBuilders.map<Future<void>>(
        (PenguinBuilder builder) => builder.build(
          classesForPlatforms(libraryClasses, builder.platformTypes),
          classesForPlatforms(importedClasses, builder.platformTypes),
          PenguinBuilderBuildStep(buildStep),
        ),
      ),
    );
  }

  @override
  Map<String, List<String>> get buildExtensions => <String, List<String>>{
        InfoBuilder.infoExtension: penguinBuilders
            .expand<String>((PenguinBuilder builder) => builder.filenames)
            .toList(),
      };
}

class PlatformBuilder extends CodeBuilder {
  PlatformBuilder(List<PenguinBuilder> penguinBuilders)
      : super(penguinBuilders);

  static final Glob _allInfoFiles = Glob('lib/**${InfoBuilder.infoExtension}');

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final Set<ClassInfo> libraryClasses = <ClassInfo>{};
    Set<ClassInfo> importedClasses = <ClassInfo>{};

    await for (AssetId input in buildStep.findAssets(_allInfoFiles)) {
      final String json = await buildStep.readAsString(input);
      libraryClasses.addAll(getLibraryClasses(json));
      importedClasses.addAll(getImportedClasses(json));
    }

    if (libraryClasses.isEmpty) return;

    importedClasses = importedClasses.difference(libraryClasses);

    await Future.wait<void>(
      penguinBuilders.map<Future<void>>(
        (PenguinBuilder builder) => builder.build(
          classesForPlatforms(libraryClasses, builder.platformTypes),
          classesForPlatforms(importedClasses, builder.platformTypes),
          PenguinBuilderBuildStep(buildStep),
        ),
      ),
    );
  }

  @override
  Map<String, List<String>> get buildExtensions => <String, List<String>>{
        r'$lib$': penguinBuilders
            .expand<String>((PenguinBuilder builder) => builder.filenames)
            .toList(),
      };
}
