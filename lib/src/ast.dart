abstract class Node {}

class Void extends Node {
  @override
  String toString() => 'Void';
}

class Lst extends Node {
  Lst(this.children);

  static Lst from(List<Node> values) => Lst(values);

  final Iterable<Node> children;

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
  Ident(this.name);

  static Ident from(String value) => Ident(value.trim());

  final String name;

  String toString() => 'Ident $name';
}

class Float extends Node {
  Float(this.value);

  static Float from(String value) => Float(double.parse(value));

  final double value;

  String toString() => 'Float $value';
}

class Int extends Node {
  Int(this.value);

  static Int from(String value) => Int(int.parse(value));

  final int value;

  String toString() => 'Int $value';
}

class Str extends Node {
  Str(this.value);

  static Str from(String value) => Str(value);

  final String value;

  String toString() => 'Str $value';
}
