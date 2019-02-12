import 'package:disp/src/context.dart';
import 'package:disp/src/execute.dart';
import 'package:disp/src/standard_context.dart';
import 'package:meta/meta.dart';

/// A function that returns a [Future] that should complete to a
/// [String] that contains an expression provided by the user for
/// evaluation.
///
/// This function should complete to `null` once input has
/// finished.
typedef Future<String> Reader();

/// A function that returns a [Future] that should complete once the
/// given output has been presented to the user.
typedef Future<void> Writer(String output);

class Repl {
  Repl({
    Iterable<String> args,
    Context context,
    String prompt,
    @required Reader reader,
    @required Writer writer,
  })  : assert(reader != null),
        assert(writer != null),
        _args = args ?? const [],
        _prompt = prompt ?? '\nλ ',
        _reader = reader,
        _writer = writer {
    _currentContext = context ?? standardContext;
  }

  Iterable<String> _args;

  Context _currentContext;

  final String _prompt;

  final Reader _reader;

  final Writer _writer;

  Future<void> accept(String input) async {
    await _processInput(input);
  }

  Future<void> listen() async {
    while (true) {
      await _writer(_prompt);
      final input = await _reader();

      if (input == null) {
        break;
      }

      try {
        await _processInput(input);
      } catch (e) {
        await _writer(e.toString());
      }
    }
  }

  Future<void> _processInput(String input) async {
    final result = executeString(
      input,
      args: _args,
      context: _currentContext,
    );
    await _writer('$result');
  }
}
