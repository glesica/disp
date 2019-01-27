import 'package:disp/src/ast/escaped.dart';
import 'package:disp/src/ast/float.dart';
import 'package:disp/src/ast/ident.dart';
import 'package:disp/src/ast/int.dart';
import 'package:disp/src/ast/lst.dart';
import 'package:disp/src/ast/node.dart';
import 'package:disp/src/ast/s_exp.dart';
import 'package:disp/src/ast/str.dart';
import 'package:petitparser/petitparser.dart';
import 'package:petitparser/debug.dart';

final _parser = _buildParser();

Result<Node> parseString(String source, {bool useTracer}) {
  final parser = useTracer == true ? trace(_parser) : _parser;
  return parser.parse(source);
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

  final escapeMarker = char('`').trim();

  // Syntactic elements

  final identifier = idChars.plus().flatten().trim().map<Ident>(Ident.from);
  final float = (digits & char('.') & digits).flatten().map<Float>(Float.from);
  final integer = digits.flatten().map<Int>(Int.from);
  final string = (lQuote & strChars.star().flatten() & rQuote)
      .pick<String>(1)
      .map(Str.from);

  final sExp = undefined<SExp>();

  final expr = (identifier | float | integer | string | sExp).cast<Node>();
  final escExpr =
      (escapeMarker & expr).pick<Node>(1).map<Escaped>(Escaped.from);

  final list = (expr | escExpr).plus().castList<Node>().map<Lst>(Lst.from);

  final sExpInner = (lParen & list.optional(Lst.empty()) & rParen)
      .pick(1)
      .cast<Lst>()
      .map<SExp>(SExp.from);
  sExp.set(sExpInner);

  return sExp.end();
}
