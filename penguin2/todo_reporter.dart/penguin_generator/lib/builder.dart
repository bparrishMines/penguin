import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'src/todo_reporter_generator.dart';

Builder classBuilder(BuilderOptions options) =>
    SharedPartBuilder([ClassGenerator()], 'class');
