import 'package:dumblisp/src/ast/float.dart';
import 'package:dumblisp/src/ast/int.dart';
import 'package:dumblisp/src/ast/node.dart';
import 'package:dumblisp/src/ast/num.dart';
import 'package:dumblisp/src/ast/str.dart';
import 'package:dumblisp/src/ast/void.dart';
import 'package:dumblisp/src/ast/binding.dart';
import 'package:dumblisp/src/context.dart';

final _standardBuilder = Context.builder()
  ..addAllBindings([
    NativeFunction(name: 'echo', callback: echo),
    NativeFunction(name: 'id', callback: id),
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

Node id(List<Node> args) {
  final arg = args[0];
  return arg;
}

Num sum(List<Node> expressions) {
  final left = expressions[0] as Num;
  final right = expressions[1] as Num;
  return _chooseNum(left.value + right.value);
}

Num diff(List<Node> expressions) {
  final left = expressions[0] as Int;
  final right = expressions[1] as Int;
  return _chooseNum(left.value - right.value);
}

Num prod(List<Node> expressions) {
  final left = expressions[0] as Int;
  final right = expressions[1] as Int;

  return _chooseNum(left.value * right.value);
}

Float quot(List<Node> expressions) {
  final left = expressions[0] as Int;
  final right = expressions[1] as Int;
  return Float(left.value / right.value);
}

Num _chooseNum(num value) {
  if (value is int) {
    return Int(value);
  }

  if (value is double) {
    return Float(value);
  }

  throw Exception('No mapping for numeric type: "${value.runtimeType}"');
}
