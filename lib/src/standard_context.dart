import 'package:dumblisp/src/ast.dart';
import 'package:dumblisp/src/binding.dart';
import 'package:dumblisp/src/context.dart';

final _standardBuilder = Context.builder()
  ..addAllBindings([
    NativeFunction(name: 'sum', callback: sum),
  ]);

final standardContext = _standardBuilder.build();

Int sum(List<Node> addends) {
  final left = addends[0] as Int;
  final right = addends[1] as Int;

  return Int(left.value + right.value);
}
