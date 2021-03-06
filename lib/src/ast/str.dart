import 'package:disp/src/ast/node.dart';
import 'package:disp/src/ast/scalar.dart';

/// A [Node] to represent UTF-8 strings.
class Str extends Node implements Scalar<String> {
  Str(this.value);

  static Str from(String value) => Str(value);

  final String value;

  @override
  int get hashCode => value.hashCode;

  @override
  bool operator ==(other) => other is Str && value == other.value;

  String toString() => 'Str "$value"';
}
