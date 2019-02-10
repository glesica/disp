import 'package:disp/src/ast/node.dart';

/// A [Node] that can represent a list of other [Nodes].
class Lst extends Node {
  Lst(this.children);

  static Lst empty() => Lst(const []);

  static Lst from(List<Node> children) => Lst(children);

  final Iterable<Node> children;

  @override
  int get hashCode => children.fold(0, (hash, node) => hash ^ node.hashCode);

  @override
  bool operator ==(final other) {
    if (other is Lst) {
      if (children.length != other.children.length) {
        return false;
      }

      return children.toSet().containsAll(other.children);
    }
    return false;
  }

  @override
  String toString() => 'Lst $children';
}
