import 'package:dumblisp/src/ast/float.dart';
import 'package:dumblisp/src/ast/ident.dart';
import 'package:dumblisp/src/ast/int.dart';
import 'package:dumblisp/src/ast/lst.dart';
import 'package:dumblisp/src/ast/node.dart';
import 'package:dumblisp/src/ast/s_exp.dart';
import 'package:dumblisp/src/ast/str.dart';
import 'package:petitparser/petitparser.dart';

final _parser = _buildParser();

Result<Node> parseString(String source) {
  return _parser.parse(source);
}

Parser<Node> _buildParser() {
  // Basic building blocks

  final lQuote = char('"').trim();
  final rQuote = char('"').trim();

  final lParen = char('(').trim();
  final rParen = char(')').trim();

  final digits = digit().plus().trim().flatten();

  final idChars = lowercase() | char('-');
  final strChars = char('"').neg();

  // Syntactic elements

  final identifier = idChars.plus().flatten().map<Ident>(Ident.from);
  final float = (digits & char('.') & digits).flatten().map<Float>(Float.from);
  final integer = digits.flatten().map<Int>(Int.from);
  final string = (lQuote & strChars.star().flatten() & rQuote)
      .pick<String>(1)
      .map(Str.from);

  final sExp = undefined<SExp>();
  final list = (identifier | integer | float | string | sExp)
      .plus()
      .castList<Node>()
      .map<Lst>(Lst.from);
  final sExpInner =
      (lParen & list & rParen).pick(1).cast<Lst>().map<SExp>(SExp.from);
  sExp.set(sExpInner);

  return sExp.end();
}
