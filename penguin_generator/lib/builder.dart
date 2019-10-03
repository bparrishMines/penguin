import 'package:build/build.dart';

import 'src/builders/android_builder.dart';
import 'src/builders/dart_builder.dart';
import 'src/builders/platform_builder.dart';

Builder readBuilder(BuilderOptions options) => ReadInfoBuilder();
Builder writeBuilder(BuilderOptions options) => WriteBuilder(
      <PlatformBuilder>[FlutterBuilder(), AndroidBuilder()],
    );
