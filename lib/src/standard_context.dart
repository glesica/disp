import 'package:dumblisp/src/ast/int.dart';
import 'package:dumblisp/src/ast/node.dart';
import 'package:dumblisp/src/ast/num.dart';
import 'package:dumblisp/src/ast/str.dart';
import 'package:dumblisp/src/ast/void.dart';
import 'package:dumblisp/src/binding.dart';
import 'package:dumblisp/src/context.dart';

final _standardBuilder = Context.builder()
  ..addAllBindings([
    NativeFunction(name: 'echo', callback: echo),
    NativeFunction(name: 'sum', callback: sum),
    NativeFunction(name: 'diff', callback: diff),
    NativeFunction(name: 'prod', callback: prod),
    NativeFunction(name: 'quot', callback: quot),
  ]);

final standardContext = _standardBuilder.build();

Void echo(List<Node> args) {
  var output = '';
  for (final arg in args) {
    if (arg is Num) {
      output += arg.value.toString();
    } else if (arg is Str) {
      output += arg.value;
    } else {
      output += arg.toString();
    }
  }
  print(output);
  return Void();
}

Int sum(List<Node> expressions) {
  final left = expressions[0] as Int;
  final right = expressions[1] as Int;

  return Int(left.value + right.value);
}

Int diff(List<Node> expressions) {
  final left = expressions[0] as Int;
  final right = expressions[1] as Int;

  return Int(left.value - right.value);
}

Int prod(List<Node> expressions) {
  final left = expressions[0] as Int;
  final right = expressions[1] as Int;

  return Int(left.value * right.value);
}

Int quot(List<Node> expressions) {
  final left = expressions[0] as Int;
  final right = expressions[1] as Int;
  final quotient = left.value / right.value;

  return Int(quotient.truncate());
}
