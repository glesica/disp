import 'package:dumblisp/src/ast/node.dart';

/// A [Node] that represents an identifier, which can represent a
/// function or variable name.
class Ident extends Node {
  Ident(this.name);

  static Ident from(String value) => Ident(value);

  final String name;

  @override
  String toString() => 'Ident "$name"';
}
