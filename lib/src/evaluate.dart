import 'package:disp/src/ast/escaped.dart';
import 'package:disp/src/ast/ident.dart';
import 'package:disp/src/ast/node.dart';
import 'package:disp/src/ast/s_exp.dart';
import 'package:disp/src/ast/scalar.dart';
import 'package:disp/src/ast/binding.dart';
import 'package:disp/src/context.dart';

Node evaluate(Context ctx, dynamic tree) {
  if (tree is Escaped) {
    return tree.unescape();
  }

  if (tree is Scalar) {
    return tree;
  }

  if (tree is Ident) {
    final binding = ctx.binding(tree.name);
    if (binding == null) {
      throw Exception('Identifier not found: $tree');
    }

    if (binding is VariableBinding) {
      return binding.value;
    }

    return binding;
  }

  if (tree is SExp) {
    final binding = evaluate(ctx, tree.head);

    if (binding is FunctionBinding) {
      final arguments =
          tree.tail.map((subTree) => evaluate(ctx, subTree)).toList();
      return binding.apply(arguments);
    }

    throw Exception('$binding not a valid function');
  }

  throw Exception('what the what');
}
