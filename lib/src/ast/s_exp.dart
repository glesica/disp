// TODO: Guard against an empty s-expression

import 'package:disp/src/ast/lst.dart';
import 'package:disp/src/ast/node.dart';

/// A [Node] that represents an s-expression, which is really just
/// a list of [Nodes] that is interpreted as code to be executed.
class SExp extends Node implements Lst {
  SExp(this.list);

  static SExp from(Lst list) => SExp(list);

  final Lst list;

  Iterable<Node> get arguments => children.skip(1);

  Iterable<Node> get children => list.children;

  Node get function => children.first;

  @override
  String toString() => 'SExp $children';
}
