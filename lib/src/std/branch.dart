import 'package:disp/src/ast/bool.dart';
import 'package:disp/src/ast/node.dart';

/// If-else expression
Node ifElse(List<Node> expressions) {
  final condition = expressions[0] as Bool;
  final trueValue = expressions[1];
  final falseValue = expressions[2];
  return condition.value ? trueValue : falseValue;
}
