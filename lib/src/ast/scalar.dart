import 'package:disp/src/ast/node.dart';

/// A [Node] interface to represent scalar values of any type.
abstract class Scalar<T> implements Node {
  T get value;

  @override
  int get hashCode => value.hashCode;

  @override
  bool operator ==(other) => other is Scalar && value == other.value;
}