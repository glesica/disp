import 'package:dumblisp/src/ast/node.dart';
import 'package:dumblisp/src/ast/scalar.dart';

/// A base [Node] to represent numeric types.
abstract class Num<T extends num> extends Node implements Scalar<T> {
  Num(this.value);

  final T value;

  @override
  String toString() => 'Num $value';
}