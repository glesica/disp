import 'package:disp/src/ast/num.dart';

/// A [Num] node to represent integers (64-bit).
class Int extends Num<int> {
  Int(int value) : super(value);

  static Int from(String value) => Int(int.parse(value));

  @override
  String toString() => 'Int $value';
}
