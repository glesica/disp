import 'package:dumblisp/src/ast/node.dart';

/// A [Node] that represents an identifier, which can represent a
/// function or variable name.
abstract class Ident extends Node {
  Ident(this.name);

  final String name;

  @override
  String toString() => 'Ident $name';
}
