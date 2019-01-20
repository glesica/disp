import 'package:dumblisp/src/ast.dart';
import 'package:dumblisp/src/binding.dart';
import 'package:dumblisp/src/context.dart';

Node evaluate(Context ctx, dynamic tree) {
  if (tree is Int) {
    return tree;
  }

  if (tree is Float) {
    return tree;
  }

  if (tree is Str) {
    return tree;
  }

  if (tree is Ident) {
    // TODO: Turn Ident instances into Func or Var instances
    return ctx.binding(tree.name);
  }

  // TODO: Implement data lists, '(...) or whatever syntax

  if (tree is SExp) {
    final binding = evaluate(ctx, tree.function);
    final args = tree.arguments.map((subTree) => evaluate(ctx, subTree)).toList();

    if (binding is FunctionBinding) {
      return binding.apply(args);
    }

    throw Exception('$binding is not a function');
  }

  throw Exception('what the what');
}


