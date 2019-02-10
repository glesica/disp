import 'package:disp/src/ast/float.dart';
import 'package:disp/src/ast/int.dart';
import 'package:disp/src/ast/num.dart';

Num toNum(num value) {
  if (value is int) {
    return Int(value);
  }

  if (value is double) {
    return Float(value);
  }

  throw Exception('Dart type "${value.runtimeType}" has no mapping to Num');
}
