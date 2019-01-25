import 'package:dumblisp/src/ast/node.dart';

final Bool boolFalse = Bool(false);

final Bool boolTrue = Bool(true);

class Bool extends Node {
  Bool(this.value);

  static Bool from(bool value) => Bool(value);

  final bool value;

  @override
  int get hashCode => value.hashCode;

  bool operator ==(other) => other is Bool && value == other.value;

  String toString() => 'Bool $value';
}