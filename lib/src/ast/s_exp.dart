// TODO: Guard against an empty s-expression

import 'package:disp/src/ast/lst.dart';
import 'package:disp/src/ast/node.dart';

/// A [Node] that represents an s-expression, which is really just
/// a list of [Nodes] that is interpreted as code to be executed.
class SExp extends Node implements Lst {
  SExp(this.list);

  static SExp empty() => SExp(Lst.empty());

  static SExp from(Lst list) => SExp(list);

  static SExp wrap(Iterable<Node> iterable) => SExp(Lst(iterable));

  final Lst list;

  Iterable<Node> get children => list.children;

  @override
  int get hashCode => list.hashCode;

  Node get head => children.first;

  Iterable<Node> get tail => children.skip(1);

  @override
  bool operator ==(other) => other is SExp && list == other.list;

  @override
  String toString() => 'SExp $children';
}
