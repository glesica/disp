import 'package:dumblisp/src/ast/node.dart';

/// A [Node] that represents no value at all, used as the return type
/// for functions that exist to provide side effects.
class Void extends Node {
  @override
  String toString() => 'Void';
}