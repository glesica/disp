import 'package:dumblisp/src/ast/node.dart';
import 'package:dumblisp/src/ast/scalar.dart';

/// A [Node] to represent UTF-8 strings.
class Str extends Node implements Scalar<String> {
  Str(this.value);

  static Str from(String value) => Str(value);

  final String value;

  String toString() => 'Str $value';
}
