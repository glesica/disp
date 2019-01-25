import 'package:disp/src/ast/bool.dart';
import 'package:disp/src/ast/float.dart';
import 'package:disp/src/ast/int.dart';
import 'package:disp/src/ast/node.dart';
import 'package:disp/src/ast/num.dart';
import 'package:disp/src/ast/s_exp.dart';
import 'package:disp/src/ast/scalar.dart';
import 'package:disp/src/ast/str.dart';
import 'package:disp/src/ast/void.dart';
import 'package:disp/src/ast/binding.dart';
import 'package:disp/src/context.dart';

final _standardBuilder = Context.builder()
  ..addAllBindings([
    NativeFunction(name: 'echo', callback: echo),
    NativeFunction(name: 'id', callback: id),
    NativeFunction(name: 'sum', callback: sum),
    NativeFunction(name: 'diff', callback: diff),
    NativeFunction(name: 'prod', callback: prod),
    NativeFunction(name: 'quot', callback: quot),
    NativeFunction(name: 'if', callback: ifElse),
    NativeFunction(name: 'eq', callback: equalTo),
    NativeFunction(name: 'gt', callback: greaterThan),
    NativeFunction(name: 'lt', callback: lessThan),
    NativeFunction(name: 'nth', callback: nth),
    VariableBinding(name: 'false', value: Bool(false)),
    VariableBinding(name: 'true', value: Bool(true)),
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

Node ifElse(List<Node> expressions) {
  final condition = expressions[0] as Bool;
  final trueValue = expressions[1];
  final falseValue = expressions[2];
  return condition.value ? trueValue : falseValue;
}

Bool equalTo(List<Node> expressions) {
  final left = expressions[0] as Scalar;
  final right = expressions[1] as Scalar;
  return Bool(left == right);
}

Bool greaterThan(List<Node> expressions) {
  final left = expressions[0] as Num;
  final right = expressions[1] as Num;
  return Bool(left.value > right.value);
}

Bool lessThan(List<Node> expressions) {
  final left = expressions[0] as Num;
  final right = expressions[1] as Num;
  return Bool(left.value < right.value);
}

Node nth(List<Node> expressions) {
  final index = expressions[0] as Int;
  final array = expressions[1] as SExp;
  return array.children.toList()[index.value];
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
