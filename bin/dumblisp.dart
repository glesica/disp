import 'package:dumblisp/dumblisp.dart';

void main(List<String> args) {
  final input = args[0];
  final tree = parseString(input);

  print(evaluate(standardContext, tree.value));
}

