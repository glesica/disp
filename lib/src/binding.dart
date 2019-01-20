import 'package:dumblisp/src/ast/node.dart';

abstract class Binding extends Node {
  String get name;
}

abstract class FunctionBinding extends Binding {
  Node apply(List<Node> arguments);
}

typedef Node NativeFunctionCallback(List<Node> arguments);

class NativeFunction implements FunctionBinding {
  NativeFunction({this.name, this.callback});

  @override
  final String name;

  final NativeFunctionCallback callback;

  @override
  Node apply(List<Node> arguments) => callback(arguments);
}

class ProgramFunction implements FunctionBinding {
  ProgramFunction(this.name);

  @override
  final String name;

  @override
  Node apply(List<Node> arguments) => throw UnimplementedError();
}

class VariableBinding<T extends Node> extends Binding {
  @override
  final String name;

  final T value;

  VariableBinding({this.name, this.value});
}
