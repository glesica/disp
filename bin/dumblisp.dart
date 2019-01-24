import 'dart:io';

import 'package:args/args.dart';
import 'package:dumblisp/dumblisp.dart';

const scriptOption = 'script';
const traceFlag = 'trace';

void main(List<String> args) {
  final argParser = ArgParser(usageLineLength: 80)
    ..addOption(scriptOption,
        abbr: 's', help: 'Pass script to execute as a string')
    ..addFlag(traceFlag, help: 'Use tracing parser for debugging');
  final argResults = argParser.parse(args);

  final _isScript = argResults[scriptOption] != null;

  if (_isScript) {
    final input = argResults[scriptOption];
    final tree = parseString(input, useTracer: argResults[traceFlag]);

    print(evaluate(standardContext, tree.value));
    return;
  }

  if (argResults.arguments.isNotEmpty) {
    for (final scriptPath in argResults.arguments) {
      final input = File(scriptPath).readAsStringSync();
      final tree = parseString(input);

      print(evaluate(standardContext, tree.value));
      return;
    }
  }

  print('No script or file provided');
  exit(1);
}
