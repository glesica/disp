import 'package:disp/src/ast/bool.dart';
import 'package:disp/src/ast/node.dart';
import 'package:disp/src/ast/num.dart';
import 'package:disp/src/ast/scalar.dart';

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
