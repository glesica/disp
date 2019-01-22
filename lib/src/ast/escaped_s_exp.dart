import 'package:dumblisp/src/ast/lst.dart';
import 'package:dumblisp/src/ast/s_exp.dart';

class EscapedSExp extends SExp {
  EscapedSExp(Lst list) : super(list);

  static EscapedSExp from(Lst list) => EscapedSExp(list);

  @override
  String toString() => 'EscapedSExp $children';

  SExp unescaped() => SExp(list);
}
