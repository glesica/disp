import 'package:dumblisp/src/ast/ident.dart';
import 'package:dumblisp/src/ast/escaped_s_exp.dart';
import 'package:dumblisp/src/ast/node.dart';
import 'package:dumblisp/src/ast/s_exp.dart';
import 'package:dumblisp/src/ast/scalar.dart';
import 'package:dumblisp/src/ast/binding.dart';
import 'package:dumblisp/src/context.dart';

Node evaluate(Context ctx, dynamic tree) {
  if (tree is Scalar) {
    return tree;
  }

  if (tree is EscapedSExp) {
    return tree;
  }

  if (tree is Ident) {
    final binding = ctx.binding(tree.name);
    if (binding == null) {
      throw Exception('Identifier not found: $tree');
    }
    return binding;
  }

  if (tree is SExp) {
    final binding = evaluate(ctx, tree.function);

    if (binding is FunctionBinding) {
      final args =
          tree.arguments.map((subTree) => evaluate(ctx, subTree)).toList();
      return binding.apply(args);
    }

    if (binding is VariableBinding) {
      return binding.value;
    }
  }

  throw Exception('what the what');
}
