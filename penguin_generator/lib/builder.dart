import 'package:build/build.dart';
import 'package:penguin_generator/src/builders/ios_builder.dart';

import 'src/builders/android_builder.dart';
import 'src/builders/dart_builders.dart';
import 'src/builders/platform_builder.dart';

Builder readBuilder(BuilderOptions options) =>
    ReadInfoBuilder(<PlatformBuilder>[DartMethodChannelBuilder()]);

Builder writeBuilder(BuilderOptions options) =>
    WriteBuilder(<PlatformBuilder>[AndroidBuilder(), IosBuilder()]);
