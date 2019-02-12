import 'package:disp/src/ast/binding.dart';
import 'package:disp/src/ast/lst.dart';
import 'package:disp/src/ast/node.dart';
import 'package:disp/src/ast/str.dart';
import 'package:disp/src/context.dart';
import 'package:disp/src/evaluate.dart';
import 'package:disp/src/parser.dart';
import 'package:disp/src/standard_context.dart';

Node executeString(
  String program, {
  Iterable<String> args,
  Context context,
}) {
  final tree = parseString(program);
  final builder = Context.builder()
    ..addContext(context ?? standardContext)
    ..addBinding(
      VariableBinding(
        name: 'args',
        value: Lst(
          (args ?? const []).map(Str.from),
        ),
      ),
    );
  return evaluate(builder.build(), tree.value);
}
