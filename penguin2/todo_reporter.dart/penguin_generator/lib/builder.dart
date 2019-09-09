import 'package:build/build.dart';

import 'src/builders/android_builder.dart';
import 'src/builders/dart_builder.dart';

Builder dartBuilder(BuilderOptions options) => DartBuilder();

Builder androidBuilder(BuilderOptions options) => AndroidBuilder();
PostProcessBuilder androidMoveBuilder(BuilderOptions options) => AndroidMoveBuilder();

