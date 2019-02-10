import 'package:disp/src/ast/float.dart';
import 'package:disp/src/ast/int.dart';
import 'package:disp/src/ast/node.dart';
import 'package:disp/src/ast/str.dart';

Int toInt(List<Node> args) {
  final value = args[0];
  if (value is Int) {
    return value;
  }
  if (value is Float) {
    return Int(value.value.floor());
  }
  if (value is Str) {
    return Int(int.parse(value.value));
  }
  throw Exception('Failed to convert to int: "$value"');
}
