import 'package:disp/src/ast/node.dart';

/// A [Node] that represents no value at all, used as the return type
/// for functions that exist to provide side effects.
class Void extends Node {
  @override
  int get hashCode => 0;

  @override
  bool operator ==(other) => other is Void;

  @override
  String toString() => 'Void';
}
