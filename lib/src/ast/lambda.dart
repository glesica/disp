import 'package:disp/src/ast/ident.dart';
import 'package:disp/src/ast/node.dart';

class Lambda extends Node {
  Lambda(this.parameters, this.expression) : arity = parameters.length;

  final int arity;

  final Node expression;

  final List<Ident> parameters;

  @override
  int get hashCode => arity ^ expression.hashCode;

  @override
  bool operator ==(other) =>
      other is Lambda && arity == other.arity && expression == other.expression;

  @override
  String toString() => 'Lambda $arity "$expression"';
}
