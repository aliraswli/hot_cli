import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:mason/mason.dart';
import 'package:args/command_runner.dart';

class MakeFeatureCommand extends Command<int> {
  @override
  final name = 'make';

  @override
  final description = 'Generate a feature with usecases';

  MakeFeatureCommand() {
    addSubcommand(_FeatureCommand());
  }

  @override
  Future<int> run() async {
    print('Use "make feature" to generate a feature');
    return 0;
  }
}

class _FeatureCommand extends Command<int> {
  @override
  final name = 'feature';

  @override
  final description = 'Generate a feature with usecases';

  _FeatureCommand();

  @override
  Future<int> run() async {
    final args = argResults?.rest;
    if (args == null) return -1;
    final featureName = args.isNotEmpty ? args.first : 'Example';
    final isResource = args.contains('--resource');

    final generator = await MasonGenerator.fromBrick(
      Brick.path(p.join(Directory.current.path, 'lib', 'bricks', 'feature')),
    );

    final target = DirectoryGeneratorTarget(Directory.current);
    await generator.generate(
      target,
      vars: {'name': featureName, 'isResource': isResource},
    );

    return 0;
  }
}
