import 'dart:io';

import 'java_library.dart';

class PluginCreator {
  PluginCreator({
    this.pluginName,
    this.javaLibrary,
    this.organization,
  })  : assert(organization != null),
        assert(pluginName != null);

  final String pluginName;
  final JavaLibrary javaLibrary;
  final String organization;

  Map<File, String> getAndroidFiles() => javaLibrary
      .createAndroidLibrary(
        org: organization,
        pluginName: pluginName,
      )
      .asFiles();

  Map<File, String> getDartFiles() => javaLibrary.createDartLibrary().asFiles();
}
