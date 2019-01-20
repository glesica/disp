// TODO: Guard against an empty s-expression

import 'package:dumblisp/src/ast/lst.dart';
import 'package:dumblisp/src/ast/node.dart';

/// A [Node] that represents an s-expression, which is really just
/// a list of [Nodes] that is interpreted as code to be executed.
class SExp extends Lst {
  SExp(Iterable<Node> children) : super(children);

  static SExp from(List<Node> values) => SExp(values);

  Iterable<Node> get arguments => children.skip(1);

  Node get function => children.first;

  @override
  String toString() => 'SExp ${children}';
}
