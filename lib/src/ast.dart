class Node {}

class Lst extends Node {
  final Iterable<Node> children;

  Lst(this.children);

  static Lst from(List<Node> values) => Lst(values);

  static bool isOf(Node node) => node is Lst;

  String toString() => 'Lst $children';
}

// TODO: Guard against an empty s-expression
class SExp extends Lst {
  SExp(Iterable<Node> children) : super(children);

  static SExp from(List<Node> values) => SExp(values);

  Iterable<Node> get arguments => children.skip(1);

  Node get function => children.first;

  String toString() => 'SExp ${children}';
}

class Ident extends Node {
  final String name;

  Ident(this.name);

  static Ident from(String value) => Ident(value.trim());

  String toString() => 'Ident $name';
}

class Float extends Node {
  final double value;

  Float(this.value);

  static Float from(String value) => Float(double.parse(value));

  String toString() => 'Float $value';
}

class Int extends Node {
  final int value;

  Int(this.value);

  static Int from(String value) => Int(int.parse(value));

  String toString() => 'Int $value';
}

class Str extends Node {
  final String value;

  Str(this.value);

  static Str from(String value) => Str(value);

  String toString() => 'Str $value';
}
