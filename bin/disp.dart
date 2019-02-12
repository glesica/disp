import 'dart:io';

import 'package:args/args.dart';
import 'package:disp/disp.dart';

const scriptOption = 'script';
const traceFlag = 'trace';

Future<void> main(List<String> args) async {
  final argParser = ArgParser(usageLineLength: 80)
    ..addOption(
      scriptOption,
      abbr: scriptOption[0],
      help: 'Pass script to execute as a string',
    )
    ..addFlag(
      traceFlag,
      help: 'Use tracing parser for debugging',
    );
  final argResults = argParser.parse(args);

  final _isScript = argResults[scriptOption] != null;

  if (_isScript) {
    final input = argResults[scriptOption];
    print(executeString(input, args: argResults.rest));
    return;
  }

  if (argResults.arguments.isNotEmpty) {
    for (final scriptPath in argResults.arguments) {
      final input = File(scriptPath).readAsStringSync();
      print(executeString(input, args: argResults.rest));
    }
    return;
  }

  // REPL
  print('Disp - Dart Lisp');
  print('A simple Lisp written, and embeddable, in Dart.');

  final repl = Repl(
    reader: () async {
      return stdin.readLineSync();
    },
    writer: (output) async {
      stdout.write(output);
    },
  );
  await repl.listen();

  exit(0);
}
