import 'package:dumblisp/src/ast/node.dart';

/// A [Node] that can represent a list of other [Nodes] but cannot
/// itself be instantiated.
class Lst extends Node {
  Lst(this.children);

  static Lst from(List<Node> children) => Lst(children);

  final Iterable<Node> children;

  @override
  String toString() => 'Lst $children';
}
