import 'package:disp/src/ast/node.dart';
import 'package:disp/src/ast/scalar.dart';

/// A base [Node] to represent numeric types.
abstract class Num<T extends num> extends Node implements Scalar<T> {
  Num(this.value);

  final T value;

  @override
  int get hashCode => value.hashCode;

  @override
  bool operator ==(other) => other is Num<T> && value == other.value;

  @override
  String toString() => 'Num $value';
}