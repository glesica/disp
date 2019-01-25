import 'package:disp/src/ast/num.dart';

/// A [Num] node to represent floating point values (doubles).
class Float extends Num<double> {
  Float(double value) : super(value);

  static Float from(String value) => Float(double.parse(value));

  @override
  String toString() => 'Float $value';
}
