import 'package:disp/src/ast/bool.dart';
import 'package:disp/src/ast/ident.dart';
import 'package:disp/src/ast/int.dart';
import 'package:disp/src/ast/lambda.dart';
import 'package:disp/src/ast/lst.dart';
import 'package:disp/src/ast/node.dart';
import 'package:disp/src/ast/s_exp.dart';
import 'package:disp/src/ast/binding.dart';
import 'package:disp/src/context.dart';
import 'package:disp/src/std/branch.dart';
import 'package:disp/src/std/convert.dart';
import 'package:disp/src/std/io.dart';
import 'package:disp/src/std/math.dart';
import 'package:disp/src/std/predicate.dart';

// TODO: Make Lst a linked list for simpler manipulation?

final _standardBuilder = Context.builder()
  ..addAllBindings([
    // Functions
    NativeFunction(name: 'diff', callback: diff),
    NativeFunction(name: 'echo', callback: echo),
    NativeFunction(name: 'env', callback: env),
    NativeFunction(name: 'eq', callback: equalTo),
    NativeFunction(name: 'gt', callback: greaterThan),
    NativeFunction(name: 'head', callback: head),
    NativeFunction(name: 'id', callback: id),
    NativeFunction(name: 'if', callback: ifElse),
    NativeFunction(name: 'lambda', callback: lambda),
    NativeFunction(name: 'lt', callback: lessThan),
    NativeFunction(name: 'nth', callback: nth),
    NativeFunction(name: 'prod', callback: prod),
    NativeFunction(name: 'quot', callback: quot),
    NativeFunction(name: 'sum', callback: sum),
    NativeFunction(name: 'tail', callback: tail),
    NativeFunction(name: 'int', callback: toInt),

    // Constants
    VariableBinding(name: 'false', value: Bool(false)),
    VariableBinding(name: 'true', value: Bool(true)),
  ]);

final standardContext = _standardBuilder.build();

Node head(List<Node> args) {
  final list = args[0] as Lst;
  return list.children.first;
}

Node id(List<Node> args) {
  final arg = args[0];
  return arg;
}

Node nth(List<Node> args) {
  final index = args[0] as Int;
  final array = args[1] as SExp;
  return array.children.toList()[index.value];
}

Node lambda(List<Node> args) {
  // TODO: Don't just skip invalid parameter names
  final parameters =
      (args[0] as SExp).children.whereType<Ident>().toList();
  final expression = args[1];
  return Lambda(parameters, expression);
}

Lst tail(List<Node> args) {
  final list = args[0] as Lst;
  if (list.children.isEmpty) {
    return Lst.empty();
  }
  return Lst.from(list.children.skip(1));
}
