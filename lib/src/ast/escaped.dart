import 'package:disp/src/ast/node.dart';

class Escaped<T extends Node> extends Node {
  Escaped(this.node);

  static Escaped from(Node node) => Escaped(node);

  final T node;

  @override
  int get hashCode => node.hashCode;

  @override
  bool operator ==(other) => other is Escaped && node == other.node;

  @override
  String toString() => 'Escaped $node';

  T unescape() => node;
}
