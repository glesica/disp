import 'dart:io';

import 'package:disp/src/ast/node.dart';
import 'package:disp/src/ast/num.dart';
import 'package:disp/src/ast/str.dart';
import 'package:disp/src/ast/void.dart';

// Echo - variadic
Void echo(List<Node> args) {
  var output = '';
  for (final arg in args) {
    if (arg is Num) {
      output += arg.value.toString();
    } else if (arg is Str) {
      output += arg.value;
    } else {
      output += arg.toString();
    }
  }

  print(output);
  return Void();
}

// Env - read from environment
Str env(List<Node> args) {
  final name = args[0] as Str;
  final value = Platform.environment[name.value] ?? '';
  return Str.from(value);
}
