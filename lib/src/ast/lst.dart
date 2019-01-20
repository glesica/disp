import 'package:dumblisp/src/ast/node.dart';

/// A [Node] that can represent a list of other [Nodes] but cannot
/// itself be instantiated.
abstract class Lst extends Node {
  Lst(this.children);

  final Iterable<Node> children;

  @override
  String toString() => 'Lst $children';
}
