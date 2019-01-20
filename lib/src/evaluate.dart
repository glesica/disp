import 'package:dumblisp/src/ast/ident.dart';
import 'package:dumblisp/src/ast/node.dart';
import 'package:dumblisp/src/ast/s_exp.dart';
import 'package:dumblisp/src/ast/scalar.dart';
import 'package:dumblisp/src/binding.dart';
import 'package:dumblisp/src/context.dart';

Node evaluate(Context ctx, dynamic tree) {
  if (tree is Scalar) {
    return tree;
  }

  if (tree is Ident) {
    return ctx.binding(tree.name);
  }

  // TODO: Implement data lists, '(...) or whatever syntax

  if (tree is SExp) {
    final binding = evaluate(ctx, tree.function);
    final args = tree.arguments.map((subTree) => evaluate(ctx, subTree)).toList();

    if (binding is FunctionBinding) {
      return binding.apply(args);
    }

    if (binding is VariableBinding) {
      return binding.value;
    }

    throw Exception('$binding is not a function');
  }

  throw Exception('what the what');
}


