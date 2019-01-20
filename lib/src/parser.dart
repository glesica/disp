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
  final strChar = char('"').neg();

  // Syntactic elements

  // TODO: Keep this from gobbling the trailing whitespace
  final identifier = letter().plus().trim().flatten().map<Ident>(Ident.from);
  final float = (digits & char('.') & digits).flatten().map<Float>(Float.from);
  final integer = digits.map<Int>(Int.from);
  final string =
      (lQuote & strChar.star().flatten().map(Str.from) & rQuote).pick<Str>(1);

  final sExp = undefined<SExp>();
  final list = (sExp | identifier | float | integer | string)
      .plus()
      .castList<Node>()
      .map<Lst>(Lst.from);
  final sExpInner = (lParen & list & rParen)
      .pick(1)
      .cast<Lst>()
      .map((l) => l.children.toList())
      .castList<Node>()
      .map<SExp>(SExp.from);
  sExp.set(sExpInner);

  return sExp.end();
}
