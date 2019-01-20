import 'package:dumblisp/src/ast/node.dart';

/// A [Node] interface to represent scalar values of any type.
abstract class Scalar<T> implements Node {
  T get value;
}