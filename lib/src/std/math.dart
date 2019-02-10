import 'package:disp/src/ast/int.dart';
import 'package:disp/src/ast/node.dart';
import 'package:disp/src/ast/num.dart';
import 'package:disp/src/std/utils.dart';

// Difference
Num diff(List<Node> args) {
  final left = args[0] as Num;
  final right = args[1] as Num;
  return toNum(left.value - right.value);
}

// Product
Num prod(List<Node> args) {
  final left = args[0] as Num;
  final right = args[1] as Num;

  return toNum(left.value * right.value);
}

// Quotient
Num quot(List<Node> args) {
  final left = args[0] as Num;
  final right = args[1] as Num;
  if (left is Int && right is Int) {
    // Integer division
    return toNum(left.value ~/ right.value);
  }
  return toNum(left.value / right.value);
}

// Remainder (modulo)
Int rem(List<Node> args) {
  final left = args[0] as Int;
  final right = args[1] as Int;
  return toNum(left.value % right.value);
}

// Sum
Num sum(List<Node> args) {
  final left = args[0] as Num;
  final right = args[1] as Num;
  return toNum(left.value + right.value);
}
